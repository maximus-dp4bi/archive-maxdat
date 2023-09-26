--Data cleanup tomorrow 5/18
UPDATE dmas_file_log
SET file_date = CAST('05/12/2023' AS DATE),
filename = 'CVIU_INTAKE_20230512'
WHERE UPPER(filename) = 'CVIU_INTAKE_20230515';

UPDATE cviu_intake_data_full_load
SET filename = 'CVIU_Intake_20230512'
WHERE UPPER(filename) = 'CVIU_INTAKE_20230515';