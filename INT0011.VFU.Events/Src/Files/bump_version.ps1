 param (
    [Parameter(Mandatory=$true)][string]$old_version,
    [Parameter(Mandatory=$true)][string]$new_version
 )
 $DevBindings = '.\INT0011.VFU.Events.BindingInfo_Dev.xml'
 $VersionPrefix1 = 'INT0011.VFU.Events, Version='
 $VersionPrefix2 = 'INT0011.VFU.Events" Version="'
 $AssemblyInfo = '..\Properties\AssemblyInfo.cs'

(Get-Content -Path $AssemblyInfo).Replace($old_version,$new_version) | Set-Content -Encoding UTF8 -Path $AssemblyInfo

(Get-Content -Path $DevBindings).Replace($VersionPrefix1+$old_version,$VersionPrefix1+$new_version) | Set-Content  -Path $DevBindings
(Get-Content -Path $DevBindings).Replace($VersionPrefix2+$old_version,$VersionPrefix2+$new_version) | Set-Content -Path $DevBindings

.\generate_bindings.ps1

