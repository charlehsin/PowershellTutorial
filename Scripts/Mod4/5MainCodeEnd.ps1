Function Get-CompInfo{
    [CmdletBinding()]
    Param(
        #Want to support multiple computers
        [String[]]$ComputerName,
        #Switch to turn on Error logging
        [Switch]$ErrorLog,
        [String]$LogFile = 'c:\errorlog.txt'
    )
    Begin{
        If($errorLog){
                Write-Verbose 'Error logging turned on'
            } Else {
                Write-Verbose 'Error logging turned off'
            }
            Foreach($C in $ComputerName){
                Write-Verbose "Computer: $C"
            }    
    }
    Process{
        foreach($C in $ComputerName){
            $os=Get-Wmiobject -ComputerName $C -Class Win32_OperatingSystem
            $Disk=Get-WmiObject -ComputerName $C -class Win32_LogicalDisk -filter "DeviceID='c:'"
            
            #Hash table
            $Prop=[ordered]@{
                'ComputerName'=$C
                'OS Name'=$os.caption
                'OS Build'=$os.buildnumber
                'FreeSpace'=$Disk.freespace / 1gb -as [int]
            }
        #This doesn't produce objects yet - just for testing
        Write-Output $Prop

        } 
    }
    End{}

}

