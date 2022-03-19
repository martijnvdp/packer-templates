vm_name           = "Centos-9-Template"
vm_notes          = "Centos 9 Stream Server Template EFI"
vm_boot_commands  = ["e<down><down><end><bs><bs><bs><bs><bs>inst.text inst.ks=cdrom:/dev/sr1:/ks.cfg<leftCtrlOn>x<leftCtrlOff>"]
vm_cpu_num        = 2
vm_disk_size      = 4048
vm_guest_os_type  = "centos8_64Guest"
vm_mem_size       = 4096
iso_url           = "https://mirrors.centos.org/mirrorlist?path=/9-stream/BaseOS/x86_64/iso/CentOS-Stream-9-latest-x86_64-dvd1.iso&redirect=1&protocol=https"
iso_checksum_type = "sha256"
iso_checksum      = "e3774a7d398200b6a47ef0fd0a47311d44e0b9efbbe524448c579947d74e5de8"
iso_target_path   = "CentOS-Stream-9-latest-x86_64-dvd1.iso"
linux_distro      = "centos"
ssh_username      = "root"
ssh_password      = "packer"
