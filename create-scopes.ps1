. $PSScriptRoot\config.ps1
Import-Module dhcpserver
foreach ($Server in $DHCPServers) {
    foreach ($Scope in $DHCP6Scopes) {
        try {
            $scope=Get-DhcpServerv6Scope -ComputerName $Server -Prefix ($Scope.Network -split '/')[0] -ErrorAction Stop
            "Scope $($scope.Prefix) on server $($server) exists, skipping."
        }
        catch {
            "Scope not found, adding:"
            Add-DhcpServerv6Scope -ComputerName $Server -Prefix ($Scope.Network -split '/')[0] -Name $Scope.Name -State Active -PassThru
        }
    }
}