$baseOu = (Get-ADDomain).DistinguishedName

if ( !(Get-ADOrganizationalUnit -Filter {DistinguishedName -eq "OU=Sites,$baseOu"}) ) {
    # Create Parent OU
    $parentOu = New-ADOrganizationalUnit -Name Sites -Path $baseOu -ProtectedFromAccidentalDeletion $true -PassThru

    # Create level OUs
    foreach ( $l in "CO","ES","MS","HS" ) {
        $levelOu = New-ADOrganizationalUnit -Name $l -Path $parentOu.DistinguishedName -ProtectedFromAccidentalDeletion $true -PassThru

        if ( $l -eq "CO" ) {
            foreach ( $c in "Users","Computers" ) {
                $containerOu = New-ADOrganizationalUnit -Name $c -Path $levelOu.DistinguishedName -ProtectedFromAccidentalDeletion $true -PassThru

                if ( $c -eq "Users" ) {
                    foreach ( $t in "Staff","Technology" ) {
                        $typeOu = New-ADOrganizationalUnit -Name $t -Path $containerOu.DistinguishedName -ProtectedFromAccidentalDeletion $true -PassThru
                    }
                }
            }
        }
        else {
            
            foreach ( $s in "A","B","C" ) {
                $siteOu = New-ADOrganizationalUnit -Name "$s$l" -Path $levelOu.DistinguishedName -ProtectedFromAccidentalDeletion $true -PassThru

                foreach ( $c in "Users","Computers" ) {
                $containerOu = New-ADOrganizationalUnit -Name $c -Path $siteOu.DistinguishedName -ProtectedFromAccidentalDeletion $true -PassThru

                    if ( $c -eq "Users" ) {
                        foreach ( $t in "Staff","Students" ) {
                            $typeOu = New-ADOrganizationalUnit -Name $t -Path $containerOu.DistinguishedName -ProtectedFromAccidentalDeletion $true -PassThru
                        }
                    }
                }
            }
        }
    }
}
