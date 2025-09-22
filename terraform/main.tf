# LXCs
##############################

module "pocketid" {
  source = "./lxc"
  
  name = "pocketid"
  vmid = 104
  cores = 2
  memory = 2048
  start_on_boot = true  
}

module "media" {
  source = "./lxc"
  
  name = "media"
  vmid = 105
  cores = 4
  memory = 8192
  rootfs = "16G"
  start_on_boot = true
  privileged = true
  
  mountpoints = [ 
    {
      key = 0
      mp = "/mnt/data"
      storage = "big_data"
      size = "1024G"
    } 
  ]
}

module "openwebui" {
  source = "./lxc"
  
  name = "openwebui"
  vmid = 110
  cores = 2
  memory = 4096
  rootfs = "25G"
  start_on_boot = true
}

module "immich" {
  source = "./lxc"
  
  name = "immich"
  vmid = 119
  cores = 2
  memory = 4096
  rootfs = "16G"
  start_on_boot = true

  mountpoints = [ 
    {
      key = 0
      mp = "/mnt/cloud"
      storage = "big_data"
      size = "250G"
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

module "homebox" {
  source = "./lxc"
  
  name = "homebox"
  vmid = 133
  cores = 1
  memory = 1024
  rootfs = "16G"
  start_on_boot = true

}

module "spoolman" {
  source = "./lxc"
  
  name = "spoolman"
  vmid = 134
  cores = 1
  memory = 1024
  rootfs = "4G"
  start_on_boot = true

}


module "plantit" {
  source = "./lxc"
  name = "plantit"
  vmid = 102
  cores = 4
  memory = 2048
  rootfs = "8G"
  start_on_boot = true
}

module "siyuan" {
  source = "./lxc"
  name = "siyuan"
  vmid = 135
  cores = 3
  memory = 4096
  rootfs = "8G"
  start_on_boot = true

}

################################
