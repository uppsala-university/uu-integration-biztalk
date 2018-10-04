
$DevBindings = 'INT0011.VFU.Events.BindingInfo_Dev.xml'
$TestBindings = 'INT0011.VFU.Events.BindingInfo_Test.xml'
$ProdBindings = 'INT0011.VFU.Events.BindingInfo_Prod.xml'
$VerBindings = 'INT0011.VFU.Events.BindingInfo_Ver.xml'

$DevQueue  = 'OS:.'
$TestQueue  = 'OS:UUC-BIZSRV021-T'
$ProdQueue  = 'OS:UUC-MSMQSRV002'
$VerQueue  = 'OS:UUC-MSMQSRV001'

$DevUsersLDAP  = 'LDAP://exchange-test.its.uu.se:389/OU=Users,OU=Student,OU=AKKA,DC=exchange-test,DC=its,DC=uu,DC=se'
$TestUsersLDAP  = 'LDAP://exchange-test.its.uu.se:389/OU=Users,OU=Student,OU=Akka,DC=exchange-test,DC=its,DC=uu,DC=se'
$ProdUsersLDAP = 'LDAP://user.uu.se/OU=Users,OU=Student,OU=Akka,DC=user,DC=uu,DC=se'
$VerUsersLDAP  = 'LDAP://exchange-test.its.uu.se:389/OU=Users,OU=Student,OU=Akka,DC=exchange-test,DC=its,DC=uu,DC=se'

$DevRestApi = 'https://vfu-test.its.uu.se/vfutest'
$TestRestApi = 'https://vfu-test.its.uu.se/vfutest'
$ProdRestApi = 'https://vfu.its.uu.se/vfu'
$VerRestApi =  'https://vfu-test.its.uu.se/vfutest'

copy .\$DevBindings .\$TestBindings
(Get-Content -Path .\$TestBindings).Replace($DevQueue,$TestQueue).Replace($DevUsersLDAP,$TestUsersLDAP).Replace($DevRestApi,$TestRestApi) | Set-Content -Path .\$TestBindings

copy .\$DevBindings .\$ProdBindings
(Get-Content -Path .\$ProdBindings).Replace($DevQueue,$ProdQueue).Replace($DevUsersLDAP,$ProdUsersLDAP).Replace($DevRestApi,$ProdRestApi)  | Set-Content -Path .\$ProdBindings

copy .\$DevBindings .\$VerBindings
(Get-Content -Path .\$VerBindings).Replace($DevQueue,$VerQueue).Replace($DevUsersLDAP,$VerUsersLDAP).Replace($DevRestApi,$VerRestApi)  | Set-Content -Path .\$VerBindings

