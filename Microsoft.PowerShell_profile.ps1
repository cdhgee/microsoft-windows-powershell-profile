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

<#
# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
#>
Function Start-ElevatedTerminal {

  [CmdletBinding()]
  Param()

  Start-Process -FilePath wt.exe -Verb RunAs

}
