param(
    [switch]$SkipTests,
    [switch]$SkipAnalyzer,
    [switch]$SkipDocs
)

Write-Host "Building NewModuleTemplate..."

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
    New-MarkdownHelp -Module "$PSScriptRoot\NewModuleTemplate.psd1" -OutputFolder "$PSScriptRoot\Docs" -Force
}

Write-Host "Build complete."
