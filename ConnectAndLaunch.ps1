# Author: Jeremy Browne
# Created: 11 MAY 18

#This script is used to connect to existing VPN connections and then launch the corresponding RDG file used for remote support

# List all VPN Connections
Write-Host 'The current VPN connections are:'
$vpnList = Get-VpnConnection | Format-Table -Property 'Name','ConnectionStatus' -AutoSize
$vpnList

# User input
$VPN = read-host 'Type your VPN connection'
$username = Get-Content '.\credu.txt'
$password = Get-Content '.\credp.txt' | ConvertTo-SecureString

# Harness the power of magic to turn a System.Security.Securestring back into plain text
# FYI, a BSTR = binary string
$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
$ConvertedPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

# Connect to VPN 
rasdial.exe $VPN $username $ConvertedPassword

# Check VPN is connected
$ConnectStatus = Get-VpnConnection $VPN
if ($ConnectStatus.ConnectionStatus -eq "Connected") {
    Write-Host $VPN "VPN Connected" -ForegroundColor Green
} else {
    Clear-Host
    Write-Host ""
    Write-Host ""
    Write-Host ""
    Write-Host "Unable to connect to"$VPN -ForegroundColor Red
    Write-Host "Check your username and password details are correct and try again."
    Write-Host "Also check in Meraki to make sure you are authenticated for the VPN"
    Write-Host "Otherwise, try setting up and connecting to the VPN manually."
    Write-Host ""
    Write-Host ""
    Write-Host ""
    pause
}

# Launch RDG file
Write-Host 'opening'$VPN'.rdg'
.\RDCMan.exe "$env:USERPROFILE\YOURFILEPATH\$VPN\$VPN.rdg"