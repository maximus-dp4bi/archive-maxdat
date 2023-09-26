alter table s_crs_imr add (INJURED_WORKER_ZIP varchar2(255));

CREATE OR REPLACE VIEW S_CRS_IMR_SV AS
SELECT * FROM S_CRS_IMR
with read only;
