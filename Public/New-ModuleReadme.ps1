<#
.SYNOPSIS
    Creates a rich README.md inside the generated module.

.DESCRIPTION
    Generates a professional README including badges, metadata,
    documentation links, usage examples, and module structure.
    Only uses $Name and $env:USERNAME—no additional inputs required.
#>
function New-ModuleReadme {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$BasePath,

        [Parameter(Mandatory)]
        [string]$Name
    )

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

    Set-Content -Path "$BasePath\README.md" -Value $content
}

