INSERT INTO enum_doc_code_to_type_stg(value,report_label,create_ts,update_ts)
VALUES('NAV_CAC_ID_PROOFING_FORM','Nav/CAC ID Proofing Form',to_date('06/29/2019 16:54:47','mm/dd/yyyy hh24:mi:ss'),null);

INSERT INTO enum_doc_code_to_type_stg(value,report_label,create_ts,update_ts)
VALUES('MEDICARE_SAVINGS_PROGRAM','Medicare Savings Program',to_date('06/29/2019 16:54:47','mm/dd/yyyy hh24:mi:ss'),null);


MERGE /*+ Enable_Parallel_Dml Parallel */
INTO nyhix_etl_mail_fax_doc_v2 e
USING(SELECT eemfdb_id
FROM nyhix_etl_mail_fax_doc_v2
WHERE form_type_cd = 'NAV_CAC_ID_PROOFING_FORM') ae ON (e.eemfdb_id = ae.eemfdb_id)
WHEN MATCHED THEN UPDATE
SET e.form_type = 'Nav/CAC ID Proofing Form';

MERGE /*+ Enable_Parallel_Dml Parallel */
INTO nyhix_etl_mail_fax_doc_v2 e
USING(SELECT eemfdb_id
FROM nyhix_etl_mail_fax_doc_v2
WHERE form_type_cd = 'MEDICARE_SAVINGS_PROGRAM') ae ON (e.eemfdb_id = ae.eemfdb_id)
WHEN MATCHED THEN UPDATE
SET e.form_type = 'Medicare Savings Program'; 

commit;