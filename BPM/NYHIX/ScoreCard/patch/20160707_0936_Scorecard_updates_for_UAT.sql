show errors;

declare  c int;
begin
   select count(*) into c from user_tables where table_name ='SC_EXCLUSION';
   if c = 1 then
      execute immediate 'drop table SC_EXCLUSION cascade constraints';
   end if;
end;
/

CREATE TABLE SC_EXCLUSION 
(exclusion_ID number(38,0) NOT NULL
,supervisor_id  NUMBER(38,0) NOT NULL
,agent_id NUMBER(38,0)
,staff_id  NUMBER(38,0)
,exclusion_date  date NOT NULL
,exclusion_flag varchar2(1) 
,exclusion_comment varchar2(400)
,Create_date date NOT NULL
,Create_by number(38,0) Not null
,  CONSTRAINT SC_EXCLUSION_pk primary key
  (
    exclusion_id
  )
enable
)
tablespace MAXDAT_DATA parallel;

alter table sc_exclusion add CONSTRAINT flag_check check (exclusion_flag in ('Y','N'));

grant select on SC_EXCLUSION to MAXDAT_READ_ONLY; 
GRANT select, insert, update, delete on SC_EXCLUSION to MAXDAT;
GRANT select, insert, update, delete ON SC_EXCLUSION TO MAXDAT_MSTR_TRX_RPT; 

--create view SC_EXCLUSION_SV

CREATE OR REPLACE FORCE VIEW SC_EXCLUSION_SV
(exclusion_ID
,supervisor_id
,agent_id
,staff_id
,excl_date
,exclusion_flag
,exclusion_comment
,create_date
,Create_by	
) 
as
select 
exclusion_ID
,supervisor_id
,agent_id
,staff_id
,exclusion_date
,exclusion_flag
,exclusion_comment
,create_date
,Create_by
from SC_EXCLUSION
WITH READ ONLY;

grant select on SC_EXCLUSION_SV to MAXDAT_READ_ONLY; 
grant select on SC_EXCLUSION_SV to MAXDAT; 
grant select ON SC_EXCLUSION TO MAXDAT_MSTR_TRX_RPT;

create or replace TRIGGER TRG_NYHX_AI_SC_EXCLUSION 
AFTER INSERT ON SC_EXCLUSION 
for each row
  
BEGIN
 if :new.agent_id is not null then
  update DP_SCORECARD.SC_AGENT_STAT
  set exclusion_flag = :new.exclusion_flag
  where agent_id = :new.agent_id
  and trunc(as_date) = trunc(:new.exclusion_date);
 end if;

 if :new.staff_id is not null then
  update MAXDAT.PP_WFM_ACTUALS
  set exclusion_flag = :new.exclusion_flag
  where staff_id = :new.staff_id
  and trunc(task_end) = trunc(:new.exclusion_date);
 end if; 
END;
/

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

-----------------------------------------------------------------

alter table sc_agent_Stat rename column exclude_flag to exclusion_flag;

GRANT select, insert, update, delete ON SC_AGENT_STAT TO MAXDAT_MSTR_TRX_RPT;

--create view SC_AGENT_STAT_SV

CREATE OR REPLACE FORCE VIEW SC_AGENT_STAT_SV
(AS_Date 
,Agent_ID 
,Supervisor_ID 
,Calls_Answered 
,Short_Calls_Answered
,Average_Handle_time 
,Tot_Return_to_Queue 
,Tot_Sched_Productive_Time 
,Actual_Productive_Time 
,Talk_Time
,Wrap_Up_Time 
,Logged_in_Time 
,Not_Ready_Time
,Break_Time 
,Lunch_Time 
,EXCLUSION_FLAG 
) 
as
select 
AS_Date 
,Agent_ID 
,Supervisor_ID 
,Calls_Answered 
,Short_Calls_Answered
,Average_Handle_time 
,Tot_Return_to_Queue 
,Tot_Sched_Productive_Time 
,Actual_Productive_Time 
,Talk_Time
,Wrap_Up_Time 
,Logged_in_Time 
,Not_Ready_Time
,Break_Time 
,Lunch_Time 
,EXCLUSION_FLAG
from SC_AGENT_STAT
WITH READ ONLY;

grant select on SC_AGENT_STAT_SV to MAXDAT_READ_ONLY; 
grant select, insert, update, delete on SC_AGENT_STAT_SV to MAXDAT; 
grant select on SC_AGENT_STAT_SV to MAXDAT_MSTR_TRX_RPT; 

---------------------------------------------------------------

CREATE OR REPLACE Procedure DP_SCORECARD.Update_Corrective_Action
   ( in_staff_id in number
   , in_ca_id in number
   , in_unsatisfactory_behavior in varchar2
   , in_comments in varchar2
   , in_delete_flag in number)

AS

BEGIN

   if in_delete_flag = 1 then
     delete from dp_scorecard.sc_corrective_action where staff_id=in_staff_id and ca_id = in_ca_id;
     commit;
   elsif  length(in_unsatisfactory_behavior) is NULL and length(in_comments) is NULL then
     /*do nothing*/
      null;
   else
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
                         end
        where ca_id = in_ca_id;

       commit;

   end if;

END;
/

