--------------------------------------------------------
--  DDL for Procedure Update_Attendance
--------------------------------------------------------

create or replace Procedure              Update_Attendance
   ( in_staff_id in number
   , in_sc_attendance_id in number
   , in_absence_type_id in number
   , in_NATIONAL_ID	in NUMBER 
   , in_waive_point_comments in VARCHAR2)

AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL: svn://rcmxapp1d.maximus.com/maxdat/BPM/NYHIX/ScoreCard/patch/20170929_1610_SC_ATTENDANCE_DDL_PRD3.sql $';
  	SVN_REVISION varchar2(20) := '$Revision: 21344 $';
 	SVN_REVISION_DATE varchar2(60) := '$Date: 2017-09-27 11:12:30 -0400 (Wed, 27 Sep 2017) $';
  	SVN_REVISION_AUTHOR varchar2(20) := '$Author: wl134672 $';

   v_all_id number;
   v_username varchar2(100);
   cursor c1 is
   select sc_all_id from DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP where absence_type='Delete';

BEGIN

   open c1;
   fetch c1 into v_all_id;

   if c1%notfound then
      v_all_id := NULL;
   end if;

   if  in_sc_attendance_id = 0 then
     /*do nothing*/
      null;
   else
      if (in_absence_type_id is not null) or (in_absence_type_id = v_all_id)
      then

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


          update dp_scorecard.sc_attendance
          set sc_all_id = in_absence_type_id,
              absence_type = (select absence_type from DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP where sc_all_id=in_absence_type_id),
              point_value = (select point_value from DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP where sc_all_id=in_absence_type_id),
              incentive_flag = (select incentive_flag from DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP where sc_all_id=in_absence_type_id),
              last_updated_by = v_username,
              LAST_UPDATED_DATETIME = sysdate,
              WAIVE_POINT_CMNTS = (case when LENGTH(TRIM(TRANSLATE(LTRIM(RTRIM(in_waive_point_comments)), ' +-.0123456789',' '))) = NULL then NULL else LTRIM(RTRIM(in_waive_point_comments)) end)
          where staff_id = in_staff_id and sc_attendance_id = in_sc_attendance_id;
      else
            if (in_absence_type_id is null)
             then

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


            update dp_scorecard.sc_attendance
            set last_updated_by = v_username,
              LAST_UPDATED_DATETIME = sysdate,
              WAIVE_POINT_CMNTS = (case when LENGTH(TRIM(TRANSLATE(LTRIM(RTRIM(in_waive_point_comments)), ' +-.0123456789',' '))) = NULL then NULL else LTRIM(RTRIM(in_waive_point_comments)) end)
            where staff_id = in_staff_id and sc_attendance_id = in_sc_attendance_id;
            else
          /*do nothing if a comment is not submitted with an update or user wants to perform a Delete*/
            null;
          end if;
      end if;

   end if;

   delete from dp_scorecard.sc_attendance where staff_id=in_staff_id and absence_type='Delete' ;

   commit;

   close c1;

   --call procedure to recalculate running totals for this staff id
   --DP_SCORECARD.Calc_Attendance_Score(in_staff_id);
   --call procedure to populate monthly score table
   --DP_SCORECARD.Update_Sc_Attendance_Mthly(in_staff_id)

   DP_SCORECARD.Calc_Attendance_Score_PKG.CALC_ATTENDANCE_SCORE(in_staff_id);

END;

/
