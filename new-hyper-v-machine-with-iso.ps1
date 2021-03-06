param (
    [string]$NAME = "TW-DEV1",
    [long]$RAMSIZE = 4GB,
    [long]$VHDSIZE = 80GB,
    [string]$VMLOC = "C:\HyperV",
    [string]$ExternalSwitch = "ExternalSwitch",
    [string]$NetworkAdapter = "Ethernet",
    [string]$ISO = "C:\Win7-32b.iso",
    [int]$CPUCount = 4
)


# Create VM Folder
MD $VMLOC -ErrorAction SilentlyContinue

# Create Network Switch
$TestSwitch = Get-VMSwitch -Name $ExternalSwitch -ErrorAction SilentlyContinue; if ($TestSwitch.Count -EQ 0){New-VMSwitch -Name $ExternalSwitch -NetAdapterName $NetworkAdapter -EnableIov $True}

# Create Virtual Machines
New-VM -Name $NAME -Path $VMLOC -MemoryStartupBytes $RAMSIZE -NewVHDPath $VMLOC\$NAME.vhdx -NewVHDSizeBytes $VHDSIZE -SwitchName $ExternalSwitch

# Configure Virtual Machines
Set-VMDvdDrive -VMName $NAME -Path $ISO
Set-VMProcessor -VMName $NAME -Count $CPUCount

# The following line only make graphics worse
# Add-VMRemoteFx3dVideoAdapter -VMName $Name


Start-VM $NAME