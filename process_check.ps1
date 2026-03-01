#***********************************************************************************************************************************
Function process-check {
[cmdletbinding()]
param(
    [Parameter (Mandatory=$true)]
    $Path
    
    )
$processdata = Get-Process | Sort-Object WorkingSet -Descending | select-object Name, CPU, Handles, Threads, @{ Name = "Memory(MB)" ; Expression = {[math]::Round($_.WorkingSet/1MB)} } -First 10
foreach($process in $processdata)
    {
       $data = @(
            [PSCustomObject] @{
            "ProcessName" = $process.Name
            "CPU" = $process.CPU
            "Handles" = $process.Handles 
            "Threads" = $process.Threads 
            "Memory(MB)" = $process.'Memory(MB)'
            }
        )
        $data | Export-Excel $Path -Append
    }

}

process-check -Path "c:\temp\process.xlsx"