# Command used the most - to set break points...
Get-Command -Name Set-PSBreakpoint -Syntax

# Few other commands at our disposal...
Get-Help -Name *-PSBreakpoint

# Trick: any terminating error would write to $StackTrace, so we can catch non-terminating errors this way...
Set-PSBreakpoint -Variable StackTrace -Mode Write

# Test - how does it behave...?
function Get-Break {
    Get-Process -Id 13 -ErrorAction Stop
}

# source: https://4sysops.com/archives/setting-powershell-breakpoints-on-an-exception/

# We can have conditional breakpoints too!
Set-PSBreakpoint -Variable foo -Action {
    if ($foo -eq 5) {
        break
        
        # we can use continue or break - defaults to continue so we can skip it too...
    }
}

# Lets see it in action... :)
foreach ($foo in 1..10) {
    Write-Warning -Message "Foo is $foo"
}

# From Case of Unexplained session - issue with using Switch as a parameter name...
Import-Module .\SampleFiles\FibreChannelSwitch.psm1
Set-FCPort -Switch test_psconf_01 -Port 42 -ConnectedDevice test_psconf_02 -ConnectedPort 42 -State Enabled

# What happened with the switch...? We set it with -Parameter, but when read, we got different value...
# Set a breakpoint on READ mode for Switch variable and try again...
Set-PSBreakpoint -Script .\SampleFiles\FibreChannelSwitch.psm1 -Variable Switch -Mode Read

Set-FCPort -Switch test_psconf_01 -Port 42 -ConnectedDevice test_psconf_02 -ConnectedPort 42 -State Enabled

<#
        But what if we need to debug...
        - scheduled task
        - any other automation platform that uses PowerShell
        - PowerShell Universal
        - other tools that use PowerShell as a code-behind for REST APIs
        - Desired State Configuration (DSC)
#>
