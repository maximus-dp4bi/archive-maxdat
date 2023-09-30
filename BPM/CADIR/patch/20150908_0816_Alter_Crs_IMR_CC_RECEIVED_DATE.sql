alter table s_crs_imr
add imr_cc_received_date date;

create or replace view s_crs_imr_sv
as select * from s_crs_imr;