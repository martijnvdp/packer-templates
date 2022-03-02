source "vsphere-iso" "windows" {
  vm_name              = var.vm_name
  boot_command         = ["<tab><wait><enter><wait>", "a<wait>a<wait>a<wait>a<wait>a<wait>a<wait>"]
  boot_wait            = "70s"
  cdrom_type           = "sata"
  cluster              = var.vcenter_cluster
  communicator         = "winrm"
  convert_to_template  = "true"
  CPUs                 = var.vm_cpu_num
  datacenter           = var.vcenter_datacenter
  datastore            = var.vcenter_datastore
  disk_controller_type = ["lsilogic-sas"]
  firmware             = "efi-secure"
  floppy_files         = ["${path.root}/bootconfig/${var.windows_version}/${var.windows_edition}/autounattend.xml", "${path.root}/scripts/windows/boot_init.ps1"]
  folder               = var.vcenter_folder
  guest_os_type        = "windows9Server64Guest"
  insecure_connection  = "true"
  iso_checksum         = "${var.iso_checksum_type}:${var.iso_checksum}"
  iso_paths            = ["[] /vmimages/tools-isoimages/windows.iso"]
  iso_url              = var.iso_url
  iso_target_path      = var.iso_target_path
  notes                = "${var.vm_notes}\nDefault User: Administrator\nDefault Pass: packer\nBuilt by Packer @ {{isotime \"2006-01-02 03:04\"}}."
  password             = var.vcenter_password
  RAM                  = var.vm_mem_size
  RAM_reserve_all      = true
  shutdown_timeout     = "15m"
  tools_upgrade_policy = true
  username             = var.vcenter_username
  vcenter_server       = var.vcenter_server
  winrm_password       = "packer"
  winrm_username       = "administrator"

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
  sources = ["source.vsphere-iso.windows"]

  provisioner "windows-shell" {
    inline = ["ipconfig"]
  }

  provisioner "powershell" {
    environment_vars = ["wsus_server=${var.os_wsus_server}", "wsus_server=${var.os_wsus_group}"]
    scripts          = ["${path.root}/scripts/windows/settings.ps1"]
  }

  provisioner "windows-update" {
    filters = ["include:$true"]
  }

  provisioner "windows-restart" {
    restart_timeout = "30m"
  }
}
