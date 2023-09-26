alter session set current_schema = cisco_enterprise_cc;

update cc_c_contact_queue
set region_name = 'Central'
where program_name = 'TTWP-Beneficiary Service';

update cc_d_geography_master
set region_id = 1 
where geography_name = 'Texas';

commit;