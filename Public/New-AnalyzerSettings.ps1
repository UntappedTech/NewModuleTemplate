<#
.SYNOPSIS
    Generates a PSScriptAnalyzer settings file for the module.

.DESCRIPTION
    Creates a PSScriptAnalyzer settings file inside the module's AnalyzerSettings
    directory. The file defines rule severities and allows the module to enforce
    consistent linting behavior across development environments and CI pipelines.

.PARAMETER ModulePath
    The root directory of the module where the AnalyzerSettings folder exists.
    This is typically the path returned by New-ModuleFolders.

.EXAMPLE
    New-AnalyzerSettings -ModulePath "C:\Projects\MyModule"

.EXAMPLE
    $root = Join-Path $env:TEMP "TestModule"
    New-AnalyzerSettings -ModulePath $root

.NOTES
    This function is automatically invoked by New-ModuleTemplate.
    The settings file created is named PSScriptAnalyzerSettings.psd1.
#>
function New-AnalyzerSettings {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$ModulePath
    )

    Write-Verbose "Creating PSScriptAnalyzer settings for module at '$ModulePath'."

    # Path to the AnalyzerSettings directory
    $settingsDir = Join-Path $ModulePath 'Analyzer'
    Write-Debug "Analyzer settings directory resolved to: $settingsDir"

    # Ensure the directory exists
    Ensure-Directory -Path $settingsDir -Name 'Analyzer'


    # Default analyzer configuration
    $content = @'
@{
    Rules = @{
        PSAvoidUsingWriteHost = @{
            Severity = 'Warning'
        }
        PSUseDeclaredVarsMoreThanAssignments = @{
            Severity = 'Warning'
        }
        PSUseCorrectCasing = @{
            Severity = 'Warning'
        }
        PSProvideCommentHelp = @{
            Severity = 'Information'
        }
    }
}
'@

    # Write the settings file
    $settingsPath = Join-Path $settingsDir 'PSScriptAnalyzerSettings.psd1'

    Write-FileContent -Path $settingsPath -Content $content -Name 'PSScriptAnalyzer settings'

    return $settingsPath
}

