# Update Powershell help files
Update-Help

# Get help on a cmdlet
Get-Help cmdlet-name -Detailed
help cmdlet-name -Detailed
man cmdlet-name -Detailed

# Rename a computer
Rename-Computer -NewName '<some name>' -Restart

# Add computer to the domain
Add-Computer -DomainName 'ad.example.edu' -Restart

# Remove computer from the domain
Remove-Computer -Restart

# Connect to another computer
Enter-PSSession DC1
etsn DC1