# Requires -Module Pester
Describe "New-ModuleChangelog" {

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

    It "Includes the correct version and notes" {
        $version = "2.5.0"
        $notes = "Added new API endpoints."

        $path = New-ModuleChangelog -ModulePath $TempRoot -Version $version -Notes $notes
        $lines = Get-Content $path

        $date = (Get-Date).ToString("yyyy-MM-dd")

        $lines | Should -Contain "## [$version] - $date"
        $lines | Should -Contain "### Added"
        $lines | Should -Contain "- $notes"
    }

    It "Is idempotent and overwrites the file cleanly" {
        New-ModuleChangelog -ModulePath $TempRoot -Version "1.0.0" -Notes "Initial"

        {
            New-ModuleChangelog -ModulePath $TempRoot -Version "1.0.1" -Notes "Second release"
        } | Should -Not -Throw

        $lines = Get-Content (Join-Path $TempRoot "CHANGELOG.md")
        $date = (Get-Date).ToString("yyyy-MM-dd")

        $lines | Should -Contain "## [1.0.1] - $date"
        $lines | Should -Contain "- Second release"
    }
}
