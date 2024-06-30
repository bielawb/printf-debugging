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

# now that debug session is in progress - we can Enter-PSSession...
Enter-PSSession -ComputerName DC01 -Credential <credentials>
# That would work in real domain, but my machine is not a member, so...
Enter-PSSession -Session $session

Enter-PSHostProcess -Id 1100 -AppDomainName DscPsPluginWkr_AppDomain
Debug-Runspace -Id 4

# We can also use same method we've used before...

# Find the right process...
Get-PSHostProcessInfo | Where-Object -Property AppDomainName -EQ DscPsPluginWkr_AppDomain | Tee-Object -Variable dsc

# Notice: AppDomainName is not a default name, so we have to specify it!
Enter-PSHostProcess -Id $dsc.ProcessId -AppDomainName DscPsPluginWkr_AppDomain

# Time to debug our code...
Get-Runspace
Debug-Runspace -Id 2