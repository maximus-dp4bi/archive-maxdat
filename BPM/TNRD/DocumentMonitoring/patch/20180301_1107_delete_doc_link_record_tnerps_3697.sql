UPDATE doc_link_stg
SET case_id = null
   ,client_id = null
   ,link_ref_id = null
   ,updated_by = 'TNERPS-4009'
where doc_link_id in(3465724,
3465727,
3511763,
3458896,
3465601,
3465604); 

DELETE FROM doc_link_stg  --client_id 1523204, link_ref_id 912106
WHERE doc_link_id = 3514852;

commit;