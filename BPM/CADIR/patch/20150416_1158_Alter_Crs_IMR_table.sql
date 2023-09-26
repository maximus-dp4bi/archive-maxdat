alter table s_crs_imr add (dummy_records_flg varchar2(1) default 'N') ;

CREATE OR REPLACE VIEW S_CRS_IMR_SV AS
SELECT * FROM S_CRS_IMR
with read only;