# Requires -Module Pester
Describe "New-ModuleFolders" {

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
    }

    It "Creates the correct core folder structure" {
        $modulePath = New-ModuleFolders -Path $TempRoot -Name "TestModule"

        $expected = @(
            "$modulePath",
            "$modulePath\Public",
            "$modulePath\Private"
        )

        foreach ($folder in $expected) {
            Test-Path $folder | Should -Be $true
        }
    }

    It "Creates full scaffolding when -Minimal is NOT used" {
        $modulePath = New-ModuleFolders -Path $TempRoot -Name "TestModule"

        $expected = @(
            "$modulePath\Tests",
            "$modulePath\Docs",
            "$modulePath\Analyzer",
            "$modulePath\Scripts"
        )

        foreach ($folder in $expected) {
            Test-Path $folder | Should -Be $true
        }
    }

    It "Skips full scaffolding when -Minimal is used" {
        $modulePath = New-ModuleFolders -Path $TempRoot -Name "TestModule" -Minimal

        $expectedMissing = @(
            "$modulePath\Tests",
            "$modulePath\Docs",
            "$modulePath\Analyzer",
            "$modulePath\Scripts"
        )

        foreach ($folder in $expectedMissing) {
            Test-Path $folder | Should -Be $false
        }

        # Core folders must still exist
        Test-Path "$modulePath\Public"  | Should -Be $true
        Test-Path "$modulePath\Private" | Should -Be $true
    }

    It "Returns the correct module root path" {
        $modulePath = New-ModuleFolders -Path $TempRoot -Name "TestModule"

        $expected = Join-Path $TempRoot "TestModule"
        $modulePath | Should -Be $expected
    }

    It "Is idempotent when run multiple times" {
        $modulePath = New-ModuleFolders -Path $TempRoot -Name "TestModule"
        {
            New-ModuleFolders -Path $TempRoot -Name "TestModule"
        } | Should -Not -Throw

        # Still has all expected folders
        Test-Path "$modulePath\Public"  | Should -Be $true
        Test-Path "$modulePath\Private" | Should -Be $true
        Test-Path "$modulePath\Tests"   | Should -Be $true
    }
}
