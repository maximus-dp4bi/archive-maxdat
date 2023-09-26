Update NYHIX_ETL_MAIL_FAX_DOC_V2 D
set (d.Complete_dt, d.Instance_end_date) = (select n.csc_proc_dt, n.csc_proc_dt from NYHIX_ETL_MAIL_FAX_DOC_CSC_V2 N where D.KOFAX_DCN = N.KOFAX_DCN and N.CSC_PROC_DT IS NOT NULL)
WHERE D.SLA_COMPLETE_DT >= '07-SEP-15' 
and D.SLA_COMPLETE_DT <= '09-SEP-15'
and d.Complete_dt is null;
