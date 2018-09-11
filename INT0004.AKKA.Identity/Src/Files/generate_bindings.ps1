$DevBindings = 'INT0004.AKKA.Identity.BindingInfo_Dev.xml'
$TestBindings = 'INT0004.AKKA.Identity.BindingInfo_Test.xml'
$ATBindings = 'INT0004.AKKA.Identity.BindingInfo_AT.xml'
$ProdBindings = 'INT0004.AKKA.Identity.BindingInfo_Prod.xml'
$VerBindings = 'INT0004.AKKA.Identity.BindingInfo_Ver.xml'

$DevQueue  = 'OS:.'
$TestQueue  = 'OS:UUC-BIZSRV021-T'
$ATQueue  = 'OS:UUC-MSMQSRV001'
$ProdQueue  = 'OS:UUC-MSMQSRV002'
$VerQueue  = 'OS:UUC-MSMQSRV001'

$DevAKKA  = 'https://akka-adm.test.uu.se/akkaappl-soap/ws/AkkaCall'
$TestAKKA  = 'https://akka-adm.test.uu.se/akkaappl-soap/ws/AkkaCall'
$ATAKKA  = ''
$ProdAKKA  = 'https://akka-adm.uu.se/akkaappl-soap/ws/AkkaCall'
$VerAKKA  = 'https://akka-adm.test.uu.se/akkaappl-soap/ws/AkkaCall'

copy .\$DevBindings .\$TestBindings
(Get-Content -Path .\$TestBindings).Replace($DevQueue,$TestQueue).Replace($DevAKKA,$TestAKKA) | Set-Content -Path .\$TestBindings

copy .\$DevBindings .\$ATBindings
(Get-Content -Path .\$ATBindings).Replace($DevQueue,$ATQueue).Replace($DevAKKA,$ATAKKA) | Set-Content -Path .\$ATBindings

copy .\$DevBindings .\$ProdBindings
(Get-Content -Path .\$ProdBindings).Replace($DevQueue,$ProdQueue).Replace($DevAKKA,$ProdAKKA) | Set-Content -Path .\$ProdBindings

copy .\$DevBindings .\$VerBindings
(Get-Content -Path .\$VerBindings).Replace($DevQueue,$VerQueue).Replace($DevAKKA,$VerAKKA) | Set-Content -Path .\$VerBindings