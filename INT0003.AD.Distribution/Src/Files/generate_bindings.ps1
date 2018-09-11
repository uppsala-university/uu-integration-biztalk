$DevBindings = 'INT0003.AD.Distribution.BindingInfo_Dev.xml'
$ATBindings = 'INT0003.AD.Distribution.BindingInfo_AT.xml'
$TestBindings = 'INT0003.AD.Distribution.BindingInfo_Test.xml'
$ProdBindings = 'INT0003.AD.Distribution.BindingInfo_Prod.xml'
$VerBindings = 'INT0003.AD.Distribution.BindingInfo_Ver.xml'

$DevQueue  = 'OS:.'
$TestQueue  = 'OS:UUC-BIZSRV021-T'
$ATQueue  = 'OS:UUC-MSMQSRV001'
$ProdQueue  = 'OS:UUC-MSMQSRV002'
$VerQueue  = 'OS:UUC-MSMQSRV001'

$DevMail  = 'kristofer.strom@uadm.uu.se'
$ATMail  = 'uadm.bt-prod@uadm.uu.se'
$TestMail  = 'uadm.bt-test@uadm.uu.se'
$ProdMail  = 'uadm.bt-prod@uadm.uu.se'
$VerMail  = 'uadm.bt-prod@uadm.uu.se'

$DevSMTP  = 'smtp.uu.se'
$ATSMTP  = 'smtp.uu.se'
$TestSMTP  = 'smtp.uu.se'
$ProdSMTP  = 'smtp.user.uu.se'
$VerSMTP  = 'smtp.uu.se'

$DevUsersLDAP  = 'LDAP://exchange-test.its.uu.se:389/OU=Users,OU=Student,OU=Akka,DC=exchange-test,DC=its,DC=uu,DC=se'
$ATUsersLDAP  = ''
$TestUsersLDAP  = 'LDAP://exchange-test.its.uu.se:389/OU=Users,OU=Student,OU=Akka,DC=exchange-test,DC=its,DC=uu,DC=se'
$ProdUsersLDAP = 'LDAP://user.uu.se/OU=Users,OU=Student,OU=Akka,DC=user,DC=uu,DC=se'
$VerUsersLDAP  = 'LDAP://exchange-test.its.uu.se:389/OU=Users,OU=Student,OU=Akka,DC=exchange-test,DC=its,DC=uu,DC=se'

$DevCoursesLDAP = 'LDAP://exchange-test.its.uu.se:389/OU=Courses,OU=Student,OU=Akka,DC=exchange-test,DC=its,DC=uu,DC=se'
$ATCoursesLDAP = ''
$TestCoursesLDAP  = 'LDAP://exchange-test.its.uu.se:389/OU=Courses,OU=Student,OU=Akka,DC=exchange-test,DC=its,DC=uu,DC=se'
$ProdCoursesLDAP  = 'LDAP://user.uu.se/OU=Courses,OU=Student,OU=Akka,DC=user,DC=uu,DC=se'
$VerCoursesLDAP  = 'LDAP://exchange-test.its.uu.se:389/OU=Courses,OU=Student,OU=Akka,DC=exchange-test,DC=its,DC=uu,DC=se'

$DevCoursesLDAP2 = 'EqualToValue=OU EQ Courses,OU EQ Student,OU EQ Akka,DC EQ exchange-test,DC EQ its,DC EQ uu,DC EQ se'
$ATCoursesLDAP2 = ''
$TestCoursesLDAP2  = 'EqualToValue=OU EQ Courses,OU EQ Student,OU EQ Akka,DC EQ exchange-test,DC EQ its,DC EQ uu,DC EQ se'
$ProdCoursesLDAP2  = 'EqualToValue=OU EQ Courses,OU EQ Student,OU EQ Akka,DC EQ user,DC EQ uu,DC EQ se'
$VerCoursesLDAP2  = 'EqualToValue=OU EQ Courses,OU EQ Student,OU EQ Akka,DC EQ exchange-test,DC EQ its,DC EQ uu,DC EQ se'

$DevUsersLDAP2 = 'URI=exchange-test.its.uu.se:389|path=OU EQ Users,OU EQ Student,OU EQ Akka,DC EQ exchange-test,DC EQ its,DC EQ uu,DC EQ se'
$TestUsersLDAP2  = 'URI=exchange-test.its.uu.se:389|path=OU EQ Users,OU EQ Student,OU EQ Akka,DC EQ exchange-test,DC EQ its,DC EQ uu,DC EQ se'
$ATUsersLDAP2 = ''
$ProdUsersLDAP2  = 'URI=user.uu.se|path=OU EQ Users,OU EQ Student,OU EQ Akka,DC EQ user,DC EQ uu,DC EQ se'
$VerUsersLDAP2  = 'URI=exchange-test.its.uu.se:389|path=OU EQ Users,OU EQ Student,OU EQ Akka,DC EQ exchange-test,DC EQ its,DC EQ uu,DC EQ se'

copy .\$DevBindings .\$TestBindings
(Get-Content -Path .\$TestBindings).Replace($DevQueue,$TestQueue).Replace($DevMail,$TestMail).Replace($DevUsersLDAP,$TestUsersLDAP).Replace($DevCoursesLDAP,$TestCoursesLDAP).Replace($DevCoursesLDAP2,$TestCoursesLDAP2).Replace($DevUsersLDAP2,$TestUsersLDAP2).Replace($DevSMTP,$TestSMTP) | Set-Content -Path .\$TestBindings

copy .\$DevBindings .\$ATBindings
(Get-Content -Path .\$ATBindings).Replace($DevQueue,$ATQueue).Replace($DevMail,$ATMail).Replace($DevUsersLDAP,$ATUsersLDAP).Replace($DevCoursesLDAP,$ATCoursesLDAP).Replace($DevCoursesLDAP2,$ATCoursesLDAP2).Replace($DevUsersLDAP2,$ATUsersLDAP2).Replace($DevSMTP,$ATSMTP) | Set-Content -Path .\$ATBindings

copy .\$DevBindings .\$ProdBindings
(Get-Content -Path .\$ProdBindings).Replace($DevQueue,$ProdQueue).Replace($DevMail,$ProdMail).Replace($DevUsersLDAP,$ProdUsersLDAP).Replace($DevCoursesLDAP,$ProdCoursesLDAP).Replace($DevCoursesLDAP2,$ProdCoursesLDAP2).Replace($DevUsersLDAP2,$ProdUsersLDAP2).Replace($DevSMTP,$ProdSMTP) | Set-Content -Path .\$ProdBindings

copy .\$DevBindings .\$VerBindings
(Get-Content -Path .\$VerBindings).Replace($DevQueue,$VerQueue).Replace($DevMail,$VerMail).Replace($DevUsersLDAP,$VerUsersLDAP).Replace($DevCoursesLDAP,$VerCoursesLDAP).Replace($DevCoursesLDAP2,$VerCoursesLDAP2).Replace($DevUsersLDAP2,$VerUsersLDAP2).Replace($DevSMTP,$VerSMTP) | Set-Content -Path .\$ProdBindings

