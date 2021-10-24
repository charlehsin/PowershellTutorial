
Get-MpPreference

Get-MpThreat




# Add Exclusion Extension to MpPreference. This is not default setting.
$a = @("obj","bat")
Add-MpPreference -ExclusionExtension $a

# Add Exclusion Path to MpPreference. This is not default setting.
$a = @("C:\Common7","C:\PerfLogs")
Add-MpPreference -ExclusionPath $a

# Add Exclusion Process to MpPreference. This is not default setting.
$a = @("C:\bat\1.exe","C:\PerfLogs\2.exe")
Add-MpPreference -ExclusionProcess $a






# Set Exclusion Extension to empty. This is default setting.
if ((Get-MpPreference).ExclusionExtension -ne $null) {
    Remove-MpPreference -ExclusionExtension ((Get-MpPreference).ExclusionExtension)
}

# Set Exclusion Path to empty. This is default setting.
if ((Get-MpPreference).ExclusionPath -ne $null) {
    Remove-MpPreference -ExclusionPath ((Get-MpPreference).ExclusionPath)
}

# Set Exclusion Process to empty. This is default setting.
if ((Get-MpPreference).ExclusionProcess -ne $null) {
    Remove-MpPreference -ExclusionProcess ((Get-MpPreference).ExclusionProcess)
}

# Set ThreatIDDefaultAction_Actions to empty. This is default setting.
if ((Get-MpPreference).ThreatIDDefaultAction_Actions -ne $null) {
    Remove-MpPreference -ThreatIDDefaultAction_Actions ((Get-MpPreference).ThreatIDDefaultAction_Actions)
}
# Set ThreatIDDefaultAction_Ids to empty. This is default setting.
if ((Get-MpPreference).ThreatIDDefaultAction_Ids -ne $null) {
    Remove-MpPreference -ThreatIDDefaultAction_Ids ((Get-MpPreference).ThreatIDDefaultAction_Ids)
}

# Remove HighThreatDefaultAction and LowThreatDefaultAction. This is default setting.
Remove-MpPreference -HighThreatDefaultAction -LowThreatDefaultAction -ModerateThreatDefaultAction -SevereThreatDefaultAction -UnknownThreatDefaultAction

# Set SignatureDefinitionUpdateFileSharesSources to empty. This is default setting.
# Strictly speaking the default is an empty string; however, the Cmdlet does not allow us to set it to empty string.
if ((Get-MpPreference).SignatureDefinitionUpdateFileSharesSources -ne [String]::Empty) {
    Set-MpPreference -SignatureDefinitionUpdateFileSharesSources '{}'
}

# Set other to default
Set-MpPreference -CheckForSignaturesBeforeRunningScan $false -DisableArchiveScanning $false -DisableAutoExclusions $false `
    -DisableBehaviorMonitoring $false -DisableCatchupFullScan $true -DisableCatchupQuickScan $true -DisableEmailScanning $true `
    -DisableIntrusionPreventionSystem $false -DisableIOAVProtection $false -DisablePrivacyMode $false -DisableRealtimeMonitoring $false `
    -DisableRemovableDriveScanning $true -DisableRestorePoint $true -DisableScanningMappedNetworkDrivesForFullScan $true `
    -DisableScanningNetworkFiles $false -DisableScriptScanning $false -MAPSReporting Advanced -QuarantinePurgeItemsAfterDelay 90 `
    -RandomizeScheduleTaskTimes $true -RealTimeScanDirection Both -RemediationScheduleDay Everyday -RemediationScheduleTime '02:00:00' `
    -ReportingAdditionalActionTimeOut 10080 -ReportingCriticalFailureTimeOut 10080 -ReportingNonCriticalTimeOut 1440 -ScanAvgCPULoadFactor 50 `
    -ScanOnlyIfIdleEnabled $true -ScanParameters QuickScan -ScanPurgeItemsAfterDelay 15 -ScanScheduleDay Everyday -ScanScheduleQuickScanTime '00:00:00' `
    -ScanScheduleTime '02:00:00' -SignatureAuGracePeriod 1440 -SignatureDisableUpdateOnStartupWithoutEngine $false `
    -SignatureFallbackOrder 'MicrosoftUpdateServer|MMPC' -SignatureFirstAuGracePeriod 1 -SignatureScheduleDay Never -SignatureScheduleTime '01:45:00' `
    -SignatureUpdateCatchupInterval 1 -SignatureUpdateInterval 8 -SubmitSamplesConsent Always -UILockdown $false 

