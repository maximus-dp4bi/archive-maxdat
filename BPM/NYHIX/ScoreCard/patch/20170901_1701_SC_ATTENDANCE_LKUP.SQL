
-------------------------------------------------------------
-- Add new Absence TYPE
-------------------------------------------------------------

INSERT INTO DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP (
    SC_ALL_ID, ABSENCE_TYPE, POINT_VALUE,
    END_DATE, CREATE_BY, CREATE_DATETIME,
    INCENTIVE_FLAG
    )
 VALUES ( SEQ_SCAL_ID.Nextval, 		--	SC_ALL_ID 
  'Perfect Attendance (3)', 		--	ABSENCE_TYPE 
  3, 								--	POINT_VALUE 
  to_date('20770707','YYYYMMDD'), 	-- 	END_DATE 
  'script', 						--	CREATE_BY 
  sysdate,  						--	CREATE_DATETIME 
  null 								--	INCENTIVE_FLAG 
  );
  
commit; 


-------------------------------------------------------------
-- Hide Old Absence Types
-------------------------------------------------------------

DROP VIEW DP_SCORECARD.SCORECARD_ATTENDANCE_LKUP_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SCORECARD_ATTENDANCE_LKUP_SV
(SC_ALL_ID, ABSENCE_TYPE, ABSENCE_TYPE_SHORT_NAME, POINT_VALUE, END_DATE, 
 CREATE_BY, CREATE_DATETIME, INCENTIVE_FLAG)
AS 
select sc_all_id,
       absence_type,
       case
         when instr(ABSENCE_TYPE, '|') = 0 then
          ABSENCE_TYPE
         else
          substr(ABSENCE_TYPE, 1, instr(ABSENCE_TYPE, '|') - 2)
       end as ABSENCE_TYPE_SHORT_NAME,
       point_value,
       end_date,
       create_by,
       create_datetime,
       incentive_flag
  from dp_scorecard.sc_attendance_absence_lkup
  where end_date >= sysdate;
  
GRANT SELECT ON DP_SCORECARD.SCORECARD_ATTENDANCE_LKUP_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SCORECARD_ATTENDANCE_LKUP_SV TO MAXDAT_REPORTS;

GRANT SELECT ON DP_SCORECARD.SCORECARD_ATTENDANCE_LKUP_SV TO MAXDAT_READ_ONLY;



update dp_scorecard.sc_attendance_absence_lkup
set end_date = to_date('20170829','yyyymmdd')
where absence_type like 'Perfect Attendance |%';

update dp_scorecard.sc_attendance_absence_lkup
set end_date = to_date('20171001','yyyymmdd')
where absence_type = 'Perfect Attendance | 08 - August (6)*';

Commit;

