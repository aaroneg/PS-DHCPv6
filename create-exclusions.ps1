. $PSScriptRoot\config.ps1
Import-Module dhcpserver
foreach ($Server in $DHCPServers) {
    foreach ($Scope in (Get-DhcpServerv6Scope -ComputerName $Server)) {
        try { 
            $exclusionRange=Get-DhcpServerv6ExclusionRange -ComputerName $Server -Prefix $Scope.Prefix -ErrorAction Stop
            "Exclusion for $($exclusionRange.Prefix) on $($Server) exists, skipping"
            if ($null -eq $exclusionRange) { Write-Error "Exception not found" -ErrorAction stop}
        }
        catch {
            $Scope|Add-DhcpServerv6ExclusionRange -StartRange ("$($Scope.Prefix)$($ExcludeStart)") -EndRange ("$($Scope.Prefix)$($ExcludeEnd)") -ComputerName $Server -PassThru
        }
    }   
}