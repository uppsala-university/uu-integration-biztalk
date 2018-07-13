INT0015 Usmr.identity.distribution

Adapter for transmitting changes in personnummer for Uppsala studentkårs medlemsregister (Usmr).

The change event is read from the MSMQ queue identity-sp. A map transforms the change event to
parameters required by the stored procedure uusmrPnrChangeProc which updates personnummer in the table UUSKLIST.

Database name is sd-usmr-test-db for DEV & TEST. 


Deployment 

prerequisites:

The application INT0017 must be installed.
There must be a MSMQ queue named 

Bindings

   
                                                     