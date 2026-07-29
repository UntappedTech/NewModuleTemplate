<#
.SYNOPSIS
    Creates a rich README.md inside the generated module.

.DESCRIPTION
    Generates a professional README containing:
    - PowerShell Gallery badges
    - Module metadata
    - Documentation references
    - Installation instructions
    - Usage examples
    - Folder structure overview
    - Build and publish script references
    The README is designed to be immediately useful for developers and users
    of the generated module.

.PARAMETER ModulePath
    The root directory of the module where README.md will be created.

.PARAMETER Name
    The name of the module. Used to populate placeholders inside the README.

.EXAMPLE
    New-ModuleReadme -ModulePath "C:\Projects\MyModule" -Name "MyModule"

.EXAMPLE
    $root = Join-Path $env:TEMP "TestModule"
    New-ModuleReadme -ModulePath $root -Name "TestModule"

.NOTES
    - The here-string is intentionally single-quoted.
    - No escaping or interpolation occurs inside the here-string.
    - Placeholders (__MODULE_NAME__, __AUTHOR__) are replaced afterward.
#>
function New-ModuleReadme {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$ModulePath,

        [Parameter(Mandatory)]
        [string]$Name
    )

    Write-Verbose "Creating README.md for module '$Name'."

    # Ensure module root exists
    Ensure-Directory -Path $ModulePath -Name 'Module root'

    # Template for README.md
    $content = @'
# __MODULE_NAME__

[![PowerShell Gallery](https://img.shields.io/powershellgallery/v/__MODULE_NAME__.svg?style=flat-square)](https://www.powershellgallery.com/packages/__MODULE_NAME__)
[![Downloads](https://img.shields.io/powershellgallery/dt/__MODULE_NAME__.svg?style=flat-square)](https://www.powershellgallery.com/packages/__MODULE_NAME__)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square)](LICENSE)

A PowerShell module generated using the **New-ModuleTemplate** scaffolder.

---

## 📦 Module Metadata

| Field | Value |
|-------|-------|
| **Name** | `__MODULE_NAME__` |
| **Author** | `__AUTHOR__` |
| **License** | MIT |
| **Tags** | PowerShell, Module |

---

## 📚 Documentation

This module includes PlatyPS-generated Markdown help.

- Docs folder: [`Docs/`](Docs/)
- Update script: `Scripts/Update-ModuleDocumentation.ps1`

Regenerate docs:

```powershell
pwsh Scripts/Update-ModuleDocumentation.ps1
```

## **🚀 Installation**

Install from the PowerShell Gallery:

```powershell
Install-Module __MODULE_NAME__ -Scope CurrentUser
```

Import:

```powershell
Import-Module __MODULE_NAME__
```

## **🧩 Features**

* Public/Private function separation  
* Strict mode enabled  
* PSScriptAnalyzer settings included  
* Pester test scaffolding  
* PlatyPS documentation integration  
* Build and publish scripts  
* Optional Git initialization  
* Clean, predictable module structure

## **📁 Folder Structure**

```text
__MODULE_NAME__/

  __MODULE_NAME__.psm1
  __MODULE_NAME__.psd1

  Public/
  Private/
  Tests/
  Docs/
  Scripts/
  Analyzer/
  README.md
  .gitignore
```

## **🧪 Testing**

Run all tests:

```powershell
Invoke-Pester -Path Tests
```

## **🔧 Build Script**

```powershell
pwsh Scripts/build.ps1
```

## **📤 Publish Script**

```powershell
pwsh Scripts/publish.ps1 -ApiKey '<Your PSGallery API Key>'
```

## **📄 License**

MIT

'@

    $content = $content.Replace('__MODULE_NAME__', $Name)
    $content = $content.Replace('__AUTHOR__', $env:USERNAME)

    # Write README.md
    $readmePath = Join-Path $ModulePath 'README.md'
    Write-FileContent -Path $readmePath -Content $content -Name 'README.md'

    return $readmePath
}

