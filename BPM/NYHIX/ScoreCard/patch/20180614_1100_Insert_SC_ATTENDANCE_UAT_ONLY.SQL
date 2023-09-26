insert into dp_scorecard.SC_ATTENDANCE
(
    SC_ATTENDANCE_ID, 
    STAFF_ID, 
    ENTRY_DATE, 
    SC_ALL_ID, 
    ABSENCE_TYPE, 
    POINT_VALUE, 
    CREATE_BY, 
    CREATE_DATETIME, 
    INCENTIVE_FLAG, 
    LAST_UPDATED_BY, 
    LAST_UPDATED_DATETIME
)
with inserts as
(
SELECT distinct
   SC_ATTENDANCE_ID, 
   STAFF_ID, ENTRY_DATE, 
   SC_ALL_ID, ABSENCE_TYPE, POINT_VALUE, 
   CREATE_BY, CREATE_DATETIME, BALANCE, 
   INCENTIVE_BALANCE, TOTAL_BALANCE, INCENTIVE_FLAG, 
   LAST_UPDATED_BY, LAST_UPDATED_DATETIME
FROM restore.SC_ATTENDANCE
where (
   STAFF_ID 
   , ENTRY_DATE 
   , ABSENCE_TYPE 
   , POINT_VALUE 
   , nvl(INCENTIVE_FLAG,'NULL') 
    )
in (
    SELECT 
   STAFF_ID 
   , ENTRY_DATE 
   , ABSENCE_TYPE 
   , POINT_VALUE 
   , nvl(INCENTIVE_FLAG,'NULL') 
    FROM restore.SC_ATTENDANCE
    MINUS
    SELECT 
   STAFF_ID 
   , ENTRY_DATE 
   , ABSENCE_TYPE 
   , POINT_VALUE 
   , nvl(INCENTIVE_FLAG,'NULL') 
    FROM dp_scorecard.SC_ATTENDANCE
    )
)
select 
    SEQ_SCAS_ID.nextval, -- inserts.SC_ATTENDANCE_ID, 
    inserts.STAFF_ID, 
    inserts.ENTRY_DATE, 
    lkup.SC_ALL_ID, 
    inserts.ABSENCE_TYPE, 
    inserts.POINT_VALUE, 
    inserts.CREATE_BY, 
    inserts.CREATE_DATETIME, 
    inserts.INCENTIVE_FLAG, 
    inserts.LAST_UPDATED_BY, 
    inserts.LAST_UPDATED_DATETIME
from inserts
join dp_scorecard.SC_ATTENDANCE_ABSENCE_LKUP lkup
on lkup.ABSENCE_TYPE = inserts.ABSENCE_TYPE;

commit;
