function Run-MonthlyAccountCleanupReport{
Import-Module ActiveDirectory

$Stage3OU = "OU=Stage3,OU=Staged-less90Days,OU=Disabled Accounts,OU=US,DC=ezcorp,DC=com"

$anonUsername = "anonymous"
$anonPassword = ConvertTo-SecureString -String "anonymous" -AsPlainText -Force
$anonCredentials = New-Object System.Management.Automation.PSCredential($anonUsername, $anonPassword)


$Stage3Accounts = Get-ADUser -properties * -SearchBase $Stage3OU -Filter { (Enabled -eq $false) } | select GivenName, Surname, SamAccountname, Description, EmployeeID | ConvertTo-Html
Send-MailMessage -To "ruben_reyes@ezcorp.com" -From "monthlycleanupnotice@ezcorp.com" -Subject "Monthly Account Cleanup Notice" -Body "The following accounts will be processed for deletion in accordance with our account management process. Please contact WinEngineeringTeam@ezcorp.com should you have any questions or concerns. $Stage3Accounts" -BodyAsHtml -SmtpServer "ezmail-out.ezcorp.com" -Port 25 -Credential $anonCredentials
=======
$Stage3Accounts = Get-ADUser -properties * -SearchBase $Stage3OU -Filter { (Enabled -eq $false) } |
Select-Object @{Label = "First Name";Expresion = {$_.GivenName}}, 
              @{Label = "Last Name";Expresion = {$_.Surname}},
              @{Label = "Username";Expresion = {$_.SamAccountname}},
              @{Label = "Description";Expresion = {$_.Description}},
              @{Label = "Employee ID";Expresion = {$_.EmployeeID}} | 
ConvertTo-Html
Send-MailMessage -To "ruben_reyes@ezcorp.com" -From "techsupport@ezcorp.com" -Subject "Monthly Account Cleanup Notice" 
-Body "The following accounts will be processed for deletion in accordance with our account management process. Please contact 
WinEngineeringTeam@ezcorp.com should you have any questions or concerns. $Stage3Accounts" -BodyAsHtml -SmtpServer "ezmail-out.ezcorp.com" -Port 25 -Credential $anonCredentials
    }