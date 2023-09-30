

UPDATE corp_etl_list_lkup
SET out_var = '''OUTREACH REQUEST'',''Eligibility Expansion Request'''
where list_type='INC_STATUS'
and name = 'PI_INCIDENT_HEADER_TYPE';


CREATE TABLE tx_process_incidents_eer_bak
AS
SELECT *
FROM corp_etl_process_incidents
WHERE incident_type = 'Eligibility Expansion Request';


DELETE 
FROM corp_etl_process_incidents
WHERE incident_type IN('Outreach Request', 'Eligibility Expansion Request');

DELETE 
FROM f_pi_by_date
WHERE PI_BI_ID IN(SELECT pi_bi_id FROM d_pi_current
WHERE "Incident Type" IN('Outreach Request', 'Eligibility Expansion Request'));

DELETE 
FROM d_pi_current
WHERE "Incident Type" IN('Outreach Request', 'Eligibility Expansion Request');


commit;