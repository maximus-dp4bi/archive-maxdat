use maxco_awdb

declare @Date as Date = dateadd(mm, -1, convert(date, getdate())) -- Within 1 month

--Check Call Types
select 'Call Types' as [Table]
,Left(EnterpriseName, 4)Enterprise_ID
,Count(*)Records_Added
from maxco_awdb.dbo.Call_Type
where EnterpriseName like 'CARC%'
group by Left(EnterpriseName, 4);

--Compare to DP

select substr(queue_name,1,4), count(*) from cc_c_contact_queue
where queue_name like 'CARC%'
group by substr(queue_name,1,4);



--Check Desk Settings
select distinct 'Desk Settings' as [Table]
,Left(EnterpriseName, 4)Enterprise_ID, convert(date, DateTimeStamp)Added
,Count(*)Records_Added
from [dbo].[Agent_Desk_Settings]
where EnterpriseName like 'CARC%'
group by Left(EnterpriseName, 4), convert(date, DateTimeStamp);

--DP Query

select out_var from cc_a_list_lkup
where list_type = 'CAHCO_DESK_SETTINGS';


--Check Agent Routing Group
select distinct 'Agent Routing Group' as [Table]
,PrecisionQueueID
from [dbo].[Skill_Group]
where PeripheralName like 'CARC%';

--DP Query
"select distinct value from cc_c_filter
where filter_type in ('ACD_ARG_ID_INC');"


--Check Precision Queues
select distinct 'Precision Queues' as [Table], CallTypeID, EnterpriseName from [dbo].Call_Type
where EnterpriseName like 'CARC%'
order by 1;

--DP Query

"select distinct queue_number, queue_name from cc_c_contact_queue
where queue_name like 'CARC%'
order by queue_number;"
