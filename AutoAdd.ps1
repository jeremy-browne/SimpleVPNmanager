# Author: Jeremy Browne
# Created: 11 MAY 18

# Import the csv containing the list of VPNs
$filepath ='.\VPN.csv'
$VPNcsv = import-csv $filepath

# For each line in the CSV, add the VPN with the name, URL and Key
Foreach ($line in $VPNcsv){
    try{
    write-host 'Adding'$line.Name'to the list of VPNs.' -ForegroundColor DarkGray
    write-host ''
    Add-VpnConnection `
        -Name $line.Name `
        -ServerAddress $line.URL `
        -TunnelType L2tp `
        -AuthenticationMethod Pap `
        -EncryptionLevel Optional `
        -L2tpPsk $line.PSK `
        -PassThru `
        -RememberCredential `
        -Force
    } catch {
        write-host 'Adding'$line.Name'Failed. You already have the VPN' -ForegroundColor DarkRed
        write-host ''
    }
}
Write-Host "Task Complete" -ForegroundColor Green

# Prompt user to update Meraki Credentials. Any choice other than Y will exit the switch.
Write-host "Would you like to update your Meraki Credentials? (Y if this is the first time you have run this)" -ForegroundColor Green 
    $Readhost = Read-Host " (Y / N) " 
    Switch ($ReadHost) 
     { 
       Y {Write-host "Yes"; .\SetSecureCredential.ps1} 
       N {Write-Host "No"; break} 
       Default {Write-Host "Defaulting to No"; break}
     }

# Uncomment to Remove all VPNS if you want to start fresh
# Foreach ($line in $VPNcsv){
#     write-host 'removing' $line.Name 'from the list of VPNs'
#     Remove-VpnConnection $line.Name -Force
# }