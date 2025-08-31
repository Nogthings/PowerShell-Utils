<#
.SYNOPSIS
    Finds active TCP connections on a specified port and retrieves associated process information.
.DESCRIPTION
    This function checks for active TCP connections on a given port and returns details including the local address, port, connection state, owning process ID, and process name.
.PARAMETER Port
    The TCP port number to check for active connections.
.EXAMPLE
    Find-Port -Port 80
    This command checks for active TCP connections on port 80 and returns relevant information.
#>
function Find-Port {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, Position=0)]
        [int]$Port
    )

    try {
        Get-NetTCPConnection -LocalPort $Port -ErrorAction Stop | Select-Object LocalAddress, LocalPort, State, OwningProcess, @{Name='ProcessName';Expression={
            try {
                (Get-Process -Id $_.OwningProcess -ErrorAction Stop).ProcessName
            } catch {
                "System or Not Found"
            }
        }}
    } catch {
        Write-Warning "No active connections found on port $Port. It may be free or not in use."
    }
}

Set-Alias -Name findport -Value Find-Port

<#
.SYNOPSIS
    Finds the process listening on a specified TCP port and stops it using Stop-Process, with confirmation prompt.

.DESCRIPTION
    This function searches for a process that is listening on a specified TCP port. If found, it retrieves the process information and prompts the user for confirmation before stopping the process using Stop-Process.
.PARAMETER Port
    The TCP port number to check for a listening process.
.EXAMPLE
    killport 3000
    This command finds the process listening on port 3000 and prompts for confirmation before stopping it.
#>
function Stop-ProcessByPort {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        [Parameter(Mandatory=$true, Position=0)]
        [int]$Port
    )

    $processInfo = Get-NetTCPConnection -LocalPort $Port -ErrorAction SilentlyContinue | Where-Object { $_.State -eq 'Listen' } | Select-Object -First 1

    if ($null -eq $processInfo) {
        Write-Host "No hay ningún proceso escuchando en el puerto $Port." -ForegroundColor Yellow
        return
    }

    $processToKill = Get-Process -Id $processInfo.OwningProcess
    
    Write-Host "Puerto $Port está siendo usado por: $($processToKill.ProcessName) (PID: $($processToKill.Id))"

    # Confirm before stopping the process
    Stop-Process -Id $processToKill.Id -Confirm
}

Set-Alias -Name killport -Value Stop-ProcessByPort

<#
.SYNOPSIS
    Searches for a specified text string within files of a given extension in the current directory and its subdirectories.
.DESCRIPTION
    This function recursively searches through files with a specified extension in the current directory and its subdirectories for a given text string, returning any matches found.
.PARAMETER Text
    The text string to search for within the files.
.PARAMETER Extension
    The file extension to filter the search (default is "*.*" for all files).
.EXAMPLE
    Find-TextInFiles -Text "TODO" -Extension "*.ps1"
    This command searches for the string "TODO" in all PowerShell script files in the current directory and its subdirectories.
#>
function Find-TextInFiles {
[CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Text,
        
        [Parameter(Position=1)]
        [string]$Extension = "*.*"
    )

    Get-ChildItem -Recurse -Filter $Extension | Select-String -Pattern $Text -IgnoreCase
}

Set-Alias -Name findtext -Value Find-TextInFiles

<#
.SYNOPSIS
    A shortcut for 'git status -s -b' to show the current branch and modified/new files in a very compact form.
.DESCRIPTION
    This function runs 'git status -s -b' to provide a concise overview of the current Git branch and the status of files in the repository, showing only modified and new files.
.EXAMPLE
    g
#>
function Get-GitStatusShort {
    git status -s -b
}

Set-Alias -Name g -Value Get-GitStatusShort

<#
.SYNOPSIS
    Lists all functions defined in the user's PowerShell profile along with their descriptions and usage.
.DESCRIPTION
    This function retrieves all functions defined in the user's PowerShell profile script and displays their names, descriptions (from help), and usage.
.EXAMPLE
    MyFunctions
    This command lists all functions defined in the user's PowerShell profile with their descriptions and usage.
#>
function MyFunctions {
    Write-Host "Available Functions in your environment: '$PROFILE':" -ForegroundColor Cyan

    Get-ChildItem Function: | Where-Object { $_.ScriptBlock.File -eq $PROFILE } | ForEach-Object {
        $functionName = $_.Name
        $help = try { Get-Help $functionName -ErrorAction Stop } catch { $null }
        $synopsis = if ($help) { $help.Synopsis } else { "No description available." }

        [PSCustomObject]@{
            Function = $functionName
            Description = $synopsis
            Use = $_.Definition.Split('{')[0].Trim()
        }
    } | Format-Table -AutoSize -Wrap
}
