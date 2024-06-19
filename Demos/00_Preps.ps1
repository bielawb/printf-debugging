$creds = Import-Clixml -Path C:\RecycleBin\creds.clixml
$session = New-PSSession -ComputerName 192.168.56.10 -Credential $creds
$sampleFolder = Join-Path $PSScriptRoot -ChildPath SampleFiles
if ($env:PSModulePath -split ';' -notcontains $sampleFolder) {
    $env:PSModulePath += ";$sampleFolder"
}
