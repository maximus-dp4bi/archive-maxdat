
select 'INSERT INTO D_METRIC_VALIDATION_RULE (' ||
'D_METRIC_VALIDATION_RULE_ID,  ' ||
'D_METRIC_DEFINITION_ID,  ' ||
'RULE_NAME,  ' ||
'RULE_DESCRIPTION,  ' ||
'RULE_MESSAGE,  ' ||
'RULE_VALIDATION_TYPE,  ' ||
'RULE_SEVERITY_INDICATOR,  ' ||
'METRIC_VALUE_TYPE,  ' ||
'METRIC_VALUE_LOCATION,  ' ||
'PREVENT_SUBMIT,  ' ||
'ALLOW_IGNORE_WITH_COMMENT,  ' ||
'IS_EXPRESSION_RULE,  ' ||
'RULE_EXPRESSION,  ' ||
'CREATE_DATE,  ' ||
'CREATED_BY,  ' ||
'LAST_MODIFIED_DATE,  ' ||
'UPDATED_BY ' ||
') VALUES ( ' ||
  D_METRIC_VALIDATION_RULE_ID || ', ' || 
  '(SELECT D_METRIC_DEFINITION_ID FROM D_METRIC_DEFINITION WHERE NAME = ''' || md.NAME || ''')' || ', ' || 
  '''' || RULE_NAME || ''', ' || 
  '''' || RULE_DESCRIPTION || ''', ' || 
  '''' || RULE_MESSAGE || ''', ' || 
  '''' || RULE_VALIDATION_TYPE || ''', ' || 
  '''' || RULE_SEVERITY_INDICATOR || ''', ' || 
  '''' || METRIC_VALUE_TYPE || ''', ' || 
  '''' || METRIC_VALUE_LOCATION || ''', ' || 
  PREVENT_SUBMIT || ', ' || 
  ALLOW_IGNORE_WITH_COMMENT || ', ' ||  
  IS_EXPRESSION_RULE || ', ' ||  
  '''' || RULE_EXPRESSION || ''', ' || 
  'TO_DATE(''' || TO_CHAR(mvr.CREATE_DATE, 'YYYY-MM-DD HH24:MI:SS') || ''', ''YYYY-MM-DD HH24:MI:SS''), ' || 
  '''' || mvr.CREATED_BY || ''', ' || 
  'TO_DATE(''' || TO_CHAR(mvr.LAST_MODIFIED_DATE, 'YYYY-MM-DD HH24:MI:SS') || ''',''YYYY-MM-DD HH24:MI:SS''), ' || 
  '''' || mvr.UPDATED_BY || '''' || 
');' as INSERT_SQL
from d_metric_validation_rule mvr
inner join d_metric_definition md on mvr.d_metric_definition_id = md.d_metric_definition_id
;
