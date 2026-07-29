function Write-FileContent {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Path,

        [Parameter(Mandatory)]
        [string]$Content,

        [Parameter(Mandatory)]
        [string]$Name
    )

    Write-Verbose "Writing $Name to '$Path'."
    Write-Debug "Content length: $($Content.Length) characters"

    Set-Content -Path $Path -Value $Content -Encoding UTF8 -Force

    Write-Information "$Name created at '$Path'."
}
