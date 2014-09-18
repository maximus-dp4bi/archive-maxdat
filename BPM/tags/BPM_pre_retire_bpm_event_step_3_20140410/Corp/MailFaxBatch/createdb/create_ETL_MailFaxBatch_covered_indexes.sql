declare  c int;
begin
   select count(*) into c from USER_INDEXES where INDEX_NAME ='IDX_CEMFB_BATCH_OLTP_COVERED';
   if c = 1 then
      execute immediate 'DROP INDEX IDX_CEMFB_BATCH_OLTP_COVERED';
   end if;
end;
/

declare  c int;
begin
   select count(*) into c from USER_INDEXES where INDEX_NAME ='IDX_CEMFB_BATCH_STG_COVERED';
   if c = 1 then
      execute immediate 'DROP INDEX IDX_CEMFB_BATCH_STG_COVERED';
   end if;
end;
/

declare  c int;
begin
   select count(*) into c from USER_INDEXES where INDEX_NAME ='IDX_CEMFB_BATCH_WIP_COVERED';
   if c = 1 then
      execute immediate 'DROP INDEX IDX_CEMFB_BATCH_WIP_COVERED';
   end if;
end;
/

declare  c int;
begin
   select count(*) into c from USER_INDEXES where INDEX_NAME ='IDX_CEMFB_BATCH_COVERED';
   if c = 1 then
      execute immediate 'DROP INDEX IDX_CEMFB_BATCH_COVERED';
   end if;
end;
/

declare  c int;
begin
   select count(*) into c from USER_INDEXES where INDEX_NAME ='IDX_CEMFB_BEVENTS_OLTP_COVERED';
   if c = 1 then
      execute immediate 'DROP INDEX IDX_CEMFB_BEVENTS_OLTP_COVERED';
   end if;
end;
/

declare  c int;
begin
   select count(*) into c from USER_INDEXES where INDEX_NAME ='IDX_CEMFB_BEVENTS_STG_COVERED';
   if c = 1 then
      execute immediate 'DROP INDEX IDX_CEMFB_BEVENTS_STG_COVERED';
   end if;
end;
/

declare  c int;
begin
   select count(*) into c from USER_INDEXES where INDEX_NAME ='IDX_CEMFB_BEVENTS_WIP_COVERED';
   if c = 1 then
      execute immediate 'DROP INDEX IDX_CEMFB_BEVENTS_WIP_COVERED';
   end if;
end;
/

declare  c int;
begin
   select count(*) into c from USER_INDEXES where INDEX_NAME ='IDX_CEMFB_BEVENTS_COVERED';
   if c = 1 then
      execute immediate 'DROP INDEX IDX_CEMFB_BEVENTS_COVERED';
   end if;
end;
/

declare  c int;
begin
   select count(*) into c from USER_INDEXES where INDEX_NAME ='IDX_CEMFB_FORM_OLTP_COVERED';
   if c = 1 then
      execute immediate 'DROP INDEX IDX_CEMFB_FORM_OLTP_COVERED';
   end if;
end;
/

declare  c int;
begin
   select count(*) into c from USER_INDEXES where INDEX_NAME ='IDX_CEMFB_FORM_STG_COVERED';
   if c = 1 then
      execute immediate 'DROP INDEX IDX_CEMFB_FORM_STG_COVERED';
   end if;
end;
/

declare  c int;
begin
   select count(*) into c from USER_INDEXES where INDEX_NAME ='IDX_CEMFB_FORM_WIP_COVERED';
   if c = 1 then
      execute immediate 'DROP INDEX IDX_CEMFB_FORM_WIP_COVERED';
   end if;
end;
/

declare  c int;
begin
   select count(*) into c from USER_INDEXES where INDEX_NAME ='IDX_CEMFB_FORM_COVERED';
   if c = 1 then
      execute immediate 'DROP INDEX IDX_CEMFB_FORM_COVERED';
   end if;
end;
/


