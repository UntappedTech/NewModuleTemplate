param(
    [switch]$SkipTests,
    [switch]$SkipAnalyzer,
    [switch]$SkipDocs
)

$InformationPreference = 'Continue'

Write-Information "Building NewModuleTemplate..."

# Import the module being built
try {
    Import-Module -Name "$PSScriptRoot\..\" -Force -ErrorAction Stop
    Write-Information "Module imported successfully."
}
catch {
    Write-Error "Failed to import module from $PSScriptRoot\..\. Build aborted."
    exit 1
}

# ---------------------------
# Analyzer
# ---------------------------
if (-not $SkipAnalyzer) {
    Write-Information "Running PSScriptAnalyzer..."

    try {
        Import-Module PSScriptAnalyzer -ErrorAction Stop
    }
    catch {
        Write-Warning "PSScriptAnalyzer is not installed. Skipping analyzer step."
        $SkipAnalyzer = $true
    }

    if (-not $SkipAnalyzer) {
        Invoke-ScriptAnalyzer -Path $PSScriptRoot `
            -Settings "$PSScriptRoot\..\Analyzer\PSScriptAnalyzerSettings.psd1"
    }
}

# ---------------------------
# Tests
# ---------------------------
if (-not $SkipTests) {
    Write-Information "Running Pester tests..."

    try {
        Import-Module Pester -ErrorAction Stop
    }
    catch {
        Write-Warning "Pester is not installed. Skipping tests."
        $SkipTests = $true
    }

    if (-not $SkipTests) {
        Invoke-Pester -Path "$PSScriptRoot\..\Tests"
        if ($LASTEXITCODE -ne 0) {
            Write-Error "Pester tests failed."
            exit $LASTEXITCODE
        }
    }
}

# ---------------------------
# Documentation
# ---------------------------
if (-not $SkipDocs) {
    Write-Information "Updating PlatyPS docs..."

    try {
        Import-Module PlatyPS -ErrorAction Stop
    }
    catch {
        Write-Warning "PlatyPS is not installed. Skipping documentation generation."
        $SkipDocs = $true
    }

    if (-not $SkipDocs) {
        New-MarkdownHelp -Module NewModuleTemplate `
            -OutputFolder "$PSScriptRoot\..\Docs\" `
            -WithModulePage -Force
    }
}

Write-Information "Build complete."
