#*************************************************************************************************************************************
Function local-usercheck {
[cmdletbinding()]
param()
$excluded = @("Administrator", "DefaultAccount", "Guest", "WDAGUtilityAccount")
$disabledusers = Get-LocalUser | Where-Object {$_.Enabled -eq $false -and $_.Name -notin $excluded }
$notloggedinyet = Get-LocalUser | Where-Object {$_.lastlogon -eq $null -and $_.Name -notin $excluded} 
if ($disabledusers.count -eq 0)
    {
        write-host "No disabled users found.."
    }
else
    {
        foreach ($user in $disabledusers)
            {
                write-host $user.Name" was found disabled."
            }
    }
if ($notloggedinyet.count -eq 0)
    {
        write-host "No user found who is yet to login.."
    }
else
    {
        foreach ($user in $notloggedinyet)
            {
                write-host $user.Name" is yet to login."
            }
    }

}

local-usercheck