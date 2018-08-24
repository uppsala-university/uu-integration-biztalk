$DevBindings = 'INT0010.Studentportalen.Events.BindingInfo_Dev.xml'
$TestBindings = 'INT0010.Studentportalen.Events.BindingInfo_Test.xml'
$ProdBindings = 'INT0010.Studentportalen.Events.BindingInfo_Prod.xml'

$DevQueue  = 'OS:.'
$TestQueue  = 'OS:UUC-BIZSRV021-T'
$ProdQueue  = 'OS:UUC-MSMQSRV002'

$DevEndPoint  = 'https://spl3t.studentportalen.uu.se/uusp-webapp/spring/ladok-event?pw=CHANGEME'
$TestEndPoint  = 'https://spl3t.studentportalen.uu.se/uusp-webapp/spring/ladok-event?pw=CHANGEME'
$ProdEndPoint  = 'https://spl3t.studentportalen.uu.se/uusp-webapp/spring/ladok-event?pw=CHANGEME'

copy .\$DevBindings .\$TestBindings
(Get-Content -Path .\$TestBindings).Replace($DevQueue,$TestQueue).Replace($DevEndPoint,$TestEndPoint) | Set-Content -Path .\$TestBindings

copy .\$DevBindings .\$ProdBindings
(Get-Content -Path .\$ProdBindings).Replace($DevQueue,$ProdQueue).Replace($DevEndPoint,$ProdEndPoint) | Set-Content -Path .\$ProdBindings