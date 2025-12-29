#!/bin/bash
# Paths
UPLOAD_LOCATION="/mnt/cloud/library"
# Backblaze B2 credentials
. /opt/immich/backblaze.env
# URL ntfy
NTFY_URL="ntfy.puccia.org/immich"

# Function to send notifications
send_notification() {
    local title="$1"
    local message="$2"
    local priority="$3"

    curl -H "Title: $title" \
         -H "Priority: $priority" \
         -d "$message" \
         "$NTFY_URL"
}

# Set a variable to track errors
BACKUP_ERROR=0

### Local
# Backup Immich database
if ! docker exec -t immich_postgres pg_dumpall --clean --if-exists --username=postgres > "$UPLOAD_LOCATION"/database-backup/immich-database.sql; then
    send_notification "Immich Backup Error" "Error during database backup" "high"
    BACKUP_ERROR=1
    exit 1
fi

### Backup to Backblaze B2 with Restic
# Initialize repository if needed (comment out after first use)
# restic init

# Execute backup
if ! restic backup "$UPLOAD_LOCATION" --exclude="$UPLOAD_LOCATION/thumbs/" --exclude="$UPLOAD_LOCATION/encoded-video/"; then
    send_notification "Immich Backup Error" "Error during Backblaze B2 backup" "high"
    BACKUP_ERROR=1
    exit 1
fi

# Clean up old backups
if ! restic forget --keep-weekly 4 --keep-monthly 3 --prune; then
    send_notification "Immich Backup Error" "Error during old backup cleanup" "high"
    BACKUP_ERROR=1
fi

# Send success notification only if there were no errors
if [ $BACKUP_ERROR -eq 0 ]; then
    send_notification "Immich Backup Completed" "Backup completed successfully" "default"
fi

# Clean up environment variables
unset B2_ACCOUNT_ID
unset B2_ACCOUNT_KEY
unset RESTIC_PASSWORD
unset RESTIC_REPOSITORY