declare  c int;
begin
   select count(*) into c from USER_INDEXES where INDEX_NAME ='IDX_CEMFB_ENV_OLTP_COVERED';
   if c = 1 then
      execute immediate 'DROP INDEX IDX_CEMFB_ENV_OLTP_COVERED';
   end if;
end;
/

declare  c int;
begin
   select count(*) into c from USER_INDEXES where INDEX_NAME ='IDX_CEMFB_ENV_STG_COVERED';
   if c = 1 then
      execute immediate 'DROP INDEX IDX_CEMFB_ENV_STG_COVERED';
   end if;
end;
/

declare  c int;
begin
   select count(*) into c from USER_INDEXES where INDEX_NAME ='IDX_CEMFB_ENV_WIP_COVERED';
   if c = 1 then
      execute immediate 'DROP INDEX IDX_CEMFB_ENV_WIP_COVERED';
   end if;
end;
/

declare  c int;
begin
   select count(*) into c from USER_INDEXES where INDEX_NAME ='IDX_CEMFB_ENV_COVERED';
   if c = 1 then
      execute immediate 'DROP INDEX IDX_CEMFB_ENV_COVERED';
   end if;
end;
/

declare  c int;
begin
   select count(*) into c from USER_INDEXES where INDEX_NAME ='IDX_CEMFB_DOC_OLTP_COVERED';
   if c = 1 then
      execute immediate 'DROP INDEX IDX_CEMFB_DOC_OLTP_COVERED';
   end if;
end;
/

declare  c int;
begin
   select count(*) into c from USER_INDEXES where INDEX_NAME ='IDX_CEMFB_DOC_STG_COVERED';
   if c = 1 then
      execute immediate 'DROP INDEX IDX_CEMFB_DOC_STG_COVERED';
   end if;
end;
/

declare  c int;
begin
   select count(*) into c from USER_INDEXES where INDEX_NAME ='IDX_CEMFB_DOC_WIP_COVERED';
   if c = 1 then
      execute immediate 'DROP INDEX IDX_CEMFB_DOC_WIP_COVERED';
   end if;
end;
/

declare  c int;
begin
   select count(*) into c from USER_INDEXES where INDEX_NAME ='IDX_CEMFB_DOC_COVERED';
   if c = 1 then
      execute immediate 'DROP INDEX IDX_CEMFB_DOC_COVERED';
   end if;
end;
/

declare  c int;
begin
   select count(*) into c from USER_INDEXES where INDEX_NAME ='IDX_CEMFB_BARS_OLTP_COVERED';
   if c = 1 then
      execute immediate 'DROP INDEX IDX_CEMFB_BARS_OLTP_COVERED';
   end if;
end;
/

declare  c int;
begin
   select count(*) into c from USER_INDEXES where INDEX_NAME ='IDX_CEMFB_BARS_STG_COVERED';
   if c = 1 then
      execute immediate 'DROP INDEX IDX_CEMFB_BARS_STG_COVERED';
   end if;
end;
/


CREATE INDEX IDX_CEMFB_BATCH_OLTP_COVERED ON CORP_ETL_MFB_BATCH_OLTP (BATCH_GUID,CREATION_STATION_ID,CREATION_USER_NAME,CREATION_USER_ID,BATCH_CLASS,BATCH_CLASS_DES,CANCEL_DT,BATCH_PRIORITY,BATCH_DELETED) tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);
CREATE INDEX IDX_CEMFB_BATCH_STG_COVERED ON CORP_ETL_MFB_BATCH_STG (BATCH_GUID,CREATION_STATION_ID,CREATION_USER_NAME,CREATION_USER_ID,BATCH_CLASS,BATCH_CLASS_DES,CANCEL_DT,BATCH_PRIORITY,BATCH_DELETED) tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);
CREATE INDEX IDX_CEMFB_BATCH_WIP_COVERED ON CORP_ETL_MFB_BATCH_WIP (BATCH_GUID,CREATION_STATION_ID,CREATION_USER_NAME,CREATION_USER_ID,BATCH_CLASS,BATCH_CLASS_DES,CANCEL_DT,BATCH_PRIORITY,BATCH_DELETED) tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);
CREATE INDEX IDX_CEMFB_BATCH_COVERED ON CORP_ETL_MFB_BATCH (BATCH_GUID,CREATION_STATION_ID,CREATION_USER_NAME,CREATION_USER_ID,BATCH_CLASS,BATCH_CLASS_DES,CANCEL_DT,BATCH_PRIORITY,BATCH_DELETED) tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

