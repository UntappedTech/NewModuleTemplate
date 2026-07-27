<#
.SYNOPSIS
    Creates a documentation update script for the module.

.DESCRIPTION
    Generates a PowerShell script that updates PlatyPS-based Markdown help
    for the module. The script imports PlatyPS and calls Update-MarkdownHelp
    using the module's manifest and Docs folder. This allows developers to
    regenerate documentation after modifying public functions.

.PARAMETER BasePath
    The root directory of the module where the Scripts folder will be created.

.PARAMETER Name
    The name of the module. Used to reference the module manifest inside the
    generated documentation update script.

.EXAMPLE
    New-DocumentationScripts -BasePath "C:\Projects\MyModule" -Name "MyModule"

.EXAMPLE
    $root = Join-Path $env:TEMP "TestModule"
    New-DocumentationScripts -BasePath $root -Name "TestModule"

.NOTES
    - The generated script is named Update-ModuleDocumentation.ps1.
    - PlatyPS must be installed for the script to run successfully.
#>
function New-DocumentationScripts {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$BasePath,

        [Parameter(Mandatory)]
        [string]$Name
    )

    # Ensure the Scripts directory exists
    $scriptsDir = Join-Path $BasePath 'Scripts'
    if (-not (Test-Path $scriptsDir)) {
        New-Item -ItemType Directory -Path $scriptsDir -Force | Out-Null
    }

    # Template for the documentation update script
    $content = @'
Import-Module PlatyPS

Update-MarkdownHelp -Module "$PSScriptRoot\..\__MODULE_NAME__.psd1" -OutputFolder "$PSScriptRoot\..\Docs" -Force
'@

    # Replace placeholder with module name
    $content = $content.Replace('__MODULE_NAME__', $Name)

    # Write the documentation update script
    $docScriptPath = Join-Path $scriptsDir 'Update-ModuleDocumentation.ps1'
    Set-Content -Path $docScriptPath -Value $content -Encoding UTF8
}
