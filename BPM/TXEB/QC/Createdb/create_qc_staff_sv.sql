CREATE OR REPLACE VIEW qc_staff_sv
AS
SELECT
staff_id
,ext_staff_number
,dob
,ssn
,first_name
,first_name_canon
,first_name_sound_like
,gender_cd
,start_date
,end_date
,phone_number
,last_name
,last_name_canon
,last_name_sound_like
,created_by
,create_ts
,updated_by
,update_ts
,middle_name
,middle_name_canon
,middle_name_sound_like
,email
,fax_number
,note_refid
,deployment_staff_num
,default_group_id
,staff_type_cd
,unique_staff_id
,void_ind
,title
,supervisor_empid
,CASE WHEN MONTHS_BETWEEN(TRUNC(sysdate,'mm'),TRUNC(start_date,'mm')) <= 3 THEN '0 - 3 Months'
      WHEN MONTHS_BETWEEN(TRUNC(sysdate,'mm'),TRUNC(start_date,'mm')) > 3 AND MONTHS_BETWEEN(TRUNC(sysdate,'mm'),TRUNC(start_date,'mm')) <= 6 THEN '4 - 6 Months'
      WHEN MONTHS_BETWEEN(TRUNC(sysdate,'mm'),TRUNC(start_date,'mm')) > 6 AND MONTHS_BETWEEN(TRUNC(sysdate,'mm'),TRUNC(start_date,'mm')) <= 9  THEN '7 - 9 Months'
      WHEN MONTHS_BETWEEN(TRUNC(sysdate,'mm'),TRUNC(start_date,'mm')) > 9 AND MONTHS_BETWEEN(TRUNC(sysdate,'mm'),TRUNC(start_date,'mm')) <= 12  THEN '10 - 12 Months'
      WHEN MONTHS_BETWEEN(TRUNC(sysdate,'mm'),TRUNC(start_date,'mm')) > 12 THEN '> 1 Year'
   ELSE 'Undefined' END tenure_band
FROM qc_staff;

grant select on QC_STAFF_SV to maxdat_read_only;
grant select on QC_STAFF_SV to maxdat_reports;

