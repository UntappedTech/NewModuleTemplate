---
external help file: NewModuleTemplate-help.xml
Module Name: NewModuleTemplate
online version:
schema: 2.0.0
---

# New-PublishScript

## SYNOPSIS
Creates a publish.ps1 script inside the generated module.

## SYNTAX

```
New-PublishScript [-ModulePath] <String> [-Name] <String> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Generates a PowerShell script that publishes the module to a specified
PowerShell repository (default: PSGallery).
The script requires an API key
and uses Publish-Module to push the module from its root directory.

## EXAMPLES

### EXAMPLE 1
```
New-PublishScript -ModulePath "C:\Projects\MyModule" -Name "MyModule"
```

### EXAMPLE 2
```
$root = Join-Path $env:TEMP "TestModule"
New-PublishScript -ModulePath $root -Name "TestModule"
```

## PARAMETERS

### -ModulePath
The root directory of the module where the Scripts folder exists.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
The name of the module.
Used to populate placeholders inside the publish script.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProgressAction
{{ Fill ProgressAction Description }}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
- The here-string is intentionally single-quoted.
- No escaping or interpolation occurs inside the here-string.
- Placeholders (__MODULE__) are replaced afterward.

## RELATED LINKS
