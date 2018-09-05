$DevBindings = 'INT0000.SD-distribution.Routing.BindingInfo_Dev.xml'
$TestBindings = 'INT0000.SD-distribution.Routing.BindingInfo_Test.xml'
$VerBindings = 'INT0000.SD-distribution.Routing.BindingInfo_Ver.xml'
$ProdBindings = 'INT0000.SD-distribution.Routing.BindingInfo_Prod.xml'

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