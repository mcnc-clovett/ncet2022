$domainName = (Get-ADDomain).DNSRoot
$staff = Import-Csv C:\Users\clovett-adm\Documents\Staff.csv
$students = Import-Csv C:\Users\clovett-adm\Documents\Students.csv

foreach ( $l in $staff,$students ) {
    foreach ( $s in $l ) {
        $username = ($s.GivenName.Substring(0,1)+$s.Surname.Substring(0,4)+$s.EmployeeID.Substring(($s.EmployeeID.Length-4),4))
        New-ADUser -Name $username `
            -DisplayName "$($s.GivenName) $($s.Surname)" `
            -PasswordNeverExpires $false `
            -CannotChangePassword $false `
            -ChangePasswordAtLogon $false `
            -AccountPassword (ConvertTo-SecureString -AsPlainText -String $s.Password -Force)`
            -UserPrincipalName "$username@$domainName"`
            -EmployeeID $s.EmployeeID `
            -Enabled $true `
            -GivenName $s.GivenName `
            -Surname $s.Surname `
            -PasswordNotRequired $false `
            -Path $s.OU `
            -SamAccountName $username
    }
}