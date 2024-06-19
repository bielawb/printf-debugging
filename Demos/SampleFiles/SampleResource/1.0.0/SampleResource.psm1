[DscResource()]
class PSConfEU {
    [DscProperty(Key)]
    [String]$Foo
    
    [DscProperty()]
    [String]$Bar
    
    [PSConfEU] Get () {
        return @{
            Foo = $this.Foo
            Bar = '{0} is Bar' -f $this.Foo
        }
    }
    
    [bool] Test () {
        if ($this.Foo -eq 'Long') {
            foreach ($item in 1..1000) {
                $item
                Start-Sleep -Seconds 10
            }
            return $false
        } else {
            foreach ($item in 1..1000) {
                $item
                Start-Sleep -Milliseconds 100
            }
            return $true        
        }
    }
    
    Set () {
        # To be honest... no point in doing anything, is there? ;)
    }
}