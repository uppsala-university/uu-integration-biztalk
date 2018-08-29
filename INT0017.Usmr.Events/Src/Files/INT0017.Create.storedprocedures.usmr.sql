
Create PROCEDURE  [dbo].[uusmrCreateStudentRecord]
           @PNR CHAR(11),
            @GPNR CHAR(11),
            @EFTERNAMN VARCHAR(255),
            @FORNAMN VARCHAR(255),
            @INLDATUM_PERS CHAR(10),
            @COADRESS VARCHAR(255),
            @GATUADRESS VARCHAR(255),
            @POSTNR VARCHAR(10),
            @ORT VARCHAR(255),
            @LAND VARCHAR(255),
            @INLDATUM_ADRESS CHAR(10),
            @TELNR VARCHAR(255),
            @INLDATUM_TELNR CHAR(10),
            @EPOSTADRESS VARCHAR(255),
            @UPPEH VARCHAR(7),
            @KURS CHAR(6),
            @INST CHAR(4),
            @POANG VARCHAR(5),
            @KT VARCHAR(3),
            @UF CHAR(3),
            @KORT CHAR(4),
            @FIN CHAR(3),
            @PROGR VARCHAR(5),
            @AKT VARCHAR(3),
            @TERMIN VARCHAR(5),
            @PTAKT VARCHAR(5),
            @KAR   CHAR(3),
            @TYP   CHAR(3),
            @PLG   VARCHAR(255)
AS
BEGIN  
    SET NOCOUNT ON;      
	IF(@TYP='J' OR @TYP='P')
	BEGIN
    INSERT INTO [dbo].["UUSKLIST"] VALUES
            ( @PNR, 
            @GPNR,
            @EFTERNAMN,
            @FORNAMN,
            @INLDATUM_PERS,
            @COADRESS,
            @GATUADRESS,
            @POSTNR,
            @ORT,
            @LAND,
            @INLDATUM_ADRESS,
            @TELNR,
            @INLDATUM_TELNR,
            @EPOSTADRESS,
            @UPPEH,
            @KURS,
            @INST,
            @POANG,
            @KT,
            @UF,
            @KORT,
            @FIN,
            @PROGR,
            @AKT,
            @TERMIN,
            @PTAKT,
            @KAR,
            @TYP,
            @PLG )
			END
ELSE
BEGIN
DELETE FROM [dbo].["UUSKLIST"] WHERE PNR=@PNR AND KURS=@KURS AND TERMIN=@TERMIN AND PROGR=@PROGR AND (TYP='J' OR TYP='P');
  INSERT INTO [dbo].["UUSKLIST"] VALUES
            ( @PNR, 
            @GPNR,
            @EFTERNAMN,
            @FORNAMN,
            @INLDATUM_PERS,
            @COADRESS,
            @GATUADRESS,
            @POSTNR,
            @ORT,
            @LAND,
            @INLDATUM_ADRESS,
            @TELNR,
            @INLDATUM_TELNR,
            @EPOSTADRESS,
            @UPPEH,
            @KURS,
            @INST,
            @POANG,
            @KT,
            @UF,
            @KORT,
            @FIN,
            @PROGR,
            @AKT,
            @TERMIN,
            @PTAKT,
            @KAR,
            @TYP,
            @PLG )
END
END

	   go
CREATE PROCEDURE [dbo].[INT0017UsmrRecords]
AS
BEGIN
  select PNR,GPNR,EFTERNAMN,FORNAMN,INLDATUM_PERS, COADRESS, GATUADRESS,POSTNR,ORT,LAND,INLDATUM_ADRESS,TELNR,
INLDATUM_TELNR , EPOSTADRESS, UPPEH,KURS,INST,POANG,KT,UF,KORT,FIN,PROGR,AKT,TERMIN,PTAKT,KAR,TYP,PLG from ["UUSKLIST"] where (FIN != 'E' and 
FIN != 'EES' and FIN != 'SLU'  and FIN != 'SWB' and FIN != 'U' and FIN != 'UCI' and FIN != 'UFM' and FIN != 'UH'
and FIN != 'UKU' and FIN != 'UL' and FIN != 'UMD' )
 for xml auto 
END

go

Create PROCEDURE  [dbo].[uusmrUpdateStudentRecord]  
            @PNR CHAR(11),
            @EFTERNAMN VARCHAR(255),
            @FORNAMN VARCHAR(255),
            @INLDATUM_PERS CHAR(10),
            @COADRESS VARCHAR(255),
            @GATUADRESS VARCHAR(255),
            @POSTNR VARCHAR(10),
            @ORT VARCHAR(255),
            @LAND VARCHAR(255),
            @INLDATUM_ADRESS CHAR(10),
            @TELNR VARCHAR(255),
            @INLDATUM_TELNR CHAR(10),
            @EPOSTADRESS VARCHAR(255)            
AS
BEGIN  
    SET NOCOUNT ON;      
    UPDATE [dbo].["UUSKLIST"] SET
            efternamn=@EFTERNAMN,
            fornamn=@FORNAMN,
            inldatum_pers=@INLDATUM_PERS,
            coadress=@COADRESS,
            gatuadress=@GATUADRESS,
            postnr=@POSTNR,
            ort=@ORT,
            land=@LAND,
            inldatum_adress=@INLDATUM_ADRESS,
            telnr=@TELNR,
            inldatum_telnr=@INLDATUM_TELNR,
            epostadress=@EPOSTADRESS 
			where pnr=@PNR
           
       END
go
CREATE  PROCEDURE  [dbo].[uusmrSetDeceased]
            @PNR CHAR(11),
            @STATUS CHAR(1)

AS
BEGIN  
    SET NOCOUNT ON;      
	IF(@STATUS='J')
	   BEGIN
	   UPDATE [dbo].["UUSKLIST"] SET AVLIDEN='J' WHERE PNR = @PNR
	   END
	ELSE 
	   BEGIN
	   UPDATE [dbo].["UUSKLIST"] SET AVLIDEN='' WHERE PNR = @PNR
	   END
END