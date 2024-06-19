Enter-PSSession -Session $session
Start-ScheduledTask -TaskName Task
Get-PSHostProcessInfo
Get-CimInstance -ClassName Win32_Process -Filter "Name = 'powershell.exe'" |
    Select-Object -Property ProcessId, CommandLine

$myProcess = Get-CimInstance -ClassName Win32_Process -Filter "CommandLine LIKE '%Invoke-ThePoke%'"
Enter-PSHostProcess -Id $myProcess.ProcessId

whoami

Get-Runspace

Debug-Runspace -Id 1
