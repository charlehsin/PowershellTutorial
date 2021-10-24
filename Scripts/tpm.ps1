
$tpm = Get-Tpm
$tpm.TpmPresent
$tpm.TpmReady
$tpm.AutoProvisioning

#Auto provisioning is mainly when TPM Owner Password is in AD DS and GPO to backup TPM password is enabled.
Disable-TpmAutoProvisioning
$tpm = Get-Tpm
$tpm.AutoProvisioning
Enable-TpmAutoProvisioning
$tpm = Get-Tpm
$tpm.AutoProvisioning

# If TpmPresent is True and TpmReady is False, then do the following......
# If TpmPresent is False, the error log for features requiring tpm.
# This still requires physical presence to press a key
Initialize-Tpm -AllowClear -AllowPhysicalPresence
# Need to restart computer to start it
Restart-Computer

# This does not work, since OwnerClearDisabled is True.
Clear-Tpm

#try bitlocker, after tpm is present and ready
Enable-BitLocker -MountPoint "C:" -EncryptionMethod Aes128 -UsedSpaceOnly -TpmProtector
# Need to restart computer to start it
Restart-Computer

#disable bitlocker
Disable-BitLocker -MountPoint "C:"

#WMI
$tpm = Get-WmiObject -Namespace ROOT\CIMV2\Security\MicrosoftTpm -Class Win32_Tpm
if ($tpm.IsEnabled().IsEnabled -eq $true) {
    Write-Output "TPM is enabled !"
} else {
    Write-Output "TPM is NOT enabled !"
}
if ($tpm.IsActivated().IsActivated -eq $true) {
    Write-Output "TPM is activated !"
} else {
    Write-Output "TPM is NOT activated !"
}
if ($tpm.IsOwned().IsOwned -eq $true) {
    Write-Output "TPM is ownded !"
} else {
    Write-Output "TPM is NOT owned !"
}

if ($tpm.IsPhysicalPresenceHardwareEnabled().IsPhysicalPresenceHardwareEnabled -eq $true) {
    Write-Output "TPM Physical Presence HW is enabled !"
} else {
    Write-Output "TPM Physical Presence HW is NOT enabled !"
}

Write-Output "Check status of Physical Presence Confirmation for Clear TPM:"
$c = $tpm.GetPhysicalPresenceConfirmationStatus(5)
switch ($c.ConfirmationStatus ) 
    {
        0 {Write-Output "Not implemented"}
        1 {Write-Output "BIOS only"}
        2 {Write-Output "Blocked for OS by BIOS config"}
        3 {Write-Output "Allowed, and physically present user required"}
        4 {Write-Output "Allowed, and physically present user not required"}
    }

Write-Output "Check status of Physical Presence Confirmation for Enable TPM:"
$c = $tpm.GetPhysicalPresenceConfirmationStatus(1)
switch ($c.ConfirmationStatus ) 
    {
        0 {Write-Output "Not implemented"}
        1 {Write-Output "BIOS only"}
        2 {Write-Output "Blocked for OS by BIOS config"}
        3 {Write-Output "Allowed, and physically present user required"}
        4 {Write-Output "Allowed, and physically present user not required"}
    }


# Clear any pending request
$tpm.SetPhysicalPresenceRequest(0)
# SetNoPPIProvision_True  : don't need to be physically presence to set TPM
$tpm.SetPhysicalPresenceRequest(16)
# SetNoPPIMaintenance_True  : don't need to be physically presence to set TPM
$tpm.SetPhysicalPresenceRequest(20)

$tpm.GetPhysicalPresenceTransition()

$tpm.GetPhysicalPresenceResponse()


Get-BitLockerVolume
Add-BitLockerKeyProtector -MountPoint C: -RecoveryPasswordProtector
Get-BitLockerVolume

$BLV = Get-BitLockerVolume -MountPoint "C:"
Remove-BitLockerKeyProtector -MountPoint "C:" -KeyProtectorId $BLV.KeyProtector[0].KeyProtectorId

$p = "111111-342650-607607-626285-132319-115621-083204-229482"
Add-BitLockerKeyProtector -MountPoint C: -RecoveryPassword $p -RecoveryPasswordProtector
Get-BitLockerVolume


Enable-BitLocker -MountPoint "C:" -UsedSpaceOnly -TpmProtector
Get-BitLockerVolume