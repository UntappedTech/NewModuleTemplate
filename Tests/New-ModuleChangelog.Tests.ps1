Describe "New-ModuleChangelog" {

    It "Creates a CHANGELOG.md file" {
        $temp = Join-Path $env:TEMP ([guid]::NewGuid().ToString())
        New-Item -ItemType Directory -Path $temp | Out-Null

        $result = New-ModuleChangelog -ModulePath $temp -Version "1.0.0"

        Test-Path $result | Should Be $true
    }

    It "Populates the changelog with correct version" {
        $temp = Join-Path $env:TEMP ([guid]::NewGuid().ToString())
        New-Item -ItemType Directory -Path $temp | Out-Null

        $result = New-ModuleChangelog -ModulePath $temp -Version "0.1.0"

        $content = Get-Content $result -Raw
        $content | Should Match "0.1.0"
    }

    It "Includes the provided notes" {
        $temp = Join-Path $env:TEMP ([guid]::NewGuid().ToString())
        New-Item -ItemType Directory -Path $temp | Out-Null

        $result = New-ModuleChangelog -ModulePath $temp -Version "1.0.0" -Notes "Testing notes"

        $content = Get-Content $result -Raw
        $content | Should Match "Testing notes"
    }
}
