-- Update MFD Complete Date IAW NYHIX-17292, NYHIX-17345

update NYHIX_ETL_MAIL_FAX_DOC_V2 s
set (s.complete_dt, s.INSTANCE_END_DATE) = (select MIN(c.CSC_PROC_DT), MIN(c.CSC_PROC_DT) FROM NYHIX_ETL_MAIL_FAX_DOC_CSC_V2 c 
                     where c.KOFAX_DCN = s.KOFAX_DCN
                     and C.CSC_PROC_DT IS NOT NULL),
s.INSTANCE_STATUS = 'Complete',
S.STG_DONE_DATE = sysdate
where s.INSTANCE_STATUS = 'Active'
and s.ENV_STATUS_CD = 'COMPLETEDRELEASED';



