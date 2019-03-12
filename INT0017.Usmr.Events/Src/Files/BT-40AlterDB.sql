---BT-40  Uttöka fältlängder för adressuppgifter. Trunkera postnr till 10 tecken i utdatafil

ALTER TABLE ["UUSKLIST"] ALTER COLUMN POSTNR VARCHAR(MAX); 
ALTER TABLE ["UUSKLIST"] ALTER COLUMN COADRESS VARCHAR(MAX); 
ALTER TABLE ["UUSKLIST"] ALTER COLUMN GATUADRESS VARCHAR(MAX); 
ALTER TABLE ["UUSKLIST"] ALTER COLUMN ORT VARCHAR(MAX); 
ALTER TABLE ["UUSKLIST"] ALTER COLUMN LAND VARCHAR(MAX);

ALTER PROCEDURE [dbo].[INT0017UsmrRecords]
AS
BEGIN
  select PNR,GPNR,EFTERNAMN,FORNAMN,INLDATUM_PERS, COADRESS, GATUADRESS,substring(POSTNR,0,11) as POSTNR,ORT,UPPER(LAND) as LAND,INLDATUM_ADRESS,TELNR,
INLDATUM_TELNR , EPOSTADRESS, UPPEH,KURS,INST,POANG,KT,UF,KORT,FIN,PROGR,AKT,TERMIN,PTAKT,KAR,TYP,PLG from ["UUSKLIST"] where (FIN != 'E' and 
FIN != 'EES' and FIN != 'SLU'  and FIN != 'SWB' and FIN != 'U' and FIN != 'UCI' and FIN != 'UFM' and FIN != 'UH'
and FIN != 'UKU' and FIN != 'UL' and FIN != 'UMD'   and (AVLIDEN IS NULL  or AVLIDEN != 'J') )
and
( programavbrott is null or len(programavbrott) < 1 or  
                            (SELECT CONVERT (    
       date, GETDATE() 
    )) < programavbrott 
                           )
order by PNR desc
for xml auto 
END

