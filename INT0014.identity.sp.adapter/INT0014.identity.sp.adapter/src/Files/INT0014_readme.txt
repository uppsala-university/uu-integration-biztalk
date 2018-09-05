INT0014 identity-sp-adapter

Adapter for transmitting changes in personnummer for students & employees to studentportalen
The change event is read from the MSMQ queue identity-sp. A map transforms the change event into parameters
required by studentportalen. 


Deployment 

prerequisites:

There must be a SSO-key named sp2restpwd with the value <AWELLKEPTSECRET> for the application INT0014.identity.sp.adapter
There must be a MSMQ queue name IDENTITY-SP

Bindings

INT0014.identity.sp.adapter.bindings.DEV.xml         for development, production & test bindings will have changes in service endpoint url. 
                                                     For now, the test endpoint in studentportalen is the same as in the dev-bindings.
                                                     
                                                     

