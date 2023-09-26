set echo on
set verify on
set feedback on
-------------------------------------------
-- create a backup 
-------------------------------------------

CREATE TABLE F_MFB_V2_BY_HOUR_20220330_BAK
AS SELECT * 
FROM F_MFB_V2_BY_HOUR;

select count(*) from F_MFB_V2_BY_HOUR_20220330_BAK;

-------------------------------------------
-- check for records without a batch_summary record
-------------------------------------------

select * from maxdat.F_MFB_V2_BY_HOUR
where MFB_V2_BI_ID
in ( select MFB_V2_BI_ID
from maxdat.F_MFB_V2_BY_HOUR
minus
select MFB_V2_BI_ID
from maxdat.nyhix_mfb_v2_batch_summary
);

-------------------------------------------
-- delete if necessary
-------------------------------------------

delete from maxdat.F_MFB_V2_BY_HOUR
where MFB_V2_BI_ID
in ( select MFB_V2_BI_ID
from maxdat.F_MFB_V2_BY_HOUR
minus
select MFB_V2_BI_ID
from maxdat.nyhix_mfb_v2_batch_summary
);
 
commit;

-------------------------------------------
-- identify duplicate bucket_end_dates
-------------------------------------------

select MFB_V2_BI_ID, bucket_end_date, sum(1)
from maxdat.F_MFB_V2_BY_HOUR
group by MFB_V2_BI_ID, bucket_end_date
having sum(1) > 1;

-------------------------------------------
-- get rid of duplicae end dates
-------------------------------------------

delete from maxdat.F_MFB_V2_BY_HOUR
where bucket_start_date = bucket_end_date
and creation_count = 0 
and inventory_count = 0
and bucket_start_date = bucket_end_date
and ( MFB_V2_BI_ID, bucket_end_date )
in (
    -- identify duplicate bucket_end_date
    select MFB_V2_BI_ID, bucket_end_date --, sum(1)
    from maxdat.F_MFB_V2_BY_HOUR
    group by MFB_V2_BI_ID, bucket_end_date
    having sum(1) > 1
    );


-------------------------------------------
-- check creation counts > 1
-------------------------------------------

select MFB_V2_BI_ID, sum(creation_count)
from maxdat.F_MFB_V2_BY_HOUR
group by MFB_V2_BI_ID
having sum(creation_count) > 1;

-------------------------------------------
-- get rid of duplicate creation counts
-------------------------------------------

update maxdat.F_MFB_V2_BY_HOUR
set creation_count = 0
where d_date = trunc(d_date)
and creation_count = 1
and MFB_V2_BI_ID in     
        ( select MFB_V2_BI_ID
        from maxdat.F_MFB_V2_BY_HOUR
        where d_date <> trunc(d_date)
        and creation_count = 1
        );   
   
commit;       

-------------------------------------------
-- validate check creation counts > 1
-------------------------------------------

select MFB_V2_BI_ID, sum(creation_count)
from maxdat.F_MFB_V2_BY_HOUR
group by MFB_V2_BI_ID
having sum(creation_count) > 1;


-------------------------------------------
-- check creation counts < 1
-------------------------------------------

select MFB_V2_BI_ID, sum(creation_count)
from maxdat.F_MFB_V2_BY_HOUR
group by MFB_V2_BI_ID
having sum(creation_count) < 1;

-------------------------------------------
-- set a creation count if less than 1
-------------------------------------------

update maxdat.F_MFB_V2_BY_HOUR
set creation_count = 1
where ( MFB_V2_BI_ID, bucket_start_date )
in ( select MFB_V2_BI_ID, min(bucket_start_date) as bucket_start_date
    from maxdat.F_MFB_V2_BY_HOUR
    where MFB_V2_BI_ID
    in ( select MFB_V2_BI_ID --, sum(creation_count)
        from maxdat.F_MFB_V2_BY_HOUR
        group by MFB_V2_BI_ID
        having sum(creation_count) < 1 
        )
    group by MFB_V2_BI_ID
    );
    
commit;

-------------------------------------------
-- validate creation counts < 1
-------------------------------------------

select MFB_V2_BI_ID, sum(creation_count)
from maxdat.F_MFB_V2_BY_HOUR
group by MFB_V2_BI_ID
having sum(creation_count) < 1;


-------------------------------------------
-- check for multiple completion counts
-------------------------------------------

