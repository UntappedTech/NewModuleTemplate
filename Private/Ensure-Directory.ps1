function Ensure-Directory {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Path,

        [Parameter(Mandatory)]
        [string]$Name
    )

    if (-not (Test-Path $Path)) {
        Write-Verbose "$Name directory does not exist. Creating it."
        Write-Debug "Creating directory at: $Path"
        New-Item -ItemType Directory -Path $Path -Force | Out-Null
    }
    else {
        Write-Debug "$Name directory already exists at: $Path"
    }
}
