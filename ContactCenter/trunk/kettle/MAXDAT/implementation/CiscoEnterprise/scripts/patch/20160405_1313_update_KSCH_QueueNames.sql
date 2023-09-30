--MAXDAT-3419

alter session set current_schema = CISCO_ENTERPRISE_CC;

update cc_c_contact_queue
set queue_name = 'KSTP_KSCH_4884_SESCL1'
where queue_name = 'KSTP_KSCH_4884_SEESCL';

update cc_c_contact_queue
set queue_name = 'KSTP_KSCH_4884_SESCL2'
where queue_name = 'KSTP_KSCH_4884_SSESCL';

commit;

update cc_s_contact_queue
set queue_name = 'KSTP_KSCH_4884_SESCL1'
where queue_name = 'KSTP_KSCH_4884_SEESCL';

update cc_s_contact_queue
set queue_name = 'KSTP_KSCH_4884_SESCL2'
where queue_name = 'KSTP_KSCH_4884_SSESCL';

commit;

update cc_d_contact_queue
set queue_name = 'KSTP_KSCH_4884_SESCL1'
where queue_name = 'KSTP_KSCH_4884_SEESCL';

update cc_d_contact_queue
set queue_name = 'KSTP_KSCH_4884_SESCL2'
where queue_name = 'KSTP_KSCH_4884_SSESCL';

commit;