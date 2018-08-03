CREATE PROCEDURE addDelayedEvent @body varchar(MAX), @eventTime datetime, @ack int
AS
INSERT INTO dbo.delayed (body,eventTime,ack) VALUES (@body, @eventTime, @ack)
GO;