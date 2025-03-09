variable "vmid" {
  type = number
  default = 124
}


resource "proxmox_lxc" "nextcloud" {
  target_node  = var.proxmox_node
  hostname     = "nextcloud"
  ostemplate   = var.lxc_template
  vmid         = var.vmid
  
  unprivileged = true

  features {
    nesting = true
  }
  
  // LXC System Specs
  cores    = 2
  cpuunits = 100
  memory   = 4096
  swap     = 2048
  
  // Terraform will crash without rootfs defined
  rootfs {
    storage = var.default_rootfs_storage
    size    = "16G"
  }

  network {
    name   = "eth0"
    bridge = var.nic_name
    ip     = "10.0.46.${var.vmid}/24"
    gw     = "10.0.46.1"
  }
  
  onboot = true
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
        command = "ansible-playbook -u root --key-file ${var.ssh_keys["priv"]} -i 10.0.46.${var.vmid}, docker/docker.ansible.yml"
  }
  
}