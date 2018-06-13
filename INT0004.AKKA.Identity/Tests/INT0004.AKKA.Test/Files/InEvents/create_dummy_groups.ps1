$OldString  = '5XXXXXXXXXXX'
$OldNameString = 'REFOTSIRK'
1..7000 | % {
    $randomYearPrefix = get-random -Minimum 50 -Maximum 59
    $randomYear = get-random -Minimum 10 -Maximum 99
    $randomMonth = get-random -Minimum 1 -Maximum 12
    $randomDate = get-random -Minimum 1 -Maximum 28
    $randomThree = get-random -Minimum 100 -Maximum 999
    $rchar = [char](get-random -Minimum 65 -Maximum 90)

    If ($randomMonth -lt 10) 
    {
        $randomMonth = '0' + $randomMonth
    }
    If ($randomDate -lt 10) 
    {
        $randomDate = '0' + $randomDate
    } 
 
    $random = ''  + $randomYear + $randomMonth + $randomDate + $randomThree

    
    $mul = 2
    $aggregate = ''

    for ($i=0; $i -lt $random.Length; $i++)
    {
        $aggregate = $aggregate + [string](([int][string]$random[$i]) * $mul)
        If ($mul -lt 2) 
        {
            $mul = 2
        }
        Else
        {
            $mul = 1
        }
    }

    $check = 0
   for ($i=0; $i -lt $aggregate.Length; $i++)
    {
        $check = $check + [int][string]$aggregate[$i]
    }

    $check =  (10 - ($check % 10)) % 10
    $random = '' + $randomYearPrefix + $random + $check
    $test = ('' + $randomYear + $randomMonth + $randomDate + '-' + $randomThree + $check)
    $test
    copy .\dummy.original ".\$_-$random-infile.xml"
    (Get-Content -Path ".\$_-$random-infile.xml").Replace($OldString,$random) | Set-Content -Path ".\$_-$random-infile.xml"
    (Get-Content -Path ".\$_-$random-infile.xml").Replace($OldNameString,$rchar+$OldNameString) | Set-Content -Path ".\$_-$random-infile.xml"
}