---
external help file: NewModuleTemplate-help.xml
Module Name: NewModuleTemplate
online version:
schema: 2.0.0
---

# New-BuildScript

## SYNOPSIS
Creates a build.ps1 script inside the generated module.

## SYNTAX

```
New-BuildScript [-ModulePath] <String> [-Name] <String> [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Generates a build script that performs common module maintenance tasks:
- Runs PSScriptAnalyzer using the module's analyzer settings
- Executes Pester tests
- Regenerates PlatyPS documentation
The script supports switches to skip individual steps.

## EXAMPLES

### EXAMPLE 1
```
New-BuildScript -ModulePath "C:\Projects\MyModule" -Name "MyModule"
```

### EXAMPLE 2
```
$root = Join-Path $env:TEMP "TestModule"
New-BuildScript -ModulePath $root -Name "TestModule"
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
Used to reference the module manifest and display
status messages inside the generated build script.

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
- The Analyzer folder is intentionally named "Analyzer".
- This script is automatically invoked by New-ModuleTemplate.

## RELATED LINKS
