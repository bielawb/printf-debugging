configuration ScheduledTask {
    Import-DscResource -ModuleName @{ ModuleName = 'ComputerManagementDsc'; RequiredVersion = '9.1.0' }
    Import-DscResource -ModuleName @{ ModuleName = 'SampleResource'; RequiredVersion = '1.0.0' }
    
    node DC01 {
        ScheduledTask Test {
            TaskPath = '\'
            TaskName = 'Task'
            ExecuteAsGMSA = 'IGO\svg_task$'
            ActionExecutable = 'powershell.exe'
            ActionArguments = '-file c:\temp\Invoke-ThePoke.ps1'
            ScheduleType = 'Once'
            StartTime = '2024-06-01 20:00'
            MultipleInstances = 'StopExisting'
            AllowStartIfOnBatteries = $true
            RunOnlyIfIdle = $false
        }

        PSConfEU FakeResource {
            Foo = 'This is foo'
            Bar = 'And that is bar'
        }
    }
}
