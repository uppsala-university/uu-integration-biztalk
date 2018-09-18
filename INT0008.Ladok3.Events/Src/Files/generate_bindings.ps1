
$DevBindings = 'INT0008.Ladok3.Events.BindingInfo_Dev.xml'
$TestBindings = 'INT0008.Ladok3.Events.BindingInfo_Test.xml'
$ProdBindings = 'INT0008.Ladok3.Events.BindingInfo_Prod.xml'
$VerBindings = 'INT0008.Ladok3.Events.BindingInfo_Ver.xml'

$DevQueue  = 'OS:.'
$TestQueue  = 'OS:UUC-BIZSRV021-T'
$ProdQueue  = 'OS:UUC-MSMQSRV002'
$VerQueue  = 'OS:UUC-MSMQSRV001'

$DevFile  = 'C:\Integrations\INT0008.Ladok3.Events'
$TestFile  = '\\uuc-biz025-t.exchange-test.its.uu.se\ladok3-atom$'
$ProdFile  = '\\UUC-BIZ015.user.uu.se\ladok3-atom$'
$VerFile  = '\\uuc-biz008-t.exchange-test.its.uu.se\ladok3-atom$'

$DevArchiveFile = 'C:\integrations\Archive\sd-distribution'
$TestArchiveFile = '\\uuc-biz025-t.exchange-test.its.uu.se\ladok3-atom$\archive'
$VerArchiveFile = '\\uuc-biz008-t.exchange-test.its.uu.se\ladok3-atom$\archive'
$ProdArchiveFile = '\\uuc-ladokfs001.its.uu.se\BizTalk-root$'

$DevThumb  = '7B6E9150DD5B9EA485F23B1393398F583F53D90E'
$TestThumb  = '7B6E9150DD5B9EA485F23B1393398F583F53D90E'
$ProdThumb  = ''
$VerThumb  = '4AFAFD5B2E152F8743C5460288333D90088A8A45'

$DevRecent  = 'https://api.mit-integration.ladok.se/uppfoljning/feed/recent'
$TestRecent  = 'https://api.mit-integration.ladok.se/uppfoljning/feed/recent'
$ProdRecent  = 'https://api.ladok.se/uppfoljning/feed/recent'
$VerRecent  = 'https://api.verifiering4.ladok.se/uppfoljning/feed/recent'


$DevInitFeed  = 'https://api.mit-integration.ladok.se/uppfoljning/feed/143653'
$TestInitFeed  = 'https://api.mit-integration.ladok.se/uppfoljning/feed/CHANGE_ME'
$ProdInitFeed  = 'https://api.ladok.se/uppfoljning/feed/CHANGE_ME'
$VerInitFeed  = 'https://api.verifiering4.ladok.se/uppfoljning/feed/CHANGE_ME'

$DevInitEntry  = '0b8dbce3-ad05-11e8-9494-c630dded4f0c'
$TestInitEntry  = ''
$ProdInitEntry  = ''
$VerInitEntry  = ''


copy .\$DevBindings .\$TestBindings
(Get-Content -Path .\$TestBindings).Replace($DevQueue,$TestQueue).Replace($DevFile,$TestFile).Replace($DevArchiveFile,$TestArchiveFile).Replace($DevThumb,$TestThumb).Replace($DevRecent,$TestRecent).Replace($DevInitFeed,$TestInitFeed).Replace($DevInitEntry,$TestInitEntry)| Set-Content -Path .\$TestBindings

copy .\$DevBindings .\$ProdBindings
(Get-Content -Path .\$ProdBindings).Replace($DevQueue,$ProdQueue).Replace($DevFile,$ProdFile).Replace($DevArchiveFile,$ProdArchiveFile).Replace($DevThumb,$ProdThumb).Replace($DevRecent,$ProdRecent).Replace($DevInitFeed,$ProdInitFeed).Replace($DevInitEntry,$ProdInitEntry)| Set-Content -Path .\$ProdBindings

copy .\$DevBindings .\$VerBindings
(Get-Content -Path .\$VerBindings).Replace($DevQueue,$VerQueue).Replace($DevFile,$VerFile).Replace($DevArchiveFile,$VerArchiveFile).Replace($DevThumb,$VerThumb).Replace($DevRecent,$VerRecent).Replace($DevInitFeed,$VerInitFeed).Replace($DevInitEntry,$VerInitEntry)| Set-Content -Path .\$VerBindings