select MFB_V2_BI_ID, sum(completion_count), sum(1)
from maxdat.F_MFB_V2_BY_HOUR
group by MFB_V2_BI_ID
having sum(completion_count) > 1;

-------------------------------------------
-- get rid of multiple completion counts
-------------------------------------------

update maxdat.F_MFB_V2_BY_HOUR
set completion_count = 0
where d_date = trunc(d_date)
and completion_count = 1
and MFB_V2_BI_ID in     
        ( select MFB_V2_BI_ID
        from maxdat.F_MFB_V2_BY_HOUR
        where d_date <> trunc(d_date)
        and completion_count = 1
        );   
   
commit;       

-------------------------------------------
-- validate for multiple completion counts
-------------------------------------------

select MFB_V2_BI_ID, sum(completion_count), sum(1)
from maxdat.F_MFB_V2_BY_HOUR
group by MFB_V2_BI_ID
having sum(completion_count) > 1;

-- *************************************************
-------------------------------------------
-- final validation rerun validation steps
-------------------------------------------
-- *************************************************


-------------------------------------------
-- validate there is a batch_summary record
-------------------------------------------

select * from maxdat.F_MFB_V2_BY_HOUR
where MFB_V2_BI_ID
in ( select MFB_V2_BI_ID
from maxdat.F_MFB_V2_BY_HOUR
minus
select MFB_V2_BI_ID
from maxdat.nyhix_mfb_v2_batch_summary
);


-------------------------------------------
-- identify duplicate bucket_end_dates
-------------------------------------------

select MFB_V2_BI_ID, bucket_end_date, sum(1)
from maxdat.F_MFB_V2_BY_HOUR
group by MFB_V2_BI_ID, bucket_end_date
having sum(1) > 1;

-------------------------------------------
-- validate creation counts > 1 ( should only be 1 )
-------------------------------------------

select MFB_V2_BI_ID, sum(creation_count)
from maxdat.F_MFB_V2_BY_HOUR
group by MFB_V2_BI_ID
having sum(creation_count) > 1;

-------------------------------------------
-- validate creation counts < 1 ( always should be 1 )
-------------------------------------------

select MFB_V2_BI_ID, sum(creation_count)
from maxdat.F_MFB_V2_BY_HOUR
group by MFB_V2_BI_ID
having sum(creation_count) < 1;

-------------------------------------------
-- validate for multiple completion counts
-- may be zero but never more than 1
-------------------------------------------

select MFB_V2_BI_ID, sum(completion_count), sum(1)
from maxdat.F_MFB_V2_BY_HOUR
group by MFB_V2_BI_ID
having sum(completion_count) > 1;


-- ***********************************************************
-- ***********************************************************

-- On conversion BATCH_SUMMARY and F_MFB_V2_BY_HOUR
-- were loaded with history data but STATS_BATCH was not and  
-- Also, MAXDAT_REPORTING from Kofax does not have history past 
-- there conversion date in 2021
 
select count(*) -- a count is expected  
from  
( select batch_guid from nyhix_mfb_v2_batch_summary
minus
 select batch_guid from nyhix_mfb_v2_stats_batch );

select count(*) -- The count should be zero  
from  
( select batch_guid from nyhix_mfb_v2_batch_summary
minus
 select batch_guid from nyhix_mfb_v2_batch_summary);

-- Because both were 'converted' there should
-- NOT be any MFB_V2_BI_ID ( batch guids )
-- in F_MFB_V2_BY_HOUR which are not in BATCH_SUMMARY

select count(*) from
( -- Fact_by_hour W/O batch_summary 
select mfb_v2_bi_id from f_mfb_v2_by_hour
minus
select mfb_v2_bi_id from nyhix_mfb_v2_batch_summary
);

-- There should be a Fact_by_hour for
-- all batches in Batch_summary
select count(*) from
( -- Batch_Summary W/O FACT_BY_HOUR
select mfb_v2_bi_id from nyhix_mfb_v2_batch_summary
minus
select mfb_v2_bi_id from f_mfb_v2_by_hour
);


select count(*) from
( -- A large count is expected because STATS_BATCH
  -- was not converted.
    ( select batch_guid 
    from f_mfb_v2_by_hour f
    join
    nyhix_mfb_v2_batch_summary s
    on s.mfb_v2_bi_id = f.mfb_v2_bi_id
    )
minus
 select batch_guid from nyhix_mfb_v2_stats_batch );
