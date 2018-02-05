use [getUpdoctestDB]

--ganska många poster kör top
--select top 10 * from [dbo].[MEMBERSHIP_EVENTS]

--ganska många poster kör top
select top 10 * from [dbo].[MEMBERSHIP_EVENTS]
where meType = 'KurstillfalleTillStatusEvent'
and courseCode = 'MA017'

--välj ut en kurs
select * from [dbo].[MEMBERSHIP_EVENTS]
where courseCode = '3MC659' and reportCode = 'MC659'
order by startSemester

--endast poster med processed=0 kommer att processas, exemple nedan KurstillfalleTillStatusEvent
update [dbo].[MEMBERSHIP_EVENTS]
	set processed = 0
where id = 2876840

--rensa evenuella ack poster för det specifika ladok eventet, ack_event ska vara samma som ladok id
delete from [dbo].[ACK_EVENTS]
where ack_event = 2876840

--ovan gör att kursen kommer skapas om den inte redan finns
--släpp därefter personer som ska kopplas till specifik kurs
update [dbo].[MEMBERSHIP_EVENTS]
	set processed = 0
where courseCode = '3MC659' and reportCode = 'MC659' and startSemester = '20062'

--i fallet ovan är det enklast att rensa hela ack tabellen enligt nedan
truncate table [dbo].[ACK_EVENTS]
