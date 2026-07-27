function New-DocumentationScripts {
    param(
        [string]$BasePath,
        [string]$Name
    )

    $content = @'
Import-Module PlatyPS

Update-MarkdownHelp -Module "$PSScriptRoot\..\__MODULE_NAME__.psd1" -OutputFolder "$PSScriptRoot\Docs" -Force
'@

    $content = $content.Replace('__MODULE_NAME__', "$Name")
    # $content = $content.Replace('__DOCS_PATH__', "$BasePath\Docs")

    Set-Content -Path "$BasePath\Scripts\Update-ModuleDocumentation.ps1" -Value $content
}
