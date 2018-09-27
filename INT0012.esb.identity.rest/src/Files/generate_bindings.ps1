$DevBindings = 'INT0012.esb.identity.rest.BindingInfo_DEV.xml'
$TestBindings = 'INT0012.esb.identity.rest.BindingInfo_TEST.xml'
$VerBindings = 'INT0012.esb.identity.rest.BindingInfo_VER.xml'
$ProdBindings = 'INT0012.esb.identity.rest.BindingInfo_PROD.xml'

$DevQueue  = 'OS:.'
$TestQueue  = 'OS:UUC-BIZSRV021-T'
$VerQueue  =  'OS:UUC-MSMQSRV001'
$ProdQueue  = 'OS:UUC-MSMQSRV002'

$DevArchive  = 'C:\Integrations\Archive\esb-identity'
$TestArchive  = '\\uuc-biz025-t.exchange-test.its.uu.se\esb-identity$\archive'
$VerArchive  =  '\\uuc-biz008-t.exchange-test.its.uu.se\esb-identity$\archive'
$ProdArchive  = '\\uuc-ladokfs001.its.uu.se\BizTalk-root$\esb-identity'

copy .\$DevBindings .\$TestBindings
(Get-Content -Path .\$TestBindings).Replace($DevQueue,$TestQueue).Replace($DevArchive,$TestArchive) | Set-Content -Path .\$TestBindings

copy .\$DevBindings .\$VerBindings
(Get-Content -Path .\$VerBindings).Replace($DevQueue,$VerQueue).Replace($DevArchive,$VerArchive) | Set-Content -Path .\$VerBindings

copy .\$DevBindings .\$ProdBindings
(Get-Content -Path .\$ProdBindings).Replace($DevQueue,$ProdQueue).Replace($DevArchive,$ProdArchive) | Set-Content -Path .\$ProdBindings