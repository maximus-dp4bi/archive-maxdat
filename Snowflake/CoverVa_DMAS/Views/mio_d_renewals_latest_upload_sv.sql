USE SCHEMA PUBLIC;
--pbi_renewals_latest_upload
CREATE OR REPLACE VIEW mio_d_renewals_latest_upload_sv AS
SELECT recip_id,
   case_id,
   vacms_enrl_id,
   case_d_review,
   filedate,
   createdby 
 FROM coverva_mio.upload_renewals ur
   JOIN(SELECT MAX(filedate) max_filedate
        FROM coverva_mio.upload_renewals) urm ON ur.filedate = urm.max_filedate;