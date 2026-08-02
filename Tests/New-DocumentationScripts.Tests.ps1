# Requires -Module Pester
Describe "New-DocumentationScripts" {

    It "Creates documentation scripts" {
        $temp = Join-Path $env:TEMP ([guid]::NewGuid().ToString()) "TestModule"
        New-Item -ItemType Directory -Path $temp | Out-Null

        New-DocumentationScripts -Name "TestModule" -ModulePath $temp

        Test-Path "$temp\Scripts\Update-ModuleDocumentation.ps1" | Should Be $true
    }
}
