# Requires -Module Pester
Describe "New-AnalyzerSettings" {

    It "Creates analyzer settings file" {
        $temp = Join-Path $env:TEMP ([guid]::NewGuid().ToString()) "TestModule"
        New-Item -ItemType Directory -Path $temp | Out-Null

        New-AnalyzerSettings -ModulePath $temp

        Test-Path "$temp\Analyzer\PSScriptAnalyzerSettings.psd1" | Should Be $true
    }
}
