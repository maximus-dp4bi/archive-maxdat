update d_metric_project
set ACTUAL_VALUE_PROVIDED_BY = 'Template'
where d_metric_project_id in
( 
 145 -- ILEB FTE Count
,146 -- ILEB NUMBER_OF_SKILLED_AGENTS_ATTRITTED
,151 -- ILEEV FTE Count
,152 -- ILEEV NUMBER_OF_SKILLED_AGENTS_ATTRITTED
);

commit;

