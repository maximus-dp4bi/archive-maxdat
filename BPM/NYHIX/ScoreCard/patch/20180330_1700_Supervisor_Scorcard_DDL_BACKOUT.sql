-- DROP VIEW DP_SCORECARD.SCORECARD_CORRECT_ACTION_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SCORECARD_CORRECT_ACTION_SV
(MANAGER_STAFF_ID, MANAGER_NAME, SUPERVISOR_STAFF_ID, SUPERVISOR_NAME, STAFF_STAFF_ID, 
 STAFF_STAFF_NAME, STAFF_NATID, CA_ID, CA_ENTRY_DATE, CAL_ID, 
 CORRECTION_ACTION_TYPE, UNSATISFACTORY_BEHAVIOR, COMMENTS, CREATE_BY, CREATE_DATETIME, 
 LAST_UPDATED_BY, LAST_UPDATED_DATETIME)
AS 
select
          sh.manager_staff_id,
          sh.manager_name,
          sh.supervisor_staff_id,
          sh.supervisor_name,
          sh.staff_staff_id,
          sh.staff_staff_name,
          sh.staff_natid,
          ca.ca_id,
          ca.ca_entry_date,
          ca.cal_id,
          cal.correction_action_type,
          ca.unsatisfactory_behavior,
          ca.comments,
          ca.create_by,
          ca.create_datetime,
          ca.last_updated_by,
          ca.LAST_UPDATED_DATETIME
      from dp_scorecard.sc_corrective_action ca
      join dp_scorecard.sc_corrective_action_lkup cal on ca.cal_id=cal.cal_id
      join dp_scorecard.scorecard_hierarchy sh on ca.staff_id=sh.staff_staff_id;


GRANT SELECT ON DP_SCORECARD.SCORECARD_CORRECT_ACTION_SV TO DP_SCORECARD_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SCORECARD_CORRECT_ACTION_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SCORECARD_CORRECT_ACTION_SV TO MAXDAT_REPORTS;

GRANT SELECT ON DP_SCORECARD.SCORECARD_CORRECT_ACTION_SV TO MAXDAT_READ_ONLY;


-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
DROP VIEW DP_SCORECARD.SCORECARD_GOAL_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SCORECARD_GOAL_SV
(MANAGER_STAFF_ID, MANAGER_NAME, SUPERVISOR_STAFF_ID, SUPERVISOR_NAME, STAFF_STAFF_ID, 
 STAFF_STAFF_NAME, STAFF_NATID, GOAL_ID, STAFF_ID, GOAL_ENTRY_DATE, 
 GTL_ID, GOAL_DESCRIPTION, GOAL_DATE, PROGRESS_NOTE, CREATE_BY, 
 CREATE_DATETIME, LAST_UPDATED_BY, LAST_UPDATED_DATETIME)
AS 
select
       sh.manager_staff_id,
       sh.manager_name,
       sh.supervisor_staff_id,
       sh.supervisor_name,
       sh.staff_staff_id,
       sh.staff_staff_name,
       sh.staff_natid,
       g.goal_id,
       g.staff_id,
       g.goal_entry_date,
       g.gtl_id,
       g.goal_description,
       g.goal_date,
       g.progress_note,
       g.create_by,
       g.create_datetime,
       g.last_updated_by,
       g.LAST_UPDATED_DATETIME
  from dp_scorecard.sc_goal g
  join dp_scorecard.sc_goal_type_lkup gtl on g.gtl_id=gtl.gtl_id
  join dp_scorecard.scorecard_hierarchy sh on g.staff_id=sh.staff_staff_id;


GRANT SELECT ON DP_SCORECARD.SCORECARD_GOAL_SV TO DP_SCORECARD_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SCORECARD_GOAL_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SCORECARD_GOAL_SV TO MAXDAT_REPORTS;

