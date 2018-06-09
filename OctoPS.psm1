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
    [System.Collections.ArrayList]$Global:OctoHost = ConvertFrom-Json (Get-Content -Raw -Path $ConfigPath)

} else {
    Write-Verbose -Message "Configuration file $($ConfigPath) not found."
    Write-Verbose -Message "Creating configuration file $($ConfigPath)."
    New-Item -Type File -Path $ConfigPath -Force
}

$Global:OctoPSConfigPath = $ConfigPath
# Load Functions

. "$PSScriptRoot\Functions\Set-OctoPrintHost.ps1"
. "$PSScriptRoot\Functions\Get-OctoPrintHost.ps1"
. "$PSScriptRoot\Functions\Remove-OctoPrintHost.ps1"
. "$PSScriptRoot\Functions\Get-OctoPrintVersion.ps1"
. "$PSScriptRoot\Functions\Get-OctoPrintPrinterProfile.ps1"
. "$PSScriptRoot\Functions\Get-OctoPrintFile.ps1"
. "$PSScriptRoot\Functions\Get-OctoPrintFolder.ps1"
. "$PSScriptRoot\Functions\Publish-OctoPrintFile.ps1"
. "$PSScriptRoot\Functions\New-OctoPrintFolder.ps1"
. "$PSScriptRoot\Functions\Get-OctoPrintJob.ps1"
. "$PSScriptRoot\Functions\Start-OctoPrintJob.ps1"
. "$PSScriptRoot\Functions\Stop-OctoPrintJob.ps1"
. "$PSScriptRoot\Functions\Restart-OctoPrintJob.ps1"
. "$PSScriptRoot\Functions\Suspend-OctoPrintJob.ps1"
. "$PSScriptRoot\Functions\Resume-OctoPrintJob.ps1"
. "$PSScriptRoot\Functions\Get-OctoPrintPrinterConnection.ps1"
. "$PSScriptRoot\Functions\Invoke-OctoPrintPrinterConnect.ps1"
. "$PSScriptRoot\Functions\Invoke-OctoPrintPrinterDisonnect.ps1"
. "$PSScriptRoot\Functions\Get-OctoPrintPrinterState.ps1"
. "$PSScriptRoot\Functions\Remove-OctoPrintItem.ps1"