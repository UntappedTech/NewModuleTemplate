<#
.SYNOPSIS
    Creates a build.ps1 script inside the generated module.

.DESCRIPTION
    Generates a build script that performs common module maintenance tasks:
    - Runs PSScriptAnalyzer using the module's analyzer settings
    - Executes Pester tests
    - Regenerates PlatyPS documentation
    The script supports switches to skip individual steps.

.PARAMETER BasePath
    The root directory of the module where the Scripts folder will be created.

.PARAMETER Name
    The name of the module. Used to reference the module manifest and display
    status messages inside the generated build script.

.EXAMPLE
    New-BuildScript -BasePath "C:\Projects\MyModule" -Name "MyModule"

.EXAMPLE
    $root = Join-Path $env:TEMP "TestModule"
    New-BuildScript -BasePath $root -Name "TestModule"

.NOTES
    - The Analyzer folder is intentionally named "Analyzer".
    - This script is automatically invoked by New-ModuleTemplate.
#>
function New-BuildScript {
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

    # Template for the build script
    $content = @'
param(
    [switch]$SkipTests,
    [switch]$SkipAnalyzer,
    [switch]$SkipDocs
)

Write-Host "Building __MODULE__..."

if (-not $SkipAnalyzer) {
    Write-Host "Running PSScriptAnalyzer..."
    Invoke-ScriptAnalyzer -Path $PSScriptRoot -Settings "$PSScriptRoot\Analyzer\PSScriptAnalyzerSettings.psd1"
}

if (-not $SkipTests) {
    Write-Host "Running Pester tests..."
    Invoke-Pester -Path "$PSScriptRoot\Tests" -EnableExit
}

if (-not $SkipDocs) {
    Write-Host "Updating PlatyPS docs..."
    Import-Module PlatyPS -ErrorAction Stop
    New-MarkdownHelp -Module "$PSScriptRoot\__MODULE__.psd1" -OutputFolder "$PSScriptRoot\Docs" -Force
}

Write-Host "Build complete."
'@

    # Replace placeholder with module name
    $content = $content.Replace('__MODULE__', $Name)

    # Write the build script
    $buildScriptPath = Join-Path $scriptsDir 'build.ps1'
    Set-Content -Path $buildScriptPath -Value $content -Encoding UTF8 -Force
}
