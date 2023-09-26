create table ineo.d_dates
as
select * from public.d_dates
where project_id = 428;

create or replace view ineo.d_dates_sv
as 
select * from ineo.d_dates;

--script used in prod to build d_dates table
CREATE OR REPLACE TABLE INEO.D_DATES (
   D_DATE            DATE        NOT NULL
  ,PROJECT_ID       NUMBER      NOT NULL
  ,D_MONTH_NAME      CHAR(3) NOT NULL
  ,D_MONTH           CHAR(15) NOT NULL 
  ,D_DAY             CHAR(3) NOT NULL
  ,D_DAY_NAME        CHAR(10) NOT NULL  
  ,DAY_OF_WEEK       VARCHAR(9)  NOT NULL
  ,DAY_OF_MON        SMALLINT    NOT NULL
  ,DAY_OF_YEAR       SMALLINT    NOT NULL
  ,D_YEAR            SMALLINT    NOT NULL
  ,D_MONTH_NUM       SMALLINT    NOT NULL
  ,D_WEEK_NUM        SMALLINT    NOT NULL
  ,D_WEEK_OF_MONTH   SMALLINT NOT NULL  
  ,WEEKEND_FLAG      CHAR(1)
  ,BUSINESS_DAY_FLAG CHAR(1)
 -- ,D_WEEK            SMALLINT NOT NULL
 -- ,D_MONTH           SMALLINT NOT NULL
)
AS
 WITH CTE_MY_DATE AS (
    SELECT 
         D_DATE
        ,118 PROJECT_ID
    FROM
        (SELECT 
            DATEADD(DAY, SEQ4(), TO_DATE('2021-01-01')) AS D_DATE        
        FROM 
            TABLE(GENERATOR(ROWCOUNT=>1826))) DATES
    
-- Number of days after reference date in previous line
  )
  SELECT A.D_DATE
        ,A.PROJECT_ID
        ,MONTHNAME(D_DATE)
        ,TO_CHAR(D_DATE,'MMMM')
        ,DAYNAME(D_DATE)
        ,DECODE(DAYNAME(D_DATE), 'Mon','Monday', 'Tue','Tuesday','Wed','Wednesday','Thu','Thursday','Fri','Friday','Sat','Saturday','Sun','Sunday')
        ,DAYOFWEEK(D_DATE)
        ,DAY(D_DATE)
        ,DAYOFYEAR(D_DATE)
        ,YEAR(D_DATE)
        ,MONTH(D_DATE)
        ,WEEKISO(D_DATE)
        ,CAST(ROUND((DAY( D_DATE ) +6)/7,0) as VARCHAR) AS WEEK_OF_MONTH
        ,CASE WHEN DAYOFWEEK(D_DATE) IN(0,6) THEN 'Y' ELSE 'N' END AS WEEKEND_FLAG
        ,CASE WHEN WEEKEND_FLAG ='N' AND (HOLIDAY_FLAG = 'N' OR HOLIDAY_FLAG IS NULL) THEN 'Y' ELSE 'N' END AS BUSINESS_DAY_FLAG
       -- ,CASE WHEN WEEKISO(D_DATE) = 1 THEN 
    FROM 
        CTE_MY_DATE A    
    LEFT OUTER JOIN
        (SELECT 
             118 PROJECT_ID
            ,cast ('09/05/2022' as date) HOLIDAY_DATE
            ,'Y' HOLIDAY_FLAG
            ,CASE WHEN DAYOFWEEK(cast ('09/05/2022' as date)) NOT IN (0,6) THEN 'Y' ELSE 'N' END AS  WEEKDAY_HOLIDAY FROM dual
         union all 
        SELECT 
             118 PROJECT_ID
            ,cast ('07/04/2022' as date) HOLIDAY_DATE
            ,'Y' HOLIDAY_FLAG
            ,CASE WHEN DAYOFWEEK(cast ('07/04/2022' as date)) NOT IN (0,6) THEN 'Y' ELSE 'N' END AS  WEEKDAY_HOLIDAY FROM dual
        union all 
        SELECT 
             118 PROJECT_ID
            ,cast ('05/30/2022' as date) HOLIDAY_DATE
            ,'Y' HOLIDAY_FLAG
            ,CASE WHEN DAYOFWEEK(cast ('05/30/2022' as date)) NOT IN (0,6) THEN 'Y' ELSE 'N' END AS  WEEKDAY_HOLIDAY FROM dual
        union all 
        SELECT 
             118 PROJECT_ID
            ,cast ('11/24/2022' as date) HOLIDAY_DATE
            ,'Y' HOLIDAY_FLAG
            ,CASE WHEN DAYOFWEEK(cast ('11/24/2022' as date)) NOT IN (0,6) THEN 'Y' ELSE 'N' END AS  WEEKDAY_HOLIDAY FROM dual          
union all 
        SELECT 
             118 PROJECT_ID
            ,cast ('12/26/2022' as date) HOLIDAY_DATE
            ,'Y' HOLIDAY_FLAG
            ,CASE WHEN DAYOFWEEK(cast ('12/26/2022' as date)) NOT IN (0,6) THEN 'Y' ELSE 'N' END AS  WEEKDAY_HOLIDAY FROM dual          
         
        ) B 
    ON A.D_DATE = B.HOLIDAY_DATE AND A.PROJECT_ID = B.PROJECT_ID