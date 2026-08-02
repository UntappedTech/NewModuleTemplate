# Requires -Module Pester
Describe "New-PublishScript" {

    BeforeAll {
        $moduleRoot = Join-Path $PSScriptRoot '..' | Resolve-Path
        $manifest = Join-Path $moduleRoot 'NewModuleTemplate.psd1'
        Import-Module $manifest -Force
    }

    BeforeEach {
        $guid = [guid]::NewGuid().ToString()
        $root = Join-Path $env:TEMP $guid

        New-Item -ItemType Directory -Path $root | Out-Null

        Set-Variable -Name TempRoot          -Value $root -Scope Local
        Set-Variable -Name ScriptsDir        -Value (Join-Path $root "Scripts") -Scope Local
        Set-Variable -Name PublishScriptPath -Value (Join-Path $ScriptsDir "publish.ps1") -Scope Local
    }

    It "Creates the Scripts directory and publish.ps1" {
        $result = New-PublishScript -ModulePath $TempRoot -Name "TestModule"

        Test-Path $ScriptsDir        | Should -Be $true
        Test-Path $PublishScriptPath | Should -Be $true

        $result | Should -Be $PublishScriptPath
    }

    It "Replaces __MODULE__ correctly inside the script" {
        New-PublishScript -ModulePath $TempRoot -Name "TestModule"

        $lines = Get-Content $PublishScriptPath | ForEach-Object { $_.Trim() }

        $lines | Where-Object { $_ -like '*Publishing TestModule*' } | Should -Not -BeNullOrEmpty
    }

    It "Contains expected publish pipeline sections" {
        New-PublishScript -ModulePath $TempRoot -Name "TestModule"

        $lines = Get-Content $PublishScriptPath | ForEach-Object { $_.Trim() }

        # Parameter block exists
        $lines | Where-Object { $_ -like 'param(*' } | Should -Not -BeNullOrEmpty

        # Publish-Module call
        $lines | Where-Object { $_ -like '*Publish-Module -Path*' } | Should -Not -BeNullOrEmpty

        # Completion message
        $lines | Where-Object { $_ -like '*Publish complete.*' } | Should -Not -BeNullOrEmpty
    }

    It "Is idempotent and overwrites the script cleanly" {
        New-PublishScript -ModulePath $TempRoot -Name "TestModule"

        {
            New-PublishScript -ModulePath $TempRoot -Name "TestModule"
        } | Should -Not -Throw

        $lines = Get-Content $PublishScriptPath | ForEach-Object { $_.Trim() }
        $lines | Where-Object { $_ -like '*Publishing TestModule*' } | Should -Not -BeNullOrEmpty
    }
}
