
CREATE OR REPLACE Procedure DP_SCORECARD.Insert_Attendance
   ( in_staff_id in number
   , in_absence_type_id in number
   , in_datetime in date
   , in_NATIONAL_ID	in NUMBER )

AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL: svn://rcmxapp1d.maximus.com/maxdat/BPM/NYHIX/ScoreCard/patch/20170929_1610_SC_ATTENDANCE_DDL_PRD3.sql $'; 
  	SVN_REVISION varchar2(20) := '$Revision: 21344 $'; 
 	SVN_REVISION_DATE varchar2(60) := '$Date: 2017-09-27 10:12:30 -0500 (Wed, 27 Sep 2017) $'; 
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
       DP_SCORECARD.Calc_Attendance_Score(in_staff_id)
       --call procedure to populate monthly score table
       DP_SCORECARD.Update_Sc_Attendance_Mthly(in_staff_id)
       
       --DP_SCORECARD.Calc_Attendance_Score_PKG.CALC_ATTENDANCE_SCORE(in_staff_id);

   end if;

   close c1;

END;
/

GRANT EXECUTE ON DP_SCORECARD.Insert_Attendance TO MAXDAT;
GRANT EXECUTE ON DP_SCORECARD.Insert_Attendance TO MAXDAT_READ_ONLY;
GRANT EXECUTE ON DP_SCORECARD.Insert_Attendance TO MAXDAT_REPORTS;



-------------------------------------------------

CREATE OR REPLACE Procedure DP_SCORECARD.Update_Attendance
   ( in_staff_id in number
   , in_sc_attendance_id in number
   , in_absence_type_id in number
   , in_NATIONAL_ID	in NUMBER)

AS
-- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
 	SVN_FILE_URL varchar2(200) := '$URL: svn://rcmxapp1d.maximus.com/maxdat/BPM/NYHIX/ScoreCard/patch/20170929_1610_SC_ATTENDANCE_DDL_PRD3.sql $'; 
  	SVN_REVISION varchar2(20) := '$Revision: 21344 $'; 
 	SVN_REVISION_DATE varchar2(60) := '$Date: 2017-09-27 10:12:30 -0500 (Wed, 27 Sep 2017) $'; 
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
      if (in_absence_type_id is not null) or (in_absence_type_id = v_all_id) then
          
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
   DP_SCORECARD.Update_Sc_Attendance_Mthly(in_staff_id)
   
   --DP_SCORECARD.Calc_Attendance_Score_PKG.CALC_ATTENDANCE_SCORE(in_staff_id);

END;
/

GRANT EXECUTE ON DP_SCORECARD.Update_Attendance TO MAXDAT;
GRANT EXECUTE ON DP_SCORECARD.Update_Attendance TO MAXDAT_READ_ONLY;
GRANT EXECUTE ON DP_SCORECARD.Update_Attendance TO MAXDAT_REPORTS;



-------------------------------------------------

create or replace PROCEDURE                           UPDATE_SC_ATTENDANCE_MTHLY
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
      order by staff_staff_id, dates_month_num, dates desc, create_datetime desc --staff_staff_id, dates_month_num, create_datetime
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
                   rank() over(partition by staff_staff_id, dates_month_num order by dates/*rn*/ desc, create_datetime desc) as rnk
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
      order by staff_staff_id, dates_month_num, dates desc, create_datetime desc --staff_staff_id, dates_month_num, create_datetime
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
                   rank() over(partition by staff_staff_id, dates_month_num order by dates/*rn*/ desc, create_datetime desc) as rnk
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

GRANT EXECUTE ON DP_SCORECARD.UPDATE_SC_ATTENDANCE_MTHLY TO MAXDAT;
GRANT EXECUTE ON DP_SCORECARD.UPDATE_SC_ATTENDANCE_MTHLY TO MAXDAT_READ_ONLY;
GRANT EXECUTE ON DP_SCORECARD.UPDATE_SC_ATTENDANCE_MTHLY TO MAXDAT_REPORTS;

-------------------------------------------------

