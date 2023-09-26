-- Disable Manage Work v1 queue and calc jobs.
update PROCESS_BPM_QUEUE_JOB_CONFIG set ENABLED = 'N' where BSL_ID = 1 and BDM_ID = 2;
update PROCESS_BPM_CALC_JOB_CONFIG set PROCESS_ENABLED = 'N' where PACKAGE_NAME = 'MANAGE_WORK' and PROCEDURE_NAME = 'CALC_DMWCUR';

-- Disable NYHIX Mail Fax Doc v1 queue and calc jobs.
update PROCESS_BPM_QUEUE_JOB_CONFIG set ENABLED = 'N' where BSL_ID = 18 and BDM_ID = 2;
update PROCESS_BPM_CALC_JOB_CONFIG set PROCESS_ENABLED = 'N' where PACKAGE_NAME = 'NYHIX_MAIL_FAX_DOC' and PROCEDURE_NAME = 'CALC_D_NYHIX_MF_CUR';

commit;