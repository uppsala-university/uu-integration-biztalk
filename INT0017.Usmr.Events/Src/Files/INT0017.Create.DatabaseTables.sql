CREATE TABLE [dbo].["UUSKLIST"]
(
            PNR CHAR(11),
            GPNR CHAR(11),
            EFTERNAMN VARCHAR(255),
            FORNAMN VARCHAR(255),
            INLDATUM_PERS CHAR(10),
            COADRESS VARCHAR(255),
            GATUADRESS VARCHAR(255),
            POSTNR VARCHAR(10),
            ORT VARCHAR(255),
            LAND VARCHAR(255),
            INLDATUM_ADRESS CHAR(10),
            TELNR VARCHAR(255),
            INLDATUM_TELNR CHAR(10),
            EPOSTADRESS VARCHAR(255),
            UPPEH VARCHAR(7),
            KURS CHAR(10),
            INST CHAR(4),
            POANG VARCHAR(5),
            KT VARCHAR(3),
            UF CHAR(3),
            KORT CHAR(4),
            FIN CHAR(3),
            PROGR VARCHAR(5),
            AKT VARCHAR(3),
            TERMIN VARCHAR(5),
            PTAKT VARCHAR(5),
            KAR   CHAR(3),
            TYP   CHAR(3),
            PLG   VARCHAR(255)
)
go
ALTER TABLE ["UUSKLIST"] ADD AVLIDEN varchar(1); 
go
CREATE view viewUsmrSelectAll AS
select PNR,GPNR,EFTERNAMN,FORNAMN,INLDATUM_PERS, COADRESS, GATUADRESS,POSTNR,ORT,LAND,INLDATUM_ADRESS,TELNR,
INLDATUM_TELNR, EPOSTADRESS, UPPEH,KURS,INST,POANG,KT,UF,KORT,FIN,PROGR,AKT,TERMIN,PTAKT,KAR,TYP,PLG from ["UUSKLIST"]
