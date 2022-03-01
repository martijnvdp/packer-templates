variable "iso_url" {
  type = string
}

variable "iso_checksum_type" {
  type    = string
  default = "sha256"
}

variable "iso_checksum" {
  type = string
}

variable "iso_target_path" {
  type = string
}

variable "ssh_username" {
  type    = string
  default = "root"

}

variable "ssh_password" {
  type    = string
  default = "packer"
}

variable "os_type" {
  type = string
}

#####################################################
# vsphere-iso 
#####################################################

variable "vcenter_server" {
  type    = string
  default = "vc.vmware.local"
}

variable "vcenter_username" {
  type = string
}

variable "vcenter_password" {
  type = string
}

variable "vcenter_datacenter" {
  type    = string
  default = "datacenter"
}

variable "vcenter_datastore" {
  type    = string
  default = "datastore"
}

variable "vcenter_cluster" {
  type    = string
  default = "Cluster"
}

variable "vcenter_folder" {
  type    = string
  default = "Templates"
}

variable "vcenter_network" {
  type    = string
  default = "VM Network"
}

variable "vm_name" {
  type = string
}

variable "vm_notes" {
  type = string
}

variable "vm_cpu_num" {
  type    = number
  default = 2
}

variable "vm_mem_size" {
  type    = number
  default = 4096
}

variable "vm_disk_size" {
  type = number
}

#####################################################
# windows
#####################################################

variable "os_wsus_server" {
  type    = string
  default = ""
}

variable "os_wsus_group" {
  type    = string
  default = ""
}

variable "os_edition" {
  type    = string
  default = "standard"
}
