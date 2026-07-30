---
external help file: NewModuleTemplate-help.xml
Module Name: NewModuleTemplate
online version:
schema: 2.0.0
---

# New-AnalyzerSettings

## SYNOPSIS
Generates a PSScriptAnalyzer settings file for the module.

## SYNTAX

```
New-AnalyzerSettings [-ModulePath] <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Creates a PSScriptAnalyzer settings file inside the module's AnalyzerSettings
directory.
The file defines rule severities and allows the module to enforce
consistent linting behavior across development environments and CI pipelines.

## EXAMPLES

### EXAMPLE 1
```
New-AnalyzerSettings -ModulePath "C:\Projects\MyModule"
```

### EXAMPLE 2
```
$root = Join-Path $env:TEMP "TestModule"
New-AnalyzerSettings -ModulePath $root
```

## PARAMETERS

### -ModulePath
The root directory of the module where the AnalyzerSettings folder exists.
This is typically the path returned by New-ModuleFolders.

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
This function is automatically invoked by New-ModuleTemplate.
The settings file created is named PSScriptAnalyzerSettings.psd1.

## RELATED LINKS
