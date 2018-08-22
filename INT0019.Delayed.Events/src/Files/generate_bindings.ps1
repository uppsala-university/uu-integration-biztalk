$DevBindings = 'INT0019.Delayed.Events.BindingInfo_Dev.xml'
$TestBindings = 'INT0019.Delayed.Events.BindingInfo_Test.xml'
$ProdBindings = 'INT0019.Delayed.Events.BindingInfo_Prod.xml'

$DevQueue  = 'OS:.'
$TestQueue  = 'OS:UUC-BIZSRV021-T'
$ProdQueue  = 'OS:UUC-MSMQSRV002'

$DevDB  = 'mssql://.//sd-delayed-test-db'
$TestDB  = 'mssql://SQL-AG1.exchange-test.its.uu.se//sd-delayed-test-db'
$ProdDB  = 'mssql://SQL-AG1.user.uu.se//sd-delayed-db'

copy .\$DevBindings .\$TestBindings
(Get-Content -Path .\$TestBindings).Replace($DevQueue,$TestQueue).Replace($DevDB,$TestDB) | Set-Content -Path .\$TestBindings

copy .\$DevBindings .\$ProdBindings
(Get-Content -Path .\$ProdBindings).Replace($DevQueue,$ProdQueue).Replace($DevDB,$ProdDB) | Set-Content -Path .\$ProdBindings