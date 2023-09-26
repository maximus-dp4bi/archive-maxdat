--Form Table Create and xfer

CREATE TABLE CORP_ETL_MFB_FORM_NEW 
tablespace MAXDAT_DATA parallel
as
select * 
from CORP_ETL_MFB_FORM
where (DOC_COUNT > 0
    OR REJECTED_DOCS > 0
	OR PAGES > 0
	OR REJECTED_PAGES > 0
	OR COMPLETED_DOCS > 0
	OR COMPLETED_PAGES > 0
	);

alter table CORP_ETL_MFB_FORM drop primary key;
alter table CORP_ETL_MFB_FORM drop constraint CORP_ETL_MFBF_BATCH_GUID;

drop index CORP_ETL_MFB_FORM_IX1;
drop index IDX_CEMFB_FORM_COVERED;

Alter table CORP_ETL_MFB_FORM RENAME TO CORP_ETL_MFB_FORM_OLD;
Alter table CORP_ETL_MFB_FORM_NEW RENAME TO CORP_ETL_MFB_FORM;

alter table CORP_ETL_MFB_FORM add constraint CEMFB_FTE_ID_PK primary key (FORM_TYPE_ENTRY_ID) using index tablespace MAXDAT_INDX; 
alter table CORP_ETL_MFB_FORM add constraint CORP_ETL_MFBF_BATCH_GUID foreign key (BATCH_GUID) REFERENCES MAXDAT.CORP_ETL_MFB_BATCH (BATCH_GUID) ENABLE;

create unique index CORP_ETL_MFB_FORM_IX1 on CORP_ETL_MFB_FORM (CEMFBF_ID) online tablespace MAXDAT_INDX parallel compute statistics;
create index IDX_CEMFB_FORM_COVERED on CORP_ETL_MFB_FORM (FORM_TYPE_ENTRY_ID, TYPE_NAME, DOC_CLASS_NAME, DOC_COUNT, REJECTED_DOCS, PAGES, REJECTED_PAGES, COMPLETED_DOCS, COMPLETED_PAGES) online tablespace MAXDAT_INDX parallel compute statistics;

COMMENT ON COLUMN MAXDAT.CORP_ETL_MFB_FORM.CEMFBF_ID IS 'sequence';
COMMENT ON COLUMN MAXDAT.CORP_ETL_MFB_FORM.BATCH_GUID IS 'Unique identifier for the batch.';
COMMENT ON COLUMN MAXDAT.CORP_ETL_MFB_FORM.FORM_TYPE_ENTRY_ID IS 'Unique value to identify each form type record created';
COMMENT ON COLUMN MAXDAT.CORP_ETL_MFB_FORM.BATCH_MODULE_ID IS 'Unique identifier that indicates the KOFAX Capture module associated with the batch for which a form type record was created. Foreign key to associated record in the StatsBatchModule table.';
COMMENT ON COLUMN MAXDAT.CORP_ETL_MFB_FORM.TYPE_NAME IS 'Name of the form type. If the entry is �Loose,� it relates to pages that do not belong to a document. If the entry is �None,� it relates to documents that have not been assigned a form type.';
COMMENT ON COLUMN MAXDAT.CORP_ETL_MFB_FORM.DOC_CLASS_NAME IS 'Name of the document class associated with the form type. This is empty when the FormTypeName is Loose or Empty.';
COMMENT ON COLUMN MAXDAT.CORP_ETL_MFB_FORM.DOC_COUNT IS 'Number of documents using this form type in the batch.';
COMMENT ON COLUMN MAXDAT.CORP_ETL_MFB_FORM.REJECTED_DOCS IS 'Number of rejected documents using this form type in the batch.';
COMMENT ON COLUMN MAXDAT.CORP_ETL_MFB_FORM.PAGES IS 'Number of pages using this form type in the batch.';
COMMENT ON COLUMN MAXDAT.CORP_ETL_MFB_FORM.REJECTED_PAGES IS 'Number of rejected pages using this form type in the batch.';
COMMENT ON COLUMN MAXDAT.CORP_ETL_MFB_FORM.COMPLETED_DOCS IS 'For this form type, the number of documents that have completed processing in the batch.';
COMMENT ON COLUMN MAXDAT.CORP_ETL_MFB_FORM.COMPLETED_PAGES IS 'For this form type, the number of pages that have been reviewed in the Quality Control queue. Reviewed pages are tracked if �Require review of scanned pages� is selected in the Quality Control queue properties for the batch class.';
COMMENT ON COLUMN MAXDAT.CORP_ETL_MFB_FORM.STG_EXTRACT_DATE IS 'STG_EXTRACT_DATE';
COMMENT ON COLUMN MAXDAT.CORP_ETL_MFB_FORM.STG_LAST_UPDATE_DATE IS 'STG_LAST_UPDATE_DATE';
COMMENT ON COLUMN MAXDAT.CORP_ETL_MFB_FORM.STG_PROCESSED_DATE IS 'Date that this row was successfully loaded to ETL.';

CREATE or REPLACE VIEW D_MFFORM_CURRENT_SV
AS select
  BATCH_GUID,
  FORM_TYPE_ENTRY_ID,
  BATCH_MODULE_ID,
  TYPE_NAME,
  DOC_CLASS_NAME,
  DOC_COUNT AS DOCUMENT_COUNT,
  REJECTED_DOCS,
  PAGES,
  REJECTED_PAGES,
  COMPLETED_DOCS,
  COMPLETED_PAGES
from CORP_ETL_MFB_FORM WITH READ ONLY;

grant select on CORP_ETL_MFB_FORM to MAXDAT_READ_ONLY; 
grant select on D_MFFORM_CURRENT_SV to MAXDAT_READ_ONLY; 

execute MAXDAT_ADMIN.GATHER_TABLE_STATS('MAXDAT','CORP_ETL_MFB_FORM',4);
