CREATE OR REPLACE VIEW EMRS_D_CARE_SERV_DELIV_AREA_SV
AS
SELECT csda_id
       ,managed_care_program
       ,csda_code
       ,csda_name
       ,region_number_category
       ,status
       ,implementation_date
       ,record_date
       ,record_time
       ,record_name
       ,modified_date
       ,modified_name
       ,starplus
       ,source_record_id
FROM emrs_d_care_serv_deliv_area
WHERE csda_code != 'DENTAL';

GRANT SELECT ON EMRS_D_CARE_SERV_DELIV_AREA_SV TO MAXDAT_READ_ONLY;