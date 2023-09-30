--------------------------------------------------------
--  File created - Thursday-September-12-2013   
--------------------------------------------------------
DROP PROCEDURE "MAINTAIN_BPM_D_DATES";
--------------------------------------------------------
--  DDL for Procedure MAINTAIN_BPM_D_DATES
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "MAINTAIN_BPM_D_DATES" as

  cursor c_missing_dates is
    with max_bpm_d_date as
      (select max(D_DATE) max_date
       from BPM_D_DATES)
    select trunc(max_bpm_d_date.max_date + rownum) missing_date
    from 
      ALL_OBJECTS, 
      max_bpm_d_date
    where rownum <= trunc(add_months(sysdate,60)) - max_bpm_d_date.max_date;
  begin
  
    for r_missing_date in c_missing_dates
    loop
      insert into BPM_D_DATES 
        (D_DATE,d_month,d_month_name,d_day,d_day_name,
         d_day_of_week,d_day_of_month,d_day_of_year,d_year,d_month_num,
         d_week_of_year,D_WEEK_OF_MONTH,WEEKEND_FLAG)
      values 
        (r_missing_date.missing_date,to_char(r_missing_date.missing_date,'Mon'),to_char(r_missing_date.missing_date,'FMMonth'),to_char(r_missing_date.missing_date,'Dy'), to_char(r_missing_date.missing_date,'Day'),
         to_char(r_missing_date.missing_date,'D'),to_char(r_missing_date.missing_date,'DD'),to_char(r_missing_date.missing_date,'DDD'),to_char(r_missing_date.missing_date,'YYYY'),to_char(r_missing_date.missing_date,'MM'),
         to_char(r_missing_date.missing_date,'IW'),TO_CHAR(r_missing_date.missing_date,'W'),case when TO_CHAR(r_missing_date.missing_date,'D') in('1','7') then 'Y' else 'N' end);
    end loop;
    commit;
    
  end;
/
