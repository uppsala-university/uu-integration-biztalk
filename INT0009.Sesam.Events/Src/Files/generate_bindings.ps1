
$DevBindings = 'INT0009.Sesam.Events.BindingInfo_Dev.xml'
$TestBindings = 'INT0009.Sesam.Events.BindingInfo_Test.xml'
$ProdBindings = 'INT0009.Sesam.Events.BindingInfo_Prod.xml'

$DevQueue  = 'OS:.'
$TestQueue  = 'OS:UUC-BIZSRV021-T'
$ProdQueue  = 'OS:UUC-MSMQSRV002'

$DevFile  = 'C:\Integrations\INT0009.Sesam.Events'
$TestFile  = '\\uuc-biz025-t.exchange-test.its.uu.se\sesam$'
$ProdFile  = '\\UUC-BIZ015.user.uu.se\sesam$'

copy .\$DevBindings .\$TestBindings
(Get-Content -Path .\$TestBindings).Replace($DevQueue,$TestQueue).Replace($DevFile,$TestFile) | Set-Content -Path .\$TestBindings

copy .\$DevBindings .\$ProdBindings
(Get-Content -Path .\$ProdBindings).Replace($DevQueue,$ProdQueue).Replace($DevFile,$ProdFile) | Set-Content -Path .\$ProdBindings

