param(
    [pscredential]$credential,
    [switch]$all
)

$buildVarFile = "../vars/vsphere-iso.pkrvars.hcl"

if (!(test-path $buildVarFile)) { $buildVarFile = "variables/build/vsphere-iso.pkrvars.hcl" } 
if (!$credential) { $credential = get-credential }
$templates = (Get-ChildItem .\variables\os\).name
$menu = @{}
for ($i = 1; $i -le $templates.count; $i++) {
    Write-Host "$i. $($templates[$i-1])" 
    $menu.Add($i, ($templates[$i - 1], $($templates[$i - 1].split(".")[0] + "." + $templates[$i - 1].split(".")[1])))
}
if (!$all.IsPresent) {
    [int]$option = Read-Host 'Enter selection (enter 0 to deploy all templates)'
}

if ($option -eq 0 -or $all.IsPresent) {
    packer init .
    for ($option = 1; $option -le $menu.count; $option++) {
        packer build -force --only=$($menu.item($option)[1]) --var-file=$buildVarFile  --var-file="variables/os/$($menu.item($option)[0])" -var "vcenter_username=$($Credential.username)"  -var "vcenter_password=$($Credential.GetNetworkCredential().Password)" .
    }
}

else {
    packer build -force --only=$($menu.item($option)[1]) --var-file=$buildVarFile --var-file="variables/os/$($menu.item($option)[0])" -var "vcenter_username=$($Credential.username)"  -var "vcenter_password=$($Credential.GetNetworkCredential().Password)" .    
}


