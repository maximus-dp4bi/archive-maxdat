/*
Created on 11/07/2016 by Raj A. for MAXDAT-4842

alter session set current_schema = DP_SCORECARD;

select 'alter index ' || i.INDEX_NAME || ' parallel ' || ltrim(t.DEGREE) || ';'
from ALL_INDEXES i
inner join ALL_TABLES t on i.TABLE_NAME = t.TABLE_NAME
where 
  i.OWNER = 'DP_SCORECARD'
  and t.OWNER = 'DP_SCORECARD'
  and t.DEGREE not like ('%1') 
order by i.INDEX_NAME asc;
*/
alter index BO_TASK_EVENT_ID_IDX parallel 2;
alter index BO_TASK_STAFF_ID_IDX parallel 2;
alter index BO_TASK_TASK_CATEGORY_ID_IDX parallel 2;
alter index BO_TASK_TASK_ID_IDX parallel 2;
alter index PP_WFM_TASK_BO_PK parallel 2;