# Connect to VM - should have scheduled task Task configured
Enter-PSSession -Session $session
Get-ScheduledTask -TaskName Task
Get-ScheduledTask -TaskName Task | ForEach-Object -MemberName Actions
psedit C:\temp\Invoke-ThePoke.ps1

Get-ScheduledTask -TaskName Task | ForEach-Object -MemberName Principal

# svg_task -- is Group Managed Service Account
Get-ADServiceAccount -Identity svg_task

# Lets start our schedule task and try to break into it... :)
Start-ScheduledTask -TaskName Task

# When we list processes - we should be able to see instance running in schedule task
Get-PSHostProcessInfo

# But what to choose..? Which one is ours...?
Get-CimInstance -ClassName Win32_Process -Filter "Name = 'powershell.exe'" |
    Select-Object -Property ProcessId, CommandLine

# Filter right process and get inside...
($myProcess = Get-CimInstance -ClassName Win32_Process -Filter "CommandLine LIKE '%Invoke-ThePoke%'")
Enter-PSHostProcess -Id $myProcess.ProcessId

# Who are we?
whoami

# What runspace can we get?
Get-Runspace

# RemoteHost is the branch we are sitting on, so remote debugging is not an option...
Debug-Runspace -Id 2

# When do we want to debug them?
Debug-Runspace -Id 1

# Done!
Exit-PSHostProcess
Exit-PSSession
