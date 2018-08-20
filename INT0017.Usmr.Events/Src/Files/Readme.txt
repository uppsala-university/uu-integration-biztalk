INT0017.Usmr.Events


INT0017 Stores data needed for Uppsala Studentkår and produces
the file UUSKLIST for export to the Melos system.

Data is received as events from the queue sd-usmr and
stored into a snapshot database named sd-usmr-test-db for test and dev. For production name should be sd-usmr-test-db 

Data that are updated are student participation in courses and personal
information such as name, emailadress and postal adress. Note that
changes in personalnumbers are processed in application INT0015.
This solution needs to stop receiving events during a certain time and during this interval the output file 
should be created.

Application have two receive ports:
INT0017.ReceiveUsmrSdEvents   reads data from queue    (service window will need to be set for executing file output job once a day)
INT0017.getPolledData         reads data from the database (polling intervall will need to be set for executing file output job once/service window)

Application have four send ports:
INT0017.Create.UsmrRecord             stores a registration event in snaphot database
INT0017.Create.UsmrRecordReregister   stores a rregistration event
INT0017.Create.UpdateUsmrRecord       updates a student record with new name & contact information. The
                                      origin of the new data is the Ladok event LokalStudentEvent enriched with contact information
INT0017.Create.File                   Outputs the file UUSKLIST for further processing by the system Melos.
                                      Data for the file is received from receive location INT0017.getPolledData
									  which is a sql polling job that periodically reads the content of the whole snaphot databse.
                                                                        


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

Needed Changes in bindings for test & prod:
Password, username and databseserver needs to be set for
INT0017.Create.UsmrRecord              
INT0017.Create.UsmrRecordReregister     
INT0017.Create.UpdateUsmrRecord 
INT0017.getPolledData

Needed Service windows

Receive location INT0017.ReceiveUsmrSdEvents needs to be disabled at a suitable time of day and
INT0017.GetPolledData needs a corresponding service window time when its active and should create the output file. 
Verify that this binding has a corecctPollingInterval set so it only runs once during the service window.  









 

