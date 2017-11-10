$SourceDLL = "..\NullAdapter\bin\Release\Winterdom.BizTalk.Adapters.NullAdapter.dll";


#Test for 64 bit
$Is64Bit =  [Environment]::Is64BitProcess;

#Install Path
$InstallPath = "C:\Program Files\BizTalkNullAdapter\";
If($Is64Bit) 
{
    Write-Host "64-bit Process detected."
    $InstallPath = "C:\Program Files (x86)\BizTalkNullAdapter\"; 
}

#Copy RELEASE version
If(Test-Path $SourceDLL) 
{
    Write-Host "Release version of adapter DLL found"
    xcopy /Y $SourceDLL $InstallPath
    
    #Registry entries
    Write-Host "Merging registry entries";
    regedit /S .\NullAdapter.reg

    if($Is64Bit) {
        Write-Host "Merging 32-bit on 64-bit registry entries";
        regedit /S .\NullAdapter64.reg
    }

    #Register the event source (instead of using install util)
    Write-Host "Registering Event Source"
    New-EventLog -LogName Application -Source "/dev/null Adapter"

} else {
    Write-Error "Release version of adapter DLL NOT found. Please build the VS project first in RELEASE mode."
}