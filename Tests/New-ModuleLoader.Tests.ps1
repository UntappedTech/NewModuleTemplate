# Requires -Module Pester
Describe "New-ModuleLoader" {

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

        # Create Public/Private folders so the loader has something to import
        New-Item -ItemType Directory -Path (Join-Path $root 'Public') | Out-Null
        New-Item -ItemType Directory -Path (Join-Path $root 'Private') | Out-Null

        # Add a dummy public function
        Set-Content -Path (Join-Path $root 'Public\Get-TestThing.ps1') -Value @'
function Get-TestThing {
    "Hello"
}
'@

        # Add a dummy private function
        Set-Content -Path (Join-Path $root 'Private\Invoke-InternalThing.ps1') -Value @'
function Invoke-InternalThing {
    "Internal"
}
'@

        Set-Variable -Name TempRoot -Value $root -Scope Local
    }

    It "Creates the loader file at the expected path" {
        $result = New-ModuleLoader -ModulePath $TempRoot -Name "TestModule"

        $expectedPath = Join-Path $TempRoot "TestModule.psm1"
        $result | Should -Be $expectedPath
        Test-Path $expectedPath | Should -Be $true
    }

    It "Loader imports public/private functions and exports only public ones" {
        $loaderPath = New-ModuleLoader -ModulePath $TempRoot -Name "TestModule"

        {
            Import-Module $loaderPath -Force
        } | Should -Not -Throw

        # Public function should be exported
        Get-Command -Module TestModule -Name Get-TestThing | Should -Not -BeNullOrEmpty

        # Private function should NOT be exported
        Get-Command -Module TestModule -Name Invoke-InternalThing | Should -BeNullOrEmpty
    }

    It "Generated module imports without error" {
        $loaderPath = New-ModuleLoader -ModulePath $TempRoot -Name "TestModule"

        {
            Import-Module $loaderPath -Force
        } | Should -Not -Throw
    }
}
