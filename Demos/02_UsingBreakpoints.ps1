Get-Command Set-PSBreakpoint -Syntax
Set-PSBreakpoint -Variable StackTrace -Mode Write

function Get-Break {
    Get-Process -Id 13 -ErrorAction Stop
}

Set-PSBreakpoint -Variable foo -Action {
    if ($foo -eq 2) {
        break
    }
}
