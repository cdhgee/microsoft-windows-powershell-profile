

$psReadlineVersion = Get-Module PSReadLine -ListAvailable `
| Sort-Object -Property Version -Descending `
| Select-Object -First 1 -ExpandProperty Version

$requiredVersion = New-Object System.Version(2, 2, 0)

function Test-WindowsTerminal {

  $isWindowsTerminal = $false
  $p = Get-Process -Id $PID

  while ($null -ne $p -and $p.GetType().Name -eq "Process") {

    $name = $p.Name
    if ($name -Eq "WindowsTerminal") {

      $isWindowsTerminal = $true

    }

    $p = $p.parent
  }

  $isWindowsTerminal
}


If ($psReadlineVersion.CompareTo($requiredVersion) -ge 0) {

  $listViewStyle = "ListView"
  $psHost = Get-Host

  If ($psHost.UI.RawUI.WindowSize.Width -lt 54 -or $psHost.UI.RawUI.WindowSize.Height -lt 15) {
    $listViewStyle = "InlineView"
  }

  Set-PSReadLineOption -PredictionSource History
  Set-PSReadlineOption -PredictionViewStyle $listViewStyle
  Set-PSReadLineOption -HistorySearchCursorMovesToEnd

  # In Emacs mode - Tab acts like in bash, but the Windows style completion
  # is still useful sometimes, so bind some keys so we can do both
  Set-PSReadLineKeyHandler -Key Ctrl+q -Function TabCompleteNext
  Set-PSReadLineKeyHandler -Key Ctrl+Q -Function TabCompletePrevious

  # Clipboard interaction is bound by default in Windows mode, but not Emacs mode.
  Set-PSReadLineKeyHandler -Key Ctrl+C -Function Copy
  Set-PSReadLineKeyHandler -Key Ctrl+v -Function Paste

  # CaptureScreen is good for blog posts or email showing a transaction
  # of what you did when asking for help or demonstrating a technique.
  Set-PSReadLineKeyHandler -Chord 'Ctrl+d,Ctrl+c' -Function CaptureScreen

  # The built-in word movement uses character delimiters, but token based word
  # movement is also very useful - these are the bindings you'd use if you
  # prefer the token based movements bound to the normal emacs word movement
  # key bindings.
  Set-PSReadLineKeyHandler -Key Alt+d -Function ShellKillWord
  Set-PSReadLineKeyHandler -Key Alt+Backspace -Function ShellBackwardKillWord
  Set-PSReadLineKeyHandler -Key Alt+b -Function ShellBackwardWord
  Set-PSReadLineKeyHandler -Key Alt+f -Function ShellForwardWord
  Set-PSReadLineKeyHandler -Key Alt+B -Function SelectShellBackwardWord
  Set-PSReadLineKeyHandler -Key Alt+F -Function SelectShellForwardWord

  Set-PSReadLineKeyHandler -Key Alt+w -BriefDescription SaveInHistory -Description "Save in history but do not execute" -ScriptBlock {

    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadline]::GetBufferState([ref]$line, [ref]$cursor)
    [Microsoft.PowerShell.PSConsoleReadline]::AddToHistory($line)
    [Microsoft.PowerShell.PSConsoleReadline]::RevertLine()

  }
}
