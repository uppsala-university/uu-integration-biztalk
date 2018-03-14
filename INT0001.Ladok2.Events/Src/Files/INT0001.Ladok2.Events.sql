


IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'MEMBERSHIP_EVENTS'))
BEGIN

	IF NOT EXISTS (
		SELECT *
		FROM sys.indexes AS si
		JOIN sys.objects AS so on si.object_id=so.object_id
		JOIN sys.schemas AS sc on so.schema_id=sc.schema_id
		WHERE 
			sc.name='dbo' /* Schema */
			AND so.name ='MEMBERSHIP_EVENTS' /* Table */
			AND si.name='MEMBERSHIP_EVENTS_PRIMARY' /* Index */)
	BEGIN

		CREATE UNIQUE CLUSTERED INDEX [MEMBERSHIP_EVENTS_PRIMARY] ON [dbo].[MEMBERSHIP_EVENTS]
		(
			[pnr] ASC,
			[id] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]


	END

	IF NOT EXISTS (
		SELECT *
		FROM sys.indexes AS si
		JOIN sys.objects AS so on si.object_id=so.object_id
		JOIN sys.schemas AS sc on so.schema_id=sc.schema_id
		WHERE 
			sc.name='dbo' /* Schema */
			AND so.name ='MEMBERSHIP_EVENTS' /* Table */
			AND si.name='MEMBERSHIP_EVENTS_PROCESSED' /* Index */)
	BEGIN

		CREATE NONCLUSTERED INDEX [MEMBERSHIP_EVENTS_PROCESSED] ON [dbo].[MEMBERSHIP_EVENTS]
		(
			[processed] ASC
		)
		INCLUDE ( 	[id],
			[pnr],
			[reportCode],
			[startSemester]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

	END

	
END

IF (NOT EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'ACK_EVENTS'))
BEGIN

  CREATE TABLE [dbo].[ACK_EVENTS](
	[object_key] [varchar](20) NOT NULL,
	[event_id] [bigint] NOT NULL,
	[ack_event] [datetime] DEFAULT (getdate())
) ON [PRIMARY]


CREATE UNIQUE NONCLUSTERED INDEX [ACK_EVENTS_SECONDARY] ON [dbo].[ACK_EVENTS]
(
	[event_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = ON, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]


CREATE CLUSTERED INDEX [ACK_EVENTS_MAIN] ON [dbo].[ACK_EVENTS]
(
	[object_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

END

GO

IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.VIEWS 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'GET_PROCESSED_GROUP_IDS'))
BEGIN
	DROP VIEW [dbo].[GET_PROCESSED_GROUP_IDS]
END

GO

/*
create view [dbo].[GET_NOT_PROCESSED_GROUP_IDS]
as
select concat(reportCode,'_',startSemester) as course
  FROM [dbo].[MEMBERSHIP_EVENTS]
	where pnr is null and processed = 1
	*/

create view [dbo].[GET_NOT_PROCESSED_GROUPS]
as
select concat(reportCode,'_',startSemester) as course
  FROM [dbo].[MEMBERSHIP_EVENTS]
	where pnr is null and processed = 0

GO

IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.VIEWS 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'ACK_AND_EVENTS'))
BEGIN
	DROP VIEW [dbo].[ACK_AND_EVENTS]
END

GO

CREATE VIEW [dbo].[ACK_AND_EVENTS]
		WITH SCHEMABINDING  
		AS  
		 select 
		 case when (ev.pnr is null) then	
			concat(ev.reportCode,'_',ev.startSemester)
			else
			ev.pnr
		 end as  object_key,[event_id]
			from  [dbo].[ACK_EVENTS] as ak
			join [dbo].[MEMBERSHIP_EVENTS] as ev
				on ak.[event_id] = ev.id
				where ev.processed = 0;
				
GO


IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.VIEWS 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'GET_ALL_IDS'))
BEGIN
	DROP VIEW [dbo].[GET_ALL_IDS]
END

GO

create view [dbo].[GET_ALL_IDS]
as
 SELECT 
			min(ev.Id) as Id
			 ,count(*) as transactions
			  , case when (ev.pnr is null) then	
			concat(ev.reportCode,'_',ev.startSemester)
			else
			ev.pnr
		 end as  object_key
			 
		  FROM [dbo].[MEMBERSHIP_EVENTS] as ev
		  group by  case when (ev.pnr is null) then	
			concat(ev.reportCode,'_',ev.startSemester)
			else
			ev.pnr
		 end

GO

IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.VIEWS 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'GET_NEXT_IDS'))
BEGIN
	DROP VIEW [dbo].[GET_NEXT_IDS]
END
GO 


