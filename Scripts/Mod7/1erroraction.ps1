#dir variable:*prefe*

$ErrorActionPreference

Get-WmiObject win32_bios -ComputerName NotOnline,localhost

Get-WmiObject win32_bios -ComputerName NotOnline,localhost -EA SilentlyContinue -EV MyError
$MyError

Get-WmiObject win32_bios -ComputerName NotOnline,localhost -EA Stop

Get-WmiObject win32_bios -ComputerName NotOnline,localhost -EA Inquire

#dir variable:*error*
#$ErrorView = "CategoryView"
#Stop-Process 23,83,91 -EV e
#$ErrorView = "NormalView"