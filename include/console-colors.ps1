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
    Default            = $colors.Magenta
    Parameter          = $colors.White
    Type               = $colors.Gray
  }
}

$edition = $PSEdition

# Only use "Desktop" mappings for Windows PowerShell if on Windows 10 - Windows 11 uses the "Core" mappings
If ($PSEdition -eq "Desktop" -and [System.Environment]::OSVersion.Version -lt [System.Version]"10.0.22000") {
  $edition = "Desktop"
}

Set-PSReadLineOption -Colors $colorMapping.$edition
