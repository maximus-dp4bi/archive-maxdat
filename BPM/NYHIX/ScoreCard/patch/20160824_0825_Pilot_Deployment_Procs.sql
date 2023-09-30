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

CREATE OR REPLACE Procedure DP_SCORECARD.SPAWN_EXCLUSIONS
   ( in_SUPERVISOR_ID	in NUMBER
   , in_STAFF_ID	in NUMBER
   , in_EXCLUSION_DATE	in DATE
   , in_EXCLUSION_FLAG	in VARCHAR2
   , in_EXCLUSION_COMMENT	in VARCHAR2
   , in_CREATE_BY	in NUMBER )
IS

v_staff_national_id number;
v_supervisor_id number;

cursor c1 is
 select staff_staff_id,
          staff_natid
     from dp_scorecard.scorecard_hierarchy_sv
     where supervisor_staff_id=in_SUPERVISOR_ID;

BEGIN

   if  (in_supervisor_id is null and in_STAFF_ID is null) or in_exclusion_date is null or in_exclusion_flag is null or in_create_by is null
      then
     /*do nothing*/
      null;
   else
        if in_STAFF_ID is not null/* and in_SUPERVISOR_ID is null*/ then
           select distinct staff_natid into v_staff_national_id from dp_scorecard.scorecard_hierarchy_sv where staff_staff_id = in_STAFF_ID;
           select distinct supervisor_staff_id into v_supervisor_id from dp_scorecard.scorecard_hierarchy_sv where staff_staff_id = in_STAFF_ID;
           
           insert_sc_exclusion(v_supervisor_id,
                               v_staff_national_id,--v_in_agent_id,
                               in_STAFF_ID,
                               in_EXCLUSION_DATE,
                               in_EXCLUSION_FLAG,
                               in_EXCLUSION_COMMENT,
                               NULL, 
                               in_CREATE_BY);
           
        else
           FOR RECS IN c1
           LOOP
               
               insert_sc_exclusion(in_SUPERVISOR_ID,
                                   RECS.staff_natid, --v_in_agent_id,
                                   RECS.staff_staff_id, 
                                   in_EXCLUSION_DATE,
                                   in_EXCLUSION_FLAG,
                                   in_EXCLUSION_COMMENT,
                                   NULL, 
                                   in_CREATE_BY);
       
           END LOOP;
        end if;
   end if;

END;
/ 

  GRANT execute ON DP_SCORECARD.SPAWN_EXCLUSIONS TO MAXDAT_MSTR_TRX_RPT; 
grant execute on DP_SCORECARD.SPAWN_EXCLUSIONS to MAXDAT;
grant execute on DP_SCORECARD.SPAWN_EXCLUSIONS to MAXDAT_READ_ONLY;

CREATE OR REPLACE Procedure DP_SCORECARD.UPDATE_EXCLUSIONS
   ( in_EXCLUSION_ID	in NUMBER
   , in_EXCLUSION_FLAG	in VARCHAR2
   , in_CREATE_BY	in NUMBER
   , in_COMMENT	in VARCHAR2 )
AS

v_supervisor_id number;
v_agent_id number;
v_staff_id number;
v_exclusion_date date;


BEGIN

   if  in_EXCLUSION_ID is null or in_EXCLUSION_FLAG is null or in_create_by is null
      then
     /*do nothing*/
      null;
   else
     select supervisor_id,
            agent_id,
            staff_id,
            exclusion_date
            INTO 
            v_supervisor_id,
            v_agent_id,
            v_staff_id,
            v_exclusion_date
       from dp_scorecard.sc_exclusion
       where exclusion_id = in_EXCLUSION_ID;
       
       
       insert_sc_exclusion(v_supervisor_id,
                               v_agent_id,
                               v_staff_id,
                               v_exclusion_date,
                               in_EXCLUSION_FLAG,
                               in_COMMENT,
                               NULL, 
                               in_CREATE_BY);
   end if;

END;
/ 

  GRANT execute ON DP_SCORECARD.UPDATE_EXCLUSIONS TO MAXDAT_MSTR_TRX_RPT; 
grant execute on DP_SCORECARD.UPDATE_EXCLUSIONS to MAXDAT;
grant execute on DP_SCORECARD.UPDATE_EXCLUSIONS to MAXDAT_READ_ONLY;
