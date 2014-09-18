create table BPM_D_DATES as
select d_date
, to_char(d_date,'Mon') d_month
, to_char(d_date,'FMMonth') d_month_name
, to_char(d_date,'Dy') d_day
, to_char(d_date,'Day') d_day_name
, to_char(d_date,'D') d_day_of_week
, to_char(d_date,'DD') d_day_of_month
, to_char(d_date,'DDD') d_day_of_year
, to_char(d_Date, 'YYYY') d_year
, to_char(d_date, 'MM') d_month_num
, to_char(d_date, 'IW') d_week_of_year
, TO_CHAR(D_DATE, 'W') D_WEEK_OF_MONTH
, case when TO_CHAR(D_DATE,'D') in('1','7') then 'Y' else 'N' end as WEEKEND_FLAG
from
  (select add_months(trunc(sysdate,'MM'),-3) + ROWNUM as d_date
   from DUAL connect by rownum<=(sysdate-(ADD_MONTHS(TRUNC(sysdate,'MM'),-3))))
order by D_DATE;

alter table BPM_D_DATES add constraint BPM_D_DATES_PK primary key (D_DATE);

CREATE INDEX bpm_d_dates_MONTH_NAME_IX ON BPM_D_DATES( D_MONTH_NAME ) TABLESPACE MAXDAT_INDX ;
CREATE INDEX bpm_d_dates_D_WEEK_OF_MONTH_IX ON BPM_D_DATES ("D_WEEK_OF_MONTH") TABLESPACE MAXDAT_INDX ;

CREATE OR REPLACE FORCE VIEW D_DATES
("D_DATE", "D_MONTH", "D_MONTH_NAME", "D_DAY", "D_DAY_NAME", "D_DAY_OF_WEEK", "D_DAY_OF_MONTH", "D_DAY_OF_YEAR", "D_YEAR", "D_MONTH_NUM", "D_WEEK_OF_YEAR", "D_WEEK_OF_MONTH", "WEEKEND_FLAG", "TODAY", "YESTERDAY", "LAST_WEEKDAY", "THIS_WEEK", "LAST_WEEK")
AS
  SELECT d."D_DATE",
    d."D_MONTH",
    d."D_MONTH_NAME",
    d."D_DAY",
    d."D_DAY_NAME",
    d."D_DAY_OF_WEEK",
    d."D_DAY_OF_MONTH",
    d."D_DAY_OF_YEAR",
    d."D_YEAR",
    d."D_MONTH_NUM",
    d."D_WEEK_OF_YEAR",
    d."D_WEEK_OF_MONTH",
    d."WEEKEND_FLAG" ,
    CASE
      WHEN TRUNC(d_date) = TRUNC(sysdate)
      THEN 'Y'
      ELSE 'N'
    END AS today ,
    CASE
      WHEN TRUNC(d_date) = TRUNC(sysdate-1)
      THEN 'Y'
      ELSE 'N'
    END AS yesterday ,
    CASE
      WHEN TO_CHAR(sysdate,'D') = '1'
      AND TRUNC(d_date)         = TRUNC(sysdate-2)
      THEN 'Y'
      WHEN TO_CHAR(sysdate,'D') = '2'
      AND TRUNC(d_date)         = TRUNC(sysdate-3)
      THEN 'Y'
      WHEN TO_CHAR(sysdate,'D') NOT                IN('1','2')
      AND TRUNC(d_date)              = TRUNC(sysdate-1)
      THEN 'Y'
      ELSE 'N'
    END AS last_weekday ,
    CASE
      WHEN TO_CHAR(d_date, 'YYYYIW') = TO_CHAR(sysdate, 'YYYYIW')
      THEN 'Y'
      ELSE 'N'
    END AS this_week ,
    CASE
      WHEN TO_CHAR(d_date, 'YYYYIW') = TO_CHAR(sysdate-7, 'YYYYIW')
      THEN 'Y'
      ELSE 'N'
    END AS last_week
  FROM bpm_d_dates d;
  
select max(D_DATE)
from BPM_D_DATES;

create or replace procedure MAINTAIN_BPM_D_DATES as

  cursor c_missing_dates is
    with max_bpm_d_date as
      (select max(D_DATE) max_date
       from BPM_D_DATES)
    select trunc(max_bpm_d_date.max_date + rownum) missing_date
    from 
      ALL_OBJECTS, 
      max_bpm_d_date
    where rownum <= trunc(sysdate) - max_bpm_d_date.max_date;

  begin
  
    for r_missing_date in c_missing_dates
    loop
      insert into BPM_D_DATES 
        (d_date,d_month,d_month_name,d_day,d_day_name,
         d_day_of_week,d_day_of_month,d_day_of_year,d_year,d_month_num,
         d_week_of_year,D_WEEK_OF_MONTH,WEEKEND_FLAG)
      values 
        (r_missing_date.missing_date,to_char(r_missing_date.missing_date,'Mon'),to_char(r_missing_date.missing_date,'FMMonth'),to_char(r_missing_date.missing_date,'Dy'), to_char(r_missing_date.missing_date,'Day'),
         to_char(r_missing_date.missing_date,'D'),to_char(r_missing_date.missing_date,'DD'),to_char(r_missing_date.missing_date,'DDD'),to_char(r_missing_date.missing_date,'YYYY'),to_char(r_missing_date.missing_date,'MM'),
         to_char(r_missing_date.missing_date,'IW'),TO_CHAR(r_missing_date.missing_date,'W'),case when TO_CHAR(r_missing_date.missing_date,'D') in('1','7') then 'Y' else 'N' end);
    end loop;
    commit;
    
    DELETE BPM_D_DATES where d_date < trunc((sysdate-100),'MM');
    commit;
    
  end;
/

declare
  v_jobnum number := null;
begin
  dbms_job.submit(
    job => v_jobnum,
    what => 'MAINTAIN_BPM_D_DATES;',
    next_date => sysdate,
    interval => 'trunc(sysdate + 1)');
  commit;
end;
/
