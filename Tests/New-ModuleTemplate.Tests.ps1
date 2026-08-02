# Requires -Module Pester
Describe "New-ModuleTemplate" {

    BeforeEach {
        $root = Join-Path $env:TEMP ([guid]::NewGuid().ToString())
        New-Item -ItemType Directory -Path $root | Out-Null
        Set-Variable -Name TempRoot -Value $root -Scope Local
    }

    It "Creates the core module scaffold" {
        $modulePath = Join-Path $TempRoot "TestModule"
        New-ModuleTemplate -Path $TempRoot -Name "TestModule" -NoGit

        Test-Path $modulePath | Should -Be $true
        Test-Path (Join-Path $modulePath "TestModule.psd1") | Should -Be $true
        Test-Path (Join-Path $modulePath "TestModule.psm1") | Should -Be $true
        Test-Path (Join-Path $modulePath "README.md")       | Should -Be $true
        Test-Path (Join-Path $modulePath "CHANGELOG.md")    | Should -Be $true
        Test-Path (Join-Path $modulePath "Public")          | Should -Be $true
        Test-Path (Join-Path $modulePath "Private")         | Should -Be $true
    }

    It "Throws when module exists and -Force is not used" {
        $modulePath = Join-Path $TempRoot "TestModule"
        New-Item -ItemType Directory -Path $modulePath | Out-Null

        {
            New-ModuleTemplate -Path $TempRoot -Name "TestModule"
        } | Should -Throw
    }

    It "Overwrites existing module when -Force is used" {
        $modulePath = Join-Path $TempRoot "TestModule"
        New-Item -ItemType Directory -Path $modulePath | Out-Null

        {
            New-ModuleTemplate -Path $TempRoot -Name "TestModule" -Force -NoGit
        } | Should -Not -Throw

        Test-Path (Join-Path $modulePath "TestModule.psd1") | Should -Be $true
    }

    It "Creates a minimal scaffold when -Minimal is used" {
        $modulePath = Join-Path $TempRoot "MiniModule"
        New-ModuleTemplate -Path $TempRoot -Name "MiniModule" -Minimal -NoGit

        # Core files exist
        Test-Path (Join-Path $modulePath "MiniModule.psd1") | Should -Be $true
        Test-Path (Join-Path $modulePath "MiniModule.psm1") | Should -Be $true
        Test-Path (Join-Path $modulePath "README.md")       | Should -Be $true
        Test-Path (Join-Path $modulePath "CHANGELOG.md")    | Should -Be $true

        # Optional components do NOT exist
        Test-Path (Join-Path $modulePath "Tests")           | Should -Be $false
        Test-Path (Join-Path $modulePath "Analyzer")        | Should -Be $false
        Test-Path (Join-Path $modulePath "Docs")            | Should -Be $false
        Test-Path (Join-Path $modulePath "Scripts")         | Should -Be $false
    }

    It "Respects NoTests, NoDocs, NoAnalyzer, and NoScripts switches" {
        $modulePath = Join-Path $TempRoot "SwitchModule"

        New-ModuleTemplate -Path $TempRoot -Name "SwitchModule" `
            -NoTests -NoDocs -NoAnalyzer -NoScripts -NoGit

        Test-Path (Join-Path $modulePath "Tests")    | Should -Be $false
        Test-Path (Join-Path $modulePath "Docs")     | Should -Be $false
        Test-Path (Join-Path $modulePath "Analyzer") | Should -Be $false
        Test-Path (Join-Path $modulePath "Scripts")  | Should -Be $false
    }

    It "Initializes Git when not disabled" {
        $modulePath = Join-Path $TempRoot "GitModule"

        New-ModuleTemplate -Path $TempRoot -Name "GitModule"

        Test-Path (Join-Path $modulePath ".git") | Should -Be $true
        Test-Path (Join-Path $modulePath ".gitignore") | Should -Be $true
        Test-Path (Join-Path $modulePath ".gitattributes") | Should -Be $true
    }

    It "Skips Git initialization when -NoGit is used" {
        $modulePath = Join-Path $TempRoot "NoGitModule"

        New-ModuleTemplate -Path $TempRoot -Name "NoGitModule" -NoGit

        Test-Path (Join-Path $modulePath ".git") | Should -Be $false
    }
}
