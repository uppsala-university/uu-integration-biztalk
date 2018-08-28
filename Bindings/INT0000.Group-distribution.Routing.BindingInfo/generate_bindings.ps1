$DevBindings = 'INT0000.Group-distribution.Routing.BindingInfo_Dev.xml'
$TestBindings = 'INT0000.Group-distribution.Routing.BindingInfo_Test.xml'
$ProdBindings = 'INT0000.Group-distribution.Routing.BindingInfo_Prod.xml'

$DevQueue  = 'OS:.'
$TestQueue  = 'OS:UUC-BIZSRV021-T'
$ProdQueue  = 'OS:UUC-MSMQSRV002'

copy .\$DevBindings .\$TestBindings
(Get-Content -Path .\$TestBindings).Replace($DevQueue,$TestQueue) | Set-Content -Path .\$TestBindings

copy .\$DevBindings .\$ProdBindings
(Get-Content -Path .\$ProdBindings).Replace($DevQueue,$ProdQueue) | Set-Content -Path .\$ProdBindings