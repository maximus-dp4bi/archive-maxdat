alter session set current_schema = cisco_enterprise_cc;

UPDATE cc_a_list_lkup
SET OUT_VAR = 'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS) from cc_s_acd_interval where acd_interval_id = :ACD_INTERVAL_ID'
where value in 
(
'WV EB',
'TN New Hire',
'MD EB',
'GA IES',
'TN 11',
'IDHW ET',
'SSA TTWP',
'MO CS',
'CA DIR',
'CA HCO',
--'Wyoming Dept of Health',
'MD HIX',
'MAXIMUS IT',
'TNCS',
'NE PSE',
'CLCS',
'WC HS',
'SCEB',
'Florida Healthy Kids',
'Georgia Families',
'DC PDMS',
'DC EB',
--'KS CH',
'TNTANF',
'FKCS',
'KSLW'
)
and upper(out_var) like 'SELECT (%'
AND LIST_TYPE = 'CC_S_ACD_INTERVAL-CALLS_OFFERED';


UPDATE cc_a_list_lkup
SET OUT_VAR = 'select (CONTACTS_OFFERED - OUTFLOW_CONTACTS) from cc_s_acd_queue_interval where acd_queue_interval_id = :ACD_INTERVAL_ID'
where value in 
(
'WV EB',
'TN New Hire',
'MD EB',
'GA IES',
'TN 11',
'IDHW ET',
'SSA TTWP',
'MO CS',
'CA DIR',
'CA HCO',
--'Wyoming Dept of Health',
'MD HIX',
'MAXIMUS IT',
'TNCS',
'NE PSE',
'CLCS',
'WC HS',
'SCEB',
'Florida Healthy Kids',
'Georgia Families',
'DC PDMS',
'DC EB',
--'KS CH',
'TNTANF',
'FKCS',
'KSLW'
)
and upper(out_var) like 'SELECT (%'
AND LIST_TYPE = 'CC_S_ACD_QUEUE_INTERVAL-CALLS_OFFERED';

commit;