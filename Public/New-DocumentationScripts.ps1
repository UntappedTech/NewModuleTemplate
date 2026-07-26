function New-DocumentationScripts {
    param(
        [string]$Name,
        [string]$BasePath
    )

    $content = @'
Import-Module PlatyPS

Update-MarkdownHelp -Module "__MODULE_PATH__" -OutputFolder "__DOCS_PATH__" -Force
'@

    $content = $content.Replace('__MODULE_PATH__', "$BasePath\$Name.psd1")
    $content = $content.Replace('__DOCS_PATH__', "$BasePath\Docs")

    Set-Content -Path "$BasePath\Scripts\Update-ModuleDocumentation.ps1" -Value $content
}
