<#
.SYNOPSIS
    Creates a documentation update script for the module.

.DESCRIPTION
    Generates a PowerShell script that updates PlatyPS-based Markdown help
    for the module. The script imports PlatyPS and calls Update-MarkdownHelp
    using the module's manifest and Docs folder. This allows developers to
    regenerate documentation after modifying public functions.

.PARAMETER ModulePath
    The root directory of the module where the Scripts folder will be created.

.PARAMETER Name
    The name of the module. Used to reference the module manifest inside the
    generated documentation update script.

.EXAMPLE
    New-DocumentationScripts -ModulePath "C:\Projects\MyModule" -Name "MyModule"

.EXAMPLE
    $root = Join-Path $env:TEMP "TestModule"
    New-DocumentationScripts -ModulePath $root -Name "TestModule"

.NOTES
    - The generated script is named Update-ModuleDocumentation.ps1.
    - PlatyPS must be installed for the script to run successfully.
#>
function New-DocumentationScripts {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$ModulePath,

        [Parameter(Mandatory)]
        [string]$Name
    )

    Write-Verbose "Creating documentation update script for module '$Name'."

    # Ensure Scripts directory exists
    $scriptsDir = Join-Path $ModulePath 'Scripts'
    Ensure-Directory -Path $scriptsDir -Name 'Scripts'

    # Template for the documentation update script
    $content = @'
Import-Module PlatyPS -ErrorAction Stop

# Ensure module is imported before updating docs
Import-Module "$PSScriptRoot\..\__MODULE_NAME__.psd1" -Force

Update-MarkdownHelp -Module __MODULE_NAME__ -OutputFolder "$PSScriptRoot\..\Docs" -Force
'@

    # Replace placeholder with module name
    $content = $content.Replace('__MODULE_NAME__', $Name)

    # Write the documentation update script
    $docScriptPath = Join-Path $scriptsDir 'Update-ModuleDocumentation.ps1'
    Write-FileContent -Path $docScriptPath -Content $content -Name 'Documentation update script'

    return $docScriptPath
}

