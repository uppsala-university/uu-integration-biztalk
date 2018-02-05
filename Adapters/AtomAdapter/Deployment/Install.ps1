

$adminDLL = "..\Admin\bin\Release\BizTalk.Adapter.AtomAdmin.dll";
$receiveDLL = "..\Runtime\bin\Release\BizTalk.Adapter.Atom.dll";
$baseAdapterDLL = "..\BaseAdapter\v1.0.2\bin\Release\Microsoft.BizTalk.Adapter.Common.dll";
$atomReaderDLL = "..\AtomReader\bin\Release\Shared.Components.AtomReader.dll";


#Test for 64 bit
$Is64Bit =  [Environment]::Is64BitProcess;

#Install Path
$InstallPath = "C:\Program Files\Common Files\Microsoft BizTalk\AtomAdapter\";
If($Is64Bit) 
{
    Write-Host "64-bit Process detected."
    $InstallPath = "C:\Program Files (x86)\Common Files\Microsoft BizTalk\AtomAdapter\"; 
}

#Copy RELEASE version
If((Test-Path $adminDLL) -and (Test-Path $receiveDLL) -and (Test-Path $baseAdapterDLL) -and (Test-Path $atomReaderDLL)) 
{
    Write-Host "Release version of adapter DLL found"
    xcopy /Y $adminDLL $InstallPath
    xcopy /Y $receiveDLL $InstallPath
    xcopy /Y $baseAdapterDLL $InstallPath
	xcopy /Y $atomReaderDLL $InstallPath

    #Registry entries
    Write-Host "Merging registry entries";
    regedit /S .\Atom.reg

    if($Is64Bit) {
        Write-Host "Merging 32-bit on 64-bit registry entries";
        regedit /S .\Atom64.reg
    }


} else {
    Write-Error "Release version of adapter DLL NOT found. Please build the VS project first in RELEASE mode."
}