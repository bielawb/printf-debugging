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
