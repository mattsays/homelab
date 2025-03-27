# LXCs
##############################

module "caddy" {
  source = "./lxc"
  
  name = "caddy"
  vmid = 121
  cores = 1
  memory = 1024
  rootfs = "8G"
  start_on_boot = true
}


module "nextcloud" {
  source = "./lxc"
  
  name = "nextcloud"
  vmid = 124
  cores = 2
  memory = 4096
  rootfs = "32G"
  start_on_boot = true
}

module "rustdesk-server" {
  source = "./lxc"
  
  name = "rustdesk-server"
  vmid = 125
  cores = 1
  memory = 512
  start_on_boot = true
}

module "music" {
  source = "./lxc"
  
  name = "music"
  vmid = 126
  cores = 2
  memory = 2048
  start_on_boot = true
}

module "romm" {
  source = "./lxc"
  
  name = "romm"
  vmid = 127
  cores = 2
  memory = 2048
  start_on_boot = true
  
  mountpoints = [ 
    {
      key = 0
      mp = "/mnt/roms"
      size = "20G"
    } 
  ]
}

module "actualbudget" {
  source = "./lxc"
  
  name = "actualbudget"
  vmid = 128
  cores = 2
  memory = 2048
  start_on_boot = true
}

################################
