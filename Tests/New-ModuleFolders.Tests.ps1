Describe "New-ModuleFolders" {

    It "Creates expected folders" {
        $temp = Join-Path $env:TEMP ([guid]::NewGuid().ToString())
        New-Item -ItemType Directory -Path $temp | Out-Null

        New-ModuleFolders -Name "TestModule" -Path $temp

        Test-Path "$temp\TestModule\Public"  | Should Be $true
        Test-Path "$temp\TestModule\Private" | Should Be $true
        Test-Path "$temp\TestModule\Tests"   | Should Be $true
    }
}
