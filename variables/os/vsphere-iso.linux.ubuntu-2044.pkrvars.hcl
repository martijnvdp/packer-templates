vm_name    = "Ubuntu-20.04.4-Template-Server"
vm_notes   = "Ubuntu 20.04.4 Server EFI"
vm_cpu_num = 2
#vm_boot_commands = [" <wait>", " <wait>", " <wait>", " <wait>", " <wait>", "<esc><wait>", "<f6><wait>", "<esc><wait>", "<bs><bs><bs><bs><wait>", " autoinstall<wait5>", " ds=nocloud-net;s=/cdrom/boot/<wait5>", " ---<wait5>", "<enter><wait5>"]
vm_boot_commands  = ["<esc><wait>", "<esc><wait>", "linux /casper/vmlinuz --- autoinstall ds=nocloud;s=/cidata", "<enter><wait>", "initrd /casper/initrd<enter><wait>", "boot<enter>"]
vm_disk_size      = 40480
vm_guest_os_type  = "ubuntu64Guest"
vm_mem_size       = 4096
iso_url           = "https://releases.ubuntu.com/20.04/ubuntu-20.04.4-live-server-amd64.iso"
iso_checksum_type = "sha256"
iso_checksum      = "28ccdb56450e643bad03bb7bcf7507ce3d8d90e8bf09e38f6bd9ac298a98eaad"
iso_target_path   = "ubuntu-20.04.4-live-server-amd64.iso"
linux_distro      = "ubuntu"
ssh_username      = "ubuntu"
ssh_password      = "ubuntu"
