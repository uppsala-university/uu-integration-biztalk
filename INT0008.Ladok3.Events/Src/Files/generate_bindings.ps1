
$DevBindings = 'INT0008.Ladok3.Events.BindingInfo_Dev.xml'
$TestBindings = 'INT0008.Ladok3.Events.BindingInfo_Test.xml'
$ProdBindings = 'INT0008.Ladok3.Events.BindingInfo_Prod.xml'
$VerBindings = 'INT0008.Ladok3.Events.BindingInfo_Ver.xml'

$DevQueue  = 'OS:.'
$TestQueue  = 'OS:UUC-BIZSRV021-T'
$ProdQueue  = 'OS:UUC-MSMQSRV002'
$VerQueue  = 'OS:UUC-MSMQSRV001'

$DevFile  = 'C:\Integrations\INT0008.Ladok3.Events'
$TestFile  = '\\uuc-biz025-t.exchange-test.its.uu.se\ladok3-atom$\state'
$ProdFile  = '\\UUC-BIZ015.user.uu.se\ladok3-atom$\state'
$VerFile  = '\\uuc-biz008-t.exchange-test.its.uu.se\ladok3-atom$\state'

$DevThumb  = '7B6E9150DD5B9EA485F23B1393398F583F53D90E'
$TestThumb  = '7B6E9150DD5B9EA485F23B1393398F583F53D90E'
$ProdThumb  = ''
$VerThumb  = '4AFAFD5B2E152F8743C5460288333D90088A8A45'

$DevRecent  = 'https://api.mit-integration.ladok.se/uppfoljning/feed/recent'
$TestRecent  = 'https://api.mit-integration.ladok.se/uppfoljning/feed/recent'
$ProdRecent  = 'https://api.ladok.se/uppfoljning/feed/recent'
$VerRecent  = 'https://api.verifiering4.ladok.se/uppfoljning/feed/recent'


$DevInitFeed  = 'https://api.mit-integration.ladok.se/uppfoljning/feed/143653'
$TestInitFeed  = 'https://api.mit-integration.ladok.se/uppfoljning/feed/143653'
$ProdInitFeed  = 'https://api.ladok.se/uppfoljning/feed/CHANGE_ME'
$VerInitFeed  = 'https://api.verifiering4.ladok.se/uppfoljning/feed/CHANGE_ME'

$DevInitEntry  = '74ad4da9-31e0-11e8-b65f-0778fef44f1b'
$TestInitEntry  = '74ad4da9-31e0-11e8-b65f-0778fef44f1b'
$ProdInitEntry  = ''
$VerInitEntry  = ''


copy .\$DevBindings .\$TestBindings
(Get-Content -Path .\$TestBindings).Replace($DevQueue,$TestQueue).Replace($DevFile,$TestFile).Replace($DevThumb,$TestThumb).Replace($DevRecent,$TestRecent).Replace($DevInitFeed,$TestInitFeed).Replace($DevInitEntry,$TestInitEntry)| Set-Content -Path .\$TestBindings

copy .\$DevBindings .\$ProdBindings
(Get-Content -Path .\$ProdBindings).Replace($DevQueue,$ProdQueue).Replace($DevFile,$ProdFile).Replace($DevThumb,$ProdThumb).Replace($DevRecent,$ProdRecent).Replace($DevInitFeed,$ProdInitFeed).Replace($DevInitEntry,$ProdInitEntry)| Set-Content -Path .\$ProdBindings

copy .\$DevBindings .\$VerBindings
(Get-Content -Path .\$VerBindings).Replace($DevQueue,$VerQueue).Replace($DevFile,$VerFile).Replace($DevThumb,$VerThumb).Replace($DevRecent,$VerRecent).Replace($DevInitFeed,$VerInitFeed).Replace($DevInitEntry,$VerInitEntry)| Set-Content -Path .\$VerBindings
