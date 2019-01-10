
DROP PROCEDURE IF EXISTS [dbo].[uusmrUpdateStudieuppehall]; 
go
CREATE PROCEDURE  [dbo].[uusmrUpdateStudieuppehall]
    @PNR CHAR(13),
	@PROGR VARCHAR(20),
	@KURS  VARCHAR(20),
	@TERMIN VARCHAR(5),
	@AVBROTTSPERIOD VARCHAR(7)
     AS
    BEGIN  
       SET NOCOUNT ON;  
	   UPDATE ["UUSKLIST"] set UPPEH = @AVBROTTSPERIOD, UPPDATERAD = GETDATE() where (PNR=@PNR and PROGR=@PROGR)
  END
go
DROP PROCEDURE IF EXISTS [dbo].[uusmrUpdateStudieavbrott]; 
go

CREATE PROCEDURE  [dbo].[uusmrUpdateStudieavbrott]
    @PNR CHAR(13),
	@PROGR VARCHAR(20),
	@KURS  VARCHAR(20),
	@TERMIN VARCHAR(5),
	@AVBROTTSDATUM CHAR(10)
    AS
    BEGIN  
       SET NOCOUNT ON;  
	   IF @PROGR = 'FRIST'
	   UPDATE ["UUSKLIST"] set PROGRAMAVBROTT = @AVBROTTSDATUM, UPPDATERAD = GETDATE() where (PNR=@PNR and PROGR='FRIST' and KURS = @KURS)
       ELSE
	   UPDATE ["UUSKLIST"] set PROGRAMAVBROTT = @AVBROTTSDATUM, UPPDATERAD = GETDATE() where (PNR=@PNR and PROGR=@PROGR and KURS !='')
  END

  go
  DROP PROCEDURE IF EXISTS [dbo].[uusmrUpdateAterkalladRegistrering]; 
go
CREATE PROCEDURE  [dbo].[uusmrUpdateAterkalladRegistrering]
    @PNR CHAR(13),
	@PROGR VARCHAR(20),
	@KURS  VARCHAR(20),
	@TERMIN VARCHAR(5)	 
    AS
    BEGIN  
       SET NOCOUNT ON;  
	   UPDATE ["UUSKLIST"] set TYP = 'J', UPPDATERAD = GETDATE() where (PNR=@PNR   and KURS = @KURS and TERMIN=@TERMIN) and TYP !='J' and TYP !='P'
  END
  go
  DROP PROCEDURE IF EXISTS [dbo].[uusmrUpdateLamnaAterbud]; 
go
CREATE PROCEDURE  [dbo].[uusmrUpdateLamnaAterbud]
    @PNR CHAR(13),
	@PROGR VARCHAR(20),
	@KURS  VARCHAR(20),
	@TERMIN VARCHAR(5)	 
    AS
    BEGIN  
       SET NOCOUNT ON;  
	   delete from ["UUSKLIST"]  where (PNR=@PNR and KURS = @KURS and TERMIN=@TERMIN) and TYP='J'
  END
  go
DROP PROCEDURE IF EXISTS [dbo].[uusmrCreateStudentRecord]; 
go
CREATE PROCEDURE  [dbo].[uusmrCreateStudentRecord]
            @PNR CHAR(13),
            @GPNR CHAR(13),
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
            @KURS CHAR(20),
            @INST CHAR(4),
            @POANG VARCHAR(5),
            @KT VARCHAR(3),
            @UF CHAR(3),
            @KORT CHAR(4),
            @FIN CHAR(3),
            @PROGR VARCHAR(20),
            @AKT VARCHAR(3),
            @TERMIN VARCHAR(5),
            @PTAKT VARCHAR(5),
            @KAR   CHAR(3),
            @TYP   CHAR(3),
            @PLG   VARCHAR(255)
AS
BEGIN  
    SET NOCOUNT ON;      
	 
	IF(@TYP like '%P%')
	BEGIN
  
			 exec  uusmrCreateStudentProgramAntagningRecord @PNR,@GPNR,@EFTERNAMN,@FORNAMN,@INLDATUM_PERS,@COADRESS, @GATUADRESS, @POSTNR, @ORT, @LAND, @INLDATUM_ADRESS,@TELNR,@INLDATUM_TELNR,@EPOSTADRESS,@UPPEH,@KURS,@INST,@POANG,@KT,
			'',@KORT,@FIN,@PROGR,'',@TERMIN,@PTAKT,'','P','';
     
    END

	IF(@TYP like '%J%' OR @TYP like '%P%')
	BEGIN
    INSERT INTO [dbo].["UUSKLIST"]
	 ( PNR, 
            GPNR,
            EFTERNAMN,
            FORNAMN,
            INLDATUM_PERS,
            COADRESS,
            GATUADRESS,
            POSTNR,
            ORT,
            LAND,
            INLDATUM_ADRESS,
            TELNR,
            INLDATUM_TELNR,
            EPOSTADRESS,
            UPPEH,
            KURS,
            INST,
            POANG,
            KT,
            UF,
            KORT,
            FIN,
            PROGR,
            AKT,
            TERMIN,
            PTAKT,
            KAR,
            TYP,
            PLG,
			AVLIDEN,
			PROGRAMAVBROTT,
			SKAPAD,
			UPPDATERAD)

	 VALUES
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
            'J',
            @PLG,
			'',
			'',
			GETDATE(),
			null)
			  exec  uusmrUpdateGpnr @PNR;
			END
