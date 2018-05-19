@echo off
rem Author: Jeremy Browne
rem Created: 11 MAY 18

color b 

rem You need to create a .csv file containing a list of all your VPN connections
rem the .csv must for formatted name, URL, PSK.
echo Updating VPN's from VPN.csv

timeout /t 2
@echo off

rem Copies the batch file to the desktop to connect and launch RDG
robocopy .\ %userprofile%\Desktop\ ConnectAndLaunch.lnk
robocopy .\ %userprofile%\Desktop\ ConnectToVPN.lnk
robocopy .\ %userprofile%\Desktop\ Disconnect_VPN.lnk

cls
echo Copied Connect and Launch shortcut to desktop

@echo off
timeout /t 3

rem Launches AutoAdd Powershell script
Powershell.exe -ExecutionPolicy remotesigned -File .\AutoAdd.ps1
cls

echo Done!