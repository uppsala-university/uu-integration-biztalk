CREATE PROCEDURE delDelayedEvent @eventUID varchar(MAX)
AS

DELETE FROM dbo.delayed_events
WHERE eventUID = @eventUID;