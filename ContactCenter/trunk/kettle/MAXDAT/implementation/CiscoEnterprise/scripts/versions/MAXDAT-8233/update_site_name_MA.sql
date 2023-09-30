update cc_c_lookup
set lookup_value = 'Folsom'
where  lookup_key in (5131, 5132)
and lookup_type = 'ACD_DESKSETTING_SITE';

commit;