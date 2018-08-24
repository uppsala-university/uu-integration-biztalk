$DevBindings = 'INT0016.Ladok3.Client.BindingInfo_Dev.xml'
$TestBindings = 'INT0016.Ladok3.Client.BindingInfo_Test.xml'
$ProdBindings = 'INT0016.Ladok3.Client.BindingInfo_Prod.xml'

$DevLadok  = 'https://api.mit-integration.ladok.se/'
$TestLadok  = 'https://api.mit-integration.ladok.se/'
$ProdLadok  = 'https://api.mit-integration.ladok.se/'

copy .\$DevBindings .\$TestBindings
(Get-Content -Path .\$TestBindings).Replace($DevLadok,$TestLadok) | Set-Content -Path .\$TestBindings

copy .\$DevBindings .\$ProdBindings
(Get-Content -Path .\$ProdBindings).Replace($DevLadok,$ProdLadok) | Set-Content -Path .\$ProdBindings