CREATE OR REPLACE VIEW EMRS_D_PLAN_SV
AS
SELECT plan_id
       ,managed_care_program
       ,csda
       ,plan_code
       ,plan_name
       ,plan_abbreviation
       ,plan_effective_date
       ,address1
       ,address2
       ,city
       ,state
       ,zip
       ,active
       ,contact_first_name
       ,contact_initial
       ,contact_last_name
       ,contact_full_name
       ,contact_phone
       ,contact_extension
       ,member_contact_phone
       ,enrollok
       ,plan_assign
       ,record_date
       ,record_time
       ,record_name
       ,source_record_id
       ,plan_type_id
       ,plan_service_type
FROM emrs_d_plan
WHERE plan_code NOT IN('NOMEDICAIDCHOICEMEDICAL','ZZCD','ZZCM','ZZMB','ZZMD','ZZMM');

CREATE OR REPLACE PUBLIC SYNONYM EMRS_D_PLAN_SV FOR EMRS_D_PLAN_SV;