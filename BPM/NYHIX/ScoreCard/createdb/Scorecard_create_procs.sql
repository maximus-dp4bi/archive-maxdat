---Proc
create or replace Procedure              Calc_Attendance_Score
   ( in_staff_id IN number )

IS
   attendance_total number := 0;
   incentive_total number := 0;
   total number := 0;

   cursor c1 is
     select staff_staff_id,
              dates,
              point_value,
              sc_attendance_id,
              create_datetime,
              incentive_flag
         from DP_SCORECARD.SCORECARD_ATTENDANCE_SCORE_SV
         where staff_staff_id=in_staff_id
         order by dates, create_datetime;


BEGIN
  FOR RECS IN c1
  LOOP

      if RECS.sc_attendance_id = 0 then
           attendance_total := attendance_total + RECS.point_value;
           incentive_total  := incentive_total;
           total  := attendance_total + incentive_total;
      else
          if RECS.incentive_flag = 'Y' then
            if attendance_total=40 then
              attendance_total := attendance_total;
              incentive_total  := incentive_total + RECS.point_value;
              total  := attendance_total + incentive_total;

            else
              if attendance_total + RECS.point_value <= 40 then
                attendance_total := attendance_total + RECS.point_value;
                incentive_total  := incentive_total;
                total  := attendance_total + incentive_total;
              else
                incentive_total  := (attendance_total + RECS.point_value + incentive_total ) - 40 ;
                attendance_total := 40;
                total  := attendance_total + incentive_total;
              end if;
            end if;
          else
            if total + RECS.point_value > 40 then
              if RECS.point_value > 0 then
                incentive_total := incentive_total;
                attendance_total := 40;
                total := attendance_total + incentive_total;
              else
                incentive_total := (total-40) + RECS.point_value;
                attendance_total := 40;
                total := attendance_total + incentive_total;
              end if;
            else
              attendance_total := total + RECS.point_value;
              incentive_total  := 0;
              total  := attendance_total + incentive_total;
            end if;
            --Allow negative numbers
            /*if attendance_total < 0 then
              attendance_total := 0;
              total  := attendance_total + incentive_total;
            end if;*/
          end if;

          --running total cannot be less than 0pts
          update DP_SCORECARD.SC_ATTENDANCE
              set balance=attendance_total,
              incentive_balance=incentive_total,
              total_balance=total
              where staff_id = in_staff_id and sc_attendance_id = RECS.sc_attendance_id;

      end if;
  END LOOP;

  commit;

END;
/
    GRANT execute on DP_SCORECARD.Calc_Attendance_Score to MAXDAT_READ_ONLY;
    GRANT execute on DP_SCORECARD.Calc_Attendance_Score to MAXDAT;


---Proc
create or replace Procedure              Insert_Attendance
   ( in_staff_id in number
   , in_absence_type_id in number
   , in_datetime in date
   , in_NATIONAL_ID	in NUMBER )

AS

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
        SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE director_natid=in_NATIONAL_ID
        UNION
        SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE sr_manager_natid=in_NATIONAL_ID
        UNION
        SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE manager_natid=in_NATIONAL_ID
        UNION
        SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE supervisor_natid=in_NATIONAL_ID
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
          where (trunc(in_datetime) >= (select dates from DP_SCORECARD.SCORECARD_ATTENDANCE_SCORE_SV where staff_staff_id=in_staff_id and sc_attendance_id=0)
          and trunc(in_datetime) <= trunc(sysdate)));

       commit;

       --call procedure to recalculate running totals for this staff id
       DP_SCORECARD.Calc_Attendance_Score(in_staff_id);
       --call procedure to populate monthly score table
       DP_SCORECARD.Update_Sc_Attendance_Mthly(in_staff_id);

   end if;

   close c1;

END;
/

    GRANT execute on DP_SCORECARD.Insert_Attendance to MAXDAT_READ_ONLY;
    GRANT execute on DP_SCORECARD.Insert_Attendance to MAXDAT;

--Proc
create or replace Procedure              Update_Attendance
   ( in_staff_id in number
   , in_sc_attendance_id in number
   , in_absence_type_id in number
   , in_NATIONAL_ID	in NUMBER)

AS

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
      if (in_absence_type_id is not null) or (in_absence_type_id = v_all_id) then
          
          --get username
          select name into v_username from 
          (
            SELECT 'ADMIN' as NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE admin_id=in_NATIONAL_ID
            UNION
            SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE sr_director_natid=in_NATIONAL_ID
            UNION  
            SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE director_natid=in_NATIONAL_ID
            UNION
            SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE sr_manager_natid=in_NATIONAL_ID
            UNION
            SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE manager_natid=in_NATIONAL_ID
            UNION
            SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE supervisor_natid=in_NATIONAL_ID
          );         
          
          
          update dp_scorecard.sc_attendance
          set sc_all_id = in_absence_type_id,
              absence_type = (select absence_type from DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP where sc_all_id=in_absence_type_id),
              point_value = (select point_value from DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP where sc_all_id=in_absence_type_id),
              incentive_flag = (select incentive_flag from DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP where sc_all_id=in_absence_type_id),
              last_updated_by = v_username,
              LAST_UPDATED_DATETIME = sysdate
          where staff_id = in_staff_id and sc_attendance_id = in_sc_attendance_id;
      else
          /*do nothing if a comment is not submitted with an update or user wants to perform a Delete*/
          null;
      end if;

   end if;

   delete from dp_scorecard.sc_attendance where staff_id=in_staff_id and absence_type='Delete' ;

   commit;

   close c1;

   --call procedure to recalculate running totals for this staff id
   DP_SCORECARD.Calc_Attendance_Score(in_staff_id);
   --call procedure to populate monthly score table
   DP_SCORECARD.Update_Sc_Attendance_Mthly(in_staff_id);

END;
/

    GRANT execute on DP_SCORECARD.Update_Attendance to MAXDAT_READ_ONLY;
    GRANT execute on DP_SCORECARD.Update_Attendance to MAXDAT;
GRANT execute ON DP_SCORECARD.Update_Attendance TO MAXDAT_MSTR_TRX_RPT;

---Grants - to allow MSTR Transactions to perform U,D,I
  

  

---Proc
create or replace Procedure              Insert_Corrective_Action
   ( in_staff_id in number
   , in_corrective_action_id in number
   , in_unsatisfactory_behavior in varchar2
   , in_comments in varchar2
   , in_date in date
   , in_NATIONAL_ID	in NUMBER )

AS
   v_username varchar2(100);
BEGIN

   if  in_staff_id is null or in_corrective_action_id is null or in_date is null or in_unsatisfactory_behavior is null 
     or in_comments is null or in_NATIONAL_ID is null or trunc(in_date) > trunc(sysdate) then
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
        SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE director_natid=in_NATIONAL_ID
        UNION
        SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE sr_manager_natid=in_NATIONAL_ID
        UNION
        SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE manager_natid=in_NATIONAL_ID
        UNION
        SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE supervisor_natid=in_NATIONAL_ID
      );
   
      insert into dp_scorecard.sc_corrective_action
        (ca_id,
         staff_id,
         ca_entry_date,
         cal_id,
         unsatisfactory_behavior,
         comments,
         create_by,
         create_datetime, 
         last_updated_by, 
         LAST_UPDATED_DATETIME)
      values
        (SEQ_SCCA_ID.Nextval,
         in_staff_id,
         TRUNC(in_date),
         in_corrective_action_id,
         in_unsatisfactory_behavior,
         in_comments,
         v_username,
         SYSDATE,
         v_username,
         sysdate);

       commit;

   end if;

END;
/

GRANT execute on DP_SCORECARD.Insert_Corrective_Action to MAXDAT_READ_ONLY;  
GRANT execute on DP_SCORECARD.Insert_Corrective_Action to MAXDAT;  
GRANT execute ON DP_SCORECARD.Insert_Corrective_Action TO MAXDAT_MSTR_TRX_RPT;

---Proc
create or replace Procedure              Insert_Performance_Tracker
   ( in_staff_id in number
   , in_dl_id in number
   , in_comments in varchar2
   , in_date in date
   , in_NATIONAL_ID	in NUMBER )

AS
   v_username varchar2(100);
BEGIN

   if  in_staff_id is null or in_dl_id is null or in_date is null or in_comments is null or in_NATIONAL_ID is null 
     or trunc(in_date) > trunc(sysdate) then
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
        SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE director_natid=in_NATIONAL_ID
        UNION
        SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE sr_manager_natid=in_NATIONAL_ID
        UNION
        SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE manager_natid=in_NATIONAL_ID
        UNION
        SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE supervisor_natid=in_NATIONAL_ID
      );

      insert into dp_scorecard.sc_performance_tracker
        (pt_id, staff_id, pt_entry_date, dl_id, comments, create_by, create_datetime, last_updated_by, LAST_UPDATED_DATETIME)
      values
        (SEQ_SCPT_ID.Nextval,
         in_staff_id,
         TRUNC(in_date),
         in_dl_id,
         in_comments,
         v_username,
         SYSDATE,
         v_username,
         SYSDATE);

       commit;

   end if;

END;
/

GRANT execute on DP_SCORECARD.Insert_Performance_Tracker to MAXDAT_READ_ONLY;  
GRANT execute on DP_SCORECARD.Insert_Performance_Tracker to MAXDAT;  
GRANT execute ON DP_SCORECARD.Insert_Performance_Tracker TO MAXDAT_MSTR_TRX_RPT;

create or replace Procedure              Update_Corrective_Action
   ( in_staff_id in number
   , in_ca_id in number
   , in_unsatisfactory_behavior in varchar2
   , in_comments in varchar2
   , in_delete_flag in number
   , in_NATIONAL_ID	in NUMBER)

AS
   v_username varchar2(100);
BEGIN

   if in_delete_flag = 1 then
     delete from dp_scorecard.sc_corrective_action where staff_id=in_staff_id and ca_id = in_ca_id;
     commit;
   elsif  length(in_unsatisfactory_behavior) is NULL and length(in_comments) is NULL then
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
        SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE director_natid=in_NATIONAL_ID
        UNION
        SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE sr_manager_natid=in_NATIONAL_ID
        UNION
        SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE manager_natid=in_NATIONAL_ID
        UNION
        SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE supervisor_natid=in_NATIONAL_ID
      );             
       
       
       update dp_scorecard.sc_corrective_action
          set unsatisfactory_behavior = case
                                          when (length(in_unsatisfactory_behavior) > 0) then
                                           in_unsatisfactory_behavior
                                          else
                                           unsatisfactory_behavior
                                        end,
              comments = case
                           when (length(in_comments) > 0) then
                            in_comments
                           else
                            comments
                         end,
              last_updated_by = v_username,
              LAST_UPDATED_DATETIME = sysdate
        where ca_id = in_ca_id;

       commit;

   end if;

END;
/


GRANT execute on DP_SCORECARD.Update_Corrective_Action to MAXDAT_READ_ONLY;  
GRANT execute on DP_SCORECARD.Update_Corrective_Action to MAXDAT;  
GRANT execute ON DP_SCORECARD.Update_Corrective_Action TO MAXDAT_MSTR_TRX_RPT;

