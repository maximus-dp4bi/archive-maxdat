
ALTER TABLE DP_SCORECARD.SC_ATTENDANCE_INITIAL_SCORE
 DROP PRIMARY KEY CASCADE;

ALTER TABLE DP_SCORECARD.SC_ATTENDANCE_INITIAL_SCORE ADD (
  PRIMARY KEY
  (STAFF_ID)
  USING INDEX
    TABLESPACE MAXDAT_INDX
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               )
  ENABLE VALIDATE);

-------------------------------------------------
-- DP_SCORECARD.SCORECARD_ATTENDANCE_MTHLY
-------------------------------------------------

ALTER TABLE DP_SCORECARD.SCORECARD_ATTENDANCE_MTHLY
 DROP PRIMARY KEY CASCADE;

drop index SC_ATTEN_MTHLY_STAFF_MNTH_NDX;

CREATE INDEX DP_SCORECARD.SC_ATTEN_MTHLY_STAFF_MNTH_NDX 
ON DP_SCORECARD.SCORECARD_ATTENDANCE_MTHLY (STAFF_STAFF_ID ASC, DATES_MONTH_NUM ASC) 
LOGGING 
TABLESPACE MAXDAT_INDX 
PCTFREE 10 
INITRANS 2 
STORAGE 
( 
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1 
  MAXEXTENTS UNLIMITED 
  BUFFER_POOL DEFAULT 
) 
NOPARALLEL;
		   
-------------------------------------------------

CREATE VIEW DP_SCORECARD.SCORECARD_ATTENDANCE_SCORE_SV
AS With staff as
(
select
       manager_staff_id,
       manager_name,
       supervisor_staff_id,
       supervisor_name,
       staff_staff_id,
       staff_staff_name,
       staff_natid,
       hire_date,
       0 as sc_attendance_id,
       hire_date as create_datetime
  from dp_scorecard.scorecard_hierarchy
)
, staff_starting_balance as
(
select manager_staff_id,
       manager_name,
       supervisor_staff_id,
       supervisor_name,
       staff_staff_id,
       staff_staff_name,
       staff_natid,
       --hire_date as dates,
       coalesce(ais.start_date,hire_date) as dates,
       'Starting Balance' as absence_type,
       'Starting Balance' as absence_comment_type,
       --40 as point_value,
       coalesce(ais.attendance_points,40) as point_value,
       --40 as balance,
       coalesce(ais.attendance_points,40) as balance,
       --0 as incentive_balance,
       coalesce(ais.incentive_points,0) as incentive_balance,
       --40 as total_balance,
       (coalesce(ais.attendance_points,40) + coalesce(ais.incentive_points,0)) as total_balance,
       NULL as incentive_flag,
       NULL as comments,
       create_datetime,
       null as create_by,
       NULL as last_updated_by,
       null as LAST_UPDATED_DATETIME,
       sc_attendance_id
  from staff s
  left outer join dp_scorecard.sc_attendance_initial_score ais on s.staff_staff_id = ais.staff_id
),
sc_attend_entries as
(
select s.manager_staff_id,
       s.manager_name,
       s.supervisor_staff_id,
       s.supervisor_name,
       s.staff_staff_id,
       s.staff_staff_name,
       s.staff_natid,
       sca.entry_date as dates,
       sca.absence_type,
       sca.point_value,
       sca.balance,
       sca.incentive_balance,
       sca.total_balance,
       sca.incentive_flag,
       sca.sc_attendance_id,
       sca.create_datetime,
       sca.create_by,
       sca.last_updated_by,
       sca.LAST_UPDATED_DATETIME
  from staff s
inner join DP_SCORECARD.SC_ATTENDANCE sca
    on s.staff_staff_id = sca.staff_id
)
select manager_staff_id,
       manager_name,
       supervisor_staff_id,
       supervisor_name,
       staff_staff_id,
       staff_staff_name,
       staff_natid,
       dates,
       absence_type,
       point_value,
       balance,
       incentive_balance,
       total_balance,
       incentive_flag,
       sc_attendance_id,
       create_datetime,
       create_by,
       last_updated_by,
       LAST_UPDATED_DATETIME
  from staff_starting_balance
union all
select manager_staff_id,
       manager_name,
       supervisor_staff_id,
       supervisor_name,
       staff_staff_id,
       staff_staff_name,
       staff_natid,
       dates,
       absence_type,
       point_value,
       balance,
       incentive_balance,
       total_balance,
       incentive_flag,
       sc_attendance_id,
       create_datetime,
       create_by,
       last_updated_by,
       LAST_UPDATED_DATETIME
  from sc_attend_entries;


GRANT SELECT ON DP_SCORECARD.SCORECARD_ATTENDANCE_SCORE_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SCORECARD_ATTENDANCE_SCORE_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SCORECARD_ATTENDANCE_SCORE_SV TO MAXDAT_REPORTS;

-------------------------------------------------

CREATE VIEW DP_SCORECARD.SCORECARD_ATTENDANCE_MTHLY_SV
AS select a11.MANAGER_STAFF_ID
,a11.MANAGER_NAME
,a11.SUPERVISOR_STAFF_ID
,a11.SUPERVISOR_NAME
,a11.STAFF_STAFF_ID
,a11.STAFF_STAFF_NAME
,a10.STAFF_NATID
,a11.DATES_MONTH
,a11.DATES_MONTH_NUM
,a11.DATES_YEAR
,a11.BALANCE
,a11.TOTAL_BALANCE
,a11.SC_ATTENDANCE_ID
 from dp_scorecard.scorecard_attendance_mthly a11
 join DP_SCORECARD.SCORECARD_HIERARCHY_SV a10 on a10.staff_staff_id=a11.staff_staff_id 
 WITH READ ONLY;


GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE, ON COMMIT REFRESH, QUERY REWRITE, DEBUG, FLASHBACK, MERGE VIEW ON DP_SCORECARD.SCORECARD_ATTENDANCE_MTHLY_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SCORECARD_ATTENDANCE_MTHLY_SV TO MAXDAT_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SCORECARD_ATTENDANCE_MTHLY_SV TO MAXDAT_REPORTS;

-------------------------------------------------
