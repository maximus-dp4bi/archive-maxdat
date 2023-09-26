alter TABLE MAXDAT.F_MFB_BY_HOUR enable row movement;


UPDATE MAXDAT.F_MFB_BY_HOUR a
SET (D_DATE,bucket_start_date,bucket_end_date) = (SELECT DISTINCT coalesce(b.BATCH_COMPLETE_DT, b.cancel_dt), TRUNC(coalesce(b.BATCH_COMPLETE_DT, b.cancel_dt),'HH'), TRUNC(coalesce(b.BATCH_COMPLETE_DT, b.cancel_dt),'HH') FROM MAXDAT.D_MFB_CURRENT b WHERE a.mfb_bi_id = b.MFB_BI_ID AND TRUNC(a.d_date) = to_date('18/02/2017','dd/mm/yyyy') AND a.COMPLETION_COUNT = 1 AND TRUNC(a.d_date) <> trunc(coalesce(b.BATCH_COMPLETE_DT, b.cancel_dt)))
WHERE a.MFB_BI_ID = (SELECT DISTINCT b.MFB_BI_ID FROM MAXDAT.D_MFB_CURRENT b WHERE a.mfb_bi_id = b.MFB_BI_ID AND TRUNC(a.d_date) = to_date('18/02/2017','dd/mm/yyyy') AND a.COMPLETION_COUNT = 1 AND TRUNC(a.d_date) <> trunc(coalesce(b.BATCH_COMPLETE_DT,b.cancel_dt))) 
;

commit;

alter table MAXDAT.F_MFB_BY_HOUR disable row movement;