ELSE
BEGIN

  INSERT INTO [dbo].["UUSKLIST"] 
  
    ( PNR, 
            GPNR,
            EFTERNAMN,
            FORNAMN,
            INLDATUM_PERS,
            COADRESS,
            GATUADRESS,
            POSTNR,
            ORT,
            LAND,
            INLDATUM_ADRESS,
            TELNR,
            INLDATUM_TELNR,
            EPOSTADRESS,
            UPPEH,
            KURS,
            INST,
            POANG,
            KT,
            UF,
            KORT,
            FIN,
            PROGR,
            AKT,
            TERMIN,
            PTAKT,
            KAR,
            TYP,
            PLG,
			AVLIDEN,
			PROGRAMAVBROTT,
			SKAPAD,
			UPPDATERAD)
  
  VALUES
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
            '',
            @PLG,
			'',
			'',
			GETDATE(),
			null)
			exec  uusmrUpdateGpnr @PNR;
			DELETE FROM [dbo].["UUSKLIST"] WHERE PNR=@PNR AND KURS=@KURS AND TERMIN=@TERMIN AND PROGR=@PROGR AND (TYP='J');
END

END
	   go
	   DROP PROCEDURE IF EXISTS [dbo].[INT0017UsmrRecords]; 
go
CREATE PROCEDURE [dbo].[INT0017UsmrRecords]
AS
BEGIN
  select PNR,GPNR,EFTERNAMN,FORNAMN,INLDATUM_PERS, COADRESS, GATUADRESS,POSTNR,ORT,UPPER(LAND) as LAND,INLDATUM_ADRESS,TELNR,
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

go
DROP PROCEDURE IF EXISTS [dbo].[uusmrUpdateStudentRecord]; 
go
Create PROCEDURE  [dbo].[uusmrUpdateStudentRecord]  
            @PNR CHAR(13),
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
            epostadress=@EPOSTADRESS,
			UPPDATERAD = GETDATE()
			where pnr=@PNR

       exec  uusmrUpdateGpnr @PNR;
       END
go
DROP PROCEDURE IF EXISTS [dbo].[uusmrSetDeceased]; 
go
CREATE  PROCEDURE  [dbo].[uusmrSetDeceased]
            @PNR CHAR(13),
            @STATUS CHAR(1)

AS
BEGIN  
    SET NOCOUNT ON;      
	IF(@STATUS='J')
	   BEGIN
	   UPDATE [dbo].["UUSKLIST"] SET AVLIDEN='J', UPPDATERAD = GETDATE() WHERE PNR = @PNR
	   END
	ELSE 
	   BEGIN
	   UPDATE [dbo].["UUSKLIST"] SET AVLIDEN='', UPPDATERAD = GETDATE() WHERE PNR = @PNR
	   END
END

go

DROP PROCEDURE IF EXISTS [dbo].[uusmrCreateStudentProgramAntagningRecord]; 
go
CREATE PROCEDURE  [dbo].[uusmrCreateStudentProgramAntagningRecord]
            @PNR CHAR(13),
            @GPNR CHAR(13),
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
            @KURS CHAR(20),
            @INST CHAR(4),
            @POANG VARCHAR(5),
            @KT VARCHAR(3),
            @UF CHAR(3),
            @KORT CHAR(4),
            @FIN CHAR(3),
            @PROGR VARCHAR(20),
            @AKT VARCHAR(3),
            @TERMIN VARCHAR(5),
            @PTAKT VARCHAR(5),
            @KAR   CHAR(3),
            @TYP   CHAR(3),
            @PLG   VARCHAR(255)
AS
BEGIN  
    SET NOCOUNT ON;    
	DECLARE @rowcountProgrAnt int;  
	IF(@TYP like '%P%')
	BEGIN

     select @rowcountProgrAnt = count(*) from ["UUSKLIST"] where pnr=@PNR and termin=@TERMIN and progr=@PROGR and typ like '%P%';
	 IF (@rowcountProgrAnt = 0)
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
            '',
            '',
            '',
            '',
            @UF,
            @KORT,
            @FIN,
            @PROGR,
            @AKT,
            @TERMIN,
            @PTAKT,
            @KAR,
            'P',
            @PLG,
			'',
			'',
			GETDATE(),
			null)
		END

    END
	exec  uusmrUpdateGpnr @PNR;
END
go
DROP PROCEDURE IF EXISTS [dbo].[uusmrUpdateGpnr]; 
go
create PROCEDURE  [dbo].[uusmrUpdateGpnr]
    @PNR CHAR(13)
    AS
    BEGIN  
       SET NOCOUNT ON;  
	   DECLARE @oldPnr char(13); 
	   select  top 1 @oldPnr=gpnr from ["UUSKLIST"] where pnr=@pnr and gpnr != ''   order by inldatum_pers desc; 
	   if (not LEN(ISNULL(@oldPnr,''))=0)
	     BEGIN
	      update ["UUSKLIST"] set gpnr = @oldPnr, UPPDATERAD = GETDATE() where pnr=@PNR and gpnr = '';
	     END 
  END


