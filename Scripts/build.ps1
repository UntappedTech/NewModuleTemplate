param(
    [switch]$SkipTests,
    [switch]$SkipAnalyzer,
    [switch]$SkipDocs
)
$InformationPreference = 'Continue'

Write-Information "Building NewModuleTemplate..."
Import-Module -Name "$PSScriptRoot\..\" -Force

if (-not $SkipAnalyzer) {
    Write-Information "Running PSScriptAnalyzer..."
    Invoke-ScriptAnalyzer -Path $PSScriptRoot -Settings "$PSScriptRoot\..\Analyzer\PSScriptAnalyzerSettings.psd1"
}

if (-not $SkipTests) {
    Write-Information "Running Pester tests..."
    Invoke-Pester -Path "$PSScriptRoot\..\Tests"
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Pester tests failed."
        exit $LASTEXITCODE
    }
}

if (-not $SkipDocs) {
    Write-Information "Updating PlatyPS docs..."
    Import-Module PlatyPS -ErrorAction Stop
    New-MarkdownHelp -Module NewModuleTemplate  -OutputFolder "$PSScriptRoot\..\Docs\" -WithModulePage -Force
}

Write-Information "Build complete."
