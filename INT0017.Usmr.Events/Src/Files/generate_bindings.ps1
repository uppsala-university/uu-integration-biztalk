$DevBindings = 'INT0017.DEV.Bindings.xml'
$TestBindings = 'INT0017.TEST.Bindings.xml'
$VerBindings = 'INT0017.VER.Bindings.xml'
$ProdBindings = 'INT0017.PROD.Bindings.xml'

$DevQueue  = 'OS:.'
$TestQueue  = 'OS:UUC-BIZSRV021-T'
$ProdQueue  = 'OS:UUC-MSMQSRV002'
$VerQueue  = 'OS:UUC-MSMQSRV001'

$Userreplace = 'REPLACEUSER' 
$TestDBuser  = 'sd-usmr-writer'
$VerDBuser  =  'sd-usmr-writer'
$ProdDBuser  = 'sd-usmr-writer'
 
$DevDB  = 'mssql://localhost:1433//sd-usmr-test-db'
$TestDB  = 'mssql://SQL-AG21-T.exchange-test.its.uu.se:1433//sd-usmr-test-db'
$VerDB  =  'Verdatabasename'
$ProdDB  = 'mssql://SQL-AG1.user.uu.se:1433//sd-usmr-db'

$DevSFTP  = 'localhost'
$TestSFTP  = 'CHANGE_ME'
$ProdSFTP  = 'ftp.softnac.softronic.se'
$VerSFTP  = 'CHANGE_ME'

$DevSFTPFingerPrint  = 'ssh-rsa 2048 dc:dd:1a:a4:1a:98:0f:36:ff:ce:e6:52:ae:c8:28:0a'
$TestSFTPFingerPrint  = 'CHANGE_ME'
$ProdSFTPFingerPrint  = 'ssh-dss 1024 6e:de:df:92:93:75:fa:b5:88:c2:a4:90:ca:50:da:30'
$VerSFTPFingerPrint  = 'CHANGE_ME'

$DevSFTPUser  = '\localbizservice'
$TestSFTPUser  = 'CHANGE_ME'
$ProdSFTPUser  = 'us'
$VerSFTPUser  = 'CHANGE_ME'

$DevSFTPPath  = '/C:/Integrations/INT0017.Usmr.Events'
$TestSFTPPath  = 'CHANGE_ME'
$ProdSFTPPath  = '/US:'
$VerSFTPPath  = 'CHANGE_ME'

copy .\$DevBindings .\$TestBindings
(Get-Content -Path .\$TestBindings).Replace($DevDB,$TestDB) | Set-Content -Path .\$TestBindings
(Get-Content -Path .\$TestBindings).Replace($DevQueue,$TestQueue)| Set-Content -Path .\$TestBindings
(Get-Content -Path .\$TestBindings).Replace($Userreplace,$TestDBuser)| Set-Content -Path .\$TestBindings
(Get-Content -Path .\$TestBindings).Replace($DevSFTP,$TestSFTP)| Set-Content -Path .\$TestBindings
(Get-Content -Path .\$TestBindings).Replace($DevSFTPFingerPrint,$TestSFTPFingerPrint)| Set-Content -Path .\$TestBindings
(Get-Content -Path .\$TestBindings).Replace($DevSFTPUser,$TestSFTPUser)| Set-Content -Path .\$TestBindings
(Get-Content -Path .\$TestBindings).Replace($DevSFTPPath,$TestSFTPPath)| Set-Content -Path .\$TestBindings


copy .\$DevBindings .\$VerBindings
(Get-Content -Path .\$VerBindings).Replace($DevDB,$VerDB) | Set-Content -Path .\$VerBindings
(Get-Content -Path .\$VerBindings).Replace($DevQueue,$VerQueue) | Set-Content -Path .\$VerBindings
(Get-Content -Path .\$VerBindings).Replace($Userreplace,$VerDBuser) | Set-Content -Path .\$VerBindings
(Get-Content -Path .\$VerBindings).Replace($DevSFTP,$VerSFTP) | Set-Content -Path .\$VerBindings
(Get-Content -Path .\$VerBindings).Replace($DevSFTPFingerPrint,$VerSFTPFingerPrint) | Set-Content -Path .\$VerBindings
(Get-Content -Path .\$VerBindings).Replace($DevSFTPUser,$VerSFTPUser) | Set-Content -Path .\$VerBindings
(Get-Content -Path .\$VerBindings).Replace($DevSFTPPath,$VerSFTPPath) | Set-Content -Path .\$VerBindings

copy .\$DevBindings .\$ProdBindings
(Get-Content -Path .\$ProdBindings).Replace($DevDB,$ProdDB) | Set-Content -Path .\$ProdBindings
(Get-Content -Path .\$ProdBindings).Replace($DevQueue,$ProdQueue) | Set-Content -Path .\$ProdBindings
(Get-Content -Path .\$ProdBindings).Replace($Userreplace,$ProdDBuser) | Set-Content -Path .\$ProdBindings
(Get-Content -Path .\$ProdBindings).Replace($DevSFTP,$ProdSFTP) | Set-Content -Path .\$ProdBindings
(Get-Content -Path .\$ProdBindings).Replace($DevSFTPFingerPrint,$ProdSFTPFingerPrint) | Set-Content -Path .\$ProdBindings
(Get-Content -Path .\$ProdBindings).Replace($DevSFTPUser,$ProdSFTPUser) | Set-Content -Path .\$ProdBindings
(Get-Content -Path .\$ProdBindings).Replace($DevSFTPPath,$ProdSFTPPath) | Set-Content -Path .\$ProdBindings
