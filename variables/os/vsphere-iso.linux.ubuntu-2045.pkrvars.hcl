vm_name           = "Ubuntu-20.04.5-Template-Server"
vm_notes          = "Ubuntu 20.04.5 Server EFI"
vm_cpu_num        = 2
vm_boot_commands  = ["<esc><wait>", "<esc><wait>", "linux /casper/vmlinuz --- autoinstall ds=nocloud;s=/cidata", "<enter><wait>", "initrd /casper/initrd<enter><wait>", "boot<enter>"]
vm_disk_size      = 40480
vm_guest_os_type  = "ubuntu64Guest"
vm_mem_size       = 4096
iso_url           = "https://releases.ubuntu.com/20.04/ubuntu-20.04.5-live-server-amd64.iso"
iso_checksum_type = "sha256"
iso_checksum      = "5035be37a7e9abbdc09f0d257f3e33416c1a0fb322ba860d42d74aa75c3468d4"
iso_target_path   = "ubuntu-20.04.5-live-server-amd64.iso"
linux_distro      = "ubuntu"
ssh_username      = "ubuntu"
ssh_password      = "ubuntu"
