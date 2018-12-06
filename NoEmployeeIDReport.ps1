Import-Module ActiveDirectory
$TodaysDate = Get-Date -Format ddMMMyyyy 
get-aduser -filter * -Properties * | Where-Object {$_.Enabled -eq $true -and $_.EmployeeID -eq $null} | Select GivenName,Surname,Description,EmployeeID,Enabled,SamAccountName,EmailAddress,CanonicalName | Export-Csv c:\temp\NoEmployeeIDAccounts$TodaysDate.csv -NoTypeInformation
