# Lets look at our sample configuration...
psedit .\SampleFiles\TestConfiguration.ps1

# We can generate MOF and dump it at our test box...
ScheduledTask -OutputPath C:\RecycleBin
Copy-Item -ToSession $session -Path C:\RecycleBin\DC01.mof -Destination C:\temp

# Going back to a our test VM
Enter-PSSession -Session $session

# Enable debugging - we can investigate things while they happen...
Enable-DscDebug -BreakAll
Get-DscLocalConfigurationManager | ForEach-Object -MemberName DebugMode

# We can also use same method we've used before...

# Find the right process...
Get-PSHostProcessInfo | Where-Object -Property AppDomainName -EQ DscPsPluginWkr_AppDomain | Tee-Object -Variable dsc

# Notice: AppDomainName is not a default name, so we have to specify it!
Enter-PSHostProcess -Id $dsc.ProcessId -AppDomainName DscPsPluginWkr_AppDomain

# Time to debug our code...
Get-Runspace
Debug-Runspace -Id 2