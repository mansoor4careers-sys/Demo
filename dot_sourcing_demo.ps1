cd C:\yash\training\powershell\set1\
. .\service_healthcheck.ps1
. .\diskspace.ps1
. .\eventlog.ps1
. .\process_check.ps1

process-check -Path "c:\temp\process.xlsx"
eventlog-check
disk-spacecheck
service-healthcheck -Path "c:\temp\service_healthcheck.xlsx"

Get-Help service-healthcheck -Examples

