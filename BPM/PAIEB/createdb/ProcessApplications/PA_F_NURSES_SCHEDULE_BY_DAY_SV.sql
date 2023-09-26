CREATE OR REPLACE VIEW MAXDAT_SUPPORT.PA_F_NURSES_SCHEDULE_BY_DAY_SV
AS
select ci.calendar_item_id as calendar_item_id
      ,asm.assessment_id as assessment_id
      ,cic.description as calendar_item_category
      ,cit.description as calendar_item_type
      ,cst.description as calendar_item_status
      ,cir.description as calendar_item_status_reason
      ,eci.description as assessment_reason
      ,ci.description  as out_of_office_reason
      ,eas.description as assessment_status
      ,asm.status_ts as assessment_status_date
      ,case when ci.ref_type = 'STAFF' then ci.ref_id else 0 end as staff_id
      ,stf.first_name as EB_FIRST_NAME
      ,stf.last_name  as EB_LAST_NAME
      ,CASE WHEN LENGTH(TRIM(stf.LAST_NAME)) < 1 THEN TRIM(stf.FIRST_NAME) 
            WHEN LENGTH(TRIM(stf.FIRST_NAME)) < 1 THEN TRIM(stf.LAST_NAME)
            ELSE TRIM(stf.LAST_NAME) || ', ' || TRIM(stf.FIRST_NAME) 
            END AS EB_FULL_NAME
      ,case when ci.ref_type_3 = 'NURSE' then ci.ref_id_3 else '0' end as nurse_id
      ,asm.client_id as client_id
      ,trim(asm.ref_val_1) as app_id
      ,ci.start_ts as calendar_item_start_ts
      ,ci.end_ts as calendar_item_end_ts
      ,ci.create_ts as calendar_item_create_ts
      ,ci.update_ts as calendar_item_update_ts
      ,ci.status_ts as calendar_item_status_ts
    --- select count(*)  
from   ats.calendar_item ci
left join ats.assessment asm on (ci.calendar_item_id = asm.calendar_item_id)
LEFT JOIN ats.enum_calendar_item_category cic on (ci.category_cd = cic.value)
LEFT JOIN ats.enum_calendar_item_status cst ON (ci.item_status_cd = cst.value)
LEFT JOIN ats.enum_calendar_status_reason cir ON (ci.item_status_reason_cd = cir.value)
LEFT JOIN ats.enum_calendar_item_reason eci ON (ci.ref_id_2 = eci.value AND ci.ref_type_2 = 'REASON')
LEFT JOIN ats.enum_calendar_item_type cit on (ci.type_cd = cit.value)
LEFT JOIN ats.enum_assessment_status eas on (asm.status_cd = eas.value)
LEFT JOIN ats.staff stf on (ci.ref_id = stf.staff_id and ci.ref_type = 'STAFF')
where trunc(ci.create_ts) >= trunc(sysdate - 90) 
order by ci.create_ts desc;


GRANT SELECT ON MAXDAT_SUPPORT.PA_F_NURSES_SCHEDULE_BY_DAY_SV TO MAXDAT_SUPPORT_READ_ONLY;
 
GRANT SELECT ON MAXDAT_SUPPORT.PA_F_NURSES_SCHEDULE_BY_DAY_SV TO MAXDAT_REPORTS; 