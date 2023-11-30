##############-----------Create Directory to place collected files##############-----------
mkdir c:\001-2023-event-log-collection

##############-----------Sleep for 5 seconds before tunning scripts##############-----------
Start-Sleep -Seconds 5

##############-----------Change Directory##############-----------
cd c:\001-2023-event-log-collection 

##############-----------Sleep for 5 seconds before tunning scripts##############-----------
Start-Sleep -Seconds 5

##############-----------Export all Live connections in Memory##############-----------
netstat -aon > -$((Get-Date).ToString('MM-dd-yyyy'))-netsat.txt


##############-----------Get Command History##############-----------
Get-History -count 500 | Export-CSV -$((Get-Date).ToString('MM-dd-yyyy'))-command-history.txt

##############-----------Sleep for 3 seconds before tunning scripts##############-----------
Start-Sleep -Seconds 3


##############-----------Get Installed Software##############-----------
Get-CimInstance -ClassName win32_product | Select-Object Name, Version, Vendor, InstallDate, InstallSource, PackageName, LocalPackage | Export-CSV -$((Get-Date).ToString('MM-dd-yyyy'))-installed-software.txt  -NoTypeInformation


##############-----------Export Curent Registry AutoRun##############-----------
reg export  HKLM\Software\Microsoft\Windows\CurrentVersion\Run -$((Get-Date).ToString('MM-dd-yyyy'))-reg-autorun.reg

##############-----------Export Curent Registry Rune Once##############-----------
Get-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce | Export-CSV -$((Get-Date).ToString('MM-dd-yyyy'))-reg-runonce.txt  -NoTypeInformation



##############-----------Get System Win Events##############-----------
Get-WinEvent -LogName "System" -MaxEvents 600 | Export-CSV -$((Get-Date).ToString('MM-dd-yyyy'))-system-logs.txt -NoTypeInformation

##############-----------Get Application Win Events##############-----------
Get-WinEvent -LogName "Application" -MaxEvents 600 | Export-CSV -$((Get-Date).ToString('MM-dd-yyyy'))-application_logs.txt -NoTypeInformation


##############-----------Get Security Win Events##############-----------
Get-WinEvent -LogName "Security" -MaxEvents 600 | Export-CSV -$((Get-Date).ToString('MM-dd-yyyy'))-security-logs.txt -NoTypeInformation
 
 
##############-----------Get PowerShell Win Events##############-----------
Get-WinEvent -LogName "*Powershell*" -MaxEvents 600 | Export-CSV -$((Get-Date).ToString('MM-dd-yyyy'))-powershell-winevent.txt -NoTypeInformation

##############-----------Gets DNS Client Cahce##############-----------
 Get-DnsClientCache | select Entry,Name, Status, TimeToLive, Data | Export-CSV -$((Get-Date).ToString('MM-dd-yyyy'))-dns-client-cache.txt -NoTypeInformation

##############-----------Get Current Process##############-----------
 Get-Process -includeusername| Export-CSV -$((Get-Date).ToString('MM-dd-yyyy'))-get-running-process.txt  -NoTypeInformation

##############-----------Get current Process Name and IP connection##############-----------
Get-NetTCPConnection | Select-Object LocalAddress, LocalPort, RemoteAddress, RemotePort, State, OwningProcess, @{Name="Process";Expression={(Get-Process -Id $_.OwningProcess).ProcessName}} | Export-CSV -$((Get-Date).ToString('MM-dd-yyyy'))-processname-ipconnections.txt -NoTypeInformation

##############-----------Get Firewall Rule information for allow Firewall Rule connections##############-----------
Get-NetFirewallRule | select-object Name, DisplayName, Description, Direction, Action, EdgeTraversalPolicy, Owner, EnforcementStatus | Export-CSV -$((Get-Date).ToString('MM-dd-yyyy'))-firewall-connection-rules.txt -NoTypeInformation

###########----Get Executables from Temp Folder##############-----------
Get-ChildItem C:\Users\*\AppData\Local\Temp\* -recurse  |  select  PSChildName, Root, Name, FullName, Extension, CreationTimeUTC, LastAccessTimeUTC, LastWriteTimeUTC, Attributes | where {$_.extension -eq '.exe'} | Export-CSV -$((Get-Date).ToString('MM-dd-yyyy'))-executables-from-tempfolder.txt -NoTypeInformation


