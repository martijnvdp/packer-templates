variable "iso_url" {
  type        = string
  description = "Installation ISO Source, URL/SMB/FILE"
}

variable "iso_checksum_type" {
  type        = string
  description = "ISO checksum type"
  default     = "sha256"
}

variable "iso_checksum" {
  description = "ISO checksum, this can also be determined using the powershell get-filehash function"
  type        = string
}

variable "iso_target_path" {
  description = "ISO target path/name"
  type        = string
}

variable "ssh_username" {
  type        = string
  description = "ssh username"
  default     = "root"
}

variable "ssh_password" {
  type        = string
  description = "ssh password"
  default     = "packer"
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
  type        = string
  description = "WSUS Server name for windows updates"
  default     = ""
}

variable "os_wsus_group" {
  type        = string
  description = "WSUS Group for windows updates"
  default     = ""
}

variable "os_edition" {
  type        = string
  description = "Windows Server edition core ore standard"
  default     = "standard"
}
