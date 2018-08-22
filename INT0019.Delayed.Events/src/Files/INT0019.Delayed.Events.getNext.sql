USE [sd-delayed-test-db]
GO
/****** Object:  StoredProcedure [dbo].[INT0019.Delayed.Events.getNext]    Script Date: 2018-08-22 10:58:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	 ALTER  procedure  [dbo].[INT0019.Delayed.Events.getNext]
	 as
	  
	declare
	 @id int,
	 @body varchar(max),
	 @eventTime datetime;

	begin try
		begin transaction
		
			SELECT top 1
				@Id = Id
				,@body = body
				,@eventTime = eventTime
			FROM [dbo].[delayed_events]
			where eventTime < GetDate()
			order by eventTime;

			delete from [dbo].[delayed_events]
			where id = @id;

			select @id AS Id, @body as body, @eventTime as eventTime
	
		commit transaction
	end try
	begin catch
		rollback
	end catch

	