create view [dbo].[GET_NEXT_IDS]
as
 SELECT 
			min(ev.Id) as Id
			 ,count(*) as transactions
			  , case when (ev.pnr is null) then	
			concat(ev.reportCode,'_',ev.startSemester)
			else
			ev.pnr
		 end as  object_key
			 
		  FROM [dbo].[MEMBERSHIP_EVENTS] as ev
		 where 
		--not(pnr is null) and --inkludera även grupper
		 processed = 0
		 --Make sure group exists before individual is processed
		 and (pnr is null or (concat(ev.reportCode,'_',ev.startSemester) not in
		 (select course from [dbo].GET_NOT_PROCESSED_GROUPS)
		 ))
		  group by  case when (ev.pnr is null) then	
			concat(ev.reportCode,'_',ev.startSemester)
			else
			ev.pnr
		 end

GO


IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.VIEWS 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'READY_FOR_PROCESSING'))
BEGIN
	DROP VIEW [dbo].[READY_FOR_PROCESSING]
END

GO

CREATE view [dbo].[READY_FOR_PROCESSING]
	as
	 SELECT 
			* from GET_NEXT_IDS as ev
			where 
				not exists(
			select * from [dbo].[ACK_AND_EVENTS] akev
				where (akev.object_key = ev.object_key or akev.object_key = ev.object_key)
					and ev.id = akev.event_id
					)

GO

IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.ROUTINES 
                 WHERE SPECIFIC_SCHEMA = 'dbo' 
                 AND  SPECIFIC_NAME = 'INT0001.Ladok2.Events.checkPending'))
BEGIN
  DROP PROCEDURE [dbo].[INT0001.Ladok2.Events.checkPending]
END

GO

create procedure [dbo].[INT0001.Ladok2.Events.checkPending]
as
select * from [dbo].[MEMBERSHIP_EVENTS]
join [dbo].[ACK_EVENTS] on id = event_id
where processed = 0

GO

IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.ROUTINES 
                 WHERE SPECIFIC_SCHEMA = 'dbo' 
                 AND  SPECIFIC_NAME = 'INT0001.Ladok2.Events.checkNext'))
BEGIN
  DROP PROCEDURE [dbo].[INT0001.Ladok2.Events.checkNext]
END

GO

create  procedure    [dbo].[INT0001.Ladok2.Events.checkNext]
  as
	select count(*) from [dbo].[READY_FOR_PROCESSING];
	
 

GO

IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.ROUTINES 
                 WHERE SPECIFIC_SCHEMA = 'dbo' 
                 AND  SPECIFIC_NAME = 'INT0001.Ladok2.Events.openPending'))
BEGIN
  DROP PROCEDURE [dbo].[INT0001.Ladok2.Events.openPending]
END

GO

create procedure [dbo].[INT0001.Ladok2.Events.openPending]
@Id bigint
as

if(@Id > 0)
delete from [dbo].[ACK_EVENTS]
where event_id = @Id;

go

IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.ROUTINES 
                 WHERE SPECIFIC_SCHEMA = 'dbo' 
                 AND  SPECIFIC_NAME = 'INT0001.Ladok2.Events.getNext'))
BEGIN
  DROP PROCEDURE [dbo].[INT0001.Ladok2.Events.getNext]
END

GO

	 CREATE  procedure  [dbo].[INT0001.Ladok2.Events.getNext]
	  as

	  declare @Ack as table
	  (
		Id int
	  )

	    insert into [ACK_EVENTS](event_id,object_key)
			output INSERTED.event_id into @Ack
				select top 100 Id,object_key from [dbo].[READY_FOR_PROCESSING]


			SELECT 
				[dbo].[MEMBERSHIP_EVENTS].Id as Id
				  ,[date]
				  ,[pnr]
				  ,[meType]
				  ,[courseCode]
				  ,[reportCode]
				  ,[startSemester]
				  ,[semester]
				  ,[program]
				  ,[programOrientation]
				  ,[condition1]
				  ,[condition2]
				  ,[condition3]
				  ,[origin]
				  ,[origin2]
			  FROM [dbo].[MEMBERSHIP_EVENTS]
				join @Ack as a on a.id = [dbo].[MEMBERSHIP_EVENTS].Id

GO

IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.ROUTINES 
                 WHERE SPECIFIC_SCHEMA = 'dbo' 
                 AND  SPECIFIC_NAME = 'INT0001.Ladok2.Events.updateId'))
BEGIN
	DROP PROCEDURE [dbo].[INT0001.Ladok2.Events.updateId]
END

GO

	CREATE procedure  [dbo].[INT0001.Ladok2.Events.updateId]
	 @ackId bigint
	  as


	  declare @Ack as table
	  (
		Id int
	  )


	   update [dbo].[MEMBERSHIP_EVENTS]
	   set processed = 1
		from [dbo].[MEMBERSHIP_EVENTS]
				where Id = @ackId

GO
	