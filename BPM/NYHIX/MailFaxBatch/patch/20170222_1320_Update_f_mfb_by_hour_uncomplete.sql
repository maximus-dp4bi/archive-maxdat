update maxdat.f_mfb_by_hour f
set completion_count = (SELECT 0 FROM MAXDAT.D_MFB_CURRENT_SV B where F.MFB_BI_ID = B.MFB_BI_ID and TRUNC(F.D_DATE) >= to_date('16-FEB-17','dd-MON-yy') AND B.BATCH_COMPLETE_DT IS NULL AND B.CANCEL_DT IS NULL AND f.completion_count > 0)
where F.MFB_BI_ID = (select B.MFB_BI_ID FROM MAXDAT.D_MFB_CURRENT_SV B where F.MFB_BI_ID = B.MFB_BI_ID and TRUNC(F.D_DATE) >= to_date('16-FEB-17','dd-MON-yy') AND B.BATCH_COMPLETE_DT IS NULL AND B.CANCEL_DT IS NULL AND f.completion_count > 0)
;


commit;

