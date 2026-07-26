<#
.SYNOPSIS
    Generates all Pester test files for the NewModuleTemplate module.

.DESCRIPTION
    Creates the Tests directory and populates it with structured test files
    for each public function in the module. Tests use Pester 6 syntax but
    remain compatible with Pester 3 operators.

.NOTES
    Author: Kael Sterling
    Company: Untapped Technologies
#>

# Ensure Tests directory exists
$testsRoot = Join-Path $PSScriptRoot 'Tests'
if (-not (Test-Path $testsRoot)) {
    New-Item -ItemType Directory -Path $testsRoot | Out-Null
}

function New-TestFile {
    param(
        [string]$Name,
        [string]$Content
    )

    $path = Join-Path $testsRoot $Name
    Set-Content -Path $path -Value $Content -Encoding UTF8
    Write-Host "Created test file: $Name"
}

# ---------------------------
# 1. Module Load Test
# ---------------------------
New-TestFile -Name 'NewModuleTemplate.Tests.ps1' -Content @'
Describe "NewModuleTemplate Module" {

    BeforeAll {
        Import-Module "$PSScriptRoot\..\NewModuleTemplate.psd1" -Force
    }

    It "Loads without error" {
        { Import-Module "$PSScriptRoot\..\NewModuleTemplate.psd1" -Force } | Should Not Throw
    }

    It "Exports at least one function" {
        ((Get-Command -Module NewModuleTemplate).Count -gt 0) | Should Be $true
    }
}
'@

# ---------------------------
# 2. New-ModuleTemplate Tests
# ---------------------------
New-TestFile -Name 'New-ModuleTemplate.Tests.ps1' -Content @'
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
'@

# ---------------------------
# 3. New-ModuleFolders Tests
# ---------------------------
New-TestFile -Name 'New-ModuleFolders.Tests.ps1' -Content @'
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
'@

# ---------------------------
# 4. New-ModuleManifestFile Tests
# ---------------------------
New-TestFile -Name 'New-ModuleManifestFile.Tests.ps1' -Content @'
Describe "New-ModuleManifestFile" {

    It "Creates a valid manifest" {
        $temp = Join-Path $env:TEMP ([guid]::NewGuid().ToString())
        New-Item -ItemType Directory -Path $temp | Out-Null

        New-ModuleManifestFile -Name "TestModule" -Path $temp

        $manifestPath = "$temp\TestModule\TestModule.psd1"
        Test-Path $manifestPath | Should Be $true

        $manifest = Test-ModuleManifest $manifestPath
        $manifest.RootModule | Should Be "TestModule.psm1"
    }
}
'@

# ---------------------------
# 5. New-PesterTests Tests
# ---------------------------
New-TestFile -Name 'New-PesterTests.Tests.ps1' -Content @'
Describe "New-PesterTests" {

    It "Creates starter test file" {
        $temp = Join-Path $env:TEMP ([guid]::NewGuid().ToString())
        New-Item -ItemType Directory -Path $temp | Out-Null

        New-PesterTests -Name "TestModule" -Path $temp

        Test-Path "$temp\TestModule\Tests\TestModule.Tests.ps1" | Should Be $true
    }
}
'@

# ---------------------------
# 6. New-AnalyzerSettings Tests
# ---------------------------
New-TestFile -Name 'New-AnalyzerSettings.Tests.ps1' -Content @'
Describe "New-AnalyzerSettings" {

    It "Creates analyzer settings file" {
        $temp = Join-Path $env:TEMP ([guid]::NewGuid().ToString())
        New-Item -ItemType Directory -Path $temp | Out-Null

        New-AnalyzerSettings -Name "TestModule" -Path $temp

        Test-Path "$temp\TestModule\AnalyzerSettings\Settings.psd1" | Should Be $true
    }
}
'@

# ---------------------------
# 7. New-DocumentationScripts Tests
# ---------------------------
New-TestFile -Name 'New-DocumentationScripts.Tests.ps1' -Content @'
Describe "New-DocumentationScripts" {

    It "Creates documentation scripts" {
        $temp = Join-Path $env:TEMP ([guid]::NewGuid().ToString())
        New-Item -ItemType Directory -Path $temp | Out-Null

        New-DocumentationScripts -Name "TestModule" -Path $temp

        Test-Path "$temp\TestModule\Docs\New-Help.ps1" | Should Be $true
    }
}
'@

# ---------------------------
# 8. Initialize-GitRepository Tests
# ---------------------------
New-TestFile -Name 'Initialize-GitRepository.Tests.ps1' -Content @'
Describe "Initialize-GitRepository" {

    It "Initializes a git repository" {
        $temp = Join-Path $env:TEMP ([guid]::NewGuid().ToString())
        New-Item -ItemType Directory -Path $temp | Out-Null

        Initialize-GitRepository -Path $temp

        Test-Path "$temp\.git" | Should Be $true
    }
}
'@

# ---------------------------
# 9. New-ModuleChangelog Tests
# ---------------------------
New-TestFile -Name 'New-ModuleChangelog.Tests.ps1' -Content @'
Describe "New-ModuleChangelog" {

    It "Creates a CHANGELOG.md file" {
        $temp = Join-Path $env:TEMP ([guid]::NewGuid().ToString())
        New-Item -ItemType Directory -Path $temp | Out-Null

        $result = New-ModuleChangelog -Path $temp -Version "1.0.0"

        Test-Path $result | Should Be $true
    }

    It "Populates the changelog with correct version" {
        $temp = Join-Path $env:TEMP ([guid]::NewGuid().ToString())
        New-Item -ItemType Directory -Path $temp | Out-Null

        $result = New-ModuleChangelog -Path $temp -Version "1.0.0"

        $content = Get-Content $result -Raw
        $content | Should Match "1.0.0"
    }

    It "Includes the provided notes" {
        $temp = Join-Path $env:TEMP ([guid]::NewGuid().ToString())
        New-Item -ItemType Directory -Path $temp | Out-Null

        $result = New-ModuleChangelog -Path $temp -Version "1.0.0" -Notes "Testing notes"

        $content = Get-Content $result -Raw
        $content | Should Match "Testing notes"
    }
}
'@

Write-Host ''
Write-Host 'All test files generated successfully.'
