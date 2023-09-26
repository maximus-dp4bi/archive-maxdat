--Attendance
ALTER TABLE dp_scorecard.sc_attendance
  ADD (LAST_UPDATED_BY varchar2(100),
       LAST_UPDATED_DATETIME DATE);
       
ALTER TABLE dp_scorecard.sc_attendance
  MODIFY create_by varchar2(100);
  
--Goals
ALTER TABLE dp_scorecard.SC_GOAL
  ADD (LAST_UPDATED_BY varchar2(100),
       LAST_UPDATED_DATETIME DATE);
       
ALTER TABLE dp_scorecard.SC_GOAL
  MODIFY create_by varchar2(100);
  
-- Corrective Action
ALTER TABLE dp_scorecard.SC_CORRECTIVE_ACTION
  ADD (LAST_UPDATED_BY varchar2(100),
       LAST_UPDATED_DATETIME DATE);
       
ALTER TABLE dp_scorecard.SC_CORRECTIVE_ACTION
  MODIFY create_by varchar2(100);
  
--Performance Tracker
ALTER TABLE dp_scorecard.SC_PERFORMANCE_TRACKER
  ADD (LAST_UPDATED_BY varchar2(100),
       LAST_UPDATED_DATETIME DATE);
       
ALTER TABLE dp_scorecard.SC_PERFORMANCE_TRACKER
  MODIFY create_by varchar2(100);
  
  

insert into dp_scorecard.sc_attendance_absence_lkup values (SEQ_SCAL_ID.Nextval, 'Consecutive Day Absence (0)'	,	0	, to_date('07-07-2077', 'dd-mm-yyyy'), 'script', sysdate, null); 

commit;

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

create or replace Procedure              Insert_Goal
   ( in_staff_id in number
   , in_goal_id in number
   , in_goal_description in varchar2
   , in_goal_date in date
   , in_progress_note in varchar2
   , in_date in date
   , in_NATIONAL_ID	in NUMBER )

AS
   v_username varchar2(100);
BEGIN

   if  in_staff_id is null or in_goal_id is null or in_date is null or in_goal_description is null or in_progress_note is null
     or in_goal_date is null or in_NATIONAL_ID is null or trunc(in_date) > trunc(sysdate) or trunc(in_goal_date) < trunc(sysdate) then
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

      insert into dp_scorecard.sc_goal
        (goal_id,
         staff_id,
         goal_entry_date,
         gtl_id,
         goal_description,
         goal_date,
         progress_note,
         create_by,
         create_datetime, 
         last_updated_by, 
         LAST_UPDATED_DATETIME)
      values
        (SEQ_SCGOAL_ID.nextval,
         in_staff_id,
         in_date,
         in_goal_id,
         in_goal_description,
         in_goal_date,
         in_progress_note,
         v_username,
         SYSDATE,
         v_username,
         sysdate);

       commit;

   end if;

END;
/

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

  CREATE OR REPLACE FORCE VIEW "DP_SCORECARD"."SCORECARD_ATTENDANCE_SCORE_SV" ("MANAGER_STAFF_ID", "MANAGER_NAME", "SUPERVISOR_STAFF_ID", "SUPERVISOR_NAME", "STAFF_STAFF_ID", "STAFF_STAFF_NAME", "DATES", "ABSENCE_TYPE", "POINT_VALUE", "BALANCE", "INCENTIVE_BALANCE", "TOTAL_BALANCE", "INCENTIVE_FLAG", "SC_ATTENDANCE_ID", "CREATE_DATETIME", "CREATE_BY", "LAST_UPDATED_BY", "LAST_UPDATED_DATETIME") AS 
  With staff as
(
select
       manager_staff_id,
       manager_name,
       supervisor_staff_id,
       supervisor_name,
       staff_staff_id,
       staff_staff_name,
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
  from sc_attend_entries
;


  CREATE OR REPLACE FORCE VIEW "DP_SCORECARD"."SCORECARD_CORRECT_ACTION_SV" ("MANAGER_STAFF_ID", "MANAGER_NAME", "SUPERVISOR_STAFF_ID", "SUPERVISOR_NAME", "STAFF_STAFF_ID", "STAFF_STAFF_NAME", "CA_ID", "CA_ENTRY_DATE", "CAL_ID", "CORRECTION_ACTION_TYPE", "UNSATISFACTORY_BEHAVIOR", "COMMENTS", "CREATE_BY", "CREATE_DATETIME", "LAST_UPDATED_BY", "LAST_UPDATED_DATETIME") AS 
  select
          sh.manager_staff_id,
          sh.manager_name,
          sh.supervisor_staff_id,
          sh.supervisor_name,
          sh.staff_staff_id,
          sh.staff_staff_name,
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
      join dp_scorecard.scorecard_hierarchy sh on ca.staff_id=sh.staff_staff_id
;


  CREATE OR REPLACE FORCE VIEW "DP_SCORECARD"."SCORECARD_GOAL_SV" ("MANAGER_STAFF_ID", "MANAGER_NAME", "SUPERVISOR_STAFF_ID", "SUPERVISOR_NAME", "STAFF_STAFF_ID", "STAFF_STAFF_NAME", "GOAL_ID", "STAFF_ID", "GOAL_ENTRY_DATE", "GTL_ID", "GOAL_DESCRIPTION", "GOAL_DATE", "PROGRESS_NOTE", "CREATE_BY", "CREATE_DATETIME", "LAST_UPDATED_BY", "LAST_UPDATED_DATETIME") AS 
  select
       sh.manager_staff_id,
       sh.manager_name,
       sh.supervisor_staff_id,
       sh.supervisor_name,
       sh.staff_staff_id,
       sh.staff_staff_name,
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
  join dp_scorecard.scorecard_hierarchy sh on g.staff_id=sh.staff_staff_id
;


  CREATE OR REPLACE FORCE VIEW "DP_SCORECARD"."SCORECARD_PERFORM_TRACKER_SV" ("MANAGER_STAFF_ID", "MANAGER_NAME", "SUPERVISOR_STAFF_ID", "SUPERVISOR_NAME", "STAFF_STAFF_ID", "STAFF_STAFF_NAME", "PT_ID", "PT_ENTRY_DATE", "DL_ID", "DISCUSSION_TOPIC", "COMMENTS", "CREATE_BY", "CREATE_DATETIME", "LAST_UPDATED_BY", "LAST_UPDATED_DATETIME") AS 
  select
           sh.manager_staff_id,
           sh.manager_name,
           sh.supervisor_staff_id,
           sh.supervisor_name,
           sh.staff_staff_id,
           sh.staff_staff_name,
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
    join dp_scorecard.scorecard_hierarchy sh on pt.staff_id=sh.staff_staff_id
;

