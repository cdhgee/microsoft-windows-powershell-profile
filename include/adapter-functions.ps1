Function Disable-IP {
  [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [ValidateSet(4,6)]
    $Version,
    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    $Interface
  )

  $bindings = @{4 = "ms_tcpip";6 = "ms_tcpip6"}

  Get-NetAdapterBinding -InterfaceAlias $Interface -ComponentID $bindings.$Version | Disable-NetAdapterBinding
}

Function Enable-IP {
  [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [ValidateSet(4,6)]
    $Version,
    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    $Interface
  )

  $bindings = @{4 = "ms_tcpip";6 = "ms_tcpip6"}

  Get-NetAdapterBinding -InterfaceAlias $Interface -ComponentID $bindings.$Version | Enable-NetAdapterBinding
}

Function Bounce-IP {
  [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [ValidateSet(4,6)]
    $Version,
    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    $Interface
  )

  Disable-IP -Version $Version -Interface $Interface
  Sleep 2
  Enable-IP -Version $Version -Interface $Interface
}

