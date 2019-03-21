$DevBindings = 'INT0012.esb.identity.rest.BindingInfo_DEV.xml'
$TestBindings = 'INT0012.esb.identity.rest.BindingInfo_TEST.xml'
$VerBindings = 'INT0012.esb.identity.rest.BindingInfo_VER.xml'
$ProdBindings = 'INT0012.esb.identity.rest.BindingInfo_PROD.xml'

$DevQueue  = 'OS:.'
$TestQueue  = 'OS:UUC-BIZSRV021-T'
$VerQueue  =  'OS:UUC-MSMQSRV001'
$ProdQueue  = 'OS:UUC-MSMQSRV002'

$DevLog = 'C:\Integrations\INT0012.esb.identity.rest\archive'
$TestLog = '\\uuc-biz025-t.exchange-test.its.uu.se\identity-distribution$\archive'
$VerLog = '\\uuc-biz008-t.exchange-test.its.uu.se\identity-distribution$\archive'
$ProdLog = '\\uuc-ladokfs001.its.uu.se\BizTalk-root$\identity-distribution'


copy .\$DevBindings .\$TestBindings
(Get-Content -Path .\$TestBindings).Replace($DevQueue,$TestQueue).Replace($DevLog,$TestLog) | Set-Content -Path .\$TestBindings

copy .\$DevBindings .\$VerBindings
(Get-Content -Path .\$VerBindings).Replace($DevQueue,$VerQueue).Replace($DevLog,$VerLog) | Set-Content -Path .\$VerBindings

copy .\$DevBindings .\$ProdBindings
(Get-Content -Path .\$ProdBindings).Replace($DevQueue,$ProdQueue).Replace($DevLog,$ProdLog) | Set-Content -Path .\$ProdBindings