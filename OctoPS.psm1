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

. "$PSScriptRoot\Set-OctoPrintHost.ps1"
. "$PSScriptRoot\Get-OctoPrintHost.ps1"
. "$PSScriptRoot\Remove-OctoPrintHost.ps1"
. "$PSScriptRoot\Get-OctoPrintVersion.ps1"
. "$PSScriptRoot\Get-OctoPrintPrinterProfile.ps1"
. "$PSScriptRoot\Get-OctoPrintFile.ps1"
. "$PSScriptRoot\Get-OctoPrintFolder.ps1"
. "$PSScriptRoot\Publish-OctoPrintFile.ps1"
. "$PSScriptRoot\New-OctoPrintFolder.ps1"
. "$PSScriptRoot\Get-OctoPrintJob.ps1"
. "$PSScriptRoot\Start-OctoPrintJob.ps1"
. "$PSScriptRoot\Stop-OctoPrintJob.ps1"
. "$PSScriptRoot\Restart-OctoPrintJob.ps1"
. "$PSScriptRoot\Suspend-OctoPrintJob.ps1"
. "$PSScriptRoot\Resume-OctoPrintJob.ps1"
. "$PSScriptRoot\Get-OctoPrintPrinterConnection.ps1"
. "$PSScriptRoot\Invoke-OctoPrintPrinterConnect.ps1"
. "$PSScriptRoot\Invoke-OctoPrintPrinterDisonnect.ps1"
