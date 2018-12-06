Import-Module ActiveDirectory
$TodaysDate = Get-Date -Format ddMMMyyyy
Search-ADAccount -AccountInactive -TimeSpan 90.00:00:00 | where {$_.ObjectClass -eq 'user' -and $_.Enabled -eq $true} | Select Name,Description,ObjectClass | Export-CSV c:\temp\90InactivityReport$TodaysDate.csv -NoTypeInformation