-------------------------------------------
-- create a backup 
-------------------------------------------

CREATE TABLE F_MFB_V2_BY_DAY_20220330_BAK
AS SELECT * 
FROM F_MFB_V2_BY_DAY;

select count(*) from F_MFB_V2_BY_DAY_20220330_BAK;

-------------------------------------------
-- check for records without a batch_summary record
-------------------------------------------

select * from maxdat.F_MFB_V2_BY_DAY
where MFB_V2_BI_ID
in ( select MFB_V2_BI_ID
from maxdat.F_MFB_V2_BY_DAY
minus
select MFB_V2_BI_ID
from maxdat.nyhix_mfb_v2_batch_summary
);

-------------------------------------------
-- delete if necessary
-------------------------------------------

delete from maxdat.F_MFB_V2_BY_DAY
where MFB_V2_BI_ID
in ( select MFB_V2_BI_ID
from maxdat.F_MFB_V2_BY_DAY
minus
select MFB_V2_BI_ID
from maxdat.nyhix_mfb_v2_batch_summary
);
 
commit;

-------------------------------------------
-- identify duplicate D_DATE(S)
-------------------------------------------

select MFB_V2_BI_ID, D_DATE, sum(1)
from maxdat.F_MFB_V2_BY_DAY
group by MFB_V2_BI_ID, D_DATE
having sum(1) > 1;

-------------------------------------------
-- get rid of duplicate end dates
-------------------------------------------

delete from maxdat.F_MFB_V2_BY_DAY
where ( MFB_V2_BI_ID, bucket_end_date )
in (
    -- identify duplicate D_DATES
    select MFB_V2_BI_ID, D_date --, sum(1)
    from maxdat.F_MFB_V2_BY_DAY
    group by MFB_V2_BI_ID, D_DATE
    having sum(1) > 1
    );


-------------------------------------------
-- check creation counts > 1
-------------------------------------------

select MFB_V2_BI_ID, sum(creation_count)
from maxdat.F_MFB_V2_BY_DAY
group by MFB_V2_BI_ID
having sum(creation_count) > 1;

-------------------------------------------
-- get rid of duplicate creation counts
-------------------------------------------

-- ???
-------------------------------------------
-- validate check creation counts > 1
-------------------------------------------

select MFB_V2_BI_ID, sum(creation_count)
from maxdat.F_MFB_V2_BY_DAY
group by MFB_V2_BI_ID
having sum(creation_count) > 1;


-------------------------------------------
-- check creation counts < 1
-------------------------------------------

select MFB_V2_BI_ID, sum(creation_count)
from maxdat.F_MFB_V2_BY_DAY
group by MFB_V2_BI_ID
having sum(creation_count) < 1;

-------------------------------------------
-- set a creation count if less than 1
-------------------------------------------

    
commit;

-------------------------------------------
-- validate creation counts < 1
-------------------------------------------

-------------------------------------------
-- check for multiple completion counts
-------------------------------------------

select MFB_V2_BI_ID, sum(completion_count), sum(1)
from maxdat.F_MFB_V2_BY_DAY
group by MFB_V2_BI_ID
having sum(completion_count) > 1;

-------------------------------------------
-- get rid of multiple completion counts
-------------------------------------------

update maxdat.F_MFB_V2_BY_DAY
set completion_count = 0
where d_date = trunc(d_date)
and completion_count = 1
and MFB_V2_BI_ID in     
        ( select MFB_V2_BI_ID
        from maxdat.F_MFB_V2_BY_DAY
        where d_date <> trunc(d_date)
        and completion_count = 1
        );   
   
commit;       

-------------------------------------------
-- validate for multiple completion counts
-------------------------------------------

select MFB_V2_BI_ID, sum(completion_count), sum(1)
from maxdat.F_MFB_V2_BY_DAY
group by MFB_V2_BI_ID
having sum(completion_count) > 1;

-------------------------------------------
-- final validation rerun validation steps
-------------------------------------------
*************************************************

-------------------------------------------
-- validate there is a batch_summary record
-------------------------------------------

select * from maxdat.F_MFB_V2_BY_DAY
where MFB_V2_BI_ID
in ( select MFB_V2_BI_ID
from maxdat.F_MFB_V2_BY_DAY
minus
select MFB_V2_BI_ID
from maxdat.nyhix_mfb_v2_batch_summary
);


-------------------------------------------
-- identify duplicate d_dates
-------------------------------------------

select MFB_V2_BI_ID, d_date, sum(1)
from maxdat.F_MFB_V2_BY_DAY
group by MFB_V2_BI_ID, d_date
having sum(1) > 1;

-------------------------------------------
-- validate creation counts > 1 ( should only be 1 )
-------------------------------------------

select MFB_V2_BI_ID, sum(creation_count)
from maxdat.F_MFB_V2_BY_DAY
group by MFB_V2_BI_ID
having sum(creation_count) > 1;

-------------------------------------------
-- validate creation counts < 1 ( always should be 1 )
-------------------------------------------

select MFB_V2_BI_ID, sum(creation_count)
from maxdat.F_MFB_V2_BY_DAY
group by MFB_V2_BI_ID
having sum(creation_count) < 1;

-------------------------------------------
-- validate for multiple completion counts
-- may be zero but never more than 1
-------------------------------------------

select MFB_V2_BI_ID, sum(completion_count), sum(1)
from maxdat.F_MFB_V2_BY_DAY
group by MFB_V2_BI_ID
having sum(completion_count) > 1;


