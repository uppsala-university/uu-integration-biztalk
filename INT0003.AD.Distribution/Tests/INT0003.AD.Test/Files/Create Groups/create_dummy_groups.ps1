# Creates dummy group messages from original file dummy.original. Replaces the string 67586 in the groupname with a random guid. 
# Change the span 1..10 to create a differnt amount of files
$OldString  = '67586'
1..10 | % {
    $guid = [guid]::NewGuid().ToString()
    copy .\dummy.orginal ".\$_-$guid.xml"
    (Get-Content -Path ".\$_-$guid.xml").Replace($OldString,$guid) | Set-Content -Path ".\$_-$guid.xml"
}