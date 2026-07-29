param(
    [switch]$SkipTests,
    [switch]$SkipAnalyzer,
    [switch]$SkipDocs
)

Write-Information "Building NewModuleTemplate..."

if (-not $SkipAnalyzer) {
    Write-Information "Running PSScriptAnalyzer..."
    Invoke-ScriptAnalyzer -Path $PSScriptRoot -Settings "$PSScriptRoot\Analyzer\PSScriptAnalyzerSettings.psd1"
}

if (-not $SkipTests) {
    Write-Information "Running Pester tests..."
    Invoke-Pester -Path "$PSScriptRoot\Tests" -EnableExit
}

if (-not $SkipDocs) {
    Write-Information "Updating PlatyPS docs..."
    Import-Module PlatyPS -ErrorAction Stop
    New-MarkdownHelp -Module "$PSScriptRoot\NewModuleTemplate.psd1" -OutputFolder "$PSScriptRoot\Docs" -Force
}

Write-Information "Build complete."
