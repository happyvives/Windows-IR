
# Purpose of this Powershell Script
 This Powershell can be used on a windows machine to collect the below information and can be used on Crowdstrike RTR to collect logs. This process is automated and zips the files into 1 single folder.

# How to use this Command in Windows
Run this PS with Admin rights from a windows workstation

# How to use this Command in Crodstrike Admin Console
Add this script to custom scripts in Cwordstrike admin console 
Run from RTR Console = runscript -CloudFile="Windows-IR-Event-Collection" -Timeout="300"

# Logs collected 
Events Collected, Local user accounts, Running Process with user, Location, outbound connections, Client DNS Cache,Windows Events- System, Security, Application
Installed Software, Temp and Downloads folder with executables, Chrome and Edge Browser History( getting some data, still working on tweaking this)
,Scheduled Task, Run Once registry content, Services with AutoMode, Local Firewall Rules and Connections, Command History
More to be added...


