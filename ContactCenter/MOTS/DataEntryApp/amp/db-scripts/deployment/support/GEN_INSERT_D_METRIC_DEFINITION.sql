
select 'INSERT INTO D_METRIC_DEFINITION (' ||
  'D_METRIC_DEFINITION_ID, ' ||
  'D_DATA_TYPE_ID, ' ||
  'NAME, ' ||
  'TYPE, ' ||
  'CATEGORY, ' ||
  'VALUE_TYPE, ' ||
  'STATUS, ' ||
  'HAS_TARGET, ' || 
  'HAS_FORECAST, ' ||
  'IS_CALCULATED, ' ||
  'FUNCTIONAL_AREA, ' ||
  'RECORD_EFF_DT, ' ||
  'RECORD_END_DT, ' ||
  'CREATE_DATE, ' ||
  'CREATED_BY, ' ||
  'LAST_MODIFIED_DATE, ' ||
  'UPDATED_BY, ' ||
  'LABEL, ' ||
  'SORT_ORDER, ' ||
  'SUB_CATEGORY, ' ||
  'DISPLAY_FORMAT, ' ||
  'HAS_ACTUAL, ' ||
  'IS_WEEKLY, ' ||
  'IS_MONTHLY, ' ||
  'DATA_SOURCE, ' ||
  'DESCRIPTION, ' || 
  'FORMULA, ' || 
  'HELPFUL_INFO, ' ||
  'EXAMPLE, ' ||
  'LOWER_BOUND, ' ||
  'UPPER_BOUND ' ||
') VALUES ( ' ||
  D_METRIC_DEFINITION_ID || ', ' || 
  D_DATA_TYPE_ID || ', ' || 
  '''' || NAME || ''', ' || 
  '''' || TYPE || ''', ' || 
  '''' || CATEGORY || ''', ' || 
  '''' || VALUE_TYPE || ''', ' || 
  '''' || STATUS || ''', ' || 
  '''' || HAS_TARGET || ''', ' || 
  '''' || HAS_FORECAST || ''', ' || 
  '''' || IS_CALCULATED || ''', ' || 
  '''' || FUNCTIONAL_AREA || ''', ' ||  
  'TO_DATE(''' || TO_CHAR(RECORD_EFF_DT, 'YYYY-MM-DD HH24:MI:SS') || ''', ''YYYY-MM-DD HH24:MI:SS''), ' || 
  'TO_DATE(''' || TO_CHAR(RECORD_END_DT, 'YYYY-MM-DD HH24:MI:SS') || ''', ''YYYY-MM-DD HH24:MI:SS''), ' || 
  'TO_DATE(''' || TO_CHAR(CREATE_DATE, 'YYYY-MM-DD HH24:MI:SS') || ''', ''YYYY-MM-DD HH24:MI:SS''), ' || 
  '''' || CREATED_BY || ''', ' || 
  'TO_DATE(''' || TO_CHAR(LAST_MODIFIED_DATE, 'YYYY-MM-DD HH24:MI:SS') || ''',''YYYY-MM-DD HH24:MI:SS''), ' || 
  '''' || UPDATED_BY || ''', ' || 
  '''' || LABEL || ''', ' || 
  SORT_ORDER || ', ' || 
  '''' || SUB_CATEGORY || ''', ' || 
  '''' || DISPLAY_FORMAT || ''', ' || 
  '''' || HAS_ACTUAL || ''', ' || 
  '''' || IS_WEEKLY || ''', ' || 
  '''' || IS_MONTHLY || ''', ' || 
  '''' || DATA_SOURCE || ''', ' || 
  '''' || REPLACE(DESCRIPTION, '''', '''''') || ''', ' || 
  '''' || FORMULA || ''', ' || 
  '''' || HELPFUL_INFO || ''', ' || 
  '''' || EXAMPLE || ''', ' || 
  COALESCE(TO_CHAR(LOWER_BOUND), 'NULL') || ', ' || 
  COALESCE(TO_CHAR(UPPER_BOUND), 'NULL') ||
');' as INSERT_SQL
from d_metric_definition 
where CREATE_DATE >= to_date('05-AUG-2015', 'DD-MON-YYYY') ;
