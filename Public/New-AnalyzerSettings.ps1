<#
.SYNOPSIS
    Generates a PSScriptAnalyzer settings file for the module.

.DESCRIPTION
    Creates a PSScriptAnalyzer settings file inside the module's AnalyzerSettings
    directory. The file defines rule severities and allows the module to enforce
    consistent linting behavior across development environments and CI pipelines.

.PARAMETER BasePath
    The root directory of the module where the AnalyzerSettings folder exists.
    This is typically the path returned by New-ModuleFolders.

.EXAMPLE
    New-AnalyzerSettings -BasePath "C:\Projects\MyModule"

.EXAMPLE
    $root = Join-Path $env:TEMP "TestModule"
    New-AnalyzerSettings -BasePath $root

.NOTES
    This function is automatically invoked by New-ModuleTemplate.
    The settings file created is named PSScriptAnalyzerSettings.psd1.
#>
function New-AnalyzerSettings {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$BasePath
    )

    # Path to the AnalyzerSettings directory
    $settingsDir = Join-Path $BasePath 'Analyzer'

    # Ensure the directory exists (New-ModuleFolders normally creates it)
    if (-not (Test-Path $settingsDir)) {
        New-Item -ItemType Directory -Path $settingsDir -Force | Out-Null
    }

    # Default analyzer configuration
    $content = @'
@{
    Severity = @{
        PSAvoidUsingWriteHost = 'Warning'
        PSProvideCommentHelp  = 'Information'
    }
}
'@

    # Write the settings file
    $settingsPath = Join-Path $settingsDir 'PSScriptAnalyzerSettings.psd1'
    Set-Content -Path $settingsPath -Value $content -Encoding UTF8
}
