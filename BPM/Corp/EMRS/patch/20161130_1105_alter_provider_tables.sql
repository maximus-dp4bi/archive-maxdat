ALTER TABLE emrs_s_provider_stg
MODIFY (ofc_hr_open_from VARCHAR2(200)
       ,ofc_hr_close_at VARCHAR2(200)
       ,ofc_hr_days_of_week VARCHAR2(200));
       
ALTER TABLE emrs_d_provider
MODIFY (ofc_hr_open_from VARCHAR2(200)
       ,ofc_hr_close_at VARCHAR2(200)
       ,ofc_hr_days_of_week VARCHAR2(200));