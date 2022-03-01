## packer-templates

packer templates for vmware:
- Rocky 8.5

example deploy rocky template on vsphere from powershell:
```hcl
# enter virtual center username and password:
$Credential = get-credential 
packer build --only vsphere-iso.rocky --var-file=variables/build/vsphere.pkrvars.hcl --var-file=variables/os/rocky.8.5.pkrvars.hcl -var "vcenter_username=$($Credential.username)"  -var "vcenter_password=$($Credential.GetNetworkCredential().Password)" .
```

## template deployment powershell script

example deploy templates on vsphere with the deploy.ps1 script:
```hcl
# enter virtual center username and password:
$Credential = get-credential 
deploy.ps1 -credential $credential
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