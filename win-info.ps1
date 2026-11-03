# utilities/win-info.ps1

# Run elevated, with Tee-Object to a file
# .\win-info.ps1 | Tee-Object -FilePath win-info.txt

Write-Output "`n# Host summary"
$os = Get-CimInstance Win32_OperatingSystem
$cs = Get-CimInstance Win32_ComputerSystem
[pscustomobject]@{
    Hostname           = $cs.Name
    Manufacturer       = $cs.Manufacturer
    Model              = $cs.Model
    OperatingSystem    = $os.Caption
    Version            = $os.Version
    BuildNumber        = $os.BuildNumber
    Architecture       = $os.OSArchitecture
    Domain             = $cs.Domain
    HypervisorPresent  = $cs.HypervisorPresent
    TotalPhysicalMemoryGB = [math]::Round($cs.TotalPhysicalMemory / 1GB, 1)
} | Format-List

$boot = $os.LastBootUpTime
$uptime = (Get-Date) - $boot
Write-Output ("up {0} days, {1} hours, {2} minutes" -f $uptime.Days, $uptime.Hours, $uptime.Minutes)
Write-Output $boot.ToString('yyyy-MM-dd HH:mm:ss')

Write-Output "`n# CPU model and topology"
Get-CimInstance Win32_Processor | Select-Object Name, NumberOfCores, NumberOfLogicalProcessors,
    MaxClockSpeed, CurrentClockSpeed, SocketDesignation, VirtualizationFirmwareEnabled |
    Format-List

Write-Output "`n# Usable memory and pagefile"
$memTotal = [math]::Round($os.TotalVisibleMemorySize / 1MB, 1)
$memFree  = [math]::Round($os.FreePhysicalMemory / 1MB, 1)
$memUsed  = [math]::Round($memTotal - $memFree, 1)
Write-Output ("Mem:  total={0}Gi  used={1}Gi  free={2}Gi" -f $memTotal, $memUsed, $memFree)
Get-CimInstance Win32_PageFileUsage | ForEach-Object {
    Write-Output ("Page: total={0}Gi  used={1}Gi  free={2}Gi  ({3})" -f
        [math]::Round($_.AllocatedBaseSize / 1024, 1),
        [math]::Round($_.CurrentUsage / 1024, 1),
        [math]::Round(($_.AllocatedBaseSize - $_.CurrentUsage) / 1024, 1),
        $_.Name)
}

Write-Output "`n# Local volumes"
Get-Volume | Where-Object { $_.DriveType -eq 'Fixed' -and $_.DriveLetter } |
    Select-Object DriveLetter, FileSystemLabel, FileSystem,
        @{N='SizeGB';E={[math]::Round($_.Size / 1GB, 1)}},
        @{N='FreeGB';E={[math]::Round($_.SizeRemaining / 1GB, 1)}},
        HealthStatus |
    Format-Table -AutoSize

Write-Output "`n# Disk type: MediaType is SSD/HDD, BusType is NVMe/SATA/USB"
Get-PhysicalDisk | Select-Object DeviceId, FriendlyName, SerialNumber, MediaType, BusType,
    @{N='SizeGB';E={[math]::Round($_.Size / 1GB, 1)}}, HealthStatus |
    Format-Table -AutoSize

Get-Partition | Where-Object DriveLetter | Select-Object DiskNumber, PartitionNumber, DriveLetter,
    @{N='SizeGB';E={[math]::Round($_.Size / 1GB, 1)}}, Type |
    Format-Table -AutoSize

Write-Output "`n# GPU"
Get-CimInstance Win32_VideoController | Select-Object Name, AdapterRAM, DriverVersion, CurrentHorizontalResolution, CurrentVerticalResolution |
    Format-List

Write-Output "`n# Network"
Get-NetIPAddress -AddressFamily IPv4, IPv6 |
    Where-Object { $_.IPAddress -notlike '169.254.*' -and $_.PrefixOrigin -ne 'WellKnown' } |
    Select-Object InterfaceAlias, AddressFamily, IPAddress, PrefixLength |
    Format-Table -AutoSize

Get-NetRoute -DestinationPrefix '0.0.0.0/0', '::/0' -ErrorAction SilentlyContinue |
    Select-Object DestinationPrefix, NextHop, InterfaceAlias, RouteMetric |
    Format-Table -AutoSize

Write-Output "`n# USB devices"
Get-PnpDevice -Class USB -Status OK -ErrorAction SilentlyContinue |
    Select-Object FriendlyName, InstanceId |
    Format-Table -AutoSize
