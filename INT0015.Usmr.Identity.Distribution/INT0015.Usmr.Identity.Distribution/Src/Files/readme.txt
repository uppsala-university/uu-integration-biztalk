INT0015 Usmr.identity.distribution


Adapter for transmitting changes in personnummer for Uppsala studentkårs medlemsregister (Usmr).

The change event is read from the MSMQ queue identity-sp. A map transforms the change event to
parameters required by the stored procedure uusmrPnrChangeProc The procedure is called from send port INT0015.send.identity.pnrchange.event 
which updates personnummer in the table UUSKLIST. This table have two columns for personnummer, PNR wich holds the current value and GPNR which hold the
previous value of the students personnummer. The current datestamp is also stored in the column INLDATUM_PERS. 

This application will only work when INT0017 is installed and running. Application INT0017 creates the database table UUSKLIST and populates it.


Deployment 

prerequisites:
The application INT0017 must be installed. This application creates the database table UUSKLIST and populates it.
There must be a MSMQ queue named identity-usmr

install the stored procedures in Files/INT0015.storedProcedures.sql
Database name is sd-usmr-test-db for DEV & TEST. 

Bindings
INT0015.usmr.identity.DEV.bindings.xml  for development.    Bindings DEV, TEST & PROD will differ in their database usernames & pwds. 
   
                                                     