CREATE INDEX IDX_CEMFB_BEVENTS_OLTP_COVERED ON CORP_ETL_MFB_BATCH_EVENTS_OLTP (BATCH_GUID,BATCH_MODULE_ID,MODULE_CLOSE_ID,MODULE_CLOSE_NAME,MODULE_END_DT,BATCH_STATUS,USER_NAME,STATION_ID,SITE_NAME,SITE_ID,BATCH_DELETED,DOC_PAGES,PAGES_SCANNED,PAGES_DELETED,DOCS_CREATED,DOCS_DELETED,PAGES_REPLACED) tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);
CREATE INDEX IDX_CEMFB_BEVENTS_STG_COVERED ON CORP_ETL_MFB_BATCH_EVENTS_STG (BATCH_GUID,BATCH_MODULE_ID,MODULE_CLOSE_ID,MODULE_CLOSE_NAME,MODULE_END_DT,BATCH_STATUS,USER_NAME,STATION_ID,SITE_NAME,SITE_ID,BATCH_DELETED,DOC_PAGES,PAGES_SCANNED,PAGES_DELETED,DOCS_CREATED,DOCS_DELETED,PAGES_REPLACED) tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);
CREATE INDEX IDX_CEMFB_BEVENTS_WIP_COVERED ON CORP_ETL_MFB_BATCH_EVENTS_WIP (BATCH_GUID,BATCH_MODULE_ID,MODULE_CLOSE_ID,MODULE_CLOSE_NAME,MODULE_END_DT,BATCH_STATUS,USER_NAME,STATION_ID,SITE_NAME,SITE_ID,BATCH_DELETED,DOC_PAGES,PAGES_SCANNED,PAGES_DELETED,DOCS_CREATED,DOCS_DELETED,PAGES_REPLACED) tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);
CREATE INDEX IDX_CEMFB_BEVENTS_COVERED ON CORP_ETL_MFB_BATCH_EVENTS (BATCH_GUID,BATCH_MODULE_ID,MODULE_CLOSE_ID,MODULE_CLOSE_NAME,MODULE_END_DT,BATCH_STATUS,USER_NAME,STATION_ID,SITE_NAME,SITE_ID,BATCH_DELETED,DOC_PAGES,PAGES_SCANNED,PAGES_DELETED,DOCS_CREATED,DOCS_DELETED,PAGES_REPLACED) tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

CREATE INDEX IDX_CEMFB_FORM_OLTP_COVERED ON CORP_ETL_MFB_FORM_OLTP (FORM_TYPE_ENTRY_ID, TYPE_NAME, DOC_CLASS_NAME, DOC_COUNT, REJECTED_DOCS, PAGES, REJECTED_PAGES, COMPLETED_DOCS, COMPLETED_PAGES) tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);
CREATE INDEX IDX_CEMFB_FORM_STG_COVERED ON CORP_ETL_MFB_FORM_STG (FORM_TYPE_ENTRY_ID, TYPE_NAME, DOC_CLASS_NAME, DOC_COUNT, REJECTED_DOCS, PAGES, REJECTED_PAGES, COMPLETED_DOCS, COMPLETED_PAGES) tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);
CREATE INDEX IDX_CEMFB_FORM_WIP_COVERED ON CORP_ETL_MFB_FORM_WIP (FORM_TYPE_ENTRY_ID, TYPE_NAME, DOC_CLASS_NAME, DOC_COUNT, REJECTED_DOCS, PAGES, REJECTED_PAGES, COMPLETED_DOCS, COMPLETED_PAGES) tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);
CREATE INDEX IDX_CEMFB_FORM_COVERED ON CORP_ETL_MFB_FORM (FORM_TYPE_ENTRY_ID, TYPE_NAME, DOC_CLASS_NAME, DOC_COUNT, REJECTED_DOCS, PAGES, REJECTED_PAGES, COMPLETED_DOCS, COMPLETED_PAGES) tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

