DROP MATERIALIZED VIEW d_months;
CREATE MATERIALIZED VIEW d_months
BUILD IMMEDIATE 
REFRESH FORCE
ON DEMAND
AS
SELECT d.d_month ,
  d.d_month_num ,
  CASE WHEN d.D_MONTH_NUM IN ('01','02','03') THEN d.D_YEAR||'01'
  WHEN d.D_MONTH_NUM IN ('04','05','06') THEN d.D_YEAR||'02'
  WHEN d.D_MONTH_NUM IN ('07','08','09') THEN d.D_YEAR||'03'
  WHEN d.D_MONTH_NUM IN ('10','11','12') THEN d.D_YEAR||'04'
  ELSE d.D_YEAR||'00' END AS D_QUARTER,
  d.d_year,
  d.d_month_short_name ,
  d.d_month_name ,
  d.d_month_name||' '||d.d_year month_name_year ,
  MIN(d.d_date) d_month_start ,
  MAX(d.d_date) d_month_end
FROM bpm_d_dates d
GROUP BY d.d_month,
  d.d_month_num,
  CASE WHEN d.D_MONTH_NUM IN ('01','02','03') THEN d.D_YEAR||'01'
  WHEN d.D_MONTH_NUM IN ('04','05','06') THEN d.D_YEAR||'02'
  WHEN d.D_MONTH_NUM IN ('07','08','09') THEN d.D_YEAR||'03'
  WHEN d.D_MONTH_NUM IN ('10','11','12') THEN d.D_YEAR||'04'
  ELSE d.D_YEAR||'00' END,
  d.d_year,
  d.d_month_short_name,
  d.d_month_name;
    
GRANT SELECT ON d_months TO MAXDAT_REPORTS;  

CREATE MATERIALIZED VIEW d_quarters
BUILD IMMEDIATE 
REFRESH FORCE
ON DEMAND
AS
SELECT 
 CASE WHEN d.D_MONTH_NUM IN ('01','02','03') THEN d.D_YEAR||'01'
 WHEN d.D_MONTH_NUM IN ('04','05','06') THEN d.D_YEAR||'02'
 WHEN d.D_MONTH_NUM IN ('07','08','09') THEN d.D_YEAR||'03'
 WHEN d.D_MONTH_NUM IN ('10','11','12') THEN d.D_YEAR||'04'
 ELSE d.D_YEAR||'00' END AS D_QUARTER
, CASE WHEN d.D_MONTH_NUM IN ('01','02','03') THEN '01'
 WHEN d.D_MONTH_NUM IN ('04','05','06') THEN '02'
 WHEN d.D_MONTH_NUM IN ('07','08','09') THEN '03'
 WHEN d.D_MONTH_NUM IN ('10','11','12') THEN '04'
 ELSE '00' END AS D_QUARTER_NUM
, d_year
, CASE WHEN d.D_MONTH_NUM IN ('01','02','03') THEN 'Q1'
 WHEN d.D_MONTH_NUM IN ('04','05','06') THEN 'Q2'
 WHEN d.D_MONTH_NUM IN ('07','08','09') THEN 'Q3'
 WHEN d.D_MONTH_NUM IN ('10','11','12') THEN 'Q4'
 ELSE '00' END AS D_QUARTER_SHORT_NAME
, CASE WHEN d.D_MONTH_NUM IN ('01','02','03') THEN 'Q1 '||d.D_YEAR
 WHEN d.D_MONTH_NUM IN ('04','05','06') THEN 'Q2 '||d.D_YEAR
 WHEN d.D_MONTH_NUM IN ('07','08','09') THEN 'Q3 '||d.D_YEAR
 WHEN d.D_MONTH_NUM IN ('10','11','12') THEN 'Q4 '||d.D_YEAR
 ELSE 'Unknown' END quarter_name_year
, MIN(d_date) d_quarter_start
, MAX(d_date) d_quarter_end
FROM bpm_d_dates d
GROUP BY 
CASE WHEN d.D_MONTH_NUM IN ('01','02','03') THEN d.D_YEAR||'01'
 WHEN d.D_MONTH_NUM IN ('04','05','06') THEN d.D_YEAR||'02'
 WHEN d.D_MONTH_NUM IN ('07','08','09') THEN d.D_YEAR||'03'
 WHEN d.D_MONTH_NUM IN ('10','11','12') THEN d.D_YEAR||'04'
 ELSE d.D_YEAR||'00' END
,CASE WHEN d.D_MONTH_NUM IN ('01','02','03') THEN '01'
 WHEN d.D_MONTH_NUM IN ('04','05','06') THEN '02'
 WHEN d.D_MONTH_NUM IN ('07','08','09') THEN '03'
 WHEN d.D_MONTH_NUM IN ('10','11','12') THEN '04'
 ELSE '00' END       
, d_year
, CASE WHEN d.D_MONTH_NUM IN ('01','02','03') THEN 'Q1'
 WHEN d.D_MONTH_NUM IN ('04','05','06') THEN 'Q2'
 WHEN d.D_MONTH_NUM IN ('07','08','09') THEN 'Q3'
 WHEN d.D_MONTH_NUM IN ('10','11','12') THEN 'Q4'
 ELSE '00' END
, CASE WHEN d.D_MONTH_NUM IN ('01','02','03') THEN 'Q1 '||d.D_YEAR
 WHEN d.D_MONTH_NUM IN ('04','05','06') THEN 'Q2 '||d.D_YEAR
 WHEN d.D_MONTH_NUM IN ('07','08','09') THEN 'Q3 '||d.D_YEAR
 WHEN d.D_MONTH_NUM IN ('10','11','12') THEN 'Q4 '||d.D_YEAR
 ELSE 'Unknown' END
 ORDER BY  CASE WHEN d.D_MONTH_NUM IN ('01','02','03') THEN d.D_YEAR||'01'
 WHEN d.D_MONTH_NUM IN ('04','05','06') THEN d.D_YEAR||'02'
 WHEN d.D_MONTH_NUM IN ('07','08','09') THEN d.D_YEAR||'03'
 WHEN d.D_MONTH_NUM IN ('10','11','12') THEN d.D_YEAR||'04'
 ELSE d.D_YEAR||'00' END;
 
GRANT SELECT ON d_quarters TO MAXDAT_REPORTS;  
