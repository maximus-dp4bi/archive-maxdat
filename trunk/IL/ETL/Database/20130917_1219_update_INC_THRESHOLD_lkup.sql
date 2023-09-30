update corp_etl_list_lkup
set name= 'PI_INCIDENT_SLA_BASIS'
where name= 'INCIDENT_SLA_BASIS'
and list_type='INC_THRESHOLD';

commit;