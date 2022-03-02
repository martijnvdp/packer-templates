source "vsphere-iso" "linux" {
  vm_name                = var.vm_name
  boot_command           = var.vm_boot_commands
  boot_wait              = "4s"
  cd_files               = ["${path.root}/bootconfig/${var.linux_distro}/*"]
  cd_label               = "cidata"
  cluster                = var.vcenter_cluster
  convert_to_template    = "true"
  CPUs                   = var.vm_cpu_num
  create_snapshot        = "false"
  datacenter             = var.vcenter_datacenter
  datastore              = var.vcenter_datastore
  disk_controller_type   = ["lsilogic-sas"]
  firmware               = "efi-secure"
  folder                 = var.vcenter_folder
  guest_os_type          = var.vm_guest_os_type
  insecure_connection    = "true"
  iso_checksum           = "${var.iso_checksum_type}:${var.iso_checksum}"
  iso_url                = var.iso_url
  iso_target_path        = var.iso_target_path
  notes                  = "${var.vm_notes}\nDefault SSH User: ${var.ssh_username}\nDefault SSH Pass: ${var.ssh_password}\nBuilt by Packer @ {{isotime \"2006-01-02 03:04\"}}."
  password               = var.vcenter_password
  RAM                    = var.vm_mem_size
  RAM_reserve_all        = true
  remove_cdrom           = true
  shutdown_command       = "echo 'ubuntu'|sudo -S shutdown -P now"
  shutdown_timeout       = "15m"
  ssh_handshake_attempts = "100000"
  ssh_password           = var.ssh_password
  ssh_timeout            = "40m"
  ssh_username           = var.ssh_username
  username               = var.vcenter_username
  vcenter_server         = var.vcenter_server

  network_adapters {
    network      = var.vcenter_network
    network_card = "vmxnet3"
  }

  storage {
    disk_size             = var.vm_disk_size
    disk_thin_provisioned = true
  }

  # VM Hardening settings
  configuration_parameters = {
    "RemoteDisplay.vnc.enabled"                        = "false"
    "isolation.bios.bbs.disable"                       = "true"
    "isolation.device.connectable.disable"             = "true"
    "isolation.device.edit.disable"                    = "true"
    "isolation.ghi.host.shellAction.disable"           = "true"
    "isolation.monitor.control.disable"                = "true"
    "isolation.tools.autoInstall.disable"              = "false"
    "isolation.tools.copy.disable"                     = "true"
    "isolation.tools.diskShrink.disable"               = "true"
    "isolation.tools.diskWiper.disable"                = "true"
    "isolation.tools.dispTopoRequest.disable"          = "true"
    "isolation.tools.dnd.disable"                      = "true"
    "isolation.tools.getCreds.disable"                 = "true"
    "isolation.tools.ghi.autologon.disable"            = "true"
    "isolation.tools.ghi.launchmenu.change"            = "true"
    "isolation.tools.ghi.protocolhandler.info.disable" = "true"
    "isolation.tools.ghi.trayicon.disable"             = "true"
    "isolation.tools.guestDnDVersionSet.disable"       = "true"
    "isolation.tools.hgfsServerSet.disable"            = "true"
    "isolation.tools.memSchedFakeSampleStats.disable"  = "true"
    "isolation.tools.paste.disable"                    = "true"
    "isolation.tools.setGUIOptions.enable"             = "false"
    "isolation.tools.trashFolderState.disable"         = "true"
    "isolation.tools.unity.disable"                    = "true"
    "isolation.tools.unity.push.update.disable"        = "true"
    "isolation.tools.unity.taskbar.disable"            = "true"
    "isolation.tools.unity.windowContents.disable"     = "true"
    "isolation.tools.unityActive.disable"              = "true"
    "isolation.tools.unityInterlockOperation.disable"  = "true"
    "isolation.tools.vixMessage.disable"               = "true"
    "isolation.tools.vmxDnDVersionGet.disable"         = "true"
    "log.keepold"                                      = "9"
    "log.rotatesize"                                   = "1024000"
    logging                                            = "false"
    "remotedisplay.maxconnections"                     = "2"
    "sched.mem.pshare.salt"                            = "false"
    "tools.guestlib.enableHostInfo"                    = "false"
    "tools.setInfo.sizeLimit"                          = "1048576"
  }
}

build {
  sources = ["source.vsphere-iso.linux"]

  provisioner "shell" {
    execute_command = "echo 'packer'|{{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    scripts         = ["${path.root}/scripts/${var.linux_distro}/pre.sh"]
  }

  provisioner "ansible-local" {
    playbook_file = "${path.root}/playbooks/${var.linux_distro}/setup.yml"
  }

  provisioner "shell" {
    execute_command = "echo 'packer'|{{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    scripts         = ["${path.root}/scripts/${var.linux_distro}/post.sh"]
  }
}
