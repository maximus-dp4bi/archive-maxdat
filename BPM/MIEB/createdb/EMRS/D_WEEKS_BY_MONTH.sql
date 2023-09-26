CREATE OR REPLACE VIEW D_WEEKS_BY_MONTH
 AS
 SELECT 
 CASE WHEN d_day_of_week BETWEEN 2 and 7 THEN d_week 
      WHEN d_day_of_week = 1 THEN to_char(to_number(d_week, '999999')+1)          
      ELSE to_char(d_year) || '54' END as d_week
, d_month
, CASE WHEN d_day_of_week BETWEEN 2 and 7 THEN d_week_num 
      WHEN d_day_of_week = 1 THEN to_char(lpad((to_number(d_week_num, '999999')+1),2,'0'))          
      ELSE '54' END as d_week_num
, d_year      
, MIN(CASE WHEN d_day_of_week BETWEEN 2 and 6 THEN d_date 
           WHEN d_day_of_week = 1 THEN d_date+1
           WHEN d_day_of_week = 7 THEN d_date-1           
           ELSE to_date('12-31-2050', 'mm-dd-yyyy') END) d_week_start
, MAX(CASE WHEN d_day_of_week BETWEEN 2 and 6 THEN d_date
           WHEN d_day_of_week = 1 THEN d_date+1
           WHEN d_day_of_week = 7 THEN d_date-1
           ELSE to_date('01-01-1900', 'mm-dd-yyyy') END) d_week_end
FROM bpm_d_dates
GROUP BY 
  CASE WHEN d_day_of_week BETWEEN 2 and 7 THEN d_week 
       WHEN d_day_of_week = 1 THEN to_char(to_number(d_week, '999999')+1)          
       ELSE to_char(d_year) || '54' END 
, d_month
, CASE WHEN d_day_of_week BETWEEN 2 and 7 THEN d_week_num 
      WHEN d_day_of_week = 1 THEN to_char(lpad((to_number(d_week_num, '999999')+1),2,'0'))          
      ELSE '54' END
, d_year;

  GRANT SELECT ON MAXDAT_SUPPORT.D_WEEKS_BY_MONTH TO MAXDAT_REPORTS;  
