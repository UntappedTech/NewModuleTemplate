# Requires -Module Pester
Describe "New-BuildScript" {

    BeforeAll {
        # Import the module under test
        $moduleRoot = Join-Path $PSScriptRoot '..' | Resolve-Path
        $manifest = Join-Path $moduleRoot 'NewModuleTemplate.psd1'
        Import-Module $manifest -Force
    }

    BeforeEach {
        # Fresh temp directory for each test
        $guid = [guid]::NewGuid().ToString()
        $root = Join-Path $env:TEMP $guid

        New-Item -ItemType Directory -Path $root | Out-Null

        Set-Variable -Name TempRoot -Value $root -Scope Local
        Set-Variable -Name ScriptsDir -Value (Join-Path $root "Scripts") -Scope Local
        Set-Variable -Name BuildScriptPath -Value (Join-Path $ScriptsDir "build.ps1") -Scope Local
    }

    It "Creates the Scripts directory and build.ps1" {
        New-BuildScript -ModulePath $TempRoot -Name "TestModule"

        Test-Path $ScriptsDir      | Should -Be $true
        Test-Path $BuildScriptPath | Should -Be $true
    }

    It "Replaces __MODULE__ correctly inside the script" {
        New-BuildScript -ModulePath $TempRoot -Name "TestModule"

        $lines = Get-Content $BuildScriptPath | ForEach-Object { $_.Trim() }

        $lines | Should -Contain 'Write-Information "Building TestModule..."'
        $lines | Should -Contain 'Import-Module "$PSScriptRoot\..\" -Force'
        $lines | Should -Contain 'New-MarkdownHelp -Module TestModule -OutputFolder "$PSScriptRoot\..\Docs\" -WithModulePage -Force'
    }

    It "Contains expected build pipeline sections" {
        New-BuildScript -ModulePath $TempRoot -Name "TestModule"

        $lines = Get-Content $BuildScriptPath | ForEach-Object { $_.Trim() }

        # Analyzer section
        $lines | Should -Contain 'Invoke-ScriptAnalyzer -Path $PSScriptRoot -Settings "$PSScriptRoot\..\Analyzer\PSScriptAnalyzerSettings.psd1"'

        # Pester section
        $lines | Should -Contain 'Invoke-Pester -Path "$PSScriptRoot\..\Tests"'

        # Docs section
        $lines | Should -Contain 'Import-Module PlatyPS -ErrorAction Stop'
    }

    It "Is idempotent and overwrites the script cleanly" {
        New-BuildScript -ModulePath $TempRoot -Name "TestModule"

        {
            New-BuildScript -ModulePath $TempRoot -Name "TestModule"
        } | Should -Not -Throw

        $lines = Get-Content $BuildScriptPath | ForEach-Object { $_.Trim() }
        $lines | Should -Contain 'Write-Information "Building TestModule..."'
    }
}
