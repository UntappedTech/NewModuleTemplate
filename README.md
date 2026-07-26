# NewModuleTemplate

[![PowerShell Gallery](https://img.shields.io/powershellgallery/v/NewModuleTemplate.svg?style=flat-square)](https://www.powershellgallery.com/packages/NewModuleTemplate)
[![Downloads](https://img.shields.io/powershellgallery/dt/NewModuleTemplate.svg?style=flat-square)](https://www.powershellgallery.com/packages/NewModuleTemplate)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square)](LICENSE)

A professional scaffolding generator for PowerShell modules.  
Creates complete, production‑ready module structures with tests, documentation, analyzer settings, strict mode, and optional Git initialization.

---

## 📦 Module Metadata

| Field       | Value                                     |
| ----------- | ----------------------------------------- |
| **Name**    | `NewModuleTemplate`                      |
| **Author**  | `Kael Sterling`                           |
| **License** | MIT                                       |
| **Tags**    | PowerShell, Module, Scaffolding, Template |

---

## 📚 Documentation

This module includes PlatyPS‑generated Markdown help.

- Docs folder: [`Docs/`](Docs/)
- Update script: `Scripts/Update-ModuleDocumentation.ps1`

Regenerate docs:

```powershell
pwsh Scripts/Update-ModuleDocumentation.ps1
```

## **🚀 Installation**

Install from the PowerShell Gallery:

```powershell
Install-Module NewModuleTemplate -Scope CurrentUser
```

Import:

```powershell
Import-Module NewModuleTemplate
```

## **🧩 Features**

- Public/Private function separation
- Strict mode enabled
- PSScriptAnalyzer settings included
- Pester test scaffolding
- PlatyPS documentation integration
- Build and publish scripts
- Optional Git initialization
- Clean, predictable module structure

## **📁 Folder Structure**

```text
NewModuleTemplate/

  NewModuleTemplate.psm1
  NewModuleTemplate.psd1

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
