update cc_c_project_config
set program_name = 'MO Child Support'
where project_name = 'MO CS';

update cc_c_project_config
set program_name = 'MI Provider Support'
where project_name = 'MI APCC';


update cc_c_lookup
set lookup_value = 'MO Child Support'
where lookup_key in
(
5110
,5111
,5112
)
and lookup_type = 'ACD_SKILLSET_PROGRAM';

update cc_c_lookup
set lookup_value = 'MI Provider Support'
where lookup_key in
(
5113
,5114
,5115
)
and lookup_type = 'ACD_SKILLSET_PROGRAM';

update cc_c_lookup
set lookup_value = 'MO Child Support'
where lookup_type = 'ACD_DESKSETTING_PROGRAM'
and lookup_key in 
(
5037
, 5038
);

update cc_d_program
set program_name = 'MO Child Support'
where program_name = 'Child Support';

update cc_d_program
set program_name = 'MI Provider Support'
where program_name = 'Provider Support';