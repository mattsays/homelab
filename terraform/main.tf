# LXCs
##############################

module "media" {
  source = "./lxc"
  
  name = "media"
  vmid = 105
  cores = 4
  memory = 8192
  rootfs = "16G"
  start_on_boot = true
  
  mountpoints = [ 
    {
      key = 0
      mp = "/mnt/data"
      storage = "big_data"
      size = "1024G"
    } 
  ]
}


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

module "grocy" {
  source = "./lxc"
  
  name = "grocy"
  vmid = 129
  cores = 1
  memory = 1024
  start_on_boot = true
}

module "books" {
  source = "./lxc"
  
  name = "books"
  vmid = 130
  cores = 2
  memory = 2048
  start_on_boot = true
}

module "reactive-resume" {
  source = "./lxc"
  
  name = "reactive-resume"
  vmid = 131
  cores = 2
  memory = 3072
  start_on_boot = true
}

module "mealie" {
  source = "./lxc"
  
  name = "mealie"
  vmid = 132
  cores = 1
  memory = 2048
  start_on_boot = true
}

module "overleaf" {
  source = "./lxc"
  
  name = "overleaf"
  vmid = 133
  cores = 2
  memory = 3072
  start_on_boot = true
  rootfs = "16G"
}


################################
