
# Purpose of this Powershell Script
 This Powershell can be used on a windows machine to collect logs for traiging/investigating an event. This can also be used on Crowdstrike RTR to collect logs. This process is automated and zips the files into 1 single folder.

# How to use this Command in Windows
Open a Powershell session as "Administrator" and run PS.

# How to use this Command in Crowdstrike Admin Console
Add this script to custom scripts in Cwordstrike Admin console.
Run from RTR Console = 
runscript -CloudFile="Windows-IR-Event-Collection" -Timeout="300"

# Upload logs from RTR session to Crowdstrike Cloud and Download
get /"filename"
CLick on download file and extract 

# Logs collected 
Events Collected from this script are:
Local user accounts, Running Process with user, Location, outbound connections, Client DNS Cache,Windows Events- System, Security, Application
Installed Software, Temp and Downloads folder with executables, Chrome and Edge Browser History( getting some data, still working on tweaking this)
,Scheduled Task, Run Once registry content, Services with AutoMode, Local Firewall Rules and Connections, Command History
More to be added...

# Location of Logs collected
This script automates the log creation by creating a dicrectoty in the root of c:\ --> "001-2023-event-log-collection".

# Notice
As always test this on a non-critical system. This is a simple powershell that collects logs and places them in the root of C:, pleae make sure you have enough space. The log collection is small, about 5 megs. 
This scripts collects windows system, security and application events and is limited to Max 600 events.This can be modified to your needs. 




