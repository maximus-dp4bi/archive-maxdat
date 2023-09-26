ALTER TABLE doc_link_stg ADD (mi_task_indicator NUMBER);

CREATE INDEX doc_link_stg_idx04 ON doc_link_stg(mi_task_indicator) TABLESPACE MAXDAT_INDX;
CREATE INDEX DMS_DOCUMENTS_STG_IDX4 ON dms_documents_stg(kofax_dcn) TABLESPACE MAXDAT_INDX;