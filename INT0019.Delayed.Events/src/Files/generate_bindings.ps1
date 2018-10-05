$DevBindings = 'INT0019.Delayed.Events.BindingInfo_Dev.xml'
$TestBindings = 'INT0019.Delayed.Events.BindingInfo_Test.xml'
$VerBindings = 'INT0019.Delayed.Events.BindingInfo_Ver.xml'
$ProdBindings = 'INT0019.Delayed.Events.BindingInfo_Prod.xml'

$DevQueue  = 'OS:.'
$TestQueue  = 'OS:UUC-BIZSRV021-T'
$VerQueue  = 'OS:UUC-MSMQSRV001'
$ProdQueue  = 'OS:UUC-MSMQSRV002'

$DevDB  = 'mssql://.//sd-delayed-test-db'
$TestDB  = 'mssql://SQL-AG1.exchange-test.its.uu.se//sd-delayed-test-db'
$VerDB  = 'mssql://SQL-AG1.exchange-test.its.uu.se//sd-delayed-test-db'
$ProdDB  = 'mssql://SQL-AG1.user.uu.se//sd-delayed-db'

$DevDBUser  = 'sd-delayed-test-writer'
$TestDBUser  = 'sd-delayed-test-writer'
$VerDBUser  = 'sd-delayed-test-writer'
$ProdDBUser  = 'sd-delayed-writer'

copy .\$DevBindings .\$TestBindings
(Get-Content -Path .\$TestBindings).Replace($DevQueue,$TestQueue).Replace($DevDB,$TestDB).Replace($DevDBUser,$TestDBUser) | Set-Content -Path .\$TestBindings

copy .\$DevBindings .\$VerBindings
(Get-Content -Path .\$VerBindings).Replace($DevQueue,$VerQueue).Replace($DevDB,$VerDB).Replace($DevDBUser,$VerDBUser) | Set-Content -Path .\$VerBindings

copy .\$DevBindings .\$ProdBindings
(Get-Content -Path .\$ProdBindings).Replace($DevQueue,$ProdQueue).Replace($DevDB,$ProdDB).Replace($DevDBUser,$ProdDBUser) | Set-Content -Path .\$ProdBindings