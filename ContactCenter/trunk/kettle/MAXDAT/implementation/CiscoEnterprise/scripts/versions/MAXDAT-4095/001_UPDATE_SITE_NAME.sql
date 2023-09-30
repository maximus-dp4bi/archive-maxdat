ALTER SESSION SET CURRENT_SCHEMA = CISCO_ENTERPRISE_CC;

update cc_c_lookup
set lookup_value = 'Glendale'
where lookup_value = 'Gendale';

update cc_d_site
set site_name = 'Glendale'
where site_name = 'Gendale';

update cc_s_agent
set site_name = 'Glendale'
where site_name = 'Gendale';

update cc_d_agent
set site_name = 'Glendale'
where site_name = 'Gendale';

commit;