
# Get-CompInfo -ComputerName localhost -ErrorLog -Verbose

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
    Process{}
    End{}

}

