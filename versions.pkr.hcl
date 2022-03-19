packer {
  required_version = ">= 1.8.0"
  required_plugins {
    vsphere = {
      version = ">= 1.0.3"
      source  = "github.com/hashicorp/vsphere"
    }
    windows-update = {
      version = ">= 0.14.0"
      source  = "github.com/rgl/windows-update"
    }
  }
}
