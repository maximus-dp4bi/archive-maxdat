CREATE OR REPLACE VIEW case_address_change_log
AS 
SELECT addr_id
,addr_case_id
,clnt_client_id
,addr_type_cd
,addr_type_desc
,addr_begin_date
,addr_end_date
,creation_date
,created_by
,last_update_date
,last_updated_by
,addr_verified
,addr_verified_date
,addr_bad_date
,addr_bad_date_satisfied
FROM address_stg;

GRANT SELECT ON case_address_change_log TO MAXDAT_READ_ONLY;