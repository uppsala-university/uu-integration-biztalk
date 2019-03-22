----- 2.5 BT-62  uppdatera aktivitetsprocent
DROP PROCEDURE IF EXISTS [dbo].[uusmrHanteraStudieaktivitet]; 
go
CREATE PROCEDURE  [dbo].[uusmrHanteraStudieaktivitet]
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
            @EPOSTADRESS VARCHAR(255),
			@TERMIN VARCHAR(5),
			@INST VARCHAR(4),
			@AKT  VARCHAR(3),
			@EVENTTYP VARCHAR(255)         
  AS
  BEGIN  
     SET NOCOUNT ON;    
	 DECLARE @rowcountDoktorand int;  
	
      select @rowcountDoktorand = count(*) from ["UUSKLIST"] where pnr=@PNR and termin=@TERMIN and inst =@INST and KURS='' and PROGR = '' and AKT != '';
	  IF (@rowcountDoktorand = 0)
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
            '',
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
            '',
            '',
            @INST,
            '',
            '',
            '',
            '',
            '',
            '',
            @AKT,
            @TERMIN,
            '',
            '',
            '',
            '',
			'',
			'',
			GETDATE(),
			null)
		 END
      ELSE 
	    BEGIN
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
			termin=@TERMIN,
			inst=@INST,
			akt=@AKT,
			UPPDATERAD = GETDATE()
		    where pnr=@PNR and termin=@TERMIN and inst =@INST and KURS='' and PROGR ='' and AKT != ''
		END
    
	exec  uusmrUpdateGpnr @PNR;
END

