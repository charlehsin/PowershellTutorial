<#  Default
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System]
"ConsentPromptBehaviorAdmin"=dword:00000005
"ConsentPromptBehaviorUser"=dword:00000003
"EnableInstallerDetection"=dword:00000001
"EnableLUA"=dword:00000001
"EnableSecureUIAPaths"=dword:00000001
"EnableUIADesktopToggle"=dword:00000000
"EnableVirtualization"=dword:00000001
"PromptOnSecureDesktop"=dword:00000001
"ValidateAdminCodeSignatures"=dword:00000000
"FilterAdministratorToken"=dword:00000000
#>

$message_set_defaultvalue = "Set existing registry entry to default value: "
$key_UAC = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"

$array_entries = 'ConsentPromptBehaviorAdmin', 'ConsentPromptBehaviorUser', 'EnableInstallerDetection', 'EnableLUA', 'EnableSecureUIAPaths', ` 
    'EnableUIADesktopToggle', 'EnableVirtualization', 'PromptOnSecureDesktop', 'ValidateAdminCodeSignatures', 'FilterAdministratorToken'
$array_values = 5, 3, 1, 1, 1, 0, 1, 1, 0, 0

if ((Test-Path "registry::$key_UAC")) {
    for ($i = 0; $i -lt $array_entries.Length; $i++) {
        $entry = $array_entries[$i]
        $value = $array_values[$i]
        if ((Get-ItemProperty "registry::$key_UAC").$entry -ne $null) {
            Write-Verbose "$message_set_defaultvalue $key_UAC \ $entry to $value"
            Set-ItemProperty "registry::$key_UAC" `
                        -Name $entry -Value $value -Type DWORD -ErrorAction Continue -ErrorVariable CurrentError
        }
    }
}