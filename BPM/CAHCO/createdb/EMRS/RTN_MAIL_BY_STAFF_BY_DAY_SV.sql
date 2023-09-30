CREATE OR REPLACE VIEW MAXDAT.RTN_MAIL_BY_STAFF_BY_DAY_SV
AS
WITH prev_flag AS (
    SELECT  c.modified_date date_requested
      , c.modified_name AS staff_id
      , c.mails_returned mail_flag
      , c.case_id
      FROM EMRS_D_CASE_HIST c
      GROUP BY  c.CASE_ID, c.modified_date, c.modified_name, c.mails_returned
), flag AS (
SELECT TRUNC(a.date_requested) d_date
      , a.Staff_id
      , b.mail_flag prev_flag
      , a.mail_flag curr_flag
 FROM prev_flag a
 JOIN prev_flag b
    ON (a.case_id = b.case_id)
   WHERE a.date_requested > b.date_requested
), flag_cnt AS (
SELECT d_date
    , staff_id
    , count(Staff_id) flag_cnt
    FROM flag
    WHERE prev_flag = 'Y' AND curr_flag = 'N'
    GROUP BY d_date, staff_id
    ORDER BY d_date, Staff_id
)
SELECT a.D_DATE
, upper(substr(a.staff_id,instr(a.staff_id,'\',1,1)+1,(((instr(a.staff_id, ' (',1,1)))-(instr(a.staff_id,'\',1,1)+1)))) staff_id
, substr(a.staff_id, instr(a.staff_id, ' (', 1,1)+2, (((instr(a.staff_id, ')',1,1)))-(instr(a.staff_id, ' (', 1,1)+2))) Staff_Name
, a.flag_cnt
, d.d_week_num Business_week
, d.last_weekday Last_Weekday
, d.d_week_num Week_of_Year
, d.d_day Day
, d.d_date Date_ID
, d.d_day_name Date_Name
, d.d_day_of_month Day_of_Month
, d.d_day_of_week Day_of_Week
, d.d_day_of_year Day_of_Year
, d.d_month_name Month_Name
, d.d_month_num Month_Num
, to_number(to_char(d.d_date, 'YYYYMMDD')) Date_Num
, d.d_week_of_month Week_of_Month
--, d.d_week_num Week_of_Year
, d.weekend_flag Weekend_Flag
, d.d_year Year
FROM D_DATES_sv d JOIN flag_cnt a ON (d.D_DATE = a.d_date)
WHERE (a.staff_id LIKE 'CAHCO%' OR a.staff_id LIKE 'MAXCORP%')
AND a.staff_id NOT LIKE 'MAXCORP\SVC%';
/

GRANT SELECT ON MAXDAT.RTN_MAIL_BY_STAFF_BY_DAY_SV TO MAXDAT_READ_ONLY;
