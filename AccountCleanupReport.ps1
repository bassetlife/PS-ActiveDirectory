Import-Module ActiveDirectory

$Stage3OU = "OU=Stage3,OU=Staged-less90Days,OU=Disabled Accounts,OU=US,DC=ezcorp,DC=com"

$anonUsername = "anonymous"
$anonPassword = ConvertTo-SecureString -String "anonymous" -AsPlainText -Force
$anonCredentials = New-Object System.Management.Automation.PSCredential($anonUsername, $anonPassword)

$Stage3Accounts = Get-ADUser -properties * -SearchBase $Stage3OU -Filter { (Enabled -eq $false) } |
Select-Object @{Label="First Name";Expression = {$_.GivenName}}, 
              @{Label="Last Name";Expression = {$_.Surname}},
              @{Label="Username";Expression = {$_.SamAccountname}},
              @{Label="Description";Expression = {$_.Description}},
              @{Label="Employee ID";Expression = {$_.EmployeeID}} | ConvertTo-Html

Send-MailMessage -To "monthlycleanupnotice@ezcorp.com" -From "techsupport@ezcorp.com" -Subject "Monthly Account Cleanup Notice" -Body "The following accounts will be processed for deletion in accordance with our account management process. Please contact 
WinEngineeringTeam@ezcorp.com should you have any questions or concerns. $Stage3Accounts" -BodyAsHtml -SmtpServer "ezmail-out.ezcorp.com" -Port 25 -Credential $anonCredentials

