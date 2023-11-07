UPDATE coverva_dmas.dmas_file_log x
SET filename = i.new_fn,
  file_date = i.new_fd
FROM(SELECT file_id,filename,
      CASE WHEN filename = 'CVIU_INTAKE_20231010' THEN 'CVIU_INTAKE_20231006' ELSE concat('CVIU_INTAKE','_',to_char(cast(file_date as date)-3,'yyyymmdd')) END new_fn,
      CASE WHEN filename = 'CVIU_INTAKE_20231010' THEN cast(file_date as date)-4 ELSE cast(file_date as date) -3  END new_fd,load_date
     FROM coverva_dmas.dmas_file_log
     WHERE filename IN('CVIU_INTAKE_20231030','CVIU_INTAKE_20231023','CVIU_INTAKE_20231016','CVIU_INTAKE_20231010','CVIU_INTAKE_20231002','CVIU_INTAKE_20230925')
     ) i
WHERE x.file_id = i.file_id     ;

UPDATE coverva_dmas.cviu_intake_data_full_load x
SET x.filename = i.new_fn
FROM(SELECT t.* ,
      CASE WHEN t.filename = 'CVIU_Intake_20231010' THEN 'CVIU_Intake_20231006' ELSE concat('CVIU_Intake','_',to_char(cast(f.file_date as date)-3,'yyyymmdd')) END new_fn
     FROM coverva_dmas.cviu_intake_data_full_load t
       JOIN coverva_dmas.dmas_file_log f ON UPPER(t.filename) = f.filename
     WHERE t.filename IN('CVIU_Intake_20231030','CVIU_Intake_20231023','CVIU_Intake_20231016','CVIU_Intake_20231010','CVIU_Intake_20231002','CVIU_Intake_20230925')
    ) i
WHERE x.cviu_intake_id = i.cviu_intake_id;