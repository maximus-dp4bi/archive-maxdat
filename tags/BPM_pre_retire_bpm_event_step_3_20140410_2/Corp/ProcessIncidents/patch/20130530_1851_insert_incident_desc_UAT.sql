insert into d_pi_incident_desc values (SEQ_DPIID_ID.nextval, 'HOC called to change plan cannot until 06/01/2013 says she was misled and did not know that plan '' is an HMO '' and wants to file a complaint because she feels she was misled by the FHN representative. Best number to reach at is 7738039896.');

commit;

update bpm_update_event_queue
set process_bueq_id = null
where bsl_id=10
and identifier='204179';

commit;