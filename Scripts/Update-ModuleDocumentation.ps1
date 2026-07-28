Import-Module PlatyPS
Import-Module "$PSScriptRoot/../NewModuleTemplate.psd1" -Force


Update-MarkdownHelp `
    -Module "$PSScriptRoot/../NewModuleTemplate.psd1" `
    -OutputFolder "$PSScriptRoot/../Docs" `
    -Force
