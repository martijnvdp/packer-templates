# use powershell get-filehash for checksum
vm_name           = "Windows-2022-Template-Standard"
vm_notes          = "Windows 2022 Standard template with gui EFI"
vm_cpu_num        = "2"
vm_mem_size       = "4096"
vm_disk_size      = "40960"
iso_url           = "smb://server/iso/WINDOWS_2022_SERVER_EVAL_x64FRE_en-us.ISO"
iso_target_path   = "WINDOWS_2022_SERVER_EVAL_x64FRE_en-us.ISO"
iso_checksum      = "4F1457C4FE14CE48C9B2324924F33CA4F0470475E6DA851B39CCBF98F44E7852"
iso_checksum_type = "sha256"
windows_edition   = "standard"
windows_version   = "2022"
