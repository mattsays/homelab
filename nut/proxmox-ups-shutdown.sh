#!/bin/bash
logger "NUT: Starting VM and container shutdown"

# Stop all VMs
for vmid in $(qm list | awk '{if(NR>1) print $1}'); do
    logger "NUT: Stopping VM $vmid"
    qm shutdown $vmid --timeout 60
done

# Stop all containers
for ctid in $(pct list | awk '{if(NR>1) print $1}'); do
    logger "NUT: Stopping CT $ctid"
    pct shutdown $ctid --timeout 60
done

# Wait for processes to complete
sleep 90

# Power off the server
logger "NUT: Shutting down Proxmox host"
/sbin/shutdown -h now
