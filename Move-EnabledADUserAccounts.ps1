function Move-EnabledADUserAccounts{
    Import-Module ActiveDirectory

        $Stage3OU = "OU=Stage3,OU=Staged-less90Days,OU=Disabled Accounts,OU=US,DC=ezcorp,DC=com"
        $StatusUnknownOU = "OU=StatusUnknown,OU=Disabled Accounts,OU=US,DC=ezcorp,DC=com"

    $EnabledAccounts = Get-ADUser -properties * -Server 'EZUSDC07' -SearchBase $Stage3OU -Filter { (Enabled -eq $true) }

        foreach ($Account in $EnabledAccounts)
    {
        Move-ADObject -Identity $Account -TargetPath $StatusUnknownOU
    }