###########----Get Local user accounts ##############-----------
Get-WmiObject -Class Win32_UserAccount  | Select-Object -Property AccountType,Domain,LocalAccount,Name,PasswordRequired,SID,SIDType | Export-CSV -$((Get-Date).ToString('MM-dd-yyyy'))-local-user-accounts.txt -NoTypeInformation



##############-----------Get Live TCP Connections##############-----------
Get-NetTCPConnection | Export-CSV -$((Get-Date).ToString('MM-dd-yyyy'))-tpc-connections.txt -NoTypeInformation

##############-----------Get Live UPD Connections##############-----------
Get-NetUDPEndpoint | Export-CSV -$((Get-Date).ToString('MM-dd-yyyy'))-udp-connections.txt -NoTypeInformation

##############-----------Get Scheduled Task##############-----------
Get-ScheduledTask | Export-CSV -$((Get-Date).ToString('MM-dd-yyyy'))-scheduled-task.txt -NoTypeInformation

##############-----------Get Services with Auto Start Mode##############-----------
Get-CimInstance win32_service -Filter "startmode = 'auto'" | Export-CSV -$((Get-Date).ToString('MM-dd-yyyy'))-services-automode.txt -NoTypeInformation

##############-----------Get items from Downloads folder- Last 5 days##############-----------
Get-ChildItem -Path C:\USERS\*\DOWNLOADS -recurse | Where-Object {$_.LastWriteTime -gt (Get-Date).AddDays(-5)} |select directory, name, @{Name="Size in MB";Expression={$_.Length/1MB}} | Export-CSV downloads-folder-items.txt -NoTypeInformation

##############-----------Get Chrome Browser History##############-----------
$UserName = "*" 
$UserName        
$Path = "$Env:systemdrive\Users\$UserName\AppData\Local\Google\Chrome\User Data\Default\History" 
        if (-not (Test-Path -Path $Path)) { 
            Write-Verbose "[!] Could not find Chrome History for username: $UserName" 
        } 
        $Regex = '(htt(p|s))://([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)*?' 
        $Value = Get-Content -Path "$Env:systemdrive\Users\$UserName\AppData\Local\Google\Chrome\User Data\Default\History"|Select-String -AllMatches $regex |% {($_.Matches).Value} |Sort -Unique 
        $Value | ForEach-Object { 
            $Key = $_ 
            if ($Key -match $Search){ 
                New-Object -TypeName PSObject -Property @{ 
                    User = $UserName 
                    Browser = 'Chrome' 
                    DataType = 'History' 
                    Data = $_ 
                } 
            } 
        } | Export-CSV chrome-browser-histroy.txt -NoTypeInformation


##############-----------Get Edge Browser History##############-----------
$UserName = "*" 
$UserName        
$Path = "$Env:systemdrive\Users\$UserName\AppData\Local\Microsoft\Edge\User Data\Default\History" 
        if (-not (Test-Path -Path $Path)) { 
            Write-Verbose "[!] Could not find Chrome History for username: $UserName" 
        } 
        $Regex = '(htt(p|s))://([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)*?' 
        $Value = Get-Content -Path "$Env:systemdrive\Users\$UserName\AppData\Local\Microsoft\Edge\User Data\Default\History"|Select-String -AllMatches $regex |% {($_.Matches).Value} |Sort -Unique 
        $Value | ForEach-Object { 
            $Key = $_ 
            if ($Key -match $Search){ 
                New-Object -TypeName PSObject -Property @{ 
                    User = $UserName 
                    Browser = 'Edge' 
                    DataType = 'History' 
                    Data = $_ 
                } 
            } 
        } | Export-CSV edge-browser-histroy.txt -NoTypeInformation


##############-----------Compress and Zip file##############-----------
Compress-Archive -Path C:\001-2023-event-log-collection\* -DestinationPath C:\001-2023-event-log-collection.zip


##############-----------Sleep for 3 seconds before tunning scripts##############-----------
Start-Sleep -Seconds 3


##############-----------Delete Unzipped Folder "001-2023-event-log-collection"##############-----------
cd \
Remove-Item 001-2023-event-log-collection -Force -Recurse

##############-----------Exits PS##############-----------
Start-Sleep -Seconds 3
Exit 3
