$colors = @{
  Black       = "#282c34"
  DarkBlue    = "#61afef"
  DarkGreen   = "#98c379"
  DarkCyan    = "#56b6c2"
  DarkRed     = "#e06c75"
  DarkMagenta = "#c678dd"
  DarkYellow  = "#d19a66"
  Gray        = "#abb2bf"
  DarkGray    = "#828997"
  Blue        = "#61afef"
  Green       = "#98c379"
  Cyan        = "#56b6c2"
  Red         = "#e5847b"
  Magenta     = "#c678dd"
  Yellow      = "#e5c07b"
  White       = "#ffffff"
}

$colorMapping = @{
  Core    = @{
    String             = $colors.Green
    Command            = $colors.Blue
    Number             = $colors.Yellow
    Variable           = $colors.Red
    Comment            = $colors.DarkGray
    Operator           = $colors.Magenta
    ContinuationPrompt = $colors.DarkBlue
    Default            = $colors.Magenta
    Parameter          = $colors.White
    Type               = $colors.Gray
  }
  Desktop = @{
    String             = $colors.Green
    Command            = $colors.Blue
    Number             = $colors.Yellow
    Variable           = $colors.Red
    Comment            = $colors.DarkGray
    Operator           = $colors.Magenta
    ContinuationPrompt = $colors.DarkBlue
    DefaultToken       = $colors.Magenta
    Parameter          = $colors.White
    Type               = $colors.Gray
  }
}



If ($PSEdition -in $colorMapping.Keys) {
  Set-PSReadLineOption -Colors $colorMapping[$PSEdition]
}
Else {
  Write-Error "Unknown PowerShell version '$PSEdition'"
}

# Git Powerline stuff
Import-Module -Name @("posh-git", "oh-my-posh")
Set-Theme -name "Paradox"


# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

Function Start-ElevatedTerminal {

  [CmdletBinding()]
  Param()

  Start-Process -FilePath wt.exe -Verb RunAs

}

$psReadlineVersion = Get-Module PSReadLine -ListAvailable `
| Sort-Object -Property Version -Descending `
| Select-Object -First 1 -ExpandProperty Version

$requiredVersion = New-Object System.Version(2, 2, 0)

If ($psReadlineVersion.CompareTo($requiredVersion) -ge 0) {

  Set-PSReadLineOption -PredictionSource History -PredictionViewStyle ListView -HistorySearchCursorMovesToEnd
  Set-PSReadLineKeyHandler -Chord UpArrow -Function HistorySearchBackward
  Set-PSReadLineKeyHandler -Chord DownArrow -Function HistorySearchForward

  Set-PSReadLineKeyHandler -Chord Alt+w -BriefDescription SaveInHistory -Description "Save in history but do not execute" -ScriptBlock {

    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadline]::GetBufferState([ref]$line, [ref]$cursor)
    [Microsoft.PowerShell.PSConsoleReadline]::AddToHistory($line)
    [Microsoft.PowerShell.PSConsoleReadline]::RevertLine()

  }
}
