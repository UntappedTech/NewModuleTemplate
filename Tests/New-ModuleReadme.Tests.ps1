# Requires -Module Pester
Describe "New-ModuleReadme" {

    BeforeAll {
        $moduleRoot = Join-Path $PSScriptRoot '..' | Resolve-Path
        $manifest = Join-Path $moduleRoot 'NewModuleTemplate.psd1'
        Import-Module $manifest -Force
    }

    BeforeEach {
        $guid = [guid]::NewGuid().ToString()
        $root = Join-Path $env:TEMP $guid

        New-Item -ItemType Directory -Path $root | Out-Null

        Set-Variable -Name TempRoot   -Value $root -Scope Local
        Set-Variable -Name ReadmePath -Value (Join-Path $root "README.md") -Scope Local
    }

    It "Creates README.md at the expected path" {
        $result = New-ModuleReadme -ModulePath $TempRoot -Name "TestModule"

        Test-Path $ReadmePath | Should -Be $true
        $result | Should -Be $ReadmePath
    }

    It "Replaces __MODULE_NAME__ and __AUTHOR__ correctly" {
        New-ModuleReadme -ModulePath $TempRoot -Name "TestModule"

        $lines = Get-Content $ReadmePath

        # Name line: | **Name** | `TestModule` |
        $nameLine = $lines | Where-Object { $_ -like "*| **Name** |*TestModule*|" }
        $nameLine | Should -Not -BeNullOrEmpty

        # Author line: | **Author** | `<username>` |
        $authorLine = $lines | Where-Object { $_ -like "*| **Author** |*${env:USERNAME}*|" }
        $authorLine | Should -Not -BeNullOrEmpty
    }

    It "Contains expected README sections" {
        New-ModuleReadme -ModulePath $TempRoot -Name "TestModule"

        $lines = Get-Content $ReadmePath

        # Badges
        $lines | Where-Object { $_ -like "*powershellgallery/v/TestModule*" } | Should -Not -BeNullOrEmpty

        # Metadata section
        $lines | Where-Object { $_ -like "## 📦 Module Metadata*" } | Should -Not -BeNullOrEmpty

        # Documentation section + docs folder line
        $lines | Where-Object { $_ -like "## 📚 Documentation*" } | Should -Not -BeNullOrEmpty
        $lines | Where-Object { $_ -like "*Docs folder:*Docs/*" } | Should -Not -BeNullOrEmpty

        # Installation section
        $lines | Where-Object { $_ -like "## **🚀 Installation**" } | Should -Not -BeNullOrEmpty
        $lines | Where-Object { $_ -like "*Install-Module TestModule*" } | Should -Not -BeNullOrEmpty

        # Features section
        $lines | Where-Object { $_ -like "## **🧩 Features**" } | Should -Not -BeNullOrEmpty

        # Folder structure section
        $lines | Where-Object { $_ -like "## **📁 Folder Structure**" } | Should -Not -BeNullOrEmpty

        # Build script section
        $lines | Where-Object { $_ -like "## **🔧 Build Script**" } | Should -Not -BeNullOrEmpty

        # Publish script section
        $lines | Where-Object { $_ -like "## **📤 Publish Script**" } | Should -Not -BeNullOrEmpty
    }

    It "Is idempotent and overwrites README cleanly" {
        New-ModuleReadme -ModulePath $TempRoot -Name "TestModule"

        {
            New-ModuleReadme -ModulePath $TempRoot -Name "TestModule"
        } | Should -Not -Throw

        $lines = Get-Content $ReadmePath
        $lines | Where-Object { $_ -like "# TestModule" } | Should -Not -BeNullOrEmpty
    }
}
