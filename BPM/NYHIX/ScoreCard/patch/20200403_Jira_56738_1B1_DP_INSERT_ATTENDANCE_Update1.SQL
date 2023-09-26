create or replace Procedure              Insert_Attendance
   ( in_staff_id in number
   , in_absence_type_id in number
   , in_datetime in date
   , in_NATIONAL_ID	in NUMBER )

AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL: svn://svn-staging.maximus.com/dev1d/maxdat/BPM/NYHIX/ScoreCard/patch/20180330_1700_Supervisor_Scorcard_DDL.sql $';
  	SVN_REVISION varchar2(20) := '$Revision: 22898 $';
 	SVN_REVISION_DATE varchar2(60) := '$Date: 2018-03-28 12:24:28 -0400 (Wed, 28 Mar 2018) $';
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author: wl134672 $';


   v_incentive_flag varchar2(1);
   v_username varchar2(100);

   cursor c1 is
   select incentive_flag from DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP where sc_all_id=in_absence_type_id;

BEGIN

   open c1;
   fetch c1 into v_incentive_flag;

   if c1%notfound then
      v_incentive_flag := NULL;
   end if;

   if  in_staff_id is null or in_absence_type_id is null or in_datetime is null or in_NATIONAL_ID is null then
     /*do nothing*/
      null;
   else
      --get username
      select name into v_username from
      (
        SELECT 'ADMIN' as NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE admin_id=in_NATIONAL_ID
        UNION
        SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE sr_director_natid=in_NATIONAL_ID
        UNION
        SELECT director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE director_natid=in_NATIONAL_ID
        UNION
        SELECT sr_manager_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE sr_manager_natid=in_NATIONAL_ID
        UNION
        SELECT manager_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE manager_natid=in_NATIONAL_ID
        UNION
        SELECT supervisor_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE supervisor_natid=in_NATIONAL_ID
      );

      --insert into pp_bo_scorecard. added where clause to prevent user from adding dates before staff's hire date or future dates
      insert into dp_scorecard.sc_attendance
        (sc_attendance_id, staff_id, entry_date, sc_all_id, absence_type, point_value, create_by, create_datetime, incentive_flag, last_updated_by, LAST_UPDATED_DATETIME)
        (select SEQ_SCAS_ID.nextval,
                in_staff_id,
                trunc(in_datetime),
                in_absence_type_id,
                (select absence_type from DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP where sc_all_id=in_absence_type_id),
                (select point_value from DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP where sc_all_id=in_absence_type_id),
                v_username,
                sysdate,
                v_incentive_flag,
                v_username,
                sysdate
          from dual
          where (
                trunc(sysdate) >= (select min(dates)
                                from ( select min(dates) dates
                                        from DP_SCORECARD.SCORECARD_ATTENDANCE_SCORE_SV
                                        where staff_staff_id=in_staff_id
                                        and sc_attendance_id=0
                                       union  -- << added to allow for staff i.e. supervisors who do not have
                                              -- an entry in DP_SCORECARD.SCORECARD_ATTENDANCE_SCORE_SV
                                       select trunc(sysdate) from dual
                                        )
                                )
          and trunc(in_datetime) <= trunc(sysdate)
				));

       commit;

       --call procedure to recalculate running totals for this staff id
       --DP_SCORECARD.Calc_Attendance_Score(in_staff_id)
       --call procedure to populate monthly score table
       --DP_SCORECARD.Update_Sc_Attendance_Mthly(in_staff_id)

        DP_SCORECARD.Calc_Attendance_Score_PKG.CALC_ATTENDANCE_SCORE(in_staff_id);
		CALC_SPPL_LWOP_PKG.UPDATE_SC_AUDIT_SPPL_LWOP(IN_STAFF_ID);

   end if;

   close c1;

END;
/

SHOW ERRORS
COMMIT;