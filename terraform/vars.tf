#Set your public SSH key here

variable "ssh_keys" {
	type = map
     default = {
       pub = "~/.ssh/puccia.key.pub"
       priv = "~/.ssh/puccia.key"
     }
}
#Establish which Proxmox host you'd like to spin a VM up on
variable "proxmox_node" {
    default = "puccia"
}
#Specify which template name you'd like to use
variable "lxc_template" {
    default = "local:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"
}

variable "default_rootfs_storage" {
    default = "local-lvm"
}

#Establish which nic you would like to utilize
variable "nic_name" {
    default = "vmbr1"
}



#Provide the url of the host you would like the API to communicate on.
#It is safe to default to setting this as the URL for what you used
#as your `proxmox_host`, although they can be different
variable "api_url" {
    default = "https://10.0.46.2:8006/api2/json"
}
#Blank var for use by terraform.tfvars
variable "token_secret" {
}
#Blank var for use by terraform.tfvars
variable "token_id" {
}