# Broken function - pure code, no 'ceremony'
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

# Same function, with Verbose stream used for printf debugging...
function Test-WithAssignmentEx {
    [CmdletBinding()]
    param (
        [String]$From,
        [String]$To
    )
    Write-Verbose -Message "From: $From. To: $To"
    if ($From = $To) {
        $true
        Write-Verbose -Message "From: $From. To: $To"
    } else {
        $false
    }
}

# Function doesn't work as expected...
Test-WithAssignment -From A -To B

# Printf debugging for rescue!
Test-WithAssignmentEx -From A -To B -Verbose

# Feels like we are not reading $From (mind - no $ next to name!)
Set-PSBreakpoint -Variable From -Mode Read
Test-WithAssignment -From A -To B

# We shouldn't be writing to it, but...
Set-PSBreakpoint -Variable From -Mode Write
Test-WithAssignment -From A -To B
