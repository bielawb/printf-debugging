function Set-FCPort {
    param (
        $Switch,
        $Port,
        $ConnectedDevice,
        $ConnectedPort,
        [ValidateSet(
                'Enabled',
                'Disabled'
        )]
        $State
    )

    switch ($State) {
        Enabled {
            [PSCustomObject]@{
                Switch = $Switch
                Port = $Port
                Description = '{0}_{1}' -f $ConnectedDevice, $ConnectedPort
            }
        }
        Disabled {
            [PSCustomObject]@{
                Switch = $Switch
                Port = $Port
                Description = 'port{0}' -f $Port
            }
        }
    }
}

