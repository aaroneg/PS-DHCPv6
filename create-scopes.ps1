. $PSScriptRoot\config.ps1
Import-Module dhcpserver
foreach ($Server in $DHCPServers) {
    foreach ($Scope in $DHCP6Scopes) {
        try {
            $ScopeObject=Get-DhcpServerv6Scope -ComputerName $Server -Prefix ($Scope.Network -split '/')[0] -ErrorAction Stop
            "Scope $($ScopeObject.Prefix) on server $($server) exists, skipping."
            $ScopeObject|Set-DhcpServerv6Scope -Description "Vlan $($Scope.VLAN)" -ComputerName $server
        }
        catch {
            "Scope not found, adding:"
            $ScopeObject=Add-DhcpServerv6Scope -ComputerName $Server -Prefix ($Scope.Network -split '/')[0] -Name $Scope.Name -State Active -PassThru
            $ScopeObject|Set-DhcpServerv6Scope -Description "Vlan $($Scope.VLAN)" -ComputerName $server
        }
    }
}