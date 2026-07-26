<#
.SYNOPSIS
    Creates a build.ps1 script inside the generated module.

.DESCRIPTION
    The build script runs PSScriptAnalyzer, Pester tests, and updates PlatyPS documentation.
#>
function New-BuildScript {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$BasePath,

        [Parameter(Mandatory)]
        [string]$Name
    )

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

    $content = $content.Replace('__MODULE__', $Name)

    Set-Content -Path "$BasePath\Scripts\build.ps1" -Value $content
}
