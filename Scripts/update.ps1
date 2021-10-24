

# check Group Policy settings reference document

$message_remove_key = "Remove existing key: "
$message_remove_entry = "Remove existing registry entry: "
$message_set_defaultvalue = "Set existing registry entry to default value: "

#  HKCU\Software\Policies\Microsoft\Windows\WindowsUpdate\AU!
#        Default is to remove WindowsUpdate key
#  HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\WindowsUpdate!
#        Default is to remove WindowsUpdate key
#  HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate\AU!
#  HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate!
#        Default is to remove WindowsUpdate key
$array_keys = 'HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\WindowsUpdate', `
    'HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\WindowsUpdate', `
    'HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate'

#  HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings
#           DeferUpgrade  = (Dword) 0
#           UxOption = (Dword) 0
$key_HKLM_UX_Settings = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings"
$array_entries = 'DeferUpgrade', 'UxOption'
$array_values = 0, 0
#  HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update
#           Default is no AUOptions entry under this key
$key_HKLM_AUOptions = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update"
$entry_HKLM_AUOptions = "AUOptions"
<#  The following cannot be set, so do not do thing.
#  HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX
#           IsConvergedUpdateStackEnabled = (DWORD) 1
$key_HKLM_UX = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX"
#>

foreach ($key in $array_keys) {
    if ((Test-Path "registry::$key")) {
        Write-Verbose "$message_remove_key $key"
        Remove-Item "registry::$key" -Recurse
    }
}
if ((Test-Path "registry::$key_HKLM_UX_Settings")) {
    for ($i = 0; $i -lt $array_entries.Length; $i++) {
        $entry = $array_entries[$i]
        $value = $array_values[$i]
        if ((Get-ItemProperty "registry::$key_HKLM_UX_Settings").$entry -ne $null) {
            Write-Verbose "$message_set_defaultvalue $key_HKLM_UX_Settings \ $entry to $value"
            Set-ItemProperty "registry::$key_HKLM_UX_Settings" `
                        -Name $entry -Value $value -Type DWORD -ErrorAction Continue -ErrorVariable CurrentError
        }
    }
}
if ((Get-ItemProperty "registry::$key_HKLM_AUOptions").$entry_HKLM_AUoptions -ne $null) {
    Write-Verbose "$message_remove_entry $entry_HKLM_AUOptions under $key_HKLM_AUOptions"
    Remove-ItemProperty "registry::$key_HKLM_AUOptions" -Name "$entry_HKLM_AUOptions"
}


                   