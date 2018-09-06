$DevBindings = 'INT0015.usmr.identity.DEV.bindings.xml'
$TestBindings = 'INT0015.usmr.identity.TEST.bindings.xml'
$VerBindings = 'INT0015.usmr.identity.VER.bindings.xml'
$ProdBindings = 'INT0015.usmr.identity.PROD.bindings.xml'

$DevQueue  = 'OS:.'
$TestQueue  = 'OS:UUC-BIZSRV021-T'
$ProdQueue  = 'OS:UUC-MSMQSRV002'
$VerQueue  = 'OS:UUC-MSMQSRV001'

$Userreplace = 'REPLACEUSER'
$TestDBuser  = 'sd-usmr-test-writer'
$VerDBuser  =  'sd-usmr-test-writer'
$ProdDBuser  = 'someuser'
 
$DevDB  = 'mssql://localhost:1433//sd-usmr-test-db'
$TestDB  = 'mssql://SQL-AG1.exchange-test.its.uu.se:1433//sd-usmr-test-db'
$VerDB  =  'mssql://SQL-AG1.exchange-test.its.uu.se:1433//sd-usmr-test-db'
$ProdDB  = 'Proddatabasename'

copy .\$DevBindings .\$TestBindings
(Get-Content -Path .\$TestBindings).Replace($DevDB,$TestDB) | Set-Content -Path .\$TestBindings
(Get-Content -Path .\$TestBindings).Replace($DevQueue,$TestQueue)| Set-Content -Path .\$TestBindings
(Get-Content -Path .\$TestBindings).Replace($Userreplace,$TestDBuser)| Set-Content -Path .\$TestBindings

copy .\$DevBindings .\$VerBindings
(Get-Content -Path .\$VerBindings).Replace($DevDB,$VerDB) | Set-Content -Path .\$VerBindings
(Get-Content -Path .\$VerBindings).Replace($DevQueue,$VerQueue) | Set-Content -Path .\$VerBindings
(Get-Content -Path .\$VerBindings).Replace($Userreplace,$VerDBuser) | Set-Content -Path .\$VerBindings

copy .\$DevBindings .\$ProdBindings
(Get-Content -Path .\$ProdBindings).Replace($DevDB,$ProdDB) | Set-Content -Path .\$ProdBindings
(Get-Content -Path .\$ProdBindings).Replace($DevQueue,$ProdQueue) | Set-Content -Path .\$ProdBindings
(Get-Content -Path .\$ProdBindings).Replace($Userreplace,$ProdDBuser) | Set-Content -Path .\$ProdBindings