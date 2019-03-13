---BT-40  Uttöka fältlängder för adressuppgifter. Trunkera postnr till 10 tecken i utdatafil

ALTER TABLE ["UUSKLIST"] ALTER COLUMN POSTNR VARCHAR(4096); 
ALTER TABLE ["UUSKLIST"] ALTER COLUMN COADRESS VARCHAR(4096); 
ALTER TABLE ["UUSKLIST"] ALTER COLUMN GATUADRESS VARCHAR(4096); 
ALTER TABLE ["UUSKLIST"] ALTER COLUMN ORT VARCHAR(4096); 
ALTER TABLE ["UUSKLIST"] ALTER COLUMN LAND VARCHAR(4096);

go 

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

go


alter PROCEDURE  [dbo].[uusmrUpdateStudentRecord]  
            @PNR CHAR(13),
            @EFTERNAMN VARCHAR(255),
            @FORNAMN VARCHAR(255),
            @INLDATUM_PERS CHAR(10),
            @COADRESS VARCHAR(4096),
            @GATUADRESS VARCHAR(4096),
            @POSTNR VARCHAR(4096),
            @ORT VARCHAR(4096),
            @LAND VARCHAR(4096),
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

	  alter PROCEDURE  [dbo].[uusmrCreateStudentRecord]
            @PNR CHAR(13),
            @GPNR CHAR(13),
            @EFTERNAMN VARCHAR(255),
            @FORNAMN VARCHAR(255),
            @INLDATUM_PERS CHAR(10),
            @COADRESS VARCHAR(4096),
            @GATUADRESS VARCHAR(4096),
            @POSTNR VARCHAR(4096),
            @ORT VARCHAR(4096),
            @LAND VARCHAR(4096),
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
alter PROCEDURE  [dbo].[uusmrCreateStudentProgramAntagningRecord]
            @PNR CHAR(13),
            @GPNR CHAR(13),
            @EFTERNAMN VARCHAR(255),
            @FORNAMN VARCHAR(255),
            @INLDATUM_PERS CHAR(10),
            @COADRESS VARCHAR(4096),
            @GATUADRESS VARCHAR(4096),
            @POSTNR VARCHAR(4096),
            @ORT VARCHAR(4096),
            @LAND VARCHAR(4096),
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
