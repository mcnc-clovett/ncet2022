$server = 'netserv1'
$scopes = Import-Csv .\DHCP_Scopes.csv

Set-DhcpServerv4OptionValue `
    -ComputerName $server `
    -DnsDomain 'ad.example.edu' `
    -DnsServer 192.0.2.5

foreach ( $s in $scopes ) {
    $newScope = Add-DhcpServerv4Scope -ComputerName $server `
        -StartRange $s.StartRange `
        -EndRange $s.EndRange `
        -Name $s.Name `
        -State $s.State `
        -LeaseDuration $s.LeaseDuration `
        -SubnetMask $s.SubnetMask `
        -Type $s.Type `
        -PassThru

    Set-DhcpServerv4OptionValue -ComputerName $server `
        -ScopeId $newScope.ScopeId `
        -Router $s.Router
}