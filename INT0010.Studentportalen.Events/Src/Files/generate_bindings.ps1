$DevBindings = 'INT0010.Studentportalen.Events.BindingInfo_Dev.xml'
$TestBindings = 'INT0010.Studentportalen.Events.BindingInfo_Test.xml'
$ProdBindings = 'INT0010.Studentportalen.Events.BindingInfo_Prod.xml'
$VerBindings = 'INT0010.Studentportalen.Events.BindingInfo_Ver.xml'

$DevQueue  = 'OS:.'
$TestQueue  = 'OS:UUC-BIZSRV021-T'
$ProdQueue  = 'OS:UUC-MSMQSRV002'
$VerQueue  = 'OS:UUC-MSMQSRV001'

$DevEndPoint  = 'https://dev1.studentportalen.uu.se/uusp-webapp/spring/ladok-event?pw=Curry79Groda'
$TestEndPoint  = 'https://dev1.studentportalen.uu.se/uusp-webapp/spring/ladok-event?pw=Curry79Groda'
$ProdEndPoint  = 'https://studentportalen.uu.se/uusp-webapp/spring/ladok-event?pw=CHANGEME'
$VerEndPoint  = 'https://dev1.studentportalen.uu.se/uusp-webapp/spring/ladok-event?pw=Curry79Groda'

copy .\$DevBindings .\$TestBindings
(Get-Content -Path .\$TestBindings).Replace($DevQueue,$TestQueue).Replace($DevEndPoint,$TestEndPoint) | Set-Content -Path .\$TestBindings

copy .\$DevBindings .\$ProdBindings
(Get-Content -Path .\$ProdBindings).Replace($DevQueue,$ProdQueue).Replace($DevEndPoint,$ProdEndPoint) | Set-Content -Path .\$ProdBindings

copy .\$DevBindings .\$VerBindings
(Get-Content -Path .\$VerBindings).Replace($DevQueue,$VerQueue).Replace($DevEndPoint,$VerEndPoint) | Set-Content -Path .\$VerBindings