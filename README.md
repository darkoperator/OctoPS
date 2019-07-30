
![](./Images/2018-06-08-23-15-02.png)

# OctoPS

OctoPS is a PowerShell Core module for controling and automating one or more [OctoPrint](https://www.octoprint.org) servers.
At the moment the module is still under development and has been tested on MacOS and Windows PowerShell Core 6.0.1 against OctoPrint server 1.3.8.


## Example

Example script for printing a test calibration cube using the 1st configured host (default)

```PowerShell

#######################
# Check printer status
#######################
$printer = Get-OctoPSPrinterState -SkipCertificateCheck
if ($printer.State -eq "Operational") {
    Write-Host "Printer is operational" -ForegroundColor Green
} else {
    Write-Host "Printer not connected" -ForegroundColor Yellow
    Write-Host "Attempting to connect printter" -ForegroundColor Green
    Invoke-OctoPSPrinterConnect -SkipCertificateCheck

    #wait 30 seconds to give enough time for connection. 
    sleep 30
    if ($printer.State -eq "Operational") {
        Write-Host "Printer is operational" -ForegroundColor Green
    } else {
        throw "Printer is not operational and connection attempt failed."
    }

}

######################
# Select file to print
######################
Write-Host "Printing calibration XYZ cube." -ForegroundColor Green
Select-OctoPSFile -SkipCertificateCheck -Location Local -Path xyzCalibration_cube.gcode

################
# Home all axis
################
Write-Host "Homing all axis on printer." -ForegroundColor Green
Invoke-OctoPSHomeAxis -SkipCertificateCheck

###############################
# Set Bed and Tool Temperatures
###############################
Write-Host "Starting to heat bed to 60 degree celcius." -ForegroundColor Green
Set-OctoPSBed -SkipCertificateCheck -TargetTemp 60
Write-Host "Startting to heat tool to 210 degree celcius." -ForegroundColor Green
Set-OctoPSTool -SkipCertificateCheck -TargetTemp 210

################################################################
# Wait for bed to reach temp and wait 3 minutes before printing
################################################################
Write-Host "Waiting for bed to reach temperature." -ForegroundColor Green -NoNewline
while ((Get-OctoPSBed -SkipCertificateCheck).Temperature -lt 60) {
    Write-Host "." -NoNewline -ForegroundColor Green
    sleep 10
}
Write-Host "Bed has reached temperature." -ForegroundColor Green
Write-Host "Waiting 3 minutes for the bed to properly heat." -ForegroundColor Green
sleep 180

#################
# Start printing
#################
Start-OctoPSJob -SkipCertificateCheck

```
# License

* [RestSharp](https://github.com/restsharp/RestSharp/blob/develop/LICENSE.txt) Apache 2.0 License
* OctoPS 3-BSD License