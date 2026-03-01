Function schedule-windowstask {
    [cmdletBinding()]
    param (
        [Parameter (Mandatory=$true)]
        $scriptPath,
        [Parameter (Mandatory=$true)]
        $taskPath
        )
    $action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -File $scriptPath"
    $trigger = New-ScheduledTaskTrigger -Daily -At 9am
    $principal = New-ScheduledTaskPrincipal -User "System" -LogonType ServiceAccount -RunLevel Highest
    Register-ScheduledTask -TaskName "ProcessMonitor" -Action $action -Trigger $trigger -Principal $principal -Description "Daily process monitor" -TaskPath $taskPath

}

schedule-windowstask -scriptPath "C:\Yash\training\powershell\set1\process_check.ps1" -taskPath "\PowerShell\Admin"