create or replace Procedure              Update_Performance_Tracker
   ( in_staff_id in number
   , in_pt_id in number
   , in_comments in varchar2
   , in_delete_flag in number
   , in_NATIONAL_ID	in NUMBER)

AS
   v_username varchar2(100);
BEGIN

   if in_delete_flag = 1 then
     delete from dp_scorecard.sc_performance_tracker where staff_id=in_staff_id and pt_id = in_pt_id;
     commit;
   elsif  length(in_comments) is NULL then
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
          SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE director_natid=in_NATIONAL_ID
          UNION
          SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE sr_manager_natid=in_NATIONAL_ID
          UNION
          SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE manager_natid=in_NATIONAL_ID
          UNION
          SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE supervisor_natid=in_NATIONAL_ID
        );        
       
       update dp_scorecard.sc_performance_tracker
          set comments = in_comments,
              last_updated_by = v_username,
              LAST_UPDATED_DATETIME = sysdate
        where pt_id = in_pt_id;

       commit;

   end if;

END;
/

GRANT execute ON DP_SCORECARD.Insert_Goal TO MAXDAT_MSTR_TRX_RPT;
GRANT execute on DP_SCORECARD.Insert_Goal to MAXDAT_READ_ONLY;  
GRANT execute on DP_SCORECARD.Insert_Goal to MAXDAT;  

create or replace Procedure              Update_Goal
   ( in_staff_id in number
   , in_goal_id in number
   , in_goal_description in varchar2
   , in_progress_note in varchar2
   , in_delete_flag in number
   , in_NATIONAL_ID	in NUMBER)

AS
   v_username varchar2(100);
BEGIN

   if in_delete_flag = 1 then
     delete from dp_scorecard.sc_goal where staff_id=in_staff_id and goal_id = in_goal_id;
     commit;
   elsif  length(in_goal_description) is NULL and length(in_progress_note) is NULL then
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
        SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE director_natid=in_NATIONAL_ID
        UNION
        SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE sr_manager_natid=in_NATIONAL_ID
        UNION
        SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE manager_natid=in_NATIONAL_ID
        UNION
        SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE supervisor_natid=in_NATIONAL_ID
      );               
       
       update dp_scorecard.sc_goal
          set goal_description = case
                                      when (length(in_goal_description) > 0) then
                                       in_goal_description
                                      else
                                       goal_description
                                    end,
              progress_note = case
                                 when (length(in_progress_note) > 0) then
                                  in_progress_note
                                 else
                                  progress_note
                               end,
              last_updated_by = v_username,
              LAST_UPDATED_DATETIME = sysdate
        where goal_id = in_goal_id;

       commit;

   end if;

END;
/

GRANT execute on DP_SCORECARD.Update_Goal to MAXDAT_READ_ONLY;  
GRANT execute on DP_SCORECARD.Update_Goal to MAXDAT;  
  GRANT execute ON DP_SCORECARD.Update_Goal TO MAXDAT_MSTR_TRX_RPT;
 

-- Create Proc to load Scorecard_Hierarchy
CREATE OR REPLACE PROCEDURE LOAD_SCORECARD_HIERARCHY 
AS 
BEGIN
delete scorecard_hierarchy where 1=1;
commit;

insert into scorecard_hierarchy ("ADMIN_ID", "SR_DIRECTOR_NAME", "SR_DIRECTOR_STAFF_ID", "SR_DIRECTOR_NATID", "DIRECTOR_NAME", "DIRECTOR_STAFF_ID", "DIRECTOR_NATID", "SR_MANAGER_NAME", "SR_MANAGER_STAFF_ID", "SR_MANAGER_NATID", "MANAGER_NAME", "MANAGER_STAFF_ID", "MANAGER_NATID", "SUPERVISOR_NAME", "SUPERVISOR_STAFF_ID", "SUPERVISOR_NATID", "STAFF_STAFF_ID", "STAFF_STAFF_NAME", "STAFF_NATID", "HIRE_DATE", "POSITION", "OFFICE", "TERMINATION_DATE") 
  with sr_directors as
(
select staff_id as sr_director_staff_id, national_id as sr_director_natid, (LAST_NAME||', '|| FIRST_NAME) as sr_director_name from maxdat.pp_wfm_staff_sv where staff_id in (
select staff_id
  from dp_scorecard.pp_wfm_job_classification_sv
 where job_classification_code_id in
       (select job_classification_code_id
          from dp_scorecard.pp_wfm_job_class_code_sv
         where code in ('Sr. Director'))
   and trunc(sysdate) between start_date and
       nvl(end_date, to_date('07/07/2077', 'mm/dd/yyyy')))
--       and termination_date is null
)
, directors as
(
select staff_id as director_staff_id, national_id as director_natid, (LAST_NAME||', '|| FIRST_NAME) as director_name from maxdat.pp_wfm_staff_sv where staff_id in (
select staff_id
  from dp_scorecard.pp_wfm_job_classification_sv
 where job_classification_code_id in
       (select job_classification_code_id
          from dp_scorecard.pp_wfm_job_class_code_sv
         where code in ('Director'))
   and trunc(sysdate) between start_date and
       nvl(end_date, to_date('07/07/2077', 'mm/dd/yyyy')))
--       and termination_date is null
)
, sr_managers as
(
select staff_id as sr_manager_staff_id, national_id as sr_manager_natid, (LAST_NAME||', '|| FIRST_NAME) as sr_manager_name from maxdat.pp_wfm_staff_sv where staff_id in (
select staff_id
  from dp_scorecard.pp_wfm_job_classification_sv
 where job_classification_code_id in
       (select job_classification_code_id
          from dp_scorecard.pp_wfm_job_class_code_sv
         where code in ('Sr. Manager'))
   and trunc(sysdate) between start_date and
       nvl(end_date, to_date('07/07/2077', 'mm/dd/yyyy')))
--       and termination_date is null
)
, managers as
(
select staff_id as manager_staff_id, national_id as manager_natid, (LAST_NAME||', '|| FIRST_NAME) as manager_name from maxdat.pp_wfm_staff_sv where staff_id in (
select staff_id
  from dp_scorecard.pp_wfm_job_classification_sv
 where job_classification_code_id in
       (select job_classification_code_id
          from dp_scorecard.pp_wfm_job_class_code_sv
         where job_classification_code_id in (1057,1018,1044))--'Manager','CC Management','Enrollment & Eligibility Operations Manager'
   and trunc(sysdate) between start_date and
       nvl(end_date, to_date('07/07/2077', 'mm/dd/yyyy')))
--       and termination_date is null
)
, supervisors as
(
select staff_id as supervisor_staff_id, national_id as supervisor_natid, (LAST_NAME||', '|| FIRST_NAME) as supervisor_name  from maxdat.pp_wfm_staff_sv where staff_id in (
select staff_id
  from dp_scorecard.pp_wfm_job_classification_sv
 where job_classification_code_id in
       (select job_classification_code_id
          from dp_scorecard.pp_wfm_job_class_code_sv
         where job_classification_code_id in (1058,1031)) --'Supervisor','E&E Supervisor'
   and trunc(sysdate) between start_date and
       nvl(end_date, to_date('07/07/2077', 'mm/dd/yyyy')))
--       and termination_date is null
)
, srdir_to_dir as
(
--sr director to director
select srdirs.sr_director_name, srdirs.sr_director_staff_id, srdirs.sr_director_natid, dirs.director_name, dirs.director_staff_id, dirs.director_natid
from maxdat.pp_wfm_supervisor_to_staff_sv sts
join sr_directors srdirs on sts.supervisor_id=srdirs.sr_director_staff_id
join directors dirs on sts.staff_id=dirs.director_staff_id
where sts.end_date is null
)
, dir_to_srmgr as
(
--director to sr manager
select dirs.director_name, dirs.director_staff_id, dirs.director_natid, srmgrs.sr_manager_name, srmgrs.sr_manager_staff_id, srmgrs.sr_manager_natid
from maxdat.pp_wfm_supervisor_to_staff_sv sts
join directors dirs on sts.supervisor_id=dirs.director_staff_id
join sr_managers srmgrs on sts.staff_id=srmgrs.sr_manager_staff_id
where sts.end_date is null
)
, srmgr_to_mgr as
(
--sr manager to manager
select
srmgrs.sr_manager_name, srmgrs.sr_manager_staff_id, srmgrs.sr_manager_natid, mgrs.manager_name, mgrs.manager_staff_id, mgrs.manager_natid
from maxdat.pp_wfm_supervisor_to_staff_sv sts
join sr_managers srmgrs on sts.supervisor_id=srmgrs.sr_manager_staff_id
join managers mgrs on sts.staff_id=mgrs.manager_staff_id
where sts.end_date is null
)
, mgr_to_sup as
(
--manager to supervisor
select mgrs.manager_name, mgrs.manager_staff_id, mgrs.manager_natid, sups.supervisor_name, sups.supervisor_staff_id, sups.supervisor_natid
from maxdat.pp_wfm_supervisor_to_staff_sv sts
join managers mgrs on sts.supervisor_id=mgrs.manager_staff_id
join supervisors sups on sts.staff_id=sups.supervisor_staff_id
where sts.end_date is null
)
, sup_to_staff as
(
SELECT
S.staff_id as staff_staff_id,
S.NATIONAL_ID as staff_natid,
S.LAST_NAME||', '||S.FIRST_NAME as staff_staff_name,
S.HIRE_DATE,
S.TERMINATION_DATE,
JC.CODE POSITION,
O.NAME OFFICE,
S1.STAFF_ID as supervisor_staff_id,
S1.NATIONAL_ID as supervisor_natid,
S1.LAST_NAME||', '||S1.FIRST_NAME as supervisor_name/*,
S1.HIRE_DATE,
JC1.CODE SUP_POSITION*/
FROM MAXDAT.PP_WFM_STAFF_SV S
LEFT JOIN DP_SCORECARD.PP_WFM_JOB_CLASSIFICATION_SV J ON S.STAFF_ID = J.STAFF_ID
LEFT JOIN DP_SCORECARD.PP_WFM_JOB_CLASS_CODE_SV JC ON J.JOB_CLASSIFICATION_CODE_ID = JC.JOB_CLASSIFICATION_CODE_ID
LEFT JOIN DP_SCORECARD.PP_WFM_STAFF_TO_OFFICE_SV SO ON (S.STAFF_ID = SO.STAFF_ID AND SO.END_DATE IS NULL)
LEFT JOIN DP_SCORECARD.PP_WFM_OFFICE_SV O ON SO.OFFICE_ID = O.OFFICE_ID
LEFT JOIN MAXDAT.PP_WFM_SUPERVISOR_TO_STAFF_SV ST ON S.STAFF_ID = ST.STAFF_ID
LEFT JOIN MAXDAT.PP_WFM_STAFF_SV S1 ON ST.SUPERVISOR_ID = S1.STAFF_ID
--LEFT JOIN DP_SCORECARD.PP_WFM_JOB_CLASSIFICATION_SV J1 ON S1.STAFF_ID = J1.STAFF_ID
--LEFT JOIN DP_SCORECARD.PP_WFM_JOB_CLASS_CODE_SV JC1 ON J1.JOB_CLASSIFICATION_CODE_ID = JC1.JOB_CLASSIFICATION_CODE_ID
WHERE J.END_DATE IS NULL
--AND J1.END_DATE IS NULL
AND ST.END_DATE IS NULL
AND JC.JOB_CLASSIFICATION_CODE_ID IN ('1059','1054','1053','1024','1011','1010','1009','1008','1043','1019','1013','1012','1056','1047','1028','1025','1061','1032','1033','1060','1039','1063','1038','1037','1035','1052','1030','1022','1020','1046','1055','1026','1023','1027','1045','1051','1050','1049','1048','1017','1016','1015','1014')
--AND (S.TERMINATION_DATE IS NULL or S.TERMINATION_DATE > TRUNC(SYSDATE))
)
select 999 as admin_id, --created an admin level in the hierarchy so that user id 999 in MicroStrategy can see all managers
       sdtd.sr_director_name,
       sdtd.sr_director_staff_id,
       sdtd.sr_director_natid,
       dts.director_name,
       dts.director_staff_id,
       dts.director_natid,
       dts.sr_manager_name,
       dts.sr_manager_staff_id,
       dts.sr_manager_natid,
       stm.manager_name,
       stm.manager_staff_id,
       stm.manager_natid,
       mts.supervisor_name,
       mts.supervisor_staff_id,
       mts.supervisor_natid,
       sts.staff_staff_id,
       sts.staff_staff_name,
       sts.staff_natid,
       sts.hire_date,
       sts.position,
       sts.office,
       sts.termination_date
  from srdir_to_dir sdtd
  left outer join dir_to_srmgr dts on sdtd.director_staff_id = dts.director_staff_id
  left outer join  srmgr_to_mgr stm
    on dts.sr_manager_staff_id = stm.sr_manager_staff_id
  left outer join  mgr_to_sup mts
    on stm.manager_staff_id = mts.manager_staff_id
  left outer join  sup_to_staff sts
    on mts.supervisor_staff_id = sts.supervisor_staff_id
  order by
  sdtd.sr_director_name,
       dts.director_name,
       dts.sr_manager_name,
       stm.manager_name,
       mts.supervisor_name,
       sts.staff_staff_name
