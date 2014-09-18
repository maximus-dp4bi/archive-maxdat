INSERT INTO  bpm_event_master (bem_id,brl_id,bprj_id,bprg_id,bprol_id,name,description,effective_date,end_date) 
VALUES (13, 1, 7, 1, 13, 'ILEB Client Inquiry', 'Illinois EB Support Client Inquiries', SYSDATE, bpm_common.get_max_date);

COMMIT;

