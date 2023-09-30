update cc_c_lookup
set LOOKUP_VALUE = 'Morrisville'
where LOOKUP_VALUE = 'Morristown'
and lookup_type = 'ACD_DESKSETTING_SITE';

update cc_d_site
set SITE_NAME = 'Morrisville'
where SITE_NAME = 'Morristown';

update cc_d_agent
set SITE_NAME = 'Morrisville'
where SITE_NAME = 'Morristown';

update cc_s_agent
set SITE_NAME = 'Morrisville'
where SITE_NAME = 'Morristown';

commit;




