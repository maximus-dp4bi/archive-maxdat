create OR REPLACE view maxdat.D_NYEC_DOCUMENTS_SV as
select * from maxdat.D_NYEC_DOCUMENTS;

create OR REPLACE view maxdat.D_NYEC_BATCHES_SV as
select * from maxdat.D_NYEC_BATCHES;

create OR REPLACE view maxdat.APP_DOC_DATA_NYEC_SV as
select * from maxdat.APP_DOC_DATA_NYEC_STG;

grant select on maxdat.D_NYEC_DOCUMENTS_SV to MAXDAT_READ_ONLY;
grant select on maxdat.D_NYEC_BATCHES_SV to MAXDAT_READ_ONLY;
grant select on maxdat.APP_DOC_DATA_NYEC_SV to MAXDAT_READ_ONLY;
