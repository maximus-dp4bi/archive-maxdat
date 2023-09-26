create or replace view D_MFD_DOC_REDACTION_CURRENT_SV
as 
with 
kofax as (
SELECT 'KOFAX'               AS kofax_split_redact_source,
       trunc (rea.create_ts) create_dt,
       redaction_reason      reason_id_kofax,
       report_label          AS reason_kofax,
       rea.app_doc_redaction_data_id,
       k.redaction_data_ind redaction_data_ind_kofax,
       rea.created_by        created_by_kofax_redact,
       rea.create_ts         created_ts_kofax_redact,
       rea.updated_by        updated_by_kofax_redact,
       rea.update_ts         updated_ts_kofax_redact
  FROM app_doc_redaction_data k
  JOIN app_doc_redaction_reason      rea ON k.app_doc_redaction_data_id = rea.app_doc_redaction_data_id
  JOIN enum_app_doc_redaction_reason enum ON rea.redaction_reason = enum.value
 WHERE k.app_doc_redaction_data_id IS NOT NULL
),
maxe as (
SELECT 'MAXE'                AS maxe_split_redact_source,
       app_doc_data_id       AS max_app_doc_data_id,
       doc.app_doc_maxe_redaction_data_id,
       case when doc.APP_DOC_MAXE_REDACTION_DATA_ID is not null then 1 else 0 end as redaction_data_ind_maxe,
       sec_role_id,
       step_definition_id,
       trunc (doc.create_ts) create_dt,
       redaction_reason      reason_id_maxe,
       report_label          AS reason_maxe,
       rea.created_by        created_by_maxe_redact,
       rea.create_ts         created_ts_maxe_redact,
       rea.updated_by        updated_by_maxe_redact,
       rea.update_ts         updated_ts_maxe_redact
  FROM app_doc_maxe_redaction_data doc
  JOIN app_doc_maxe_redaction_reason rea ON doc.app_doc_maxe_redaction_data_id = rea.app_doc_maxe_redaction_data_id
  JOIN enum_app_doc_redaction_reason enum ON rea.redaction_reason = enum.value
where DOC.APP_DOC_MAXE_REDACTION_DATA_ID is not null
)
SELECT ad.app_doc_data_id,
       ext.app_doc_redaction_data_id,
       kofax_split_redact_source,
       kofax.redaction_data_ind_kofax,
       kofax.reason_id_kofax,
       kofax.reason_kofax,
       kofax.created_by_kofax_redact,
       kofax.created_ts_kofax_redact,
       kofax.updated_by_kofax_redact,
       kofax.updated_ts_kofax_redact,
       maxe.app_doc_maxe_redaction_data_id,
       maxe_split_redact_source,
       maxe.redaction_data_ind_maxe,
       maxe.sec_role_id,
       maxe.step_definition_id,
       maxe.reason_id_maxe,
       maxe.reason_maxe,
       maxe.created_by_maxe_redact,
       maxe.created_ts_maxe_redact,
       maxe.updated_by_maxe_redact,
       maxe.updated_ts_maxe_redact
  FROM app_doc_data_stg ad
  JOIN app_doc_data_ext_stg ext ON ad.app_doc_data_id = ext.app_doc_data_id
  LEFT JOIN kofax ON ext.app_doc_redaction_data_id = kofax.app_doc_redaction_data_id
  LEFT JOIN maxe ON ext.app_doc_redaction_data_id = maxe.app_doc_maxe_redaction_data_id
 WHERE 
 kofax.redaction_data_ind_kofax = 1 OR redaction_data_ind_maxe =1 
-- or ad.max_redacted_ind is not null --add later
;

Grant select on MAXDAT.D_MFD_DOC_REDACTION_CURRENT_SV to MAXDAT_READ_ONLY;






