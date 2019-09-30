function GetStartPoint
{
     param (
        [Parameter(Mandatory=$true)][string]$testurl,
        [Parameter(Mandatory=$true)][string]$produrl,
        [Parameter(Mandatory=$true)][string]$testthumb,
        [Parameter(Mandatory=$true)][string]$prodthumb
     )

    #$testurl = "https://api.integrationstest.ladok.se/uppfoljning/feed/"
    #$produrl = "https://api.ladok.se/uppfoljning/feed/"
    #$testthumb = "7B6E9150DD5B9EA485F23B1393398F583F53D90E"
    #$prodthumb = "9912327594B7DC0066181B4BE3426725641FF26D"

    # URL till recent
    $testurlrecent = $testurl + "recent"
    $produrlrecent = $produrl + "recent"

    # H�mta nummer till senaste feeden fr�n recent i prod
    $prodfeednumber = GetLastFeedNumberFromRecent -urlrecent $produrlrecent -thumb $prodthumb

    # H�mta nummer till senaste feeden fr�n recent i test
    $testfeednumber = GetLastFeedNumberFromRecent -urlrecent $testurlrecent -thumb $testthumb

    # J�mf�r senaste feednummer f�r test och prod f�r att se vilken som �r l�gst
    if($prodfeednumber -gt $testfeednumber)
    {
        [int]$currentfeednumber = $testfeednumber
    }
    else
    {
        [int]$currentfeednumber = $prodfeednumber
    }

    $prodHandelseUID = 0
    $testHandelseUID = 0

    # Hitta r�tt feed
    while($true)
    {
        # Urlar till feeds
        $testurlcurrent = $testurl + $currentfeednumber
        $produrlcurrent = $produrl + $currentfeednumber

        # H�mta feeds
        $testresponse = Invoke-RestMethod -Uri $testurlcurrent -CertificateThumbprint $testthumb
        $prodresponse = Invoke-RestMethod -Uri $produrlcurrent -CertificateThumbprint $prodthumb 

        # H�mta f�rsta h�ndelseUID fr�n feeds
        $testID = $testresponse[$testresponse.Length-1].id
        $prodID = $prodresponse[$prodresponse.Length-1].id        

        # J�mf�r UIDs, avsluta loop om de �r lika
        if($prodID -eq $testID)
        {
            break
        }

        # Om de inte �r lika g� vidare till n�sta feed
        $currentfeednumber = $currentfeednumber-1
    }
    

    #Hitta r�tt entry i feeden
    $currenttestentry = $testresponse.Length-1
    $currentprodentry = $prodresponse.Length-1

    while($true)
    {
        $previousTestID = $testID
        $prodID = $prodresponse[$currentprodentry].id
        $testID = $testresponse[$currenttestentry].id

        # J�mf�r UIDs, avsluta loop om de �r olika
        if($prodID -ne $testID)
        {
            break
        }

        # Om de �r lika forts�tt med n�sta entry
        $currenttestentry = $currenttestentry-1
        $currentprodentry = $currentprodentry-1
    }

    $json = @(
        @{
            URL = $testurl + $currentfeednumber
            ID = $previousTestID
        }
    )

    return $json
}


function GetLastFeedNumberFromRecent
{
    param([System.Uri]$urlrecent, [string]$thumb)

    # H�mta recent
    $recent = Invoke-WebRequest -Uri $urlrecent -CertificateThumbprint $thumb  
    [xml]$xml = $recent.Content  

    # H�mta id f�r senaste feed
    ForEach($currentlink in $xml.feed.link)
    {
       if($currentlink.rel -eq "via")
       {
           $link = $currentlink.href
       }
    }
    [int]$link.Substring($link.LastIndexOf("/")+1)
}