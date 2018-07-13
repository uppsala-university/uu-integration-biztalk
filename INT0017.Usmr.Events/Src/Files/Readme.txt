INT0017.Usmr.Events


INT0017 Stores data needed for Uppsala Studentkår and produces
the file UUSKLIST for export to the Melos system.

Data is received as events from the queue sd-usmr and
stored into a snapshot database. A

Data that are updated are student participation in courses and personal
information such as name, emailadress and postal adress. Note that
changes in personalnumbers are processed in application INT0015.

Application have two receive ports:
INT0017.ReceiveUsmrSdEvents   reads data from queue    (service window will need to be set for executing file output job once a day)
INT0017.getPolledData         reads data from the database (polling intervall will need to be set for executing file output job once/service window)

Installation
Requirements
The usmr database must exist  
There must be a MSMQ queue named sd-usmr

for databse sd-usmr-test-db (called test and dev):
Create database tables in Files/INT0017.Create.DatabaseTables.sql
Create stored procedures in Files/INT0017.Create.storedProcedures.sql


Bindings

INT0017.DEV.Bindings.xml    Bindings for DEV. The job that produces the output file is set to run very often.
                            PROD bindings will have to set this job to run once a day.  






 

