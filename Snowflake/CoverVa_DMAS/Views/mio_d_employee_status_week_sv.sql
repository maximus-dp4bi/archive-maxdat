CREATE OR REPLACE VIEW public.mio_d_employee_status_week_sv
AS
WITH emp AS(
SELECT *
FROM(
SELECT e.id,h.date status_start_date,LEAD(h.date) OVER(PARTITION BY e.id ORDER BY h.id) status_end_date,
  h.column_value hist_training_status,t.training_status,RANK() OVER(PARTITION BY e.id,CAST(h.date AS DATE) ORDER BY h.id desc) rnk,
  CAST(h.date as date) week_start, 
  CASE WHEN LEAD(h.date) OVER(PARTITION BY e.id ORDER BY h.id) < CASE WHEN dayofweek(cast(h.date as date)) = 1 THEN LAST_DAY(DATEADD(DAY,21,cast(h.date as date)),'week')  ELSE LAST_DAY(DATEADD(DAY,28,cast(h.date as date)),'week') END
  THEN LEAD(h.date) OVER(PARTITION BY e.id ORDER BY h.id)
  ELSE CASE WHEN dayofweek(cast(h.date as date)) = 1 THEN LAST_DAY(DATEADD(DAY,21,cast(h.date as date)),'week')  ELSE LAST_DAY(DATEADD(DAY,28,cast(h.date as date)),'week') END  
  END end_4week
FROM coverva_mio.employees e
 JOIN coverva_mio.employees_his h ON e.id = h.emp_record_id  
 JOIN coverva_mio.employees_look_training_status t ON e.training_status = t.id 
WHERE h.column_name = 'Training Status')
WHERE rnk = 1),
emp_wk AS
(SELECT emp.id,emp.status_start_date, emp.status_end_date,emp.hist_training_status,emp.training_status curr_training_status,
  d_week_start,d_week_end,ROW_NUMBER() OVER(PARTITION BY emp.id,emp.status_start_date,emp.status_end_date ORDER BY d_week_start) week_num
FROM emp
  JOIN(SELECT d_week_num, CASE WHEN d_week_num = 1 THEN MAX(d_year) ELSE MIN(d_year) END d_year      
       ,MIN(d_date) d_week_start, MAX(d_date) d_week_end
       ,CONCAT(CASE WHEN weekofyear(d_date) = 1 THEN TO_CHAR(date_trunc('week', d_date)+6,'YYYY')
           ELSE TO_CHAR(date_trunc('week', d_date),'YYYY') END,LPAD(TO_CHAR(weekofyear(d_date)),2,'0')) d_week     
      FROM public.d_dates
      GROUP BY d_week_num,CONCAT(CASE WHEN weekofyear(d_date) = 1 THEN TO_CHAR(date_trunc('week', d_date)+6,'YYYY')
         ELSE TO_CHAR(date_trunc('week', d_date),'YYYY') END,LPAD(TO_CHAR(weekofyear(d_date)),2,'0')) ) wk ON wk.d_week_start BETWEEN emp.week_start AND emp.end_4week),
emp_wk_final  AS(
SELECT emp_wk.id,emp_wk.hist_training_status,emp_wk.curr_training_status,emp_wk.status_start_date, emp_wk.status_end_date
  ,emp_wk.week_num
  ,CASE WHEN emp_wk.week_num = 1 AND CAST(emp_wk.status_start_date AS DATE) < emp_wk.d_week_start THEN CAST(emp_wk.status_start_date AS DATE) ELSE emp_wk.d_week_start END d_week_start
  ,CASE WHEN COALESCE(hist_training_status,'X') != 'Production' AND week_num = 4 AND d_week_end < CAST(emp_wk.status_end_date AS DATE) THEN DATEADD(DAY,-1,CAST(emp_wk.status_end_date AS DATE))   
        WHEN d_week_end > CAST(emp_wk.status_end_date AS DATE) THEN DATEADD(DAY,-1,CAST(emp_wk.status_end_date AS DATE)) ELSE d_week_end END d_week_end
FROM emp_wk  )
SELECT emp_wk_final.*  
  ,MAX(d_week_end) OVER(PARTITION BY id,hist_training_status) max_week_end
FROM   emp_wk_final  ;