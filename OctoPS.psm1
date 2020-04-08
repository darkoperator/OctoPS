if (!(Test-Path variable:Global:OctoHost )) {
    $Global:OctoHost = New-Object System.Collections.ArrayList
}

switch ($PSVersionTable.Platform ) {
    "Unix" { $ConfigPath = "$($Env:HOME)/.octops/printservers.json" }
    "Win32NT" { $ConfigPath = "$($Env:AppData)\.octops\printservers.json" }
    Default {}
}



if ( Test-Path $ConfigPath -PathType Leaf ) {
    Write-Verbose -Message "Configuration file $($ConfigPath)"
    
    [System.Collections.ArrayList]$Global:OctoHost = @()
    ConvertFrom-Json (Get-Content -Raw -Path $ConfigPath) | ForEach-Object {
        $Global:OctoHost.Add($_)
    }

} else {
    Write-Verbose -Message "Configuration file $($ConfigPath) not found."
    Write-Verbose -Message "Creating configuration file $($ConfigPath)."
    New-Item -Type File -Path $ConfigPath -Force
}

$Global:OctoPSConfigPath = $ConfigPath
# Load Functions

. "$PSScriptRoot\Functions\Set-OctoPSHost.ps1"
. "$PSScriptRoot\Functions\Get-OctoPSHost.ps1"
. "$PSScriptRoot\Functions\Remove-OctoPSHost.ps1"
. "$PSScriptRoot\Functions\Get-OctoPSVersion.ps1"
. "$PSScriptRoot\Functions\Get-OctoPSPrinterProfile.ps1"
. "$PSScriptRoot\Functions\Get-OctoPSFile.ps1"
. "$PSScriptRoot\Functions\Get-OctoPSFolder.ps1"
. "$PSScriptRoot\Functions\Publish-OctoPSFile.ps1"
. "$PSScriptRoot\Functions\New-OctoPSFolder.ps1"
. "$PSScriptRoot\Functions\Get-OctoPSJob.ps1"
. "$PSScriptRoot\Functions\Start-OctoPSJob.ps1"
. "$PSScriptRoot\Functions\Stop-OctoPSJob.ps1"
. "$PSScriptRoot\Functions\Restart-OctoPSJob.ps1"
. "$PSScriptRoot\Functions\Suspend-OctoPSJob.ps1"
. "$PSScriptRoot\Functions\Resume-OctoPSJob.ps1"
. "$PSScriptRoot\Functions\Get-OctoPSPrinterConnection.ps1"
. "$PSScriptRoot\Functions\Invoke-OctoPSPrinterConnect.ps1"
. "$PSScriptRoot\Functions\Invoke-OctoPSPrinterDisonnect.ps1"
. "$PSScriptRoot\Functions\Get-OctoPSPrinterState.ps1"
. "$PSScriptRoot\Functions\Remove-OctoPSItem.ps1"
. "$PSScriptRoot\Functions\Select-OctoPSFile.ps1"
. "$PSScriptRoot\Functions\Get-OctoPSTool.ps1"
. "$PSScriptRoot\Functions\Get-OctoPSBed.ps1"
. "$PSScriptRoot\Functions\Set-OctoPSTool.ps1"
. "$PSScriptRoot\Functions\Invoke-OctoPSToolExtrude.ps1"
. "$PSScriptRoot\Functions\Select-OctoPSTool.ps1"
. "$PSScriptRoot\Functions\Set-OctoPSBed.ps1"
. "$PSScriptRoot\Functions\Invoke-OctoPSHomeAxis.ps1"