﻿#get-help about_Functions_Advanced_Parameters

Function Get-CompInfo{
    [CmdletBinding()]
    Param(
        #Want to support multiple computers
        #[Parameter(Mandatory=$True)]
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
            Foreach($Computer in $ComputerName){
                Write-Verbose "Computer: $Computer"
            }    
    }
    Process{
        foreach($Computer in $ComputerName){
            $os=Get-Wmiobject -ComputerName $Computer -Class Win32_OperatingSystem
            $Disk=Get-WmiObject -ComputerName $Computer -class Win32_LogicalDisk -filter "DeviceID='c:'"
            
            $Prop=@{ #With or without [ordered]
                'ComputerName'=$computer;
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

