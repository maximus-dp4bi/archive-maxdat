create table coverva_dmas.cviu_intake_data_full_load_1111
as
select distinct offender_id,offender_location_type,medicaid_number,filename
from coverva_dmas.cviu_intake_data_full_load
where upper(filename) IN('CVIU_INTAKE_20221111');

delete from coverva_dmas.cviu_intake_data_full_load
where upper(filename) IN('CVIU_INTAKE_20221111');

insert into coverva_dmas.cviu_intake_data_full_load(offender_id,offender_location_type,medicaid_number,filename)
select offender_id,offender_location_type,medicaid_number,filename
from coverva_dmas.cviu_intake_data_full_load_1111;

select distinct offender_id,offender_location_type,medicaid_number,filename
from coverva_dmas.cviu_intake_data_full_load
where upper(filename) IN('CVIU_INTAKE_20221114');

delete from coverva_dmas.cviu_intake_data_full_load
where upper(filename) IN('CVIU_INTAKE_20221114');

delete from coverva_dmas.dmas_file_log
where upper(filename) IN('CVIU_INTAKE_20221114');

update coverva_dmas.dmas_file_log
set row_count = 3380
where upper(filename) IN('CVIU_INTAKE_20221111');

drop table coverva_dmas.cviu_intake_data_full_load_1111;