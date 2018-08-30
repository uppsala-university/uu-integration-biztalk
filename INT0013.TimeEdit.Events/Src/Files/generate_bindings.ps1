$DevBindings = 'INT0013.TimeEdit.Events.BindingInfo_dev.xml'
$TestBindings = 'INT0013.TimeEdit.Events.BindingInfo_Test.xml'
$ProdBindings = 'INT0013.TimeEdit.Events.BindingInfo_Prod.xml'

$DevQueue  = 'OS:.'
$TestQueue  = 'OS:UUC-BIZSRV021-T'
$ProdQueue  = 'OS:UUC-MSMQSRV002'

$DevFolder  = 'C:\Integrations\INT0013.TimeEdit.Events\'
$TesFolder  = '\\uuc-biz025-t.exchange-test.its.uu.se\timeedit$\'
$ProdFolder  = '\\UUC-BIZ015.user.uu.se\timeedit$\'

$DevDB  = 'sftp://uuc-eko004.its.uu.se:22/timeedit/%MessageID%.xml'
$TestDB  = 'sftp://uuc-eko004.its.uu.se:22/timeedit/%MessageID%.xml'
$ProdDB  = 'sftp://uuc-eko004.its.uu.se:22/timeedit/%MessageID%.xml'

copy .\$DevBindings .\$TestBindings
(Get-Content -Path .\$TestBindings).Replace($DevQueue,$TestQueue).Replace($DevDB,$TestDB).Replace($DevFolder,$TesFolder)  | Set-Content -Path .\$TestBindings

copy .\$DevBindings .\$ProdBindings
(Get-Content -Path .\$ProdBindings).Replace($DevQueue,$ProdQueue).Replace($DevDB,$ProdDB).Replace($DevFolder,$ProdFolder)  | Set-Content -Path .\$ProdBindings