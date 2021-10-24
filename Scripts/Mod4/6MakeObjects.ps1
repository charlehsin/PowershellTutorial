
#Object is good.
#Now we can pipe our output to toher cmdlet that takes object as input
#Try Get-CompInfo -ComputerName localhost | ConvertTo-Json

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
            
            $Prop=@{ #With or without [ordered]
                'ComputerName'=$c;
                'OS Name'=$os.caption;
                'OS Build'=$os.buildnumber;
                'FreeSpace'=$Disk.freespace / 1gb -as [int]
            }
        $Obj=New-Object -TypeName PSObject -Property $Prop 
        Write-Output $Obj

        } 
    }
    End{}

}

