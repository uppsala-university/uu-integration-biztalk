$DevBindings = 'INT0016.Ladok3.Client.BindingInfo_Dev.xml'
$TestBindings = 'INT0016.Ladok3.Client.BindingInfo_Test.xml'
$VerBindings = 'INT0016.Ladok3.Client.BindingInfo_Ver.xml'
$ProdBindings = 'INT0016.Ladok3.Client.BindingInfo_Prod.xml'

$DevLadok  = 'https://api.mit-integration.ladok.se/'
$TestLadok  = 'https://api.mit-integration.ladok.se/'
$VerLadok  = 'https://api.verifiering4.ladok.se/'
$ProdLadok  = 'https://api.ladok.se/'

$DevClientThumb  = '7B6E9150DD5B9EA485F23B1393398F583F53D90E'
$TestClientThumb  = '7B6E9150DD5B9EA485F23B1393398F583F53D90E'
$VerClientThumb  = '4AFAFD5B2E152F8743C5460288333D90088A8A45'
$ProdClientThumb  = '9912327594B7DC0066181B4BE3426725641FF26D'

$DevServiceThumb  = '50DB3B6EB8AB6149A15F4EAFB9529995D45D2B1B'
$TestServiceThumb  = '50DB3B6EB8AB6149A15F4EAFB9529995D45D2B1B'
$VerServiceThumb  = 'DD050BDAA1A15C60E920E7870B2F003110D67D4B'
$ProdServiceThumb  = '6ECF836EA6D1AAA2A353A2F93E4881DBA9B67745'

copy .\$DevBindings .\$TestBindings
(Get-Content -Path .\$TestBindings).Replace($DevLadok,$TestLadok).Replace($DevClientThumb,$TestClientThumb).Replace($DevServiceThumb,$TestServiceThumb) | Set-Content -Path .\$TestBindings

copy .\$DevBindings .\$VerBindings
(Get-Content -Path .\$VerBindings).Replace($DevLadok,$VerLadok).Replace($DevClientThumb,$VerClientThumb).Replace($DevServiceThumb,$VerServiceThumb) | Set-Content -Path .\$VerBindings

copy .\$DevBindings .\$ProdBindings
(Get-Content -Path .\$ProdBindings).Replace($DevLadok,$ProdLadok).Replace($DevClientThumb,$ProdClientThumb).Replace($DevServiceThumb,$ProdServiceThumb)  | Set-Content -Path .\$ProdBindings