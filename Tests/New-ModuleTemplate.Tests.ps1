Describe "New-ModuleTemplate" {

    It "Creates the correct folder structure" {
        $temp = Join-Path $env:TEMP ([guid]::NewGuid().ToString())
        New-Item -ItemType Directory -Path $temp | Out-Null

        New-ModuleTemplate -Name "TestModule" -Path $temp

        $expected = @(
            "$temp\TestModule\Public",
            "$temp\TestModule\Private",
            "$temp\TestModule\Tests",
            "$temp\TestModule\Docs"
        )

        foreach ($folder in $expected) {
            Test-Path $folder | Should Be $true
        }
    }

    It "Generated module imports without error" {
        $temp = Join-Path $env:TEMP ([guid]::NewGuid().ToString())
        New-Item -ItemType Directory -Path $temp | Out-Null

        New-ModuleTemplate -Name "TestModule" -Path $temp

        { Import-Module "$temp\TestModule\TestModule.psd1" } | Should Not Throw
    }
}
