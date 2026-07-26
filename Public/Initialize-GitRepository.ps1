function Initialize-GitRepository {
    param([string]$BasePath)

    $gitignore = @'
## Build artifacts
bin/
obj/

# VSCode
.vscode/

# PlatyPS temp files
Docs/*.xml

# PowerShellGet publish cache
*.nupkg

# Logs
*.log

'@

    Set-Content -Path "$BasePath\.gitignore" -Value $gitignore

    git init $BasePath | Out-Null
    git -C $BasePath add . | Out-Null
    git -C $BasePath commit -m "Initial commit" | Out-Null
}
