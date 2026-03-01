Function service-healthcheck {

<#
    .SYNOPSIS
    Checks the health of Windows services and exports the result.

    .DESCRIPTION
    This function retrieves the status of important Windows services
    and optionally exports the output to an Excel file for reporting.

    .PARAMETER Path
    Full path to the Excel file where service health data will be exported.

    .EXAMPLE
    service-healthcheck -Path "C:\temp\service_healthcheck.xlsx"

    .NOTES
    Author  : Yash
    Purpose : Windows Service Health Check
    #>

    [cmdletbinding()]
    param (
            [Parameter (Mandatory=$true)]
            $Path
          )
    $count = 0
    foreach ($service in Get-Service | Select-Object ServiceName, ServiceType, Status, DisplayName, StartType)
        {
            $filename = Split-Path $Path -Leaf
            $filepath = Split-Path $Path -Parent

            if ($service.Status -eq "Stopped" -and $service.starttype -eq "Automatic")
                {
                    write-host "Service Found with Staus Stopped and Start Type as Automatic: "$service.DisplayName
                    $data = @(
                        [PSCustomObject]@{
                        ServiceName = $service.ServiceName
                        DisplayName = $service.DisplayName
                        StartType = $service.StartType
                        Status = $service.status
                        }
                    )
                    if (Test-Path $Path)
                        {
                            #$data | Out-File $Path -Append
                            #$data | Export-Csv $Path -Append
                            $data | Export-Excel $Path -WorksheetName Processes -AutoSize -FreezeTopRow -AutoFilter -BoldTopRow -Append
                        }
                    else
                        {
                            #New-Item -ItemType File -Path $filepath -Name $filename
                            #$data | Out-File $Path
                            #$data | Export-Csv $Path
                            $data | Export-Excel $Path -WorksheetName Processes -AutoSize -FreezeTopRow -AutoFilter -BoldTopRow                           
                        }                
                }
            else
                {
                    $count +=1
                }
        }

        if ($count -eq 0)
            {
                write-host "No Service found with Status as Stopped and Start Type as Automatic..."
            }

}

#***********************************************************************************************************************************************************
#service-healthcheck -Path "c:\temp\service_healthcheck.xlsx"








