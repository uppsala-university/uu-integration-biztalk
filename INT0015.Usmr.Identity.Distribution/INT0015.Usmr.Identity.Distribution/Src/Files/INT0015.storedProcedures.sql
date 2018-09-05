Create PROCEDURE  [dbo].[uusmrPnrChangeProc]
    @PNR  char(11), 
    @GPNR char(11),
            @INLDATUM_PERS char(10)
AS
BEGIN  
    SET NOCOUNT ON;      
                        UPDATE [dbo].["UUSKLIST"]
        SET PNR = @PNR, GPNR=@GPNR, INLDATUM_PERS = @INLDATUM_PERS    
        WHERE PNR = @GPNR
END
