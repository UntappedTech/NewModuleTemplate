# Requires -Module Pester
Describe "New-AnalyzerSettings" {

    BeforeAll {
        $moduleRoot = Join-Path $PSScriptRoot '..' | Resolve-Path
        $manifest = Join-Path $moduleRoot 'NewModuleTemplate.psd1'
        Import-Module $manifest -Force
    }

    BeforeEach {
        $guid = [guid]::NewGuid().ToString()
        $root = Join-Path $env:TEMP $guid

        New-Item -ItemType Directory -Path $root | Out-Null

        Set-Variable -Name TempRoot -Value $root -Scope Local
    }

    It "Creates the Analyzer directory and settings file" {
        $result = New-AnalyzerSettings -ModulePath $TempRoot

        $settingsDir = Join-Path $TempRoot "Analyzer"
        $expectedPath = Join-Path $settingsDir "PSScriptAnalyzerSettings.psd1"

        Test-Path $settingsDir  | Should -Be $true
        Test-Path $expectedPath | Should -Be $true
        $result | Should -Be $expectedPath
    }

    It "Contains expected rule definitions" {
        $path = New-AnalyzerSettings -ModulePath $TempRoot
        $lines = Get-Content $path | ForEach-Object { $_.Trim() }

        $lines | Should -Contain "PSAvoidUsingWriteHost                = @{"
        $lines | Should -Contain "PSUseDeclaredVarsMoreThanAssignments = @{"
        $lines | Should -Contain "PSUseCorrectCasing                   = @{"
        $lines | Should -Contain "PSProvideCommentHelp                 = @{"
        $lines | Should -Contain "PSAvoidUsingCmdletAliases            = @{"
        $lines | Should -Contain "PSAvoidTrailingWhitespace            = @{"
    }

    It "Is idempotent and overwrites the settings cleanly" {
        New-AnalyzerSettings -ModulePath $TempRoot

        {
            New-AnalyzerSettings -ModulePath $TempRoot
        } | Should -Not -Throw

        $lines = Get-Content (Join-Path $TempRoot "Analyzer\PSScriptAnalyzerSettings.psd1") |
        ForEach-Object { $_.Trim() }

        $lines | Should -Contain "PSUseConsistentIndentation           = @{"
    }
}
