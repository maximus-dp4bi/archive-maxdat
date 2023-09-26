/* 
** STEPS TO REPOST AVAYA AGENT HISTORICAL DATA WHEN INTERVALS IN ANY GIVEN DAY OR MISSED
** DERIVED FROM DOCUMENT SUPPLIED BY CELIA (NICE) ON 3/21/2016
** MODIFIED ORIGINAL REPOST STEPS TO REMOVE Step 5 TO PERFORM jmx actions
*/

--Step1 - Check the values that you have setup:
select * from [nice_wfm_customer1].dbo.r_features where c_feature='QueueStatsReprocessing';

--Step2 - Change values as far back as you need to.  For this example we will not be querying further than 30 days back
update [nice_wfm_customer1].dbo.r_features set c_enabled='T', c_maxvalue=30, c_value=30 where c_feature='QueueStatsReprocessing'

--Step 3 - Verify the change made in Step 2 
select * from [nice_wfm_customer1].dbo.r_features where c_feature='QueueStatsReprocessing';

--Step 4 - 2.	Change the start and end dates for the reposting job.  (Rule of thumb is 1 week at a time)
update [nice_wfm_customer1].dbo.r_swxifacejobparms set c_val='2018-08-15 00:00' where c_key='intervalStart' and c_joboid='Symposium-Acd21-Repost';
update [nice_wfm_customer1].dbo.r_swxifacejobparms set c_val='2018-08-15 21:45' where c_key='intervalEnd' and c_joboid='Symposium-Acd21-Repost';

--Step 4a - check the job parameter table value
select * from [nice_wfm_customer1].dbo.r_swxifacejobparms where c_joboid='Symposium-Acd21-Repost';  


--Step 5 - BACK TO DB - Check the job status
select 
  c_intvl, c_transformstatus,c_loadstatus, c_timestamp
from [nice_wfm_customer1].dbo.r_reportsrcvd 
where c_intvl >= '2016-11-16 13:00' and c_intvl < '2016-11-16 13:15' and
   c_acd=(select c_oid from [nice_wfm_customer1].dbo.r_acd where c_id = 22) 
order by c_intvl asc;

--Step 6 - Disable job
update [nice_wfm_customer1].dbo.r_features set c_enabled='F', c_maxvalue=30, c_value=30 where c_feature='QueueStatsReprocessing'

--Step 7 - Disable job on SWXIFACEJOB table
----run this once all of the interval posts have completed 
Update [nice_wfm_customer1].dbo.r_swxifacejob set c_enabled= 'F' where c_oid= 'Symposium-Acd21-Repost'

select * from [nice_wfm_customer1].dbo.r_swxifacejob where c_oid like 'Symposium-Acd%-Repost';

select * from nice_wfm_customer1.dbo.R_FILESRCVD 
--where c_acd = 'acd.1' 
order by C_TIMESTAMP desc;












--ignore following - kept as a reference for running the job from SSMS but this process requires the RTA node to be restarted

--Notes from Engineer Guilhermes
--Update r_swxifacejobparms set c_val='2016-03-18 05:00' where c_joboid= 'Symposium-Acd21-Repost' and c_key='intervalStart'
--Update r_swxifacejobparms set c_val='2016-03-18 11:00' where c_joboid= 'Symposium-Acd21-Repost' and c_key='intervalEnd'


--Update r_swxifacejob set c_enabled='T' where c_oid='Symposium-Acd21-Repost'

----run this once all of the interval posts have completed
--Update [nice_wfm_customer1].dbo.r_swxifacejob set c_enabled= 'F' where c_oid= 'Symposium-Acd21-Repost'

--select * from r_swxifacejobparms


/*
insert into r_swxifacejobparms (c_joboid, c_key, c_val) values ('<joboid>', 'VAR:QUERY_PAST_PERIOD', '1-4')

insert into r_swxifacejobparms (c_joboid, c_key, c_val) values ('Symposium-Acd21', 'VAR:QUERY_PAST_PERIOD', '1-4')
insert into r_swxifacejobparms (c_joboid, c_key, c_val) values ('Symposium-Acd22', 'VAR:QUERY_PAST_PERIOD', '1-4')
insert into r_swxifacejobparms (c_joboid, c_key, c_val) values ('Symposium-Acd23', 'VAR:QUERY_PAST_PERIOD', '1-4')
insert into r_swxifacejobparms (c_joboid, c_key, c_val) values ('Symposium-Acd24', 'VAR:QUERY_PAST_PERIOD', '1-4')

delete from [nice_wfm_customer1].dbo.r_swxifacejobparms where c_key='VAR:QUERY_PAST_PERIOD';
select * from [nice_wfm_customer1].dbo.r_swxifacejobparms where c_key='VAR:QUERY_PAST_PERIOD';
*/