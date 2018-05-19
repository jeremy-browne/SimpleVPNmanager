# Author: Jeremy Browne
# Created: 11 MAY 18

<# 
This Script saves your username and password in the same directory

Username is saved into credu.txt in plain text
Password is saved into credp.txt in a string that is hashed against your local machine
Both files will same into the same directory as the script

Call these files in other scripts to get your username and secure password
To convert the password back to a useable format... Use this:
    Harness the power of magic to turn a system.securestring back into plain text
    FYI, a BSTR = binary string
    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password) << This converts the object to a system.securestring containing binary characters
    $ConvertedPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR) << This converts the binary characters back into a plaintext format
 #>

# Prompt the user for a username
$username = Read-Host 'Meraki Username' | Out-File '.\credu.txt'
# Prompt the user for a password, the -AsSecureString switch
$password = Read-Host 'Meraki Password' -AsSecureString | ConvertFrom-SecureString | Out-File '.\credp.txt'