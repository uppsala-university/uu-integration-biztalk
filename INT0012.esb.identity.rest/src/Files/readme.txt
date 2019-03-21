INT0012   esb rest-identity

Adaptern INT0012 tillhandahåller ett REST-api för att skicka in ändringar av personuggifter. För närvarande
k0ommer endast personnummerförändringar. Ändringseventen skickas in med POST och en mappning körs som skapar en händelseventID som skickas med i meddelandet.
Syftet med detta ID är att kunna spåra persondataförändringar mellan system. Meddelandet läggs ut på Msmq kön identity-distribution

En orkestrering skapar retursvaret bestående av orginalmeddelandet kompletterat med händelseventID och sätter statuskoden till 202 vilket förväntas av vår restklient.
Den klient som används finns på github https://github.com/uppsala-university/uu-integration/blob/master/esb-rest-client/src/main/java/se/uu/its/integration/esb/client/


Deploy på IIS
En Receiveport exponeras genom en applikation som deployas på IIS.

1, Om inte URL Rewrite module är installerat på IIS så gör det. Kan laddas ned från https://www.iis.net/downloads/microsoft/url-rewrite

2, Starta IIS manager och importera applikationen src/Files/esbIdentityEventsApp.zip
Ange "esb/identity" som application path. 

läggs applikationen under "default website" så kommer man sedan åt den på urlen https://<biztalkmachine>:443/esb/identity/event/person/ med port 443
Har man behov, för testning t ex, av att skapa andra url-mappningar än de färdiga som finns i applikationen finns en tutorial här:
https://docs.microsoft.com/en-us/iis/extensions/url-rewrite-module/using-the-url-rewrite-module


Bindings

INT0012.esb.identity.rest.BindingInfo_DEV_Msmq.xml    - bindings för att lägga ut event på kön identity-distribution
INT0012.esb.identity.rest.BindingInfo_DEV_FileOutput.xml - används endast för utveckling, eventen skrivs till fil.

Adapters

I FILES adaptern måste CluIdentitySend läggas till.


