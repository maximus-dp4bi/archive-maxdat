CREATE OR REPLACE VIEW D_MFB_CURRENT_SV AS
SELECT mfb.*, k.kofax_dcn, k.ecn, k.doc_type
FROM d_mfb_current mfb
  LEFT OUTER JOIN kofax_maxdat_reporting_stg k
    ON mfb.batch_id = k.batch_id 
with read only;


grant select on D_MFB_CURRENT_SV to MAXDAT_READ_ONLY;