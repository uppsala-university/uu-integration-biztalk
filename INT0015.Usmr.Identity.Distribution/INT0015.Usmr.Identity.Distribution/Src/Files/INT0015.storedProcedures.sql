	   DROP PROCEDURE IF EXISTS [dbo].[uusmrPnrChangeProc]; 
go

Create PROCEDURE  [dbo].[uusmrPnrChangeProc]
    @PNR  char(13), 
    @GPNR char(13),
            @INLDATUM_PERS char(10)
AS
BEGIN  
    SET NOCOUNT ON;      
                        UPDATE [dbo].["UUSKLIST"]
        SET PNR = @PNR, GPNR=@GPNR, INLDATUM_PERS = @INLDATUM_PERS    
        WHERE PNR = @GPNR
END
