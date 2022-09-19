Function Start-Session {

  [CmdletBinding()]
  Param(
    [ValidateNotNullOrEmpty()]
    [Parameter(Mandatory=$true)]
    $ComputerName
  )

  $session = New-PSSession -ComputerName $ComputerName -Credential (Get-Credential)

  $session | Enter-PSSession

}

Function Start-ElevatedPowerShell {

  [CmdletBinding()]
  Param()

  Start-Process -FilePath "powershell.exe" -Verb RunAs
}