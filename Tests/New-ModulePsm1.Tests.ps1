# Requires -Module Pester
Describe "New-ModulePsm1" {

    It "Creates a .psm1 file" {
        $temp = Join-Path $env:TEMP ([guid]::NewGuid().ToString())
        New-Item -ItemType Directory -Path $temp | Out-Null

        $base = New-ModuleFolders -Name "TestModule" -Path $temp
        $result = New-ModulePsm1 -Name "TestModule" -ModulePath $base

        Test-Path $result | Should Be $true
    }
}
