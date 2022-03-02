vm_name           = "Rocky-8-5-Template"
vm_notes          = "Rocky 8.5 Server Template EFI"
vm_boot_commands  = ["e<down><down><end><bs><bs><bs><bs><bs>inst.text inst.ks=cdrom:/dev/sr1:/ks.cfg<leftCtrlOn>x<leftCtrlOff>"]
vm_cpu_num        = 2
vm_disk_size      = 40480
vm_guest_os_type  = "centos8_64Guest"
vm_mem_size       = 4096
iso_url           = "http://download.rockylinux.org/pub/rocky/8.5/isos/x86_64/Rocky-8.5-x86_64-minimal.iso"
iso_checksum_type = "sha256"
iso_checksum      = "4eb2ae6b06876205f2209e4504110fe4115b37540c21ecfbbc0ebc11084cb779"
iso_target_path   = "Rocky-8.5-x86_64-minimal.iso"
linux_distro      = "rocky"
ssh_username      = "root"
ssh_password      = "packer"
