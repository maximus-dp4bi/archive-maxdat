drop table d_dates;

CREATE TABLE public.D_DATES (
   DateID INT NOT NULL PRIMARY KEY,
   Date DATE NOT NULL,
   --day INT,
   dayName VARCHAR(25),
   dayOfMonth INT,
   dayOfWeek INT,
   dayOfYear INT,
  month VARCHAR(25),
  monthNumber INT,
  monthStartDay DATE,
  monthEndDay DATE,
  weekOfMonth INT,
  weekOfYear INT,
  --businessWeek INT,
  weekStartDay DATE,
  weekEndDay DATE,
  year INT,
  yearStartDay DATE,
  yearEndDay DATE,
  quarter VARCHAR(25),
  quarterNumber INT,
  quarterStartDay DATE,
  quarterEndDay DATE,
  lastYearDay DATE,
  lastQuarterDay DATE,
  lastMonthDay DATE,
  lastWeekDay DATE,
  last90day DATE,
  last30day DATE,
  last7day DATE,
  previousDay DATE,
  weekendFlag BOOLEAN,
  DAYOFQUARTER INT,
  WEEKOFQUARTER INT,
  DAYNAMELONG VARCHAR(25),
  MONTHLONG VARCHAR(25)
  );    

drop sequence dateSeq;
create or replace sequence dateSeq;

truncate table d_dates;

alter session set week_of_year_policy=1, week_start=7;
insert into public.D_DATES select * from (
WITH CTE_MY_DATE AS (
    SELECT DATEADD(DAY, SEQ4(), '1980-01-01') AS MY_DATE
      FROM TABLE(GENERATOR(ROWCOUNT=>36600))  
-- Number of days after reference date in previous line
  )
  SELECT 
  dateSeq.nextval as DateId 
        ,MY_DATE as Date
        --,DAY(MY_DATE) as day (duplicate)
        ,DAYNAME(MY_DATE) as  dayName
        ,DAYOFMONTH(MY_DATE) as dayOfMonth
        ,DAYOFWEEK(MY_DATE) as dayOfWeek
        ,DAYOFYEAR(MY_DATE) as dayOfYear
        ,MONTHNAME(MY_DATE) as month
        ,MONTH(MY_DATE) as monthNumber
        ,DATE_TRUNC('month', MY_DATE) as monthStartDay
        ,LAST_DAY(MY_DATE, 'month') as monthEndDay
        ,DATE_PART(WEEK,MY_DATE) - DATE_PART(WEEK,DATE_TRUNC('month',MY_DATE))+1 as weekOfMonth
        ,WEEKOFYEAR(MY_DATE) as weekOfYear
          --businessWeek INT, (not needed)
        ,DATE_TRUNC('week', MY_DATE) as weekStartDay
        ,LAST_DAY(MY_DATE,'week') as weekEndDay
        ,YEAR(MY_DATE) as year
        ,DATE_TRUNC('year', MY_DATE) as yearStartDay
        ,LAST_DAY(MY_DATE,'year') as yearEndDay
       ,  'Q' || CAST(quarter(MY_DATE) as VARCHAR(1)) as quarter
        ,QUARTER(MY_DATE) as quarterNumber
        ,DATE_TRUNC('quarter',MY_DATE) as quarterStartDay
        ,LAST_DAY(MY_DATE,'quarter')as quarterEndDay
        ,CAST(DATE_FROM_PARTS(YEAR(MY_DATE)-1, MONTH(MY_DATE), DAY(MY_DATE)) as DATETIME) as lastYearDate
        ,CAST(DATEADD('day', DATEDIFF('day',DATE_TRUNC('quarter',MY_DATE),MY_DATE), DATE_TRUNC('quarter',DATEADD( 'quarter', -1, MY_DATE ))) as DATETIME) as lastQuarterDay              
        ,case when DAY(MY_DATE) > DAY(LAST_DAY(DATEADD('day',-1,DATE_TRUNC('month', MY_DATE)), 'month')) then null else
        CAST(DATE_FROM_PARTS(YEAR(ADD_MONTHS(MY_DATE,-1)),MONTH(ADD_MONTHS(MY_DATE,-1)),DAY(MY_DATE)) as DATETIME) end as lastMonthDay 
        ,CAST(DATEADD(day,-7,MY_DATE) as DATETIME) as lastWeekDay
        ,CAST(DATEADD(day,-90,MY_DATE) as DATETIME) as last90day
        ,CAST(DATEADD(day,-30,MY_DATE) as DATETIME) as last30day
        ,CAST(DATEADD(day,-7,MY_DATE) as DATETIME) as last7day
        ,CAST(DATEADD(day,-1,MY_DATE) as DATETIME) as previousDay
      ,case when DAYOFWEEK(MY_DATE) in (7,1) then true else false end as weekendFlag,
  
  DATEDIFF('day',DATE_TRUNC('QUARTER',MY_DATE),MY_DATE)+1 as DAYOFQUARTER,
  DATEDIFF('week',DATE_TRUNC('QUARTER',MY_DATE),MY_DATE)+1 as WEEKOFQUARTER,
  decode(extract ('dayofweek_iso',MY_DATE),
  1, 'Monday',
  2, 'Tuesday',
  3, 'Wednesday',
  4, 'Thursday',
  5, 'Friday',
  6, 'Saturday',
  7, 'Sunday')as DAYNAMELONG,
  TO_CHAR(MY_DATE,'MMMM') as MONTHLONG
  FROM CTE_MY_DATE);