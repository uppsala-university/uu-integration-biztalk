$DevBindings = 'INT0012.esb.identity.rest.BindingInfo_DEV.xml'
$TestBindings = 'INT0012.esb.identity.rest.BindingInfo_TEST.xml'
$VerBindings = 'INT0012.esb.identity.rest.BindingInfo_VER.xml'
$ProdBindings = 'INT0012.esb.identity.rest.BindingInfo_PROD.xml'

$DevQueue  = 'OS:.'
$TestQueue  = 'OS:UUC-BIZSRV021-T'
$VerQueue  =  'OS:UUC-MSMQSRV001'
$ProdQueue  = 'OS:UUC-MSMQSRV002'

copy .\$DevBindings .\$TestBindings
(Get-Content -Path .\$TestBindings).Replace($DevQueue,$TestQueue) | Set-Content -Path .\$TestBindings

copy .\$DevBindings .\$VerBindings
(Get-Content -Path .\$VerBindings).Replace($DevQueue,$VerQueue) | Set-Content -Path .\$VerBindings

copy .\$DevBindings .\$ProdBindings
(Get-Content -Path .\$ProdBindings).Replace($DevQueue,$ProdQueue) | Set-Content -Path .\$ProdBindings