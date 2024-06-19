Enter-PSSession -Session $session

Enable-DscDebug
Get-DscLocalConfigurationManager | ForEach-Object -MemberName DebugMode
Start-DscConfiguration -UseExisting -Wait -Verbose

Exit-PSSession

psedit .\SampleFiles\TestConfiguration.ps1

ScheduledTask -OutputPath C:\RecycleBin
Copy-Item -ToSession $session -Path C:\RecycleBin\DC01.mof -Destination C:\temp

Enter-PSSession -Session $session
Start-DscConfiguration -Path C:\temp

Get-PSHostProcessInfo | Where-Object -Property AppDomainName -EQ DscPsPluginWkr_AppDomain | Tee-Object -Variable dsc
Enter-PSHostProcess -Id $dsc.ProcessId -AppDomainName DscPsPluginWkr_AppDomain
Get-Runspace
Debug-Runspace -Id 2