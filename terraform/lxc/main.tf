variable "name" {
  type = string
}

variable "vmid" {
  type = number
}

variable "cores" {
  type = number
}

variable "memory" {
  type = number
}

variable "swap" {
  type = number
  default = 2048
}

variable "rootfs" {
  type = string
  default = "8G"
}

variable "mountpoints" {
  type = list(object({
    key = number
    mp = string
    storage = optional(string, "local-lvm")
    size = string
  }))
  default = []
  description = "List of mountpoints to be added to the LXC container"
}

variable "start_on_boot" {
  type = bool
  default = false
}

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

terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      #latest version as of Nov 30 2022
      version = "2.9.11"
    }
  }
}

resource "proxmox_lxc" "lxc" {
  target_node  = var.proxmox_node
  hostname     = "${var.name}"
  ostemplate   = var.lxc_template
  vmid         = var.vmid
  
  unprivileged = true

  features {
    nesting = true
  }
  
  // LXC System Specs
  cores    = var.cores
  cpuunits = 100
  memory   = var.memory
  swap     = var.swap
  
  // Terraform will crash without rootfs defined
  rootfs {
    storage = var.default_rootfs_storage
    size    = var.rootfs
  }
  
  dynamic "mountpoint" {
      for_each = var.mountpoints
      content {
        key = "${mountpoint.value.key}"
        slot = mountpoint.value.key
        storage = "${mountpoint.value.storage}"
        mp = "${mountpoint.value.mp}"
        size = "${mountpoint.value.size}"
      }
    }
  

  network {
    name   = "eth0"
    bridge = var.nic_name
    ip     = "10.0.46.${var.vmid}/24"
    gw     = "10.0.46.1"
  }
  
  onboot = var.start_on_boot
  start = true
  
  ssh_public_keys= file(var.ssh_keys["pub"])

  #creates ssh connection to check when the CT is ready for ansible provisioning
  connection {
    host = "10.0.46.${var.vmid}"
    user = "root"
    private_key = file(var.ssh_keys["priv"])
    agent = false
    timeout = "3m"
  } 
  
  provisioner "remote-exec" {
	  # Leave this here so we know when to start with Ansible local-exec 
      inline = [ 
        "echo 'Container is ready for provisioning'",
        "apt update"
      ]
  }
  
  provisioner "local-exec" {
        working_dir = "../ansible/"
        command = "ansible-playbook -u root --key-file ${var.ssh_keys["priv"]} -i 10.0.46.${var.vmid}, ${var.name}/${var.name}.ansible.yml"
  }
  
}