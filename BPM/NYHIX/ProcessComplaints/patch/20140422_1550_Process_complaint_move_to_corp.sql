RENAME  NYHX_ETL_COMPLAINTS_INCIDENTS TO CORP_ETL_COMPLAINTS_INCIDENTS;

alter table CORP_ETL_COMPLAINTS_INCIDENTS RENAME COLUMN NECI_ID TO CECI_ID;

rename SEQ_NECI_ID to SEQ_CECI_ID;

drop trigger TRG_R_NYHX_ETL_COMPLAINTS;

drop trigger TRG_AI_NYHX_ETL_COMPLAINTS_Q;

drop trigger TRG_AU_NYHX_ETL_COMPLAINTS_Q;

drop public synonym NYHX_ETL_COMPL_INCIDENTS_OLTP;
drop public synonym NYHX_ETL_COMPL_INCIDN_WIP_BPM;
drop public synonym NYHX_ETL_COMPLAINTS_INCIDENTS;

update BPM_PROCESS_LKUP set name = 'Process Complaints Incidents',description = 'Process Complaints Incidents'
where bprol_id = 22;

update BPM_SOURCE_LKUP set name = 'CORP_ETL_COMPLAINTS_INCIDENTS' where bsl_id = 22;

update bpm_event_master set name = 'Process Complaints Incidents',
description = 'Process Complaints Incidents'
where bem_id = 22;

commit;