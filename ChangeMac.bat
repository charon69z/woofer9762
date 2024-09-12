@echo off
:: Batch file to change MAC address

:: Define the network adapter name (you can adjust this to match your adapter)
set adapter_name="Wi-Fi"

:: Define the new MAC address (you can customize this)
set new_mac=02:1A:2B:3C:4D:5E

:: Display the current MAC address
echo Current MAC address for %adapter_name%:
getmac /v /fo list | findstr /C:"%adapter_name%"

:: Change the MAC address
echo Changing MAC address to %new_mac%...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\0001" /v "NetworkAddress" /d "%new_mac%" /f

:: Disable the network adapter
echo Disabling network adapter...
netsh interface set interface name=%adapter_name% admin=disable

:: Enable the network adapter
echo Enabling network adapter...
netsh interface set interface name=%adapter_name% admin=enable

:: Display the new MAC address
echo New MAC address for %adapter_name%:
getmac /v /fo list | findstr /C:"%adapter_name%"

echo MAC address change complete.
pause
