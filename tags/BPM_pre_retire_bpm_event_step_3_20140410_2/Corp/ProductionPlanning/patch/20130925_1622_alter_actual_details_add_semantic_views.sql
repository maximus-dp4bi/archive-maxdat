ALTER TABLE PP_D_ACTUAL_DETAILS
ADD 
(
BUCKET_START_DATE DATE,
BUCKET_END_DATE DATE,
JEOPARDY_FLAG VARCHAR2(1) DEFAULT 'N'
);

commit;


UPDATE pp_d_actual_details SET BUCKET_START_DATE = D_DATE, BUCKET_END_DATE = TRUNC(D_DATE+2);
COMMIT;


create or replace view maxdat.PP_D_ACTUAL_DETAILS_SV as
select
  DAD_ID,
  PPDD.D_DATE,
  D_HOUR,
  USR_ID,
  SOURCE_DETAIL_ID, 
  case 
    when DENSE_RANK() over (partition by SOURCE_DETAIL_ID order by SOURCE_DETAIL_ID asc, PPDD.D_DATE asc) = 1 then 1
    else 0
    end ACTUAL_ARRIVAL,
  ACTUAL_COMPLETION,
  ACTUAL_INVENTORY,
  ACTUAL_INVENTORY_AGE,
  ACTUAL_HANDLE_TIME,
  ACTUAL_STAFF_HOURS,
  JEOPARDY_FLAG
from 
  PP_D_DATES PPDD,
  PP_D_ACTUAL_DETAILS DAD
where
  PPDD.D_DATE >= DAD.BUCKET_START_DATE 
  and PPDD.D_DATE < DAD.BUCKET_END_DATE
union all
select
  DAD_ID,
  PPDD.D_DATE,
  D_HOUR,
  USR_ID,
  SOURCE_DETAIL_ID, 
  ACTUAL_ARRIVAL,
  ACTUAL_COMPLETION,
  ACTUAL_INVENTORY,
  ACTUAL_INVENTORY_AGE,
  ACTUAL_HANDLE_TIME,
  ACTUAL_STAFF_HOURS,
  JEOPARDY_FLAG
from 
  PP_D_DATES PPDD,
  PP_D_ACTUAL_DETAILS DAD
where
  PPDD.D_DATE = DAD.BUCKET_START_DATE 
  and PPDD.D_DATE = DAD.BUCKET_END_DATE
with read only;

commit;

CREATE OR REPLACE VIEW PP_D_UOW_MW_SV AS
   SELECT USR.UOW_ID, USR.SOURCE_REF_VALUE AS TASK_TYPE
   FROM PP_D_SOURCE_REF_TYPE SRT
   INNER JOIN PP_D_SOURCE S ON SRT.SOURCE_ID = S.SOURCE_ID
   INNER JOIN PP_D_UOW_SOURCE_REF USR ON SRT.SOURCE_REF_TYPE_ID =
   USR.SOURCE_REF_TYPE_ID
   WHERE S.SOURCE_NAME = 'NYHIX MANAGE WORK STG'
   AND SRT.SOURCE_REF_TYPE_NAME = 'TASK TYPE';

   CREATE OR REPLACE VIEW PP_D_UOW_MFB_SCAN_SV AS
   SELECT USR.UOW_ID, USR.SOURCE_REF_VALUE AS BATCH_CLASS
   FROM PP_D_SOURCE_REF_TYPE SRT
   INNER JOIN PP_D_SOURCE S ON SRT.SOURCE_ID = S.SOURCE_ID
   INNER JOIN PP_D_UOW_SOURCE_REF USR ON SRT.SOURCE_REF_TYPE_ID =
   USR.SOURCE_REF_TYPE_ID
   WHERE S.SOURCE_NAME = 'NYHIX MAIL/FAX BATCH SCAN'
   AND SRT.SOURCE_REF_TYPE_NAME = 'BATCH CLASS';

   CREATE OR REPLACE VIEW PP_D_UOW_MFB_RVW_SV AS
   SELECT USR.UOW_ID, USR.SOURCE_REF_VALUE AS BATCH_TYPE
   FROM PP_D_SOURCE_REF_TYPE SRT
   INNER JOIN PP_D_SOURCE S ON SRT.SOURCE_ID = S.SOURCE_ID
   INNER JOIN PP_D_UOW_SOURCE_REF USR ON SRT.SOURCE_REF_TYPE_ID =
   USR.SOURCE_REF_TYPE_ID
   WHERE S.SOURCE_NAME = 'NYHIX MAIL/FAX BATCH STG'
   AND SRT.SOURCE_REF_TYPE_NAME = 'BATCH TYPE';
   
   commit;
   
   /
