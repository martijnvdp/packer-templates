## packer-templates

packer templates for vmware:
- Centos 9 Stream
- Rocky 8.5
- Ubuntu 20.04.4
- Windows 2019 core/standard
- Windows 2022 core/standard

## template deployment powershell script

example deploy templates on vsphere with the deploy.ps1 script:
( be sure to edit variables\build\vsphere-iso.pkrvars.hcl)
```hcl
# enter virtual center username and password:
$Credential = get-credential 
deploy.ps1 -credential $credential
```

choose from menu:
```hcl
1. vsphere-iso.linux.centos-9.pkrvars.hcl
2. vsphere-iso.linux.rocky-85.pkrvars.hcl
3. vsphere-iso.linux.ubuntu-2044.pkrvars.hcl
4. vsphere-iso.windows.2019.core.pkrvars.hcl
5. vsphere-iso.windows.2019.standard.pkrvars.hcl
6. vsphere-iso.windows.2022.core.pkrvars.hcl
7. vsphere-iso.windows.2022.standard.pkrvars.hcl
Enter selection (enter 0 to deploy all templates):
```

example all templates on vsphere with the deploy.ps1 script:
```hcl
# enter virtual center username and password:
$Credential = get-credential 
deploy.ps1 -credential $credential -all
```

example manual rocky template on vsphere:
```hcl
packer build --only vsphere-iso.lnx-rocky-85 `
--var-file=variables/build/vsphere.pkrvars.hcl `
--var-file=variables/os/vsphere-iso.lnx-rocky-85.pkrvars.hcl ` .
```

## requirements
packer - https://www.packer.io/

for the iso creation one of the following iso creators:
- xorriso
- mkisofs
- hdiutil (normally found in macOS)
- oscdimg (normally found in Windows as part of the Windows ADK)

## References

https://docs.rockylinux.org/sv/guides/automation/templates-automation-packer-vsphere/
https://www.packer.io/plugins/builders/vsphere/vsphere-iso

## Authors

* **M van der Ploeg** - *Initial work* - [martijn](https://github.com/martijnvdp)