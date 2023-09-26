USE SCHEMA PUBLIC;
--pbi_cpr_with_notes
CREATE OR REPLACE VIEW mio_d_cases_inprocess_detail_sv AS
SELECT cu.*,
  cp.notes case_pool_notes
FROM coverva_mio.cate_unprocessed cu 
  LEFT JOIN coverva_mio.case_pool cp ON cu.casenumber = cp.case_number
WHERE cu.status NOT IN ('Completed', 'Denied');