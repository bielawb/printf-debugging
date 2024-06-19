function Test-WithAssignment {
    param (
        [String]$From,
        [String]$To
    )

    if ($From = $To) {
        $true    
    } else {
        $false
    }
}

function Test-WithAssignmentEx {
    param (
        [String]$From,
        [String]$To
    )
    Write-Host -Object "From: $From. To: $To"
    if ($From = $To) {
        $true
        Write-Host -Object "From: $From. To: $To"
    } else {
        $false
    }
}

Set-PSBreakpoint -Variable From -Mode Read
Test-WithAssignment -From A -To B

Set-PSBreakpoint -Variable From -Mode Write
Test-WithAssignment -From A -To B
