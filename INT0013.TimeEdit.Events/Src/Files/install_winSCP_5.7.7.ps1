#Parameters
$downloadNoGetTo = “C:\temp”
$bizTalkInstallFolder = “C:\Program Files (x86)\Microsoft BizTalk Server 2016”

#Download NuGet
Write-Host “Downloading Nuget”
$sourceNugetExe = “https://dist.nuget.org/win-x86-commandline/latest/nuget.exe”
$targetNugetExe = “$downloadNoGetTo\nuget.exe”
Invoke-WebRequest $sourceNugetExe -OutFile $targetNugetExe

#Download the right version of WinSCP
Write-Host “Downloading WinSCP from NuGet”
Invoke-Expression “$targetNugetExe Install WinSCP -Version 5.7.7 -OutputDirectory $downloadNoGetTo”

#Copy WinSCP items to BizTalk Folder
Write-Host “Copying WinSCP Nuget to BizTalk Folder”
Copy-Item “$downloadNoGetTo\WinSCP.5.7.7\content\WinSCP.exe” $bizTalkInstallFolder
Copy-Item “$downloadNoGetTo\WinSCP.5.7.7\lib\WinSCPnet.dll” $bizTalkInstallFolder