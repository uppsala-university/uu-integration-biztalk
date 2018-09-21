USE [L3Events]
GO

/****** Object:  Table [dbo].[Ladok3Events]    Script Date: 9/19/2018 1:51:50 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/******* EVENT TABLE *********/
CREATE TABLE [dbo].[Ladok3Events](
	[id] [bigint] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[event] [varchar](max) NOT NULL,
	[envelope] [varchar](max) DEFAULT NULL,
	[processing] [bit] NOT NULL DEFAULT 0
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

/******* ADD EVENT TO DB *********/

CREATE PROCEDURE addEvent @event VARCHAR(MAX)

AS

INSERT INTO [dbo].[Ladok3Events] ([event]) VALUES (@event);

GO

/******* SAVE ENVELOPE TO DB *********/
CREATE PROCEDURE saveEnvelope @id BIGINT, @envelope VARCHAR(MAX)

AS

UPDATE  [dbo].[Ladok3Events] SET [envelope] = @envelope
WHERE [id] = @id; 

GO

/***** EVENTS FOR PROCESSING ******/
CREATE PROCEDURE checkNextProcessing @maxProcessing int

AS

IF  @maxProcessing > (SELECT COUNT(*) FROM [dbo].[Ladok3Events] WHERE [processing] = 1) AND (SELECT COUNT(*) FROM [dbo].[Ladok3Events]  WHERE [processing] = 0) > 0
	SELECT 1;
ELSE
	SELECT 0;

GO

CREATE PROCEDURE getNextForProcessing

AS

DECLARE 
	@id BIGINT,
	@event VARCHAR(MAX);

	BEGIN TRY
		BEGIN TRANSACTION
			SELECT TOP 1
				@id = [id],
				@event = [event]
			FROM [dbo].[Ladok3Events]
			WHERE [processing] = 0
			ORDER BY [id];

			UPDATE  [dbo].[Ladok3Events]
			SET [processing] = 1
			WHERE [id] = @id;

			SELECT @id as [id], @event AS [event];

		COMMIT TRANSACTION

	END TRY

	BEGIN CATCH
		ROLLBACK
	END CATCH

GO

/****  GET PROCESSED ENVELOPES *****/

CREATE PROCEDURE checkNextProcessed

AS

SELECT COUNT(*) FROM [dbo].[Ladok3Events] WHERE [processing] = 1 AND [envelope] IS NOT NULL AND [id] = (SELECT MIN([id]) FROM [dbo].[Ladok3Events] )

GO


CREATE PROCEDURE getNextProcessed

AS

DECLARE 
	@id BIGINT = 0,
	@envelope VARCHAR(MAX);

	BEGIN TRY
		BEGIN TRANSACTION
			SELECT TOP 1
				@id = [id],
				@envelope = [envelope]
			FROM [dbo].[Ladok3Events]
			WHERE [processing] = 1 AND [envelope] IS NOT NULL AND [id] = (SELECT MIN([id]) FROM [dbo].[Ladok3Events] )
			ORDER BY [id];

			DELETE FROM  [dbo].[Ladok3Events]
			WHERE [id] = @id;

			SELECT @envelope AS [envelope];

		COMMIT TRANSACTION

	END TRY

	BEGIN CATCH
		ROLLBACK
	END CATCH

GO