CREATE INDEX IDX_CEMFB_ENV_OLTP_COVERED ON CORP_ETL_MFB_ENVELOPE_OLTP (BATCH_GUID,ECN,ENV_RECEIPT_DATE,ENV_CREATION_DATE,ENV_DOC_COUNT,ENV_PAGE_COUNT) tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);
CREATE INDEX IDX_CEMFB_ENV_STG_COVERED ON CORP_ETL_MFB_ENVELOPE_STG (BATCH_GUID,ECN,ENV_RECEIPT_DATE,ENV_CREATION_DATE,ENV_DOC_COUNT,ENV_PAGE_COUNT) tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);
CREATE INDEX IDX_CEMFB_ENV_WIP_COVERED ON CORP_ETL_MFB_ENVELOPE_WIP (BATCH_GUID,ECN,ENV_RECEIPT_DATE,ENV_CREATION_DATE,ENV_DOC_COUNT,ENV_PAGE_COUNT) tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);
CREATE INDEX IDX_CEMFB_ENV_COVERED ON CORP_ETL_MFB_ENVELOPE (BATCH_GUID,ECN,ENV_RECEIPT_DATE,ENV_CREATION_DATE,ENV_DOC_COUNT,ENV_PAGE_COUNT) tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

CREATE INDEX IDX_CEMFB_DOC_OLTP_COVERED ON CORP_ETL_MFB_DOCUMENT_OLTP (BATCH_GUID,DOC_ID,DOC_ORDER_NUMBER,TYPE_NAME,DOC_CLASS,DOC_PAGE_COUNT,CLASSIFIED_DOC,DELETED,CONFIDENCE,CONFIDENT) tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);
CREATE INDEX IDX_CEMFB_DOC_STG_COVERED ON CORP_ETL_MFB_DOCUMENT_STG (BATCH_GUID,DOC_ID,DOC_ORDER_NUMBER,TYPE_NAME,DOC_CLASS,DOC_PAGE_COUNT,CLASSIFIED_DOC,DELETED,CONFIDENCE,CONFIDENT) tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);
CREATE INDEX IDX_CEMFB_DOC_WIP_COVERED ON CORP_ETL_MFB_DOCUMENT_WIP (BATCH_GUID,DOC_ID,DOC_ORDER_NUMBER,TYPE_NAME,DOC_CLASS,DOC_PAGE_COUNT,CLASSIFIED_DOC,DELETED,CONFIDENCE,CONFIDENT) tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);
CREATE INDEX IDX_CEMFB_DOC_COVERED ON CORP_ETL_MFB_DOCUMENT (BATCH_GUID,DOC_ID,DOC_ORDER_NUMBER,TYPE_NAME,DOC_CLASS,DOC_PAGE_COUNT,CLASSIFIED_DOC,DELETED,CONFIDENCE,CONFIDENT) tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);

CREATE INDEX IDX_CEMFB_BARS_OLTP_COVERED ON CORP_ETL_MFB_BATCH_ARS_OLTP (BATCH_GUID,BATCH_PAGE_COUNT,BATCH_TYPE,BATCH_DOC_COUNT,BATCH_ENVELOPE_COUNT,CLASSIFICATION_DT,RECOGNITION_DT,VALIDATION_DT) tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);
CREATE INDEX IDX_CEMFB_BARS_STG_COVERED ON CORP_ETL_MFB_BATCH_ARS_STG (BATCH_GUID,BATCH_PAGE_COUNT,BATCH_TYPE,BATCH_DOC_COUNT,BATCH_ENVELOPE_COUNT,CLASSIFICATION_DT,RECOGNITION_DT,VALIDATION_DT) tablespace MAXDAT_INDX pctfree 10 initrans 2 maxtrans 255 storage (initial 64K next 1M minextents 1 maxextents unlimited);



