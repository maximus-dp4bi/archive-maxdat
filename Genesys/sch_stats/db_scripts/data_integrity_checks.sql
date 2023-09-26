--use database PUREINSIGHTS_DEV;
--use database PUREINSIGHTS_UAT;
--use database PUREINSIGHTS_PRD;
use schema SCH_STATS;

-- primary key constraint check 
select jobid,runcount,count(*) from SCH_JOBSTATISTICS_SUMMARY
 group by jobid,runcount
  having count(*) > 1
  
-- data sync check, every jobid,runcount combo should exist in both summary & detailed tables 
select jobid,runcount from SCH_JOBSTATISTICS_SUMMARY smry 
 where not exists ( 
    select 1 from SCH_JOBSTATISTICS_DETAIL dtl 
        where dtl.jobid=smry.jobid and dtl.runcount=smry.runcount )
 
-- primary key constraint check 
select jobid,runcount,dtl_msgid,count(*) from SCH_JOBSTATISTICS_DETAIL
 group by jobid,runcount,dtl_msgid
  having count(*) > 1

-- foreign key constraint check 
select jobid,runcount from SCH_JOBSTATISTICS_DETAIL dtl 
 where not exists ( 
    select 1 from SCH_JOBSTATISTICS_SUMMARY smry
        where smry.jobid=dtl.jobid and smry.runcount=dtl.runcount )