--- NYHIX-31987

update maxdat.f_idr_by_date f
set complete_dt=null,
    completion_count = 0
where IDR_BI_ID = 36551582;
commit;