CREATE PROCEDURE addDelayedEvent @body varchar(MAX), @eventTime datetime, @eventUID varchar(MAX)
AS
INSERT INTO dbo.delayed_events (body,eventTime,eventUID) VALUES (@body, @eventTime, @eventUID);
