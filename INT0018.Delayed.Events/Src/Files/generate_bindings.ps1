$DevBindings = 'INT0018.Delayed.Events.BindingInfo_Dev.xml'
$TestBindings = 'INT0018.Delayed.Events.BindingInfo_Test.xml'
$VerBindings = 'INT0018.Delayed.Events.BindingInfo_Ver.xml'
$ProdBindings = 'INT0018.Delayed.Events.BindingInfo_Prod.xml'

$DevQueue  = 'OS:.'
$TestQueue  = 'OS:UUC-BIZSRV021-T'
$VerQueue  = 'OS:UUC-MSMQSRV001'
$ProdQueue  = 'OS:UUC-MSMQSRV002'

$DevDB  = 'mssql://.//sd-delayed-test-db'
$TestDB  = 'mssql://SQL-AG1.exchange-test.its.uu.se//sd-delayed-test-db'
$VerDB  = 'mssql://SQL-AG1.exchange-test.its.uu.se//sd-delayed-test-db'
$ProdDB  = 'mssql://SQL-AG1.user.uu.se//sd-delayed-db'

copy .\$DevBindings .\$TestBindings
(Get-Content -Path .\$TestBindings).Replace($DevQueue,$TestQueue).Replace($DevDB,$TestDB) | Set-Content -Path .\$TestBindings

copy .\$DevBindings .\$VerBindings
(Get-Content -Path .\$VerBindings).Replace($DevQueue,$VerQueue).Replace($DevDB,$VerDB) | Set-Content -Path .\$VerBindings

copy .\$DevBindings .\$ProdBindings
(Get-Content -Path .\$ProdBindings).Replace($DevQueue,$ProdQueue).Replace($DevDB,$ProdDB) | Set-Content -Path .\$ProdBindings