update f_nyhix_mfd_by_date
set doc_complete_dt = NULL
where trunc(doc_complete_dt) > bucket_end_date;

commit;

update f_nyhix_mfd_by_date 
set doc_completion_count = 1, doc_inventory_count = 0
where doc_complete_dt is not null;

commit;

update f_nyhix_mfd_by_date 
set doc_inventory_count = 1
where doc_complete_dt is null and creation_count = 0;

commit;