;
commit;
END LOAD_SCORECARD_HIERARCHY;
/

grant execute on load_scorecard_hierarchy to MAXDAT_READ_ONLY;  
 grant execute on load_scorecard_hierarchy to MAXDAT;  
grant execute on load_scorecard_hierarchy to MAXDAT_MSTR_TRX_RPT;

create or replace Procedure              Insert_sc_exclusion
   ( in_SUPERVISOR_ID	in NUMBER
   , in_AGENT_ID	in NUMBER
   , in_STAFF_ID	in NUMBER
   , in_EXCLUSION_DATE	in DATE
   , in_EXCLUSION_FLAG	in VARCHAR2
   , in_EXCLUSION_COMMENT	in VARCHAR2
   , in_CREATE_DATE	in DATE
   , in_CREATE_BY	in NUMBER )
AS
v_create_date date ;

BEGIN

   if  in_supervisor_id is null or in_exclusion_date is null or in_exclusion_flag is null or in_create_by is null
      then
     /*do nothing*/
      null;
   else

    if in_create_date is null 
    then v_create_date := sysdate;
    else v_create_date := in_create_date;
    end if;

      insert into dp_scorecard.sc_exclusion
        (EXCLUSION_ID
         , SUPERVISOR_ID
         , AGENT_ID
         , STAFF_ID
         , EXCLUSION_DATE
         , EXCLUSION_FLAG
         , EXCLUSION_COMMENT
         , CREATE_DATE
         , CREATE_BY)
      values
        (SEQ_SCE_ID.nextval
         , in_SUPERVISOR_ID
         , in_AGENT_ID
         , in_STAFF_ID
         , in_EXCLUSION_DATE
         , in_EXCLUSION_FLAG
         , in_EXCLUSION_COMMENT
         , v_create_date
         , in_CREATE_BY);

       commit;

   end if;

END;
/

grant execute ON Insert_sc_exclusion TO MAXDAT_MSTR_TRX_RPT;
grant execute ON Insert_sc_exclusion TO MAXDAT;
grant execute ON Insert_sc_exclusion TO MAXDAT_READ_ONLY;

create or replace procedure              UPDATE_SC_ATTENDANCE_MTHLY
(in_staff_id IN NUMBER default null)
AS

begin

if in_staff_id is null then
    Delete from scorecard_attendance_mthly;
    commit;
    
    insert INTO scorecard_attendance_mthly (MANAGER_STAFF_ID, MANAGER_NAME, SUPERVISOR_STAFF_ID, SUPERVISOR_NAME, STAFF_STAFF_ID, STAFF_STAFF_NAME, DATES_MONTH, DATES_MONTH_NUM, DATES_YEAR, BALANCE, TOTAL_BALANCE, SC_ATTENDANCE_ID)
    with all_recs as
    (
    select manager_staff_id,
           manager_name,
           supervisor_staff_id,
           supervisor_name,
           staff_staff_id,
           staff_staff_name,
           dates,
           to_char(dates, 'Month') as dates_month,
           to_char(dates, 'YYYYMM') as dates_month_num,
           to_char(dates, 'Month YYYY') as dates_year,
           balance,
           total_balance,
           sc_attendance_id,
           create_datetime,
           rownum as rn
      from dp_scorecard.scorecard_attendance_score_sv
      order by staff_staff_id, dates_month_num, create_datetime
    ),
    ranked as
    (
    select manager_staff_id,
           manager_name,
           supervisor_staff_id,
           supervisor_name,
           staff_staff_id,
           staff_staff_name,
           dates,
           dates_month,
           dates_month_num,
           dates_year,
           balance,
           total_balance,
           sc_attendance_id,
           create_datetime,
           rn
      from (select manager_staff_id,
                   manager_name,
                   supervisor_staff_id,
                   supervisor_name,
                   staff_staff_id,
                   staff_staff_name,
                   dates,
                   dates_month,
                   dates_month_num,
                   dates_year,
                   balance,
                   total_balance,
                   sc_attendance_id,
                   create_datetime,
                   rn,
                   rank() over(partition by staff_staff_id, dates_month_num order by rn desc) as rnk
              from all_recs) y
    where y.rnk = 1
    ),
    just_months as
    (
         SELECT
          to_char(add_months (trunc (to_date('01/01/2012','MM/DD/YYYY'), 'MM'), 1*Level -1), 'MM/DD/YYYY') as dates,
          to_char(add_months (trunc (to_date('01/01/2012','MM/DD/YYYY'), 'MM'), 1*Level -1), 'Month') as dates_month,
          to_char(add_months (trunc (to_date('01/01/2012','MM/DD/YYYY'), 'MM'), 1*Level -1), 'YYYYMM') as dates_month_num,
          to_char(add_months (trunc (to_date('01/01/2012','MM/DD/YYYY'), 'MM'), 1*Level -1), 'Month YYYY') as dates_year,
          0 as balance,
          0 as total_balance,
          -1 as sc_attendance_id,
          0 as rn
        FROM Dual
        CONNECT BY Level <= MONTHS_BETWEEN(trunc(SYSDATE), to_date('01/01/2012','MM/DD/YYYY')) + 1
    ),
    combined as
    (
      select r.manager_staff_id,
             r.manager_name,
             r.supervisor_staff_id,
             r.supervisor_name,
             r.staff_staff_id,
             r.staff_staff_name,
             jm.dates_month,
             jm.dates_month_num,
             jm.dates_year,
             jm.balance,
             jm.total_balance,
             jm.sc_attendance_id,
             jm.rn from ranked r, just_months jm
             where jm.dates_month_num <> r.dates_month_num
      union
      select manager_staff_id,
             manager_name,
             supervisor_staff_id,
             supervisor_name,
             staff_staff_id,
             staff_staff_name,
             dates_month,
             dates_month_num,
             dates_year,
             balance,
             total_balance,
             sc_attendance_id,
             rn
           from ranked
           order by staff_staff_id, dates_month_num
    ),
    lead_balance as
    (
    select manager_staff_id,
           manager_name,
           supervisor_staff_id,
           supervisor_name,
           staff_staff_id,
           staff_staff_name,
           to_number(dates_month_num) as dates_month_num,
           balance,
           total_balance,
           to_number(coalesce(lead (dates_month_num,1) over (partition by staff_staff_id ORDER BY staff_staff_id, dates_month_num ),'207707')) AS end_dates_month_num
    from ranked
    ),
    rolled_balances as
    (
    select c.manager_staff_id,
           c.manager_name,
           c.supervisor_staff_id,
           c.supervisor_name,
           c.staff_staff_id,
           c.staff_staff_name,
           c.dates_month,
           c.dates_month_num,
           c.dates_year,
           coalesce((select balance
                      from lead_balance
                     where staff_staff_id = c.staff_staff_id
                       and (to_number(c.dates_month_num) >= dates_month_num and
                           to_number(c.dates_month_num) < end_dates_month_num)),
                    0) as balance,
           coalesce((select total_balance
                      from lead_balance
                     where staff_staff_id = c.staff_staff_id
                       and (to_number(c.dates_month_num) >= dates_month_num and
                           to_number(c.dates_month_num) < end_dates_month_num)),
                    0) as total_balance,
           --c.total_balance as original_balance,
           c.sc_attendance_id,
           c.rn
      from combined c
     where c.dates_month_num in
           (select to_number(dates_month_num)
              from just_months
             where to_date(dates, 'mm/dd/yyyy') >= trunc(sysdate - 365))
    )
    select
           manager_staff_id,
           manager_name,
           supervisor_staff_id,
           supervisor_name,
           staff_staff_id,
           staff_staff_name,
           dates_month,
           dates_month_num,
           dates_year,
           balance, --case when balance=0 then 40 else balance end as balance,
           total_balance, --case when total_balance=0 then 40 else total_balance end as total_balance,
           sc_attendance_id
           from
           (
              select manager_staff_id,
                     manager_name,
                     supervisor_staff_id,
                     supervisor_name,
                     staff_staff_id,
                     staff_staff_name,
                     dates_month,
                     dates_month_num,
                     dates_year,
                     balance,
                     total_balance,
                     sc_attendance_id,
                     rn,
                     rank() over(partition by staff_staff_id, dates_month_num order by sc_attendance_id desc) as rnk
                from rolled_balances
             ) where rnk=1 order by staff_staff_id, dates_month_num;
