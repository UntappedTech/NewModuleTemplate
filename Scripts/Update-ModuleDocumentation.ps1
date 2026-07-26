Import-Module PlatyPS

Update-MarkdownHelp `
    -Module "$PSScriptRoot/../NewModuleTemplate.psd1" `
    -OutputFolder "$PSScriptRoot/../Docs" `
    -Force
