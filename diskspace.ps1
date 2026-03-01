#*******************************************************************************************************************************************
Function disk-spacecheck {
[cmdletbinding()]
param ()
foreach ($drive in Get-PSDrive -PSProvider FileSystem)
    {
        $totalGB = [math]::Round(($drive.Used + $drive.Free) / 1GB, 2)
        $freeGB  = [math]::Round($drive.Free / 1GB, 2)
        $percentfree = ($freeGB/$totalGB)*100
        if ($percentfree -lt 25)
            {
                write-host "Drive: "$drive.Name"found with space less space, Free space left: "$percentfree
            }
    }
}

disk-spacecheck