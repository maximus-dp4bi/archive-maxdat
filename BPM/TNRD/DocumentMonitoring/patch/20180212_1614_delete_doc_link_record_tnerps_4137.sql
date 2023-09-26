DELETE FROM doc_link_stg --doc link id 3553021
WHERE link_ref_id = 754280
AND link_type_cd = 'APPLICATION'
AND document_id = 3532796;

commit;