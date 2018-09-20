USE [L3Events]
GO

/****** Object:  Table [dbo].[Ladok3Events]    Script Date: 9/19/2018 1:51:50 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Ladok3Events](
	[id] [bigint] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[event] [varchar](max) NOT NULL,
	[envelope] [varchar](max) DEFAULT NULL,
	[processing] [bit] NOT NULL DEFAULT 0
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

CREATE PROCEDURE addEvent @event VARCHAR(MAX)

AS

INSERT INTO [dbo].[Ladok3Events] ([event]) VALUES (@event);

GO

CREATE PROCEDURE saveEnvelope @id BIGINT, @envelope VARCHAR(MAX)

AS

UPDATE  [dbo].[Ladok3Events] ([event]) SET [envelope] = @envelope
WHERE [id] = @id; 

GO

CREATE PROCEDURE checkNextProcessing @maxProcessing int

AS

IF  @maxProcessing > (SELECT COUNT(*) FROM [dbo].[Ladok3Events] WHERE [processing] = 1)
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

CREATE PROCEDURE checkNextProcessed

AS

SELECT COUNT(*) FROM [dbo].[Ladok3Events] WHERE [processing] = 1 AND [envelope] IS NOT NULL AND [id] = (SELECT MIN([id]) FROM [dbo].[Ladok3Events] )

GO


CREATE PROCEDURE getNextProcessed

AS

DECLARE 
	@envelope VARCHAR(MAX);

	BEGIN TRY
		BEGIN TRANSACTION
			SELECT TOP 1
				@envelope = [event]
			FROM [dbo].[Ladok3Events]
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