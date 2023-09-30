
select 'INSERT INTO D_COMPARISON_METRIC (' ||
'D_COMPARISON_METRIC_ID,  ' ||
'D_METRIC_VALIDATION_RULE_ID,  ' ||
'D_COMPARISON_METRIC_DEF_ID,  ' ||
'COMPARISON_METRIC_LOC,  ' ||
'ALIAS  ' ||
') VALUES ( ' ||
  D_COMPARISON_METRIC_ID || ', ' || 
  D_METRIC_VALIDATION_RULE_ID || ', ' || 
  '(SELECT D_METRIC_DEFINITION_ID FROM D_METRIC_DEFINITION WHERE NAME = ''' || md.NAME || ''')' || ', ' || 
  '''' || COMPARISON_METRIC_LOC || ''', ' || 
  '''' || ALIAS || '''' || 
');' as INSERT_SQL
from d_comparison_metric cm
inner join d_metric_definition md on cm.D_COMPARISON_METRIC_DEF_ID = md.d_metric_definition_id
;
