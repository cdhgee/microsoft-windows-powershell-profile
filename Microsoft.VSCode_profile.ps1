[CmdletBinding()]

$parentPath = Split-Path -Path $PSCommandPath
$vsCodeProfile = Join-Path -Path $parentPath -ChildPath "Microsoft.PowerShell_profile.ps1"
. $vsCodeProfile
