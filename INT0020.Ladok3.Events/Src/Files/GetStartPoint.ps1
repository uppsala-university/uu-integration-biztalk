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

    # Hämta nummer till senaste feeden från recent i prod
    $prodfeednumber = GetLastFeedNumberFromRecent -urlrecent $produrlrecent -thumb $prodthumb

    # Hämta nummer till senaste feeden från recent i test
    $testfeednumber = GetLastFeedNumberFromRecent -urlrecent $testurlrecent -thumb $testthumb

    # Jämför senaste feednummer för test och prod för att se vilken som är lägst
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

    # Hitta rätt feed
    while($true)
    {
        # Urlar till feeds
        $testurlcurrent = $testurl + $currentfeednumber
        $produrlcurrent = $produrl + $currentfeednumber

        # Hämta feeds
        $testresponse = Invoke-RestMethod -Uri $testurlcurrent -CertificateThumbprint $testthumb
        $prodresponse = Invoke-RestMethod -Uri $produrlcurrent -CertificateThumbprint $prodthumb 

        # Hämta första händelseUID från feeds
        $testHandelseUID = $testresponse[$testresponse.Length-1].content.FirstChild.HandelseUID
        $prodHandelseUID = $prodresponse[$prodresponse.Length-1].content.FirstChild.HandelseUID


        # Jämför UIDs, avsluta loop om de är lika
        if($prodHandelseUID -eq $testHandelseUID)
        {
            break
        }

        # Om de inte är lika gå vidare till nästa feed
        $currentfeednumber = $currentfeednumber-1
    }
    

    #Hitta rätt entry i feeden
    $currententry = $testresponse.Length-1

    while($true)
    {
        $previousTestHandelseUID = $testHandelseUID
        $prodHandelseUID = $prodresponse[$currententry].content.FirstChild.HandelseUID
        $testHandelseUID = $testresponse[$currententry].content.FirstChild.HandelseUID

        # Jämför UIDs, avsluta loop om de är olika
        if($prodHandelseUID -ne $testHandelseUID)
        {
            break
        }

        # Om de är lika fortsätt med nästa entry
        $currententry = $currententry-1
    }

    $json = @(
        @{
            URL = $testurl + $currentfeednumber
            HandelseUID = $previousTestHandelseUID
        }
    )

    return $json
}


function GetLastFeedNumberFromRecent
{
    param([System.Uri]$urlrecent, [string]$thumb)

    # Hämta recent
    $recent = Invoke-WebRequest -Uri $urlrecent -CertificateThumbprint $thumb  
    [xml]$xml = $recent.Content  

    # Hämta id för senaste feed
    ForEach($currentlink in $xml.feed.link)
    {
       if($currentlink.rel -eq "via")
       {
           $link = $currentlink.href
       }
    }
    [int]$link.Substring($link.LastIndexOf("/")+1)
}