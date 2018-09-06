$DevBindings = 'INT0014.identity.sp.adapter.bindings.DEV.xml'
$TestBindings = 'INT0014.identity.sp.adapter.bindings.TEST.xml'
$VerBindings = 'INT0014.identity.sp.adapter.bindings.VER.xml'
$ProdBindings = 'INT0014.identity.sp.adapter.bindings.PROD.xml'
 
$DevSp  = 'https://spl3t.studentportalen.uu.se/uusp-webapp/spring/account/pnrupdate'
$TestSp  = 'https://spl3t.studentportalen.uu.se/uusp-webapp/spring/account/pnrupdate'
$VerSp  =  'https://spl3t.studentportalen.uu.se/uusp-webapp/spring/account/pnrupdate'
$ProdSp  = 'https://spl3t.studentportalen.uu.se/uusp-webapp/spring/account/pnrupdate'

copy .\$DevBindings .\$TestBindings
(Get-Content -Path .\$TestBindings).Replace($DevSp,$TestSp) | Set-Content -Path .\$TestBindings

copy .\$DevBindings .\$VerBindings
(Get-Content -Path .\$VerBindings).Replace($DevSp,$VerSp) | Set-Content -Path .\$VerBindings

copy .\$DevBindings .\$ProdBindings
(Get-Content -Path .\$ProdBindings).Replace($DevSp,$ProdSp) | Set-Content -Path .\$ProdBindings