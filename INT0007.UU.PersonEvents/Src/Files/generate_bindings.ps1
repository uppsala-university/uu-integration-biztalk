$DevBindings = 'INT0007.UU.PersonEvents.BindingInfo_Dev.xml'
$TestBindings = 'INT0007.UU.PersonEvents.BindingInfo_Test.xml'
$ProdBindings = 'INT0007.UU.PersonEvents.BindingInfo_Prod.xml'
$VerBindings = 'INT0007.UU.PersonEvents.BindingInfo_Ver.xml'

$DevQueue  = 'OS:.'
$TestQueue  = 'OS:UUC-BIZSRV021-T'
$ProdQueue  = 'OS:UUC-MSMQSRV002'
$VerQueue  = 'OS:UUC-MSMQSRV001'


copy .\$DevBindings .\$TestBindings
(Get-Content -Path .\$TestBindings).Replace($DevQueue,$TestQueue) | Set-Content -Path .\$TestBindings

copy .\$DevBindings .\$ProdBindings
(Get-Content -Path .\$ProdBindings).Replace($DevQueue,$ProdQueue) | Set-Content -Path .\$ProdBindings

copy .\$DevBindings .\$VerBindings
(Get-Content -Path .\$VerBindings).Replace($DevQueue,$VerQueue) | Set-Content -Path .\$VerBindings