else
      Delete from scorecard_attendance_mthly
      where staff_staff_id = in_staff_id;   
    
    insert INTO scorecard_attendance_mthly (MANAGER_STAFF_ID, MANAGER_NAME, SUPERVISOR_STAFF_ID, SUPERVISOR_NAME, STAFF_STAFF_ID, STAFF_STAFF_NAME, DATES_MONTH, DATES_MONTH_NUM, DATES_YEAR, BALANCE, TOTAL_BALANCE, SC_ATTENDANCE_ID)
    with all_recs as
    (
    select manager_staff_id,
           manager_name,
           supervisor_staff_id,
           supervisor_name,
           staff_staff_id,
           staff_staff_name,
           dates,
           to_char(dates, 'Month') as dates_month,
           to_char(dates, 'YYYYMM') as dates_month_num,
           to_char(dates, 'Month YYYY') as dates_year,
           balance,
           total_balance,
           sc_attendance_id,
           create_datetime,
           rownum as rn
      from dp_scorecard.scorecard_attendance_score_sv
      where staff_staff_id = in_staff_id
      order by staff_staff_id, dates_month_num, create_datetime
    ),
    ranked as
    (
    select manager_staff_id,
           manager_name,
           supervisor_staff_id,
           supervisor_name,
           staff_staff_id,
           staff_staff_name,
           dates,
           dates_month,
           dates_month_num,
           dates_year,
           balance,
           total_balance,
           sc_attendance_id,
           create_datetime,
           rn
      from (select manager_staff_id,
                   manager_name,
                   supervisor_staff_id,
                   supervisor_name,
                   staff_staff_id,
                   staff_staff_name,
                   dates,
                   dates_month,
                   dates_month_num,
                   dates_year,
                   balance,
                   total_balance,
                   sc_attendance_id,
                   create_datetime,
                   rn,
                   rank() over(partition by staff_staff_id, dates_month_num order by rn desc) as rnk
              from all_recs) y
    where y.rnk = 1
    ),
    just_months as
    (
         SELECT
          to_char(add_months (trunc (to_date('01/01/2012','MM/DD/YYYY'), 'MM'), 1*Level -1), 'MM/DD/YYYY') as dates,
          to_char(add_months (trunc (to_date('01/01/2012','MM/DD/YYYY'), 'MM'), 1*Level -1), 'Month') as dates_month,
          to_char(add_months (trunc (to_date('01/01/2012','MM/DD/YYYY'), 'MM'), 1*Level -1), 'YYYYMM') as dates_month_num,
          to_char(add_months (trunc (to_date('01/01/2012','MM/DD/YYYY'), 'MM'), 1*Level -1), 'Month YYYY') as dates_year,
          0 as balance,
          0 as total_balance,
          -1 as sc_attendance_id,
          0 as rn
        FROM Dual
        CONNECT BY Level <= MONTHS_BETWEEN(trunc(SYSDATE), to_date('01/01/2012','MM/DD/YYYY')) + 1
    ),
    combined as
    (
      select r.manager_staff_id,
             r.manager_name,
             r.supervisor_staff_id,
             r.supervisor_name,
             r.staff_staff_id,
             r.staff_staff_name,
             jm.dates_month,
             jm.dates_month_num,
             jm.dates_year,
             jm.balance,
             jm.total_balance,
             jm.sc_attendance_id,
             jm.rn from ranked r, just_months jm
             where jm.dates_month_num <> r.dates_month_num
      union
      select manager_staff_id,
             manager_name,
             supervisor_staff_id,
             supervisor_name,
             staff_staff_id,
             staff_staff_name,
             dates_month,
             dates_month_num,
             dates_year,
             balance,
             total_balance,
             sc_attendance_id,
             rn
           from ranked
           order by staff_staff_id, dates_month_num
    ),
    lead_balance as
    (
    select manager_staff_id,
           manager_name,
           supervisor_staff_id,
           supervisor_name,
           staff_staff_id,
           staff_staff_name,
           to_number(dates_month_num) as dates_month_num,
           balance,
           total_balance,
           to_number(coalesce(lead (dates_month_num,1) over (partition by staff_staff_id ORDER BY staff_staff_id, dates_month_num ),'207707')) AS end_dates_month_num
    from ranked
    ),
    rolled_balances as
    (
    select c.manager_staff_id,
           c.manager_name,
           c.supervisor_staff_id,
           c.supervisor_name,
           c.staff_staff_id,
           c.staff_staff_name,
           c.dates_month,
           c.dates_month_num,
           c.dates_year,
           coalesce((select balance
                      from lead_balance
                     where staff_staff_id = c.staff_staff_id
                       and (to_number(c.dates_month_num) >= dates_month_num and
                           to_number(c.dates_month_num) < end_dates_month_num)),
                    0) as balance,
           coalesce((select total_balance
                      from lead_balance
                     where staff_staff_id = c.staff_staff_id
                       and (to_number(c.dates_month_num) >= dates_month_num and
                           to_number(c.dates_month_num) < end_dates_month_num)),
                    0) as total_balance,
           --c.total_balance as original_balance,
           c.sc_attendance_id,
           c.rn
      from combined c
     where c.dates_month_num in
           (select to_number(dates_month_num)
              from just_months
             where to_date(dates, 'mm/dd/yyyy') >= trunc(sysdate - 365))
    )
    select
           manager_staff_id,
           manager_name,
           supervisor_staff_id,
           supervisor_name,
           staff_staff_id,
           staff_staff_name,
           dates_month,
           dates_month_num,
           dates_year,
           balance, --case when balance=0 then 40 else balance end as balance,
           total_balance, --case when total_balance=0 then 40 else total_balance end as total_balance,
           sc_attendance_id
           from
           (
              select manager_staff_id,
                     manager_name,
                     supervisor_staff_id,
                     supervisor_name,
                     staff_staff_id,
                     staff_staff_name,
                     dates_month,
                     dates_month_num,
                     dates_year,
                     balance,
                     total_balance,
                     sc_attendance_id,
                     rn,
                     rank() over(partition by staff_staff_id, dates_month_num order by sc_attendance_id desc) as rnk
                from rolled_balances
             ) where rnk=1 order by staff_staff_id, dates_month_num;
end if;
commit;
end update_sc_attendance_mthly;
/

grant execute ON update_sc_attendance_mthly TO MAXDAT_MSTR_TRX_RPT;
grant execute on update_sc_attendance_mthly to MAXDAT;
grant execute on update_sc_attendance_mthly to MAXDAT_READ_ONLY;

CREATE OR REPLACE procedure DP_SCORECARD.LOAD_SC_SUMMARY_CC
AS

begin

    Delete from SC_SUMMARY_CC;
    commit;
    
insert into SC_SUMMARY_CC (staff_staff_id,
   staff_staff_name,
   dates_month,
   dates_month_num,
   dates_year,
   EXCLUSION_FLAG,
   TOT_CALLS_ANSWERED,
   TOT_SHORT_CALLS_ANSWERED,
   TOT_TOT_RETURN_TO_QUEUE,
   TOT_AVERAGE_HANDLE_TIME,
   TOT_SCHED_PRODUCTIVE_TIME,
   TOT_ACTUAL_PRODUCTIVE_TIME,
   TOT_TALK_TIME,
   TOT_WRAP_UP_TIME,
   TOT_LOGGED_IN_TIME,
   TOT_NOT_READY_TIME,
   TOT_BREAK_TIME,
   TOT_LUNCH_TIME,
   qcs_performed,
   avg_qc_score,
   TOT_INCIDENTS_COMPLETED,
   DAYS_INCIDENTS_COMPLETED,
   TOT_DEFECTS_COMPLETED,
   DAYS_DEFECTS_COMPLETED,
   LAG_TIME_TOT_SCHED_PROD_TIME,
   TOT_CALL_RECORDS,
   TOT_CUSTOMER_COUNT,
   TOT_CALL_WRAP_UP_COUNT,
   TOT_WRAP_UP_ERROR,
   Days_Short_Calls_GT_10,
   DAYS_CALLS_ANSWERED
   )

