$path = "C:\Integrations\INT0010.Studentportalen.Events\arkiv";
$logfile = "C:\Integrations\INT0010.Studentportalen.Events\psJobb\stats.csv"

function LogWrite{
    Param([string]$logstring)
    Add-Content $logfile -Value $logstring
}

$FILES = Get-ChildItem $path | Where-Object { -not $_.PsIsContainer } | Sort-Object LastWriteTime |  Where-Object {$_.Extension -eq ".xml"}

Write-Host "Tid;Event;Namnrymd;Berikad;Filnamn"
logWrite "Tid;Event;Namnrymd;Berikad;Filnamn"

foreach($FILE in $FILES){
    $xml = [xml](get-content $FILE.FullName)
    $time = $FILE.LastWriteTimeUtc
    $data1 = $xml.FirstChild.LocalName
    $data2 = $xml.FirstChild.NamespaceURI

    $tmp = Get-Content $FILE.FullName | Where-Object {$_ -like "*Envelope*"}
    if($tmp.Length -gt 1){
        $data3 = 1
        $data1 = $xml.FirstChild.FirstChild.LocalName
        $data2 = $xml.FirstChild.FirstChild.NamespaceURI
    }else{
        $data3 = 0
    }

    Write-Host "$time;$data1;$DATA2;$data3;$FILE"
    logWrite "$time;$data1;$DATA2;$data3;$FILE"
}

