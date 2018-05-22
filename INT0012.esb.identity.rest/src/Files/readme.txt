INT0012   esb rest-identity

Adaptern INT0012 tillhandahåller ett REST-api för att skicka in ändringar av personuggifter. För närvarande
hanteras endast personnummerförändringar. Ändringseventen skickas in med POST och läggs ut på Msmq kön identity-distribution
En orkestrering tar hand om retursvaret och sätter statuskoden till 202 vilket förväntas av vår restklient.


Deploy på IIS
Receiveporten exponeras genom en applikation som deployas på IIS.

1, Om inte URL Rewrite module är installerat på IIS så gör det. Kan laddas ned från https://www.iis.net/downloads/microsoft/url-rewrite


2, Starta IIS manager och importera applikationen src/Files/esbIdentityEventsApp.zip
Ange "esb/identity" som application path. 

läggs applikationen under "default website" så kommer man sedan åt den på urlen esb/identity/event/person/ med port 80
Har man behov, för testning t ex, av att skapa andra url-mappningar än de färdiga som finns i applikationen finns en tutorial här:
https://docs.microsoft.com/en-us/iis/extensions/url-rewrite-module/using-the-url-rewrite-module


Bindings

INT0012.esb.identity.rest.BindingInfo_DEV_Msmq.xml    - bindings för att lägga ut event på kön, bör gå att använda oförändrade i test & prod.
INT0012.esb.identity.rest.BindingInfo_DEV_FileOutput.xml - används endast för utveckling, eventen skrivs till fil.


