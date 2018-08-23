USE [sd-delayed-test-db]
GO
/****** Object:  StoredProcedure [dbo].[INT0019.Delayed.Events.checkNext]    Script Date: 2018-08-22 10:58:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER  procedure    [dbo].[INT0019.Delayed.Events.checkNext]
  as
	select count(*) 
	from delayed_events
	where eventTime < GetDate();
	
 

