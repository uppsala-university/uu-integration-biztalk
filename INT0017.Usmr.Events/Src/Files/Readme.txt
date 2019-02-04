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

Application uses a pipeline to produce the output text file UUSKLIST. This pipeline uses the map INT0017.UsmrRecordToFile and two schemas:
1, INT0017.UsmrFilerecord describes the output columns and is used for writing the file header (the column names)
2, INT0017.UsmrFileformat describes each row in the textfile




Application has two receive ports:
INT0017.ReceiveUsmrSdEvents   reads data from queue    (service window will need to be set for executing file output job once a day)
INT0017.getPolledData         reads data from the database (polling intervall will need to be set for executing file output job once/service window)

Application has six send ports:
INT0017.Create.UsmrRecord             store a registration event in snaphot database
INT0017.Create.UsmrRecordReregister   store a rregistration event
INT0017.Create.UsmrRecord.Accepted    store a forvantat deltagande event 
INT0017.Create.UpdateUsmrRecord       updates a student record with new name & contact information. The
                                      origin of the new data is the Ladok event LokalStudentEvent enriched with contact information
INT0017.setUsmrDeceased               Set/unset deceased flag in DB
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

Populate database
The database needs to be initialized with data in the latest Usmr expåort file UUSKLIST.
Run the import with the following command:
files\INT0017InitUsmrDB.exe <path/importfile> <dbuser> <dbpassword> <dbname> <dbserver>
example:
INT0017InitUsmrDB.exe E:\UUSKLIST usmr password sd-usmr-test-db localhost
After initializing the databse the content can be checked with:
select * from ["UUSKLIST"]



Bindings

INT0017.DEV.Bindings.xml    Bindings for DEV. Dev bindings produces file between 05.00 - 06.00.
                            PROD bindings will have to set this job to run once a day.Time depends on vhen Medlos expects to get the file.  See info for 
							receive ports INT0017.ReceiveUsmrSdEvents  & INT0017.getPolledData.  

Dev bindings should use the following SFTP settings:
Server = 'localhost'
SSH fingerprint  = 'ssh-rsa 2048 dc:dd:1a:a4:1a:98:0f:36:ff:ce:e6:52:ae:c8:28:0a'
SFTP user   = '\localbizservice'

Needed Changes in bindings for test & prod:
Password, username and databseserver needs to be set for
INT0017.Create.UsmrRecord              
INT0017.Create.UsmrRecordReregister     
INT0017.Create.UpdateUsmrRecord 
INT0017.getPolledData
INT0017.Create.UsmrRecord.Accepted
INT0017.setUsmrDeceased

Needed Service windows

Receive location INT0017.ReceiveUsmrSdEvents needs to be disabled at a suitable time of day and
INT0017.GetPolledData needs a corresponding service window time when its active and should create the output file. 
Verify that this binding has a corecctPollingInterval set so it only runs once during the service window.  









 

