---
external help file: NewModuleTemplate-help.xml
Module Name: NewModuleTemplate
online version:
schema: 2.0.0
---

# New-DocumentationScripts

## SYNOPSIS
Creates a documentation update script for the module.

## SYNTAX

```
New-DocumentationScripts [-ModulePath] <String> [-Name] <String> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Generates a PowerShell script that updates PlatyPS-based Markdown help
for the module.
The script imports PlatyPS and calls Update-MarkdownHelp
using the module's manifest and Docs folder.
This allows developers to
regenerate documentation after modifying public functions.

## EXAMPLES

### EXAMPLE 1
```
New-DocumentationScripts -ModulePath "C:\Projects\MyModule" -Name "MyModule"
```

### EXAMPLE 2
```
$root = Join-Path $env:TEMP "TestModule"
New-DocumentationScripts -ModulePath $root -Name "TestModule"
```

## PARAMETERS

### -ModulePath
The root directory of the module where the Scripts folder will be created.

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
Used to reference the module manifest inside the
generated documentation update script.

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
- The generated script is named Update-ModuleDocumentation.ps1.
- PlatyPS must be installed for the script to run successfully.

## RELATED LINKS
