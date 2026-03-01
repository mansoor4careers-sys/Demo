Function eventlog-check {
[cmdletbinding()]
param()
$eventdetails = Get-EventLog -LogName System -EntryType Error | Sort-object Time -Descending | Select-Object EventID,MachineName,Message,Source,TimeGenerated -First 20

foreach ($event in $eventdetails)
    {
        write-host $event.EventID,$event.MachineName,$event.Message,$event.Source,$event.TimeGenerated
    }

}


eventlog-check