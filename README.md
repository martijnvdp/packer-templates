## packer-templates

example deploy rocky template on vsphere from powershell:
```hcl
# enter virtual center username and password:
$Credential = get-credential 
packer build --only vsphere-iso.rocky --var-file=variables/build/vsphere.pkrvars.hcl --var-file=variables/os/rocky.8.5.pkrvars.hcl -var "vcenter_username=$($Credential.username)"  -var "vcenter_password=$($Credential.GetNetworkCredential().Password)" .
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