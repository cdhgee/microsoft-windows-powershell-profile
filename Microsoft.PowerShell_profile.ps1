. "$PSScriptRoot/include/console-colors.ps1"
. "$PSScriptRoot/include/psreadline.ps1"

# Git Powerline stuff
#Import-Module -Name "oh-my-posh"

# Using ../PowerShell allows this to work from either PowerShell 7 or Windows PowerShell
$scriptPath = Split-Path -Path $profile -Parent
$fullScriptPath = "$scriptPath/../PowerShell/cdhg-theme.omp.json"
oh-my-posh init pwsh --config $fullScriptPath | Invoke-Expression
#Set-PoshPrompt -Theme "$scriptPath/../PowerShell/cdhg-theme.omp.json"


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
