<#
 Comment based help
#>
Function Verb-Noun {

    [CmdletBinding()]
    Param(
        [Parameter()][String]$MyString,
        [Parameter()][Int]$MyInt
    )

    Begin{<#Code#> "Begin $MyString"}
    Process{<#Code#> "Process $MyString"}
    End{<#Code#> "End $MyString"}
}

#Begin, Process, End will be usefull when we use piped input
#Begin is to set up the initial task. It does not run indiviual input if input is multiple items.
#Process is for each indiviual item. This is sequential, not parallel. 
#For Verb-Noun2, try 1..5 | Verb-Noun2
#For Verb-Noun3, try 1..5 | Verb-Noun3

Function Verb-Noun2 {

    [CmdletBinding()]
    Param(
        [Parameter(valuefrompipeline)][String]$MyString,
        [Parameter()][Int]$MyInt
    )

    Begin{<#Code#> "Begin $MyString"}
    Process{<#Code#> "Process $MyString"}
    End{<#Code#> "End $MyString"}
}

Function Verb-Noun3 {

    [CmdletBinding()]
    Param(
        [Parameter()][String]$MyString,
        [Parameter(valuefrompipeline)][Int]$MyInt
    )

    Begin{<#Code#> $total = 0}
    Process{<#Code#> $total += $MyInt}
    End{<#Code#> "total = $total"}
}
