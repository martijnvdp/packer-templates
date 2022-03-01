source "vsphere-iso" "rocky" {
  CPUs                 = var.vm-cpu-num
  RAM                  = var.vm-mem-size
  RAM_reserve_all      = true
  boot_command         = ["e<down><down><end><bs><bs><bs><bs><bs>inst.text inst.ks=cdrom:/dev/sr1:/ks.cfg<leftCtrlOn>x<leftCtrlOff>"]
  boot_wait            = "3s"
  cd_files             = ["${path.root}/bootconfig/rocky/ks.cfg"]
  cd_label             = "cidata"
  cluster              = var.vcenter_cluster
  convert_to_template  = "true"
  create_snapshot      = "false"
  datacenter           = var.vcenter_datacenter
  datastore            = var.vcenter_datastore
  disk_controller_type = ["pvscsi"]
  firmware             = "efi-secure"
  folder               = var.vcenter_folder
  guest_os_type        = "rocky8_64Guest"
  insecure_connection  = "true"
  iso_checksum         = "${var.iso_checksum_type}:${var.iso_checksum}"
  iso_url              = var.iso_urls
  network_adapters {
    network      = var.vcenter_network
    network_card = "vmxnet3"
  }
  notes                  = "${var.vm-notes}\nDefault SSH User: ${var.ssh_username}\nDefault SSH Pass: ${var.ssh_password}\nBuilt by Packer @ {{isotime \"2006-01-02 03:04\"}}."
  password               = var.vcenter_password
  shutdown_command       = "echo 'ubuntu'|sudo -S shutdown -P now"
  ssh_handshake_attempts = "100000"
  ssh_password           = var.ssh_password
  ssh_timeout            = "40m"
  ssh_username           = var.ssh_username
  storage {
    disk_size             = var.vm-disk-size
    disk_thin_provisioned = true
  }
  username       = var.vcenter_username
  vcenter_server = var.vcenter_server
  vm_name        = var.vm_name
}

build {
  sources = ["source.vsphere-iso.rocky"]

  provisioner "shell" {
    execute_command = "echo 'packer'|{{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    inline          = ["dnf -y update", "dnf -y install python3", "python3 -m pip install --upgrade pip", "alternatives --set python /usr/bin/python3", "pip3 install ansible"]
  }

  provisioner "ansible-local" {
    playbook_file = "${path.root}/playbooks/setup-rocky.yml"
  }

  provisioner "shell" {
    execute_command = "echo 'packer'|{{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    scripts         = ["${path.root}/scripts/cleanup.sh"]
  }
}

packer {
  required_version = ">= 1.7.0"
  required_plugins {
    vsphere = {
      version = ">= 1.0.3"
      source  = "github.com/hashicorp/vsphere"
    }
  }
}
