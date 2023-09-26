UPDATE corp_etl_list_lkup
SET out_var = '''OUTREACH REQUEST'',''Eligibility Expansion Request'',''ILM Expansion Request'''
where list_type='INC_STATUS'
and name = 'PI_INCIDENT_HEADER_TYPE';


DELETE 
FROM corp_etl_process_incidents
WHERE incident_type = 'ILM Expansion Request';

DELETE 
FROM f_pi_by_date
WHERE PI_BI_ID IN(SELECT pi_bi_id FROM d_pi_current
WHERE "Incident Type" = 'ILM Expansion Request');

DELETE 
FROM d_pi_current
WHERE "Incident Type" = 'ILM Expansion Request';


commit;