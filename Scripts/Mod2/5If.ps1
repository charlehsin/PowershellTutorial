﻿If ($this -eq $that) {
  # commands
} elseif ($those -ne $them) {
  # commands
} elseif ($we -gt $they) {
  # commands
} else {
  # commands
}


If ($Status -eq "Running") {
    Clear-Host
    Write-Output "Service is being stopped"
    Stop-Service -name bits
} Else {
    Clear-Host
    Write-Output "Service is already stopped"
}