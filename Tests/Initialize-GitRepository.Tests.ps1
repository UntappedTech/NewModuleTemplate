# Requires -Module Pester
Describe "Initialize-GitRepository" {

    BeforeAll {
        # Import the module under test
        $moduleRoot = Join-Path $PSScriptRoot '..' | Resolve-Path
        $manifest = Join-Path $moduleRoot 'NewModuleTemplate.psd1'
        Import-Module $manifest -Force

        # Detect Git availability once
        $global:GitAvailable = [bool](Get-Command git -ErrorAction SilentlyContinue)
    }

    BeforeEach {
        # Fresh temp directory for each test
        $guid = [guid]::NewGuid().ToString()
        $root = Join-Path $env:TEMP $guid

        New-Item -ItemType Directory -Path $root | Out-Null

        Set-Variable -Name TempRoot -Value $root -Scope Local
    }

    It "Creates .gitignore and initializes a repo when Git is available" -Skip:(-not $GitAvailable) {
        $result = Initialize-GitRepository -ModulePath $TempRoot

        $gitignorePath = Join-Path $TempRoot ".gitignore"

        # .gitignore exists
        Test-Path $gitignorePath | Should -Be $true

        # Function returns correct path
        $result | Should -Be $gitignorePath

        # .git folder exists
        Test-Path (Join-Path $TempRoot ".git") | Should -Be $true

        # Initial commit exists
        $log = git -C $TempRoot log --oneline
        $log | Should -Not -BeNullOrEmpty
    }

    It "Does not create a repo when Git is NOT available" -Skip:$GitAvailable {
        $result = Initialize-GitRepository -ModulePath $TempRoot

        # Should return nothing
        $result | Should -BeNullOrEmpty

        # No .gitignore
        Test-Path (Join-Path $TempRoot ".gitignore") | Should -Be $false

        # No .git folder
        Test-Path (Join-Path $TempRoot ".git") | Should -Be $false
    }

    It "Is idempotent when Git is available" -Skip:(-not $GitAvailable) {
        Initialize-GitRepository -ModulePath $TempRoot

        {
            Initialize-GitRepository -ModulePath $TempRoot
        } | Should -Not -Throw

        # Repo still exists
        Test-Path (Join-Path $TempRoot ".git") | Should -Be $true

        # .gitignore still exists
        Test-Path (Join-Path $TempRoot ".gitignore") | Should -Be $true
    }
}
