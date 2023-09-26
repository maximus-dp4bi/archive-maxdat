alter table s_crs_imr add imr_cc_date date;

CREATE OR REPLACE VIEW S_CRS_IMR_SV AS
SELECT * FROM S_CRS_IMR
with read only;