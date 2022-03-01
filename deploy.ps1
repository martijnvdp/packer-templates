param(
    [pscredential]$credential
)

$buildVarFile = "variables/build/vsphere.pkrvars.hcl"

if (!$credential) { $credential = get-credential }

packer init .
packer build --only vsphere-iso.centos --var-file=$buildVarFile --var-file=variables/os/centos.8.5.pkrvars.hcl -var "vcenter_username=$($Credential.username)"  -var "vcenter_password=$($Credential.GetNetworkCredential().Password)" .