---
external help file: OctoPS-help.xml
Module Name: OctoPS
online version:
schema: 2.0.0
---

# Invoke-OctoPSPrinterConnect

## SYNOPSIS
Issue to OctoPrint a command to connect the printer.

## SYNTAX

```
Invoke-OctoPSPrinterConnect [[-Id] <Int32[]>] [-SkipCertificateCheck] [-Port <String>] [-BaudRate <Int32>]
 [-PrinterProfile <String>] [-Save] [-AutoConnect] [<CommonParameters>]
```

## DESCRIPTION
Issue to OctoPrint a command to connect the printer.

## EXAMPLES

### EXAMPLE 1
```
Get-OctoPSPrinterConnection
```

Profile  : _default
State    : Closed
Port     :
BoudRate :
Options  : @{baudratePreference=115200; baudrates=System.Object\[\]; portPreference=VIRTUAL; ports=System.Object\[\]; printerProfilePreference=cr-10s;
        printerProfiles=System.Object\[\]}
HostId   : 1

PS C:\\\>  Invoke-OctoPSPrinterConnect

PS C:\\\>  Get-OctoPSPrinterConnection

Profile  : cr-10s
State    : Operational
Port     : VIRTUAL
BoudRate :
Options  : @{baudratePreference=115200; baudrates=System.Object\[\]; portPreference=VIRTUAL; ports=System.Object\[\]; printerProfilePreference=cr-10s;
        printerProfiles=System.Object\[\]}
HostId   : 1

## PARAMETERS

### -Id
OctoPrint Host  Id

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: @()
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SkipCertificateCheck
Skips certificate validation checks.
This includes all validations such as expiration, revocation, trusted root authority, etc.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Port
Specific port to connect to.
If not set the current portPreference will be used, or if no preference is available auto detection will be attempted.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BaudRate
Specific baudrate to connect with.
If not set the current baudratePreference will be used, or if no preference is available auto detection will be attempted.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -PrinterProfile
Specific printer profile to use for connection.
If not set the current default printer profile will be used.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Save
Whether to save the request's port and baudrate settings as new preferences.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AutoConnect
Whether to automatically connect to the printer on OctoPrint's startup in the future.
If not set no changes will be made to the current configuration.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
