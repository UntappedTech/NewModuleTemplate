Import-Module PlatyPS
Import-Module "$PSScriptRoot/../NewModuleTemplate.psd1" -Force


New-MarkdownHelp -Module NewModuleTemplate `
    -OutputFolder "$PSScriptRoot\..\Docs\" `
    -WithModulePage `
    -Force