WITH TIME_metrics as
 (
   SELECT 
       to_char(TRUNC(a11.AS_DATE), 'YYYYMM') as dates_month_num,
      to_char(TRUNC(a11.AS_DATE), 'Month YYYY') as dates_year,
      to_char(AGENT_ID) AGENT_ID,
      a_s.staff_staff_id,
       EXCLUSION_FLAG,
       sum(CALLS_ANSWERED) TOT_CALLS_ANSWERED,
       sum(SHORT_CALLS_ANSWERED) TOT_SHORT_CALLS_ANSWERED,
       sum(TOT_RETURN_TO_QUEUE) TOT_TOT_RETURN_TO_QUEUE,
       avg(extract( day from NUMTODSINTERVAL (((to_date(AVERAGE_HANDLE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(AVERAGE_HANDLE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(AVERAGE_HANDLE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(AVERAGE_HANDLE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_AVERAGE_HANDLE_TIME,
       sum(extract( day from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_SCHED_PRODUCTIVE_TIME,
       sum(extract( day from NUMTODSINTERVAL (((to_date(ACTUAL_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(ACTUAL_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(ACTUAL_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(ACTUAL_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_ACTUAL_PRODUCTIVE_TIME,
       sum(extract( day from NUMTODSINTERVAL (((to_date(TALK_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(TALK_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(TALK_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(TALK_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_TALK_TIME,
       sum(extract( day from NUMTODSINTERVAL (((to_date(WRAP_UP_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(WRAP_UP_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(WRAP_UP_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(WRAP_UP_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_WRAP_UP_TIME,
       sum(extract( day from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_LOGGED_IN_TIME,
       sum(extract( day from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_NOT_READY_TIME,
       sum(extract( day from NUMTODSINTERVAL (((to_date(BREAK_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(BREAK_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(BREAK_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(BREAK_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_BREAK_TIME,
       sum(extract( day from NUMTODSINTERVAL (((to_date(LUNCH_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(LUNCH_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(LUNCH_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(LUNCH_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_LUNCH_TIME
         FROM dp_scorecard.scorecard_hierarchy_sv a_s
        join DP_SCORECARD.SC_AGENT_STAT_SV a11 on a_s.staff_natid =  a11.AGENT_ID  
        where TRUNC(a11.AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')      
    group by to_char(TRUNC(a11.AS_DATE), 'YYYYMM'), to_char(TRUNC(a11.AS_DATE), 'Month YYYY'),a_s.staff_staff_id, AGENT_ID, EXCLUSION_FLAG
 ),
 QC_metrics AS
 (
 select staff_staff_id,
           staff_staff_name,
           staff_natid,
           dates_month_num,
           dates_year,
           avg_qc_score,
           qcs_performed
      from dp_scorecard.scorecard_quality_mthly_sv
 ),
INCDEFS AS
 (
   SELECT trunc(a11.TASK_START) AS_DATE, 
       a11.STAFF_ID,
       to_char(TRUNC(a11.TASK_START), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(a11.TASK_START), 'Month YYYY') as dates_year,
        count((Case when a11.EVENT_ID in (1374, 1375, 1376, 1377, 1378, 1379) then 1 else null end)) INCIDENTS_COMPLETED,
        count((Case when a11.EVENT_ID in (1373) then 1 else null end)) DEFECTS_COMPLETED
   FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a10
  join MAXDAT.PP_WFM_ACTUALS_SV a11 on a10.staff_staff_id=a11.staff_id
   WHERE TRUNC(a11.task_start) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
  and (a11.EVENT_ID in (1374, 1375, 1376, 1377, 1378, 1379)
         or a11.EVENT_ID in (1373))
         and a11.TASK_END is not null 
   group by trunc(TASK_START),
        a11.staff_id
 ),
 INCDEF_metrics AS
 (
 select 
   distinct  a11.staff_id as staff_staff_id,
       a11.dates_month_num,
       a11.dates_year,
        sum(a11.INCIDENTS_COMPLETED) OVER (PARTITION BY a11.staff_id, a11.dates_month_num) as TOT_INCIDENTS_COMPLETED,
        count(a11.INCIDENTS_COMPLETED) OVER (PARTITION BY a11.staff_id, a11.dates_month_num) as DAYS_INCIDENTS_COMPLETED,
        sum(a11.DEFECTS_COMPLETED) OVER (PARTITION BY a11.staff_id, a11.dates_month_num) as TOT_DEFECTS_COMPLETED,
       count(a11.DEFECTS_COMPLETED) OVER (PARTITION BY a11.staff_id, a11.dates_month_num) as  DAYS_DEFECTS_COMPLETED
   from  INCDEFS a11 
 ),
 LAG_metrics AS (
   SELECT 
       to_char(TRUNC(a11.LAG_DATE), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(a11.LAG_DATE), 'Month YYYY') as dates_year,
        a10.staff_staff_id,
        sum(extract( day from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) )
        over (partition by a10.staff_staff_id, to_char(TRUNC(a11.LAG_DATE), 'YYYYMM')) as LAG_TIME_TOT_SCHED_PROD_TIME
       FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a10
  join DP_SCORECARD.SC_LAG_TIME_SV a11 on a10.staff_natid = a11.agent_id
  WHERE TRUNC(a11.LAG_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
 ),
 CUST_metrics AS
 (
    SELECT distinct 
      to_char(TRUNC(a11.CALL_DATE), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(a11.CALL_DATE), 'Month YYYY') as dates_year,
        a10.staff_staff_id,
       count(CALL_RECORD_ID) over (partition by a10.staff_staff_id,to_char(TRUNC(a11.CALL_DATE), 'Month YYYY')) as  TOT_CALL_RECORDS,
       sum(CUSTOMER_COUNT) over (partition by a10.staff_staff_id,to_char(TRUNC(a11.CALL_DATE), 'Month YYYY')) as TOT_CUSTOMER_COUNT,
       sum(CALL_WRAP_UP_COUNT) over (partition by a10.staff_staff_id,to_char(TRUNC(a11.CALL_DATE), 'Month YYYY')) as TOT_CALL_WRAP_UP_COUNT
    FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a10
  join DP_SCORECARD.SC_NON_STD_USE_SV a11 on to_char(a10.staff_natid) = a11.Employee_ID  
  WHERE TRUNC(a11.CALL_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
 ),
 WUE_metrics AS
 (
   SELECT distinct 
       to_char(TRUNC(a11.WUE_DATE), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(a11.WUE_DATE), 'Month YYYY') as dates_year,
        a10.staff_staff_id,
        sum(a11.WRAP_UP_ERROR) over (partition by a10.staff_staff_id,to_char(TRUNC(a11.WUE_DATE), 'Month YYYY')) as TOT_WRAP_UP_ERROR
   FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a10
  join DP_SCORECARD.SC_WRAP_UP_ERROR_SV a11 on a10.staff_natid = a11.AGENT_ID
  WHERE TRUNC(a11.WUE_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
 ),
 CALL_metrics AS
 (
  SELECT 
        a10.staff_staff_id,
       a11.AS_DATE,        
        a11.EXCLUSION_FLAG,
        CASE WHEN sum(a11.SHORT_CALLS_ANSWERED) > 10 THEN 1 ELSE null END short_calls,
        sum(a11.CALLS_ANSWERED) TOT_CALLS,
       to_char(TRUNC(a11.AS_DATE), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(a11.AS_DATE), 'Month YYYY') as dates_year
   FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a10
  join DP_SCORECARD.SC_AGENT_STAT_SV a11 on a10.staff_natid = a11.AGENT_ID
  WHERE TRUNC(a11.AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
   GROUP BY a10.staff_staff_id, a11.AS_DATE, a11.EXCLUSION_FLAG
 ),
 CALL_days AS
 (
   SELECT distinct 
        staff_staff_id,
        dates_month_num,
        dates_year,
        EXCLUSION_FLAG,
        count(short_calls)  over (partition by staff_staff_id,dates_month_num, EXCLUSION_FLAG) as Days_Short_Calls_GT_10,
         count(TOT_CALLS)  over (partition by staff_staff_id,dates_month_num, EXCLUSION_FLAG) as DAYS_CALLS_ANSWERED
   FROM CALL_metrics
 )
 SELECT
   all_staff.staff_staff_id,
   all_staff.staff_staff_name,
   all_staff.dates_month,
   all_staff.dates_month_num,
   all_staff.dates_year,
   tm.EXCLUSION_FLAG,
   tm.TOT_CALLS_ANSWERED,
   tm.TOT_SHORT_CALLS_ANSWERED,
   tm.TOT_TOT_RETURN_TO_QUEUE,
   tm.TOT_AVERAGE_HANDLE_TIME,
   tm.TOT_SCHED_PRODUCTIVE_TIME,
   tm.TOT_ACTUAL_PRODUCTIVE_TIME,
   tm.TOT_TALK_TIME,
   tm.TOT_WRAP_UP_TIME,
   tm.TOT_LOGGED_IN_TIME,
   tm.TOT_NOT_READY_TIME,
   tm.TOT_BREAK_TIME,
   tm.TOT_LUNCH_TIME,
   qc.qcs_performed,
   qc.avg_qc_score,
   im.TOT_INCIDENTS_COMPLETED,
   im.DAYS_INCIDENTS_COMPLETED,
   im.TOT_DEFECTS_COMPLETED,
   im.DAYS_DEFECTS_COMPLETED,
   lt.LAG_TIME_TOT_SCHED_PROD_TIME,
   cm.TOT_CALL_RECORDS,
   cm.TOT_CUSTOMER_COUNT,
   cm.TOT_CALL_WRAP_UP_COUNT,
   wm.TOT_WRAP_UP_ERROR,
   cd.Days_Short_Calls_GT_10,
   cd.DAYS_CALLS_ANSWERED
 FROM (select distinct staff_staff_id,
         staff_staff_name,
         dates_month,
         dates_month_num,
         dates_year from dp_scorecard.scorecard_attendance_mthly_sv
         ) all_staff
 left outer join TIME_metrics tm on all_staff.staff_staff_id = tm.staff_staff_id and all_staff.dates_month_num=tm.dates_month_num  
 left outer join QC_metrics qc on all_staff.staff_staff_id = qc.staff_staff_id and all_staff.dates_month_num=qc.dates_month_num   
 left outer join INCDEF_metrics im on all_staff.staff_staff_id = im.staff_staff_id and all_staff.dates_month_num=im.dates_month_num        
 left outer join LAG_metrics lt on all_staff.staff_staff_id = lt.staff_staff_id and all_staff.dates_month_num=lt.dates_month_num        
 left outer join CUST_metrics cm on all_staff.staff_staff_id = cm.staff_staff_id and all_staff.dates_month_num=cm.dates_month_num        
left outer join WUE_metrics wm on all_staff.staff_staff_id = wm.staff_staff_id and all_staff.dates_month_num=wm.dates_month_num        
left outer join CALL_days cd on all_staff.staff_staff_id = cd.staff_staff_id and all_staff.dates_month_num=cd.dates_month_num;
commit;
end LOAD_SC_SUMMARY_CC;
/

GRANT EXECUTE ON DP_SCORECARD.LOAD_SC_SUMMARY_CC TO MAXDAT;
GRANT EXECUTE ON DP_SCORECARD.LOAD_SC_SUMMARY_CC TO MAXDAT_MSTR_TRX_RPT;
GRANT EXECUTE ON DP_SCORECARD.LOAD_SC_SUMMARY_CC TO MAXDAT_READ_ONLY;
GRANT EXECUTE ON DP_SCORECARD.LOAD_SC_SUMMARY_CC TO MAXDAT_REPORTS;


create or replace Procedure              Insert_Back_Office

AS

BEGIN
delete dp_scorecard.sc_production_bo where 1=1;
delete dp_scorecard.SC_SUMMARY_BO where 1=1;
commit;

--Total Logged
insert into dp_scorecard.sc_production_bo
  (staff_id, dates, event_name_sort, event_name, event_subname_sort, event_subname, metric)
select staff_id, end_date, case when scorecard_group = 'All Other Tasks' then 2 else 1 end, scorecard_group, 1, 'Total Logged', nvl(TOTAL_LOGGED,0)
From
(
select
  a11.STAFF_ID,
  trunc(a11.TASK_END) as end_date,
  a12.scorecard_group,
  count(a11.RT_ACTUALS_ID) as total_logged
from  maxdat.PP_WFM_ACTUALS_SV  a11
  join  (select event_id,
       case
         when upper(scorecard_group) like 'OTHER%' then
          'All Other Tasks'
         else
          scorecard_group
       end as scorecard_group
  from maxdat.PP_BO_EVENT_TARGET_LKUP
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, 0), 'MM') and  a11.TASK_END is not null
and a11.event_id not in (1410,1413,1411,1412,1456)
group by
  a11.STAFF_ID,
  trunc(a11.TASK_END),
  a12.scorecard_group,a11.event_id
union
select
  a11.STAFF_ID,
  trunc(a11.TASK_END) as end_date,
  a12.scorecard_group,
 sum(work_subactivity) as total_logged
from  maxdat.PP_WFM_ACTUALS_SV  a11
  join  (select event_id,
       case
         when upper(scorecard_group) like 'OTHER%' then
          'All Other Tasks'
         else
          scorecard_group
       end as scorecard_group
  from maxdat.PP_BO_EVENT_TARGET_LKUP
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, 0), 'MM') and  a11.TASK_END is not null
and  a11.event_id in (1410,1413,1411,1412,1456)
and LENGTH(TRIM(TRANSLATE(work_subactivity, ' +-.0123456789', ' '))) is null
group by
  a11.STAFF_ID,
  trunc(a11.TASK_END),
  a12.scorecard_group
);
commit;

--Total Activity Time in Hrs
insert into dp_scorecard.sc_production_bo
  (staff_id, dates, event_name_sort, event_name, event_subname_sort, event_subname, metric)
select staff_id, end_date, case when scorecard_group = 'All Other Tasks' then 2 else 1 end, scorecard_group, 2, 'Total Activity Time', HANDLE_TIME_IN_HOURS
From
(
select
  a11.STAFF_ID,
  trunc(a11.TASK_END) as end_date,
  a12.scorecard_group,
  sum((a11.HANDLE_TIME / 60.0))  as HANDLE_TIME_IN_HOURS
from  maxdat.PP_WFM_ACTUALS_SV  a11
  join  (select event_id,
       case
         when upper(scorecard_group) like 'OTHER%' then
          'All Other Tasks'
         else
          scorecard_group
       end as scorecard_group
  from maxdat.PP_BO_EVENT_TARGET_LKUP
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, 0), 'MM') and  a11.TASK_END is not null
group by
  a11.STAFF_ID,
  trunc(a11.TASK_END),
  a12.scorecard_group
)
--where staff_id=6962;
commit;

--Task Prodution : ([Total Logged] / ([Total Activity Time in Hrs] / [Max (QC Target)]))
insert into dp_scorecard.sc_production_bo
  (staff_id, dates, event_name_sort, event_name, event_subname_sort, event_subname, metric)
select staff_id, end_date, case when scorecard_group = 'All Other Tasks' then 2 else 1 end, scorecard_group, 3, 'Task Production', metric
from
(
select tl.STAFF_ID, tl.end_date, tl.scorecard_group, tl.TOTAL_LOGGED, ht.HANDLE_TIME_IN_HOURS ,tgt.target, (tl.TOTAL_LOGGED / ht.HANDLE_TIME_IN_HOURS / tgt.target) as metric
from (
select
  a11.STAFF_ID,
  trunc(a11.TASK_END) as end_date,
  a12.scorecard_group,
  count(a11.RT_ACTUALS_ID) as total_logged
from  maxdat.PP_WFM_ACTUALS_SV  a11
  join  (select event_id,
       case
         when upper(scorecard_group) like 'OTHER%' then
          'All Other Tasks'
         else
          scorecard_group
       end as scorecard_group
  from maxdat.PP_BO_EVENT_TARGET_LKUP
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, 0), 'MM') and  a11.TASK_END is not null
and a11.event_id not in (1410,1413,1411,1412,1172,1456)
group by
  a11.STAFF_ID,
  trunc(a11.TASK_END),
  a12.scorecard_group,a11.event_id
union
select
  a11.STAFF_ID,
  trunc(a11.TASK_END) as end_date,
  a12.scorecard_group,
 sum(work_subactivity) as total_logged
from  maxdat.PP_WFM_ACTUALS_SV  a11
  join  (select event_id,
       case
         when upper(scorecard_group) like 'OTHER%' then
          'All Other Tasks'
         else
          scorecard_group
       end as scorecard_group
  from maxdat.PP_BO_EVENT_TARGET_LKUP
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, 0), 'MM') and  a11.TASK_END is not null
and  a11.event_id in (1410,1413,1411,1412,1172,1456)
and LENGTH(TRIM(TRANSLATE(work_subactivity, ' +-.0123456789', ' '))) is null
group by
  a11.STAFF_ID,
  trunc(a11.TASK_END),
  a12.scorecard_group
) tl
join
(
select
  a11.STAFF_ID,
  trunc(a11.TASK_END) as end_date,
  a12.scorecard_group,
  sum((a11.HANDLE_TIME / 60.0))  as HANDLE_TIME_IN_HOURS
from  maxdat.PP_WFM_ACTUALS_SV  a11
  join  (select event_id,
       case
         when upper(scorecard_group) like 'OTHER%' then
          'All Other Tasks'
         else
          scorecard_group
       end as scorecard_group
  from maxdat.PP_BO_EVENT_TARGET_LKUP
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, 0), 'MM') and  a11.TASK_END is not null
group by
  a11.STAFF_ID,
  trunc(a11.TASK_END),
  a12.scorecard_group
) ht on tl.STAFF_ID=ht.STAFF_ID and tl.end_date=ht.end_date and tl.scorecard_group=ht.scorecard_group
join
(
   select scorecard_group, target from
    (select distinct
           case
             when upper(scorecard_group) like 'OTHER%' then
              'All Other Tasks'
             else
              scorecard_group
           end as scorecard_group,
           target
      from maxdat.PP_BO_EVENT_TARGET_LKUP
     where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))
)   tgt on tgt.scorecard_group=ht.scorecard_group
);
commit;

--Daily PRODUCTION
insert into dp_scorecard.sc_production_bo
  (staff_id, dates, event_name_sort, event_name, event_subname_sort, event_subname, metric)
select staff_id, dates, 3, 'Daily Production',  1, NULL, daily_production_metric
from
(
select staff_id, dates, sum(subtotal) as numerator, sum(total_act_time_metric) as denominator,
sum(subtotal) / sum(total_act_time_metric) as daily_production_metric
from
(
select tp.staff_id,
       tp.dates,
       tp.event_name,
       tp.task_prod_metric,
       tat.total_act_time_metric,
       (tp.task_prod_metric * tat.total_act_time_metric) as subtotal
  from (select staff_id, dates, event_name, metric as task_prod_metric
          from dp_scorecard.sc_production_bo
         where event_subname = 'Task Production') tp
  join (select staff_id, dates, event_name, metric as total_act_time_metric
          from dp_scorecard.sc_production_bo
         where event_subname = 'Total Activity Time') tat
    on tp.staff_id = tat.staff_id
   and tp.dates = tat.dates
   and tp.event_name = tat.event_name
)
group by staff_id, dates
);

commit;



---MONTHLY
--Total Logged
insert into dp_scorecard.SC_SUMMARY_BO
  (staff_id, dates_month_num, dates_year, event_name_sort, event_name, event_subname_sort, event_subname, metric)
select staff_id, dates_month_num, dates_year, case when scorecard_group = 'All Other Tasks' then 2 else 1 end, scorecard_group, 1, 'Total Logged', nvl(TOTAL_LOGGED,0)
From
(
 select
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM') as dates_month_num,
  to_char(TRUNC(a11.TASK_END), 'Month YYYY') as dates_year,
  a12.scorecard_group,
  count(a11.RT_ACTUALS_ID)  as TOTAL_LOGGED
from  maxdat.PP_WFM_ACTUALS_SV  a11
  join  (select event_id,
       case
         when upper(scorecard_group) like 'OTHER%' then
          'All Other Tasks'
         else
          scorecard_group
       end as scorecard_group
  from maxdat.PP_BO_EVENT_TARGET_LKUP
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and  a11.TASK_END is not null
and a11.event_id not in (1410,1413,1411,1412,1172,1456)
group by
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM'),
  to_char(TRUNC(a11.TASK_END), 'Month YYYY'),
  a12.scorecard_group
 union
  select
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM') as dates_month_num,
  to_char(TRUNC(a11.TASK_END), 'Month YYYY') as dates_year,
  a12.scorecard_group,
  sum(a11.work_subactivity) as total_logged
from  maxdat.PP_WFM_ACTUALS_SV  a11
  join  (select event_id,
       case
         when upper(scorecard_group) like 'OTHER%' then
          'All Other Tasks'
         else
          scorecard_group
       end as scorecard_group
  from maxdat.PP_BO_EVENT_TARGET_LKUP
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and  a11.TASK_END is not null
and  a11.event_id in (1410,1413,1411,1412,1172,1456)
and LENGTH(TRIM(TRANSLATE(work_subactivity, ' +-.0123456789', ' '))) is null
group by
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM'),
  to_char(TRUNC(a11.TASK_END), 'Month YYYY'),
  a12.scorecard_group
/*select
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM') as dates_month_num,
  to_char(TRUNC(a11.TASK_END), 'Month YYYY') as dates_year,
  a12.scorecard_group,
  count(a11.RT_ACTUALS_ID)  as TOTAL_LOGGED
from  maxdat.PP_WFM_ACTUALS_SV  a11
  join  (select event_id,
       case
         when upper(scorecard_group) like 'OTHER%' then
          'All Other Tasks'
         else
          scorecard_group
       end as scorecard_group
  from maxdat.PP_BO_EVENT_TARGET_LKUP
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and  a11.TASK_END is not null
group by
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM'),
  to_char(TRUNC(a11.TASK_END), 'Month YYYY'),
  a12.scorecard_group*/
);
commit;

--MONTLHY
--Total Activity Time in Hrs
insert into dp_scorecard.SC_SUMMARY_BO
  (staff_id, dates_month_num, dates_year, event_name_sort, event_name, event_subname_sort, event_subname, metric)
select staff_id, dates_month_num, dates_year, case when scorecard_group = 'All Other Tasks' then 2 else 1 end, scorecard_group, 1, 'Total Activity Time', HANDLE_TIME_IN_HOURS
From
(
select
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM') as dates_month_num,
  to_char(TRUNC(a11.TASK_END), 'Month YYYY') as dates_year,
  a12.scorecard_group,
  sum((a11.HANDLE_TIME / 60.0))  as HANDLE_TIME_IN_HOURS
from  maxdat.PP_WFM_ACTUALS_SV  a11
  join  (select event_id,
       case
         when upper(scorecard_group) like 'OTHER%' then
          'All Other Tasks'
         else
          scorecard_group
       end as scorecard_group
  from maxdat.PP_BO_EVENT_TARGET_LKUP
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and  a11.TASK_END is not null
group by
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM'),
  to_char(TRUNC(a11.TASK_END), 'Month YYYY'),
  a12.scorecard_group
);
commit;

--MONTHLY
--Task Prodution : ([Total Logged] / ([Total Activity Time in Hrs] / [Max (QC Target)]))
insert into dp_scorecard.SC_SUMMARY_BO
  (staff_id, dates_month_num, dates_year, event_name_sort, event_name, event_subname_sort, event_subname, metric)
select staff_id, dates_month_num, dates_year, case when scorecard_group = 'All Other Tasks' then 2 else 1 end, scorecard_group, 3, 'Task Production', metric
from
(
select tl.STAFF_ID, tl.dates_month_num, tl.dates_year, tl.scorecard_group, tl.TOTAL_LOGGED, ht.HANDLE_TIME_IN_HOURS ,tgt.target, (tl.TOTAL_LOGGED / ht.HANDLE_TIME_IN_HOURS / tgt.target) as metric
from
(
 select
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM') as dates_month_num,
  to_char(TRUNC(a11.TASK_END), 'Month YYYY') as dates_year,
  a12.scorecard_group,
  count(a11.RT_ACTUALS_ID)  as TOTAL_LOGGED
from  maxdat.PP_WFM_ACTUALS_SV  a11
  join  (select event_id,
       case
         when upper(scorecard_group) like 'OTHER%' then
          'All Other Tasks'
         else
          scorecard_group
       end as scorecard_group
  from maxdat.PP_BO_EVENT_TARGET_LKUP
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and  a11.TASK_END is not null
and a11.event_id not in (1410,1413,1411,1412,1172,1456)
group by
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM'),
  to_char(TRUNC(a11.TASK_END), 'Month YYYY'),
  a12.scorecard_group
 union
  select
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM') as dates_month_num,
  to_char(TRUNC(a11.TASK_END), 'Month YYYY') as dates_year,
  a12.scorecard_group,
  sum(a11.work_subactivity) as total_logged
from  maxdat.PP_WFM_ACTUALS_SV  a11
  join  (select event_id,
       case
         when upper(scorecard_group) like 'OTHER%' then
          'All Other Tasks'
         else
          scorecard_group
       end as scorecard_group
  from maxdat.PP_BO_EVENT_TARGET_LKUP
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and  a11.TASK_END is not null
and  a11.event_id in (1410,1413,1411,1412,1172,1456)
and LENGTH(TRIM(TRANSLATE(work_subactivity, ' +-.0123456789', ' '))) is null
group by
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM'),
  to_char(TRUNC(a11.TASK_END), 'Month YYYY'),
  a12.scorecard_group
/*select
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM') as dates_month_num,
  to_char(TRUNC(a11.TASK_END), 'Month YYYY') as dates_year,
  a12.scorecard_group,
  count(a11.RT_ACTUALS_ID)  as TOTAL_LOGGED
from  maxdat.PP_WFM_ACTUALS_SV  a11
  join  (select event_id,
       case
         when upper(scorecard_group) like 'OTHER%' then
          'All Other Tasks'
         else
          scorecard_group
       end as scorecard_group
  from maxdat.PP_BO_EVENT_TARGET_LKUP
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and  a11.TASK_END is not null
group by
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM'),
  to_char(TRUNC(a11.TASK_END), 'Month YYYY'),
  a12.scorecard_group*/
) tl
join
(
select
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM') as dates_month_num,
  to_char(TRUNC(a11.TASK_END), 'Month YYYY') as dates_year,
  a12.scorecard_group,
  sum((a11.HANDLE_TIME / 60.0))  as HANDLE_TIME_IN_HOURS
from  maxdat.PP_WFM_ACTUALS_SV  a11
  join  (select event_id,
       case
         when upper(scorecard_group) like 'OTHER%' then
          'All Other Tasks'
         else
          scorecard_group
       end as scorecard_group
  from maxdat.PP_BO_EVENT_TARGET_LKUP
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and  a11.TASK_END is not null
group by
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM'),
  to_char(TRUNC(a11.TASK_END), 'Month YYYY'),
  a12.scorecard_group
) ht on tl.STAFF_ID=ht.STAFF_ID and tl.dates_month_num=ht.dates_month_num and tl.scorecard_group=ht.scorecard_group
join
(
   select scorecard_group, target from
    (select distinct
           case
             when upper(scorecard_group) like 'OTHER%' then
              'All Other Tasks'
             else
              scorecard_group
           end as scorecard_group,
           target
      from maxdat.PP_BO_EVENT_TARGET_LKUP
     where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))
)   tgt on tgt.scorecard_group=ht.scorecard_group
);
commit;

--MONTHLY
--Daily PRODUCTION
insert into dp_scorecard.SC_SUMMARY_BO
  (staff_id, dates_month_num, dates_year, event_name_sort, event_name, event_subname_sort, event_subname, metric)
select staff_id,  dates_month_num, dates_year, 3, 'Overall',  1, NULL, daily_production_metric
from
(
select staff_id,  dates_month_num, dates_year, sum(subtotal) as numerator, sum(total_act_time_metric) as denominator,
sum(subtotal) / sum(total_act_time_metric) as daily_production_metric
from
(
select tp.staff_id,
       tp.dates_month_num,
       tp.dates_year,
       tp.event_name,
       tp.task_prod_metric,
       tat.total_act_time_metric,
       (tp.task_prod_metric * tat.total_act_time_metric) as subtotal
  from (select staff_id, dates_month_num, dates_year, event_name, metric as task_prod_metric
          from dp_scorecard.SC_SUMMARY_BO
         where event_subname = 'Task Production') tp
  join (select staff_id, dates_month_num, dates_year, event_name, metric as total_act_time_metric
          from dp_scorecard.SC_SUMMARY_BO
         where event_subname = 'Total Activity Time') tat
    on tp.staff_id = tat.staff_id
   and tp.dates_month_num = tat.dates_month_num
   and tp.event_name = tat.event_name
)
group by staff_id, dates_month_num, dates_year
);
commit;
END;
/

grant execute on Insert_Back_Office to MAXDAT_MSTR_TRX_RPT;
grant execute on Insert_Back_Office to MAXDAT;
grant execute on Insert_Back_Office to MAXDAT_READ_ONLY;

CREATE OR REPLACE Procedure DP_SCORECARD.Update_Goal
   ( in_staff_id in number
   , in_goal_id in number
   , in_goal_description in varchar2
   , in_progress_note in varchar2
   , in_delete_flag in number)

AS

BEGIN

   if in_delete_flag = 1 then
     delete from dp_scorecard.sc_goal where staff_id=in_staff_id and goal_id = in_goal_id;
     commit;
   elsif  length(in_goal_description) is NULL and length(in_progress_note) is NULL then
     /*do nothing*/
      null;
   else
       update dp_scorecard.sc_goal
          set goal_description = case
                                      when (length(in_goal_description) > 0) then
                                       in_goal_description
                                      else
                                       goal_description
                                    end,
              progress_note = case
                                 when (length(in_progress_note) > 0) then
                                  in_progress_note
                                 else
                                  progress_note
                               end
        where goal_id = in_goal_id;

       commit;

   end if;

END Update_Goal;
/  

grant execute on Update_Goal to MAXDAT_MSTR_TRX_RPT; 
grant execute on Update_Goal to MAXDAT;
grant execute on Update_Goal to MAXDAT_READ_ONLY;

CREATE OR REPLACE Procedure DP_SCORECARD.Update_Performance_Tracker
   ( in_staff_id in number
   , in_pt_id in number
   , in_comments in varchar2
   , in_delete_flag in number)

AS

BEGIN

   if in_delete_flag = 1 then
     delete from dp_scorecard.sc_performance_tracker where staff_id=in_staff_id and pt_id = in_pt_id;
     commit;
   elsif  length(in_comments) is NULL then
     /*do nothing*/
      null;
   else
       update dp_scorecard.sc_performance_tracker
          set comments = in_comments
        where pt_id = in_pt_id;

       commit;

   end if;

END;
/

grant execute on Update_Performance_Tracker to MAXDAT_MSTR_TRX_RPT; 
grant execute on Update_Performance_Tracker to MAXDAT;
grant execute on Update_Performance_Tracker to MAXDAT_READ_ONLY;

create or replace procedure dp_scorecard.LOAD_SC_SUMMARY_CC_ROLLUP
AS

begin

    Delete from SC_SUMMARY_CC_ROLLUP;
    commit;

insert into SC_SUMMARY_CC_ROLLUP (supervisor_staff_id,
   dates_month,
   dates_month_num,
   dates_year,
   EXCLUSION_FLAG,
   TOT_CALLS_ANSWERED,
   TOT_SHORT_CALLS_ANSWERED,
   TOT_TOT_RETURN_TO_QUEUE,
   TOT_RETURN_TO_QUEUE_TIMEOUT,
   TOT_AVERAGE_HANDLE_TIME,
   TOT_SCHED_PRODUCTIVE_TIME,
   TOT_ACTUAL_PRODUCTIVE_TIME,
   TOT_TALK_TIME,
   TOT_WRAP_UP_TIME,
   TOT_LOGGED_IN_TIME,
   TOT_NOT_READY_TIME,
   TOT_BREAK_TIME,
   TOT_LUNCH_TIME,
   qcs_performed,
   avg_qc_score,
   TOT_INCIDENTS_COMPLETED,
   DAYS_INCIDENTS_COMPLETED,
   TOT_DEFECTS_COMPLETED,
   DAYS_DEFECTS_COMPLETED,
   LAG_TIME_TOT_SCHED_PROD_TIME,
   TOT_CALL_RECORDS,
   TOT_CUSTOMER_COUNT,
   TOT_CALL_WRAP_UP_COUNT,
   TOT_WRAP_UP_ERROR,
   Days_Short_Calls_GT_10,
   DAYS_CALLS_ANSWERED,
   ADHERENCE,
   avg_attendance_balance,
   avg_attendance_total_balance
   )

WITH attendance as
( 
select distinct SUPERVISOR_STAFF_ID,
                DATES_MONTH,
                DATES_MONTH_NUM,
                DATES_YEAR,
                AVG(BALANCE) over(partition by SUPERVISOR_STAFF_ID, dates_month_num) as BALANCE,
                AVG(TOTAL_BALANCE) over(partition by SUPERVISOR_STAFF_ID, dates_month_num) as TOTAL_BALANCE,
                SC_ATTENDANCE_ID
  from dp_scorecard.scorecard_attendance_mthly_sv
),
TIME_metrics as
 (
   SELECT
      distinct
      to_char(TRUNC(a11.AS_DATE), 'YYYYMM') as dates_month_num,
      to_char(TRUNC(a11.AS_DATE), 'Month YYYY') as dates_year,
       a_s.supervisor_staff_id,
       EXCLUSION_FLAG,
       sum(CALLS_ANSWERED) TOT_CALLS_ANSWERED,
       sum(SHORT_CALLS_ANSWERED) TOT_SHORT_CALLS_ANSWERED,
       sum(TOT_RETURN_TO_QUEUE) TOT_TOT_RETURN_TO_QUEUE,
       sum(TOT_RETURN_TO_QUEUE_TIMEOUT) TOT_RETURN_TO_QUEUE_TIMEOUT,
       avg(extract( day from NUMTODSINTERVAL (((to_date(AVERAGE_HANDLE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(AVERAGE_HANDLE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(AVERAGE_HANDLE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(AVERAGE_HANDLE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_AVERAGE_HANDLE_TIME,
       sum(extract( day from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_SCHED_PRODUCTIVE_TIME,
       sum(extract( day from NUMTODSINTERVAL (((to_date(ACTUAL_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(ACTUAL_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(ACTUAL_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(ACTUAL_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_ACTUAL_PRODUCTIVE_TIME,
       sum(extract( day from NUMTODSINTERVAL (((to_date(TALK_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(TALK_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(TALK_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(TALK_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_TALK_TIME,
       sum(extract( day from NUMTODSINTERVAL (((to_date(WRAP_UP_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(WRAP_UP_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(WRAP_UP_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(WRAP_UP_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_WRAP_UP_TIME,
       sum(extract( day from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_LOGGED_IN_TIME,
       sum(extract( day from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_NOT_READY_TIME,
       sum(extract( day from NUMTODSINTERVAL (((to_date(BREAK_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(BREAK_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(BREAK_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(BREAK_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_BREAK_TIME,
       sum(extract( day from NUMTODSINTERVAL (((to_date(LUNCH_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(LUNCH_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(LUNCH_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(LUNCH_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_LUNCH_TIME
         FROM dp_scorecard.scorecard_hierarchy_sv a_s
        join DP_SCORECARD.SC_AGENT_STAT_SV a11 on a_s.staff_natid =  a11.AGENT_ID
        where TRUNC(a11.AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
    group by to_char(TRUNC(a11.AS_DATE), 'YYYYMM'), to_char(TRUNC(a11.AS_DATE), 'Month YYYY'),a_s.supervisor_staff_id, EXCLUSION_FLAG
 ),
 QC_metrics AS
 (
 select supervisor_staff_id,
           dates_month_num,
           dates_year,
           avg_qc_score,
           qcs_performed
      from dp_scorecard.scorecard_quality_mthly_ru_sv
 ),
INCDEFS AS
 (
   SELECT a10.supervisor_staff_id,
   trunc(a11.TASK_START) AS_DATE,
       to_char(TRUNC(a11.TASK_START), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(a11.TASK_START), 'Month YYYY') as dates_year,
        count((Case when a11.EVENT_ID in (1374, 1375, 1376, 1377, 1378, 1379) then 1 else null end)) INCIDENTS_COMPLETED,
        count((Case when a11.EVENT_ID in (1373) then 1 else null end)) DEFECTS_COMPLETED
   FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a10
  join MAXDAT.PP_WFM_ACTUALS_SV a11 on a10.staff_staff_id=a11.staff_id
   WHERE TRUNC(a11.task_start) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
  and (a11.EVENT_ID in (1374, 1375, 1376, 1377, 1378, 1379)
         or a11.EVENT_ID in (1373))
         and a11.TASK_END is not null and trunc(a11.TASK_START)=trunc(a11.TASK_END)
   group by a10.supervisor_staff_id, trunc(TASK_START)
 ),
 INC_metrics AS
 (
 select
   distinct a11.supervisor_staff_id,
       a11.dates_month_num,
       a11.dates_year,
        sum(a11.INCIDENTS_COMPLETED) OVER (PARTITION BY a11.supervisor_staff_id, a11.dates_month_num) as TOT_INCIDENTS_COMPLETED,
        count(a11.INCIDENTS_COMPLETED) OVER (PARTITION BY a11.supervisor_staff_id, a11.dates_month_num) as DAYS_INCIDENTS_COMPLETED
   from  INCDEFS a11
   where  a11.INCIDENTS_COMPLETED <> 0
 ),
 DEF_metrics AS
 (
 select
   distinct a11.supervisor_staff_id,
       a11.dates_month_num,
       a11.dates_year,
       sum(a11.DEFECTS_COMPLETED) OVER (PARTITION BY a11.supervisor_staff_id, a11.dates_month_num) as TOT_DEFECTS_COMPLETED,
       count(a11.DEFECTS_COMPLETED) OVER (PARTITION BY a11.supervisor_staff_id, a11.dates_month_num) as  DAYS_DEFECTS_COMPLETED
   from  INCDEFS a11
   where  a11.DEFECTS_COMPLETED <> 0
 ) ,
 LAG_metrics AS (
   SELECT
       distinct to_char(TRUNC(a11.LAG_DATE), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(a11.LAG_DATE), 'Month YYYY') as dates_year,
        a10.supervisor_staff_id,
        sum(extract( day from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(TOT_SCHED_PRODUCTIVE_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) )
        over (partition by a10.supervisor_staff_id, to_char(TRUNC(a11.LAG_DATE), 'YYYYMM')) as LAG_TIME_TOT_SCHED_PROD_TIME
       FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a10
  join DP_SCORECARD.SC_LAG_TIME_SV a11 on a10.staff_natid = a11.agent_id
  join (select trunc(as_date) as as_date, agent_id from DP_SCORECARD.SC_AGENT_STAT_SV
        where TRUNC(AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')) a12
        on  a12.agent_id=a10.staff_natid and a12.as_date= TRUNC(a11.LAG_DATE)
  WHERE TRUNC(a11.LAG_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
 ),
 CUST_metrics AS
 (
    SELECT distinct
      to_char(TRUNC(a11.CALL_DATE), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(a11.CALL_DATE), 'Month YYYY') as dates_year,
       a10.supervisor_staff_id,
       count(CALL_RECORD_ID) over (partition by a10.supervisor_staff_id,to_char(TRUNC(a11.CALL_DATE), 'Month YYYY')) as  TOT_CALL_RECORDS,
       sum(CUSTOMER_COUNT) over (partition by a10.supervisor_staff_id,to_char(TRUNC(a11.CALL_DATE), 'Month YYYY')) as TOT_CUSTOMER_COUNT,
       sum(CALL_WRAP_UP_COUNT) over (partition by a10.supervisor_staff_id,to_char(TRUNC(a11.CALL_DATE), 'Month YYYY')) as TOT_CALL_WRAP_UP_COUNT
    FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a10
  join DP_SCORECARD.SC_NON_STD_USE_SV a11 on to_char(a10.staff_natid) = a11.Employee_ID
  WHERE TRUNC(a11.CALL_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
 ),
 WUE_metrics AS
 (
   SELECT distinct
       to_char(TRUNC(a11.WUE_DATE), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(a11.WUE_DATE), 'Month YYYY') as dates_year,
        a10.supervisor_staff_id,
        sum(a11.WRAP_UP_ERROR) over (partition by a10.supervisor_staff_id,to_char(TRUNC(a11.WUE_DATE), 'Month YYYY')) as TOT_WRAP_UP_ERROR
   FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a10
  join DP_SCORECARD.SC_WRAP_UP_ERROR_SV a11 on a10.staff_natid = a11.AGENT_ID
  WHERE TRUNC(a11.WUE_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
 ),
CALL_metrics AS
 (
  SELECT
        a10.supervisor_staff_id,
       a11.AS_DATE,
        a11.EXCLUSION_FLAG,
        CASE WHEN sum(a11.SHORT_CALLS_ANSWERED) > 10 THEN 1 ELSE null END short_calls,
        sum(a11.CALLS_ANSWERED) TOT_CALLS,
       to_char(TRUNC(a11.AS_DATE), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(a11.AS_DATE), 'Month YYYY') as dates_year
   FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a10
  join DP_SCORECARD.SC_AGENT_STAT_SV a11 on a10.staff_natid = a11.AGENT_ID
  WHERE TRUNC(a11.AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
   GROUP BY a10.supervisor_staff_id, a11.AS_DATE, a11.EXCLUSION_FLAG
 ),
 CALL_days AS
 (
   SELECT distinct
        supervisor_staff_id,
        dates_month_num,
        dates_year,
        EXCLUSION_FLAG,
        count(short_calls)  over (partition by supervisor_staff_id,dates_month_num, EXCLUSION_FLAG) as Days_Short_Calls_GT_10,
         count(TOT_CALLS)  over (partition by supervisor_staff_id,dates_month_num, EXCLUSION_FLAG) as DAYS_CALLS_ANSWERED
   FROM CALL_metrics
  ),
 Adherence as
 (
   SELECT distinct
      to_char(TRUNC(a11.AS_DATE), 'YYYYMM') as dates_month_num,
      to_char(TRUNC(a11.AS_DATE), 'Month YYYY') as dates_year,
      to_char(a11.AGENT_ID) AGENT_ID,
      a_s.supervisor_staff_id,
       a11.EXCLUSION_FLAG,
       sum(extract( day from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(LOGGED_IN_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_LOGGED_IN_TIME,
       sum(extract( day from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*24*60*60 +
         extract( hour from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60*60 +
         extract( minute from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second'))*60 +
         extract( second from NUMTODSINTERVAL (((to_date(NOT_READY_TIME,'HH24:MI:SS') - to_date('00:00:00','HH24:MI:SS')) * 86400), 'second')) ) TOT_NOT_READY_TIME
         FROM dp_scorecard.scorecard_hierarchy_sv a_s
        join DP_SCORECARD.SC_AGENT_STAT_SV a11 on a_s.staff_natid =  a11.AGENT_ID
        join (SELECT TRUNC(a111.LAG_DATE) as LAG_DATE, a101.staff_staff_id, a111.agent_id
                  FROM DP_SCORECARD.SCORECARD_HIERARCHY_SV a101
                  join DP_SCORECARD.SC_LAG_TIME_SV a111
                    on a101.staff_natid = a111.agent_id
                 WHERE TRUNC(a111.LAG_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
              ) a12 on a11.agent_Id=a12.agent_Id and a11.AS_Date=a12.lag_date
        where TRUNC(a11.AS_DATE) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')  and a11.EXCLUSION_FLAG='N'
    group by to_char(TRUNC(a11.AS_DATE), 'YYYYMM'), to_char(TRUNC(a11.AS_DATE), 'Month YYYY'),a_s.supervisor_staff_id, a11.AGENT_ID, a11.EXCLUSION_FLAG
 ),
Adherence_metric as
 (

   SELECT distinct
      a10.dates_month_num,
      a10.dates_year,
      a10.supervisor_staff_id,
      ((a10.TOT_LOGGED_IN_TIME - a10.TOT_NOT_READY_TIME)/a11.LAG_TIME_TOT_SCHED_PROD_TIME) as ADHERENCE
      FROM Adherence a10
      join LAG_metrics a11 on a10.supervisor_staff_id=a11.supervisor_staff_id and a10.dates_year=a11.dates_year

 )

 SELECT
   distinct all_staff.supervisor_staff_id,
   all_staff.dates_month,
   all_staff.dates_month_num,
   all_staff.dates_year,
   tm.EXCLUSION_FLAG,
   tm.TOT_CALLS_ANSWERED,
   tm.TOT_SHORT_CALLS_ANSWERED,
   tm.TOT_TOT_RETURN_TO_QUEUE,
   tm.TOT_RETURN_TO_QUEUE_TIMEOUT,
   tm.TOT_AVERAGE_HANDLE_TIME,
   tm.TOT_SCHED_PRODUCTIVE_TIME,
   tm.TOT_ACTUAL_PRODUCTIVE_TIME,
   tm.TOT_TALK_TIME,
   tm.TOT_WRAP_UP_TIME,
   tm.TOT_LOGGED_IN_TIME,
   tm.TOT_NOT_READY_TIME,
   tm.TOT_BREAK_TIME,
   tm.TOT_LUNCH_TIME,
   qc.qcs_performed,
   qc.avg_qc_score,
   im.TOT_INCIDENTS_COMPLETED,
   im.DAYS_INCIDENTS_COMPLETED,
   dm.TOT_DEFECTS_COMPLETED,
   dm.DAYS_DEFECTS_COMPLETED,
   lt.LAG_TIME_TOT_SCHED_PROD_TIME,
   cm.TOT_CALL_RECORDS,
   cm.TOT_CUSTOMER_COUNT,
   cm.TOT_CALL_WRAP_UP_COUNT,
   wm.TOT_WRAP_UP_ERROR,
   cd.Days_Short_Calls_GT_10,
   cd.DAYS_CALLS_ANSWERED,
   a.ADHERENCE,
   a.balance,
   a.total_balance
 FROM (select distinct supervisor_staff_id,
         dates_month,
         dates_month_num,
         dates_year from dp_scorecard.scorecard_attendance_mthly_sv
         ) all_staff
 left outer join attendance a on all_staff.supervisor_staff_id = a.supervisor_staff_id and all_staff.dates_month_num=a.dates_month_num        
 left outer join TIME_metrics tm on all_staff.supervisor_staff_id = tm.supervisor_staff_id and all_staff.dates_month_num=tm.dates_month_num
 left outer join QC_metrics qc on all_staff.supervisor_staff_id = qc.supervisor_staff_id and all_staff.dates_month_num=qc.dates_month_num
 left outer join INC_metrics im on all_staff.supervisor_staff_id = im.supervisor_staff_id and all_staff.dates_month_num=im.dates_month_num
 left outer join DEF_metrics dm on all_staff.supervisor_staff_id = dm.supervisor_staff_id and all_staff.dates_month_num=dm.dates_month_num
 left outer join LAG_metrics lt on all_staff.supervisor_staff_id = lt.supervisor_staff_id and all_staff.dates_month_num=lt.dates_month_num
 left outer join CUST_metrics cm on all_staff.supervisor_staff_id = cm.supervisor_staff_id and all_staff.dates_month_num=cm.dates_month_num
left outer join WUE_metrics wm on all_staff.supervisor_staff_id = wm.supervisor_staff_id and all_staff.dates_month_num=wm.dates_month_num
left outer join CALL_days cd on all_staff.supervisor_staff_id = cd.supervisor_staff_id and all_staff.dates_month_num=cd.dates_month_num
left outer join Adherence_metric a on all_staff.supervisor_staff_id = a.supervisor_staff_id and all_staff.dates_month_num=a.dates_month_num;


commit;
end LOAD_SC_SUMMARY_CC_ROLLUP;
/

GRANT execute on DP_SCORECARD.LOAD_SC_SUMMARY_CC_ROLLUP to MAXDAT_READ_ONLY;
GRANT execute on DP_SCORECARD.LOAD_SC_SUMMARY_CC_ROLLUP to MAXDAT;



