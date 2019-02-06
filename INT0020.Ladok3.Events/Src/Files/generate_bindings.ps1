
$DevBindings = 'INT0020.Ladok3.Events.BindingInfo_Dev.xml'
$TestBindings = 'INT0020.Ladok3.Events.BindingInfo_Test.xml'
$ProdBindings = 'INT0020.Ladok3.Events.BindingInfo_Prod.xml'
$VerBindings = 'INT0020.Ladok3.Events.BindingInfo_Ver.xml'

$DevQueue  = 'OS:.'
$TestQueue  = 'OS:UUC-BIZSRV021-T'
$ProdQueue  = 'OS:UUC-MSMQSRV002'
$VerQueue  = 'OS:UUC-MSMQSRV001'

$DevFile  = 'C:\Integrations\INT0020.Ladok3.Events'
$TestFile  = '\\uuc-biz025-t.exchange-test.its.uu.se\ladok3-atom$'
$ProdFile  = '\\UUC-BIZ015.user.uu.se\ladok3-atom$'
$VerFile  = '\\uuc-biz008-t.exchange-test.its.uu.se\ladok3-atom$'

$DevArchiveFile = 'C:\Integrations\Archive\sd-distribution'
$TestArchiveFile = '\\uuc-biz025-t.exchange-test.its.uu.se\ladok3-atom$\archive'
$VerArchiveFile = '\\uuc-biz008-t.exchange-test.its.uu.se\ladok3-atom$\archive'
$ProdArchiveFile = '\\uuc-ladokfs001.its.uu.se\BizTalk-root$'

$DevThumb  = '7B6E9150DD5B9EA485F23B1393398F583F53D90E'
$TestThumb  = '7B6E9150DD5B9EA485F23B1393398F583F53D90E'
$ProdThumb  = '9912327594B7DC0066181B4BE3426725641FF26D'
$VerThumb  = '4AFAFD5B2E152F8743C5460288333D90088A8A45'

$DevRecent  = 'https://api.integrationstest.ladok.se/uppfoljning/feed/recent'
$TestRecent  = 'https://api.integrationstest.ladok.se/uppfoljning/feed/recent'
$ProdRecent  = 'https://api.ladok.se/uppfoljning/feed/recent'
$VerRecent  = 'https://api.verifiering4.ladok.se/uppfoljning/feed/recent'

$DevInitFeed  = 'https://api.integrationstest.ladok.se/uppfoljning/feed/160000'
$TestInitFeed  = 'https://api.integrationstest.ladok.se/uppfoljning/feed/CHANGE_ME'
$ProdInitFeed  = 'https://api.ladok.se/uppfoljning/feed/CHANGE_ME'
$VerInitFeed  = 'https://api.verifiering4.ladok.se/uppfoljning/feed/CHANGE_ME'

$DevDB  = 'mssql://.//L3Events'
$TestDB  = 'mssql://SQL-AG21-T.exchange-test.its.uu.se//sd-ladok3events-test-db'
$VerDB  = 'mssql://SQL-AG21-T.exchange-test.its.uu.se//sd-ladok3events-test-db'
$ProdDB  = 'mssql://SQL-AG1.user.uu.se//sd-ladokevents-db'

$DevInitEntry  = 'aef236fd-c73a-11e8-9cc1-38409a894e86'
$TestInitEntry  = ''
$ProdInitEntry  = ''
$VerInitEntry  = ''


copy .\$DevBindings .\$TestBindings
(Get-Content -Path .\$TestBindings).Replace($DevQueue,$TestQueue).Replace($DevFile,$TestFile).Replace($DevArchiveFile,$TestArchiveFile).Replace($DevThumb,$TestThumb).Replace($DevRecent,$TestRecent).Replace($DevInitFeed,$TestInitFeed).Replace($DevInitEntry,$TestInitEntry).Replace($DevDB,$TestDB)| Set-Content -Path .\$TestBindings

copy .\$DevBindings .\$ProdBindings
(Get-Content -Path .\$ProdBindings).Replace($DevQueue,$ProdQueue).Replace($DevFile,$ProdFile).Replace($DevArchiveFile,$ProdArchiveFile).Replace($DevThumb,$ProdThumb).Replace($DevRecent,$ProdRecent).Replace($DevInitFeed,$ProdInitFeed).Replace($DevInitEntry,$ProdInitEntry).Replace($DevDB,$ProdDB)| Set-Content -Path .\$ProdBindings

copy .\$DevBindings .\$VerBindings
(Get-Content -Path .\$VerBindings).Replace($DevQueue,$VerQueue).Replace($DevFile,$VerFile).Replace($DevArchiveFile,$VerArchiveFile).Replace($DevThumb,$VerThumb).Replace($DevRecent,$VerRecent).Replace($DevInitFeed,$VerInitFeed).Replace($DevInitEntry,$VerInitEntry).Replace($DevDB,$VerDB)| Set-Content -Path .\$VerBindings
