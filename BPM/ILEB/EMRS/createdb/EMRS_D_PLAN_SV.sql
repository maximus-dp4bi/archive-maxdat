CREATE OR REPLACE VIEW MAXDAT.EMRS_D_PLAN_SV
AS
SELECT a.plan_id
       ,a.managed_care_program
       ,a.csda
       ,a.plan_code
       ,a.plan_name
       ,a.plan_abbreviation
       ,a.plan_effective_date
       ,a.address1
       ,a.address2
       ,a.city
       ,a.state
       ,a.zip
       ,a.active
       ,a.contact_first_name
       ,a.contact_initial
       ,a.contact_last_name
       ,a.contact_full_name
       ,a.contact_phone
       ,a.contact_extension
       ,a.member_contact_phone
       ,a.enrollok
       ,a.plan_assign
       ,a.record_date
       ,a.record_time
       ,a.record_name
       ,a.source_record_id
       ,a.plan_type_id
       ,a.plan_service_type
       ,b.plan_id_ext
FROM emrs_d_plan a
LEFT JOIN EMRS_D_SELECTION_Transaction b
ON (a.source_record_id = b.source_record_id);
/

GRANT SELECT ON MAXDAT.EMRS_D_PLAN_SV TO MAXDAT_READ_ONLY;

