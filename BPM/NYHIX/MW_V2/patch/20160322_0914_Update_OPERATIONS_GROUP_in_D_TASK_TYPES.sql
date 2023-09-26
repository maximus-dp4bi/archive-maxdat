/*
Created on 03/22/2015 By Guy T.
*/

update d_task_types
set operations_group = 'Research'
where task_name in(
'VLP 3 - G845 Upload',
'VLP 4 - VLP Unresolved',
'VLP 5 - Residual PRUCOL',
'VLP 6 - VLP Follow Up'
);

commit;
