$DevBindings = 'INT0002.UU.GroupEvents.BindingInfo.Dev.xml'
$TestBindings = 'INT0002.UU.GroupEvents.BindingInfo.Test.xml'
$ProdBindings = 'INT0002.UU.GroupEvents.BindingInfo.Prod.xml'
$VerBindings = 'INT0002.UU.GroupEvents.BindingInfo.Ver.xml'

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