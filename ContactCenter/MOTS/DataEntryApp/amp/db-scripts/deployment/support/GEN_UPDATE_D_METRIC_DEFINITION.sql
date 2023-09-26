
select 'UPDATE D_METRIC_DEFINITION ' || 
  'SET D_DATA_TYPE_ID = ' || D_DATA_TYPE_ID || ', ' || 
  ' NAME = ' || '''' || NAME || ''',' ||  
  ' TYPE = ' || '''' || TYPE || ''',' ||  
  ' CATEGORY = ' || '''' || CATEGORY || ''', ' || 
  ' VALUE_TYPE = ' || '''' || VALUE_TYPE || ''',' || 
  ' STATUS = ' || '''' || STATUS || ''',' || 
  ' HAS_TARGET =  ' || '''' || HAS_TARGET || ''',' || 
  ' HAS_FORECAST = ' || '''' || HAS_FORECAST || ''',' || 
  ' IS_CALCULATED = ' || '''' || IS_CALCULATED || ''',' || 
  ' FUNCTIONAL_AREA = ' || '''' || FUNCTIONAL_AREA || ''',' ||  
  ' RECORD_EFF_DT = ' || 'TO_DATE(''' || TO_CHAR(RECORD_EFF_DT, 'YYYY-MM-DD HH24:MI:SS') || ''', ''YYYY-MM-DD HH24:MI:SS''),' || 
  ' RECORD_END_DT = ' || 'TO_DATE(''' || TO_CHAR(RECORD_END_DT, 'YYYY-MM-DD HH24:MI:SS') || ''', ''YYYY-MM-DD HH24:MI:SS''),' || 
  ' CREATE_DATE = ' || 'TO_DATE(''' || TO_CHAR(CREATE_DATE, 'YYYY-MM-DD HH24:MI:SS') || ''', ''YYYY-MM-DD HH24:MI:SS''),' || 
  ' CREATED_BY = ' || '''' || CREATED_BY || ''',' || 
  ' LAST_MODIFIED_DATE = ' || 'TO_DATE(''' || TO_CHAR(LAST_MODIFIED_DATE, 'YYYY-MM-DD HH24:MI:SS') || ''',''YYYY-MM-DD HH24:MI:SS''),' || 
  ' UPDATED_BY = ' || '''' || UPDATED_BY || ''',' || 
  ' LABEL = ' || '''' || LABEL || ''',' || 
  ' SORT_ORDER = ' || COALESCE(TO_CHAR(SORT_ORDER), 'NULL') || ',' || 
  ' SUB_CATEGORY = ' || '''' || SUB_CATEGORY || ''',' || 
  ' DISPLAY_FORMAT = ' || '''' || DISPLAY_FORMAT || ''',' || 
  ' HAS_ACTUAL = ' || '''' || HAS_ACTUAL || ''',' || 
  ' IS_WEEKLY = ' || '''' || IS_WEEKLY || ''',' || 
  ' IS_MONTHLY = ' || '''' || IS_MONTHLY || ''',' || 
  ' DATA_SOURCE = ' || '''' || DATA_SOURCE || ''',' || 
  ' DESCRIPTION =  ' || '''' || REPLACE(DESCRIPTION, '''', '''''') || ''',' || 
  ' FORMULA =  ' || '''' || FORMULA || ''',' || 
  ' HELPFUL_INFO = ' || '''' || REPLACE(HELPFUL_INFO, '''', '''''') || ''',' || 
  ' EXAMPLE = ' || '''' || EXAMPLE || ''',' || 
  ' LOWER_BOUND = ' || COALESCE(TO_CHAR(LOWER_BOUND), 'NULL') || ', ' || 
  ' UPPER_BOUND = ' || COALESCE(TO_CHAR(UPPER_BOUND), 'NULL') || ' ' ||
  'WHERE NAME = ' || '''' || NAME || '''' ||  
  '; '
  AS UPDATE_SQL
from d_metric_definition
--where CREATE_DATE < to_date('05-AUG-2015', 'DD-MON-YYYY') 
;  
  
  
