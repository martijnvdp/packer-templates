# general settings
#$ErrorActionPreference = "Stop"
Start-Transcript -Path c:\packer.log -Append
# Set Temp Variable using PowerShell
$TempFolder = "C:\TEMP"
write-host "Setting temp folder to $TempFolder"
if (!(test-path $TempFolder)) { New-Item -ItemType Directory -Force -Path $TempFolder | Out-Null } 
[Environment]::SetEnvironmentVariable("TEMP", $TempFolder, [EnvironmentVariableTarget]::Machine)
[Environment]::SetEnvironmentVariable("TMP", $TempFolder, [EnvironmentVariableTarget]::Machine)
[Environment]::SetEnvironmentVariable("TEMP", $TempFolder, [EnvironmentVariableTarget]::User)
[Environment]::SetEnvironmentVariable("TMP", $TempFolder, [EnvironmentVariableTarget]::User)

# set wsus server
if ($env:wsus_server -ne "") {
    write-host "Setting wsus server to $env:wsus_server and group to $env:wsus_group"
    new-itemproperty -path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "WUServer" -value ($env:wsus_server)  | Out-Null
    new-itemproperty -path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "WUStatusServer" -value ($env:wsus_server)  | Out-Null
    new-itemproperty -path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "TargetGroupEnabled" -PropertyType dword -value 1  | Out-Null
    new-itemproperty -path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "TargetGroup" -value ($env:wsus_group)  | Out-Null
    if (!(test-path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate")) { new-item -path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "AU"  | Out-Null }
    new-itemproperty -path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "UseWUServer" -PropertyType dword -value 1  | Out-Null
    restart-service wuauserv  | Out-Null
}

#disable ipv6 and other components
Get-NetAdapter | Disable-NetAdapterBinding -ComponentID ms_tcpip6 -Confirm:$false
Get-NetAdapter | Disable-NetAdapterBinding -ComponentID ms_implat -Confirm:$false

# SettingSet Explorer view options
Write-Host "Setting default Explorer view options"
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "Hidden" 1 | Out-Null
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "HideFileExt" 0 | Out-Null
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "HideDrivesWithNoMedia" 0 | Out-Null
Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "ShowSyncProviderNotifications" 0 | Out-Null

# Disable system hibernation
Write-Host "Disabling system hibernation"
Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Power\" -Name "HiberFileSizePercent" -Value 0 | Out-Null
Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Power\" -Name "HibernateEnabled" -Value 0 | Out-Null

# Disable password expiration for Administrator
Write-Host "Disabling password expiration for local Administrator user"
Set-LocalUser Administrator -PasswordNeverExpires $true

# Enabling RDP connections
Write-Host "Enabling RDP connections"
netsh advfirewall firewall set rule group="Remote Desktop" new enable=yes
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0 | Out-Null

#time zone
Set-TimeZone -Name "W. Europe Standard Time"

Stop-Transcript