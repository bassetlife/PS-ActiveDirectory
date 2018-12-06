Import-Module activedirectory 
$TodaysDate = Get-Date -Format ddMMMyyyy
Get-ADComputer -Filter {OperatingSystem -Like 'Windows Server*'} -Property * | Format-Table Name,OperatingSystem,OperatingSystemServicePack -Wrap -Auto | Export-Csv c:\Temp\AllWindowsServers$TodaysDate.csv
