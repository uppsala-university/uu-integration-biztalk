$DevBindings = 'INT0014.identity.sp.adapter.bindings.DEV.xml'
$TestBindings = 'INT0014.identity.sp.adapter.bindings.TEST.xml'
$VerBindings = 'INT0014.identity.sp.adapter.bindings.VER.xml'
$ProdBindings = 'INT0014.identity.sp.adapter.bindings.PROD.xml'

$DevQueue  = 'OS:.'
$TestQueue  = 'OS:UUC-BIZSRV021-T'
$ProdQueue  = 'OS:UUC-MSMQSRV002'
$VerQueue  = 'OS:UUC-MSMQSRV001'
 
$DevSp  = 'https://spl3t.studentportalen.uu.se/uusp-webapp/spring/account/pnrupdate'
$TestSp  = 'https://spl3t.studentportalen.uu.se/uusp-webapp/spring/account/pnrupdate'
$VerSp  =  'https://spl3t.studentportalen.uu.se/uusp-webapp/spring/account/pnrupdate'
$ProdSp  = 'https://spl3t.studentportalen.uu.se/uusp-webapp/spring/account/pnrupdate'

copy .\$DevBindings .\$TestBindings
(Get-Content -Path .\$TestBindings).Replace($DevSp,$TestSp) | Set-Content -Path .\$TestBindings
(Get-Content -Path .\$TestBindings).Replace($DevQueue,$TestQueue)| Set-Content -Path .\$TestBindings

copy .\$DevBindings .\$VerBindings
(Get-Content -Path .\$VerBindings).Replace($DevSp,$VerSp) | Set-Content -Path .\$VerBindings
(Get-Content -Path .\$VerBindings).Replace($DevQueue,$VerQueue) | Set-Content -Path .\$VerBindings

copy .\$DevBindings .\$ProdBindings
(Get-Content -Path .\$ProdBindings).Replace($DevSp,$ProdSp) | Set-Content -Path .\$ProdBindings
(Get-Content -Path .\$ProdBindings).Replace($DevQueue,$ProdQueue) | Set-Content -Path .\$ProdBindings