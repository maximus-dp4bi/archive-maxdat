Update MAXDAT.D_NYHIX_MFD_CURRENT_V2
set doc_reprocessed_flag = 'N',
env_reprocessed_flag = 'N'
where doc_reprocessed_flag is null
or env_reprocessed_flag is null;

commit;
