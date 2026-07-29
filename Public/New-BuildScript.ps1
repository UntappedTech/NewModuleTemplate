<#
.SYNOPSIS
    Creates a build.ps1 script inside the generated module.

.DESCRIPTION
    Generates a build script that performs common module maintenance tasks:
    - Runs PSScriptAnalyzer using the module's analyzer settings
    - Executes Pester tests
    - Regenerates PlatyPS documentation
    The script supports switches to skip individual steps.

.PARAMETER ModulePath
    The root directory of the module where the Scripts folder will be created.

.PARAMETER Name
    The name of the module. Used to reference the module manifest and display
    status messages inside the generated build script.

.EXAMPLE
    New-BuildScript -ModulePath "C:\Projects\MyModule" -Name "MyModule"

.EXAMPLE
    $root = Join-Path $env:TEMP "TestModule"
    New-BuildScript -ModulePath $root -Name "TestModule"

.NOTES
    - The Analyzer folder is intentionally named "Analyzer".
    - This script is automatically invoked by New-ModuleTemplate.
#>
function New-BuildScript {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$ModulePath,

        [Parameter(Mandatory)]
        [string]$Name
    )

    Write-Verbose "Creating build script for module '$Name'."

    # Ensure Scripts directory exists
    $scriptsDir = Join-Path $ModulePath 'Scripts'
    Ensure-Directory -Path $scriptsDir -Name 'Scripts'

    # Template for the build script (Write-Host removed, modern patterns used)
    $content = @'
param(
    [switch]$SkipTests,
    [switch]$SkipAnalyzer,
    [switch]$SkipDocs
)

Write-Information "Building __MODULE__..."

if (-not $SkipAnalyzer) {
    Write-Information "Running PSScriptAnalyzer..."
    Invoke-ScriptAnalyzer -Path $PSScriptRoot -Settings "$PSScriptRoot\Analyzer\PSScriptAnalyzerSettings.psd1"
}

if (-not $SkipTests) {
    Write-Information "Running Pester tests..."
    Invoke-Pester -Path "$PSScriptRoot\Tests"
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Pester tests failed."
        exit $LASTEXITCODE
    }
}

if (-not $SkipDocs) {
    Write-Information "Updating PlatyPS docs..."
    Import-Module PlatyPS -ErrorAction Stop
    Import-Module "$PSScriptRoot\__MODULE__.psd1" -Force
    New-MarkdownHelp -Module __MODULE__ -OutputFolder "$PSScriptRoot\Docs" -Force
}

Write-Information "Build complete."
'@

    # Replace placeholder with module name
    $content = $content.Replace('__MODULE__', $Name)

    # Write the build script using helper
    $buildScriptPath = Join-Path $scriptsDir 'build.ps1'
    
    Write-FileContent -Path $buildScriptPath -Content $content -Name 'Build script'
}
