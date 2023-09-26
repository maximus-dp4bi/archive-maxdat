UPDATE coverva_dmas.dmas_file_load_lkup
SET filename_prefix = 'CVIU_INTAKE'
WHERE filename_prefix = 'INTAKE';

UPDATE coverva_dmas.dmas_file_load_lkup
SET filename_prefix = 'CVIU_DAILY_RELEASE'
WHERE filename_prefix = 'DOC_OFFENDER_RELEASE_FILES';


update coverva_dmas.cviu_intake_data_full_load
set filename = CONCAT('CVIU_',filename);

update coverva_dmas.cviu_daily_release_full_load
set filename = replace(filename,'DOC_Offender_Release_Files','CVIU_Daily_Release');

update coverva_dmas.dmas_file_log
set filename = upper(replace(filename,'DOC_OFFENDER_RELEASE_FILES','CVIU_DAILY_RELEASE'))
where filename_prefix like 'CVIU_DAILY_RELEASE%';

update coverva_dmas.dmas_file_log
set filename_prefix = 'CVIU_INTAKE', filename = upper(CONCAT('CVIU_',filename))
where filename_prefix like 'INTAKE%';