GRANT SELECT ON DP_SCORECARD.SCORECARD_GOAL_SV TO MAXDAT_READ_ONLY;

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
DROP VIEW DP_SCORECARD.SCORECARD_PERFORM_TRACKER_SV;

CREATE OR REPLACE FORCE VIEW DP_SCORECARD.SCORECARD_PERFORM_TRACKER_SV
(MANAGER_STAFF_ID, MANAGER_NAME, SUPERVISOR_STAFF_ID, SUPERVISOR_NAME, STAFF_STAFF_ID, 
 STAFF_STAFF_NAME, STAFF_NATID, PT_ID, PT_ENTRY_DATE, DL_ID, 
 DISCUSSION_TOPIC, COMMENTS, CREATE_BY, CREATE_DATETIME, LAST_UPDATED_BY, 
 LAST_UPDATED_DATETIME)
AS 
select
           sh.manager_staff_id,
           sh.manager_name,
           sh.supervisor_staff_id,
           sh.supervisor_name,
           sh.staff_staff_id,
           sh.staff_staff_name,
           sh.staff_natid,
           pt.pt_id,
           pt.pt_entry_date,
           pt.dl_id,
           dl.discussion_topic,
           pt.comments,
           pt.create_by,
           pt.create_datetime,
           pt.last_updated_by,
           pt.LAST_UPDATED_DATETIME
    from dp_scorecard.sc_performance_tracker pt
    join dp_scorecard.sc_discussion_lkup dl on pt.dl_id=dl.dl_id
    join dp_scorecard.scorecard_hierarchy sh on pt.staff_id=sh.staff_staff_id;


GRANT SELECT ON DP_SCORECARD.SCORECARD_PERFORM_TRACKER_SV TO DP_SCORECARD_READ_ONLY;

GRANT SELECT ON DP_SCORECARD.SCORECARD_PERFORM_TRACKER_SV TO MAXDAT;

GRANT SELECT ON DP_SCORECARD.SCORECARD_PERFORM_TRACKER_SV TO MAXDAT_REPORTS;

GRANT SELECT ON DP_SCORECARD.SCORECARD_PERFORM_TRACKER_SV TO MAXDAT_READ_ONLY;

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
CREATE OR REPLACE Procedure DP_SCORECARD.Insert_Attendance
   ( in_staff_id in number
   , in_absence_type_id in number
   , in_datetime in date
   , in_NATIONAL_ID	in NUMBER )

AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL: svn://rcmxapp1d.maximus.com/maxdat/BPM/NYHIX/ScoreCard/patch/20170929_1610_SC_ATTENDANCE_DDL_PRD3.sql $';
  	SVN_REVISION varchar2(20) := '$Revision: 21344 $';
 	SVN_REVISION_DATE varchar2(60) := '$Date: 2017-09-27 11:12:30 -0400 (Wed, 27 Sep 2017) $';
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
          where (trunc(in_datetime) >= (select min(dates)
                                        from DP_SCORECARD.SCORECARD_ATTENDANCE_SCORE_SV
                                        where staff_staff_id=in_staff_id
                                        and sc_attendance_id=0
                                        )
          and trunc(in_datetime) <= trunc(sysdate)));

       commit;

       --call procedure to recalculate running totals for this staff id
       --DP_SCORECARD.Calc_Attendance_Score(in_staff_id)
       --call procedure to populate monthly score table
       --DP_SCORECARD.Update_Sc_Attendance_Mthly(in_staff_id)

       DP_SCORECARD.Calc_Attendance_Score_PKG.CALC_ATTENDANCE_SCORE(in_staff_id);

   end if;

   close c1;

END;
/

GRANT EXECUTE ON DP_SCORECARD.Insert_Attendance TO MAXDAT;

GRANT EXECUTE ON DP_SCORECARD.Insert_Attendance TO MAXDAT_REPORTS;

GRANT DEBUG ON DP_SCORECARD.Insert_Attendance TO DP_SCORECARD_READ_ONLY;


