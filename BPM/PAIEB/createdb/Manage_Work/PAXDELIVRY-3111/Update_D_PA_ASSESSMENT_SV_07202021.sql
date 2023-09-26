/*Drop View*/
DROP VIEW MAXDAT_SUPPORT.D_PA_ASSESSMENT_SV;

/*Create View */
CREATE OR REPLACE VIEW MAXDAT_SUPPORT.D_PA_ASSESSMENT_SV
AS SELECT ss.assessment_id
       ,ss.client_id
       ,ss.assessment_type_cd
       ,null visit_subtype
       ,ss.status_cd
       ,ss.client_address_id addr_id
       ,ss.create_ts visit_create_date
       ,stf.first_name eb_broker_first_name
       ,stf.last_name eb_broker_last_name
       ,eci.report_label visit_reason
       ,cir.report_label visit_cancel_reason
       ,cst.report_label appt_status
       ,st_sup.first_name eb_broker_supervisor_fname
       ,st_sup.last_name eb_broker_supervisor_lname
       ,ss.status_ts assessment_status_date
       ,ci.start_ts
       ,stf.staff_id
FROM assessment ss
 INNER JOIN calendar_item ci ON (ss.calendar_item_id = ci.calendar_item_id)
 LEFT JOIN staff stf ON (ci.ref_id = stf.staff_id AND ci.ref_type = 'STAFF')
 LEFT JOIN groups g ON (g.group_id = stf.default_group_id AND g.type_cd = 'TEAM' AND g.group_name like ('Field EB Unit%'))
 --LEFT JOIN group_staff gf ON (gf.staff_id = stf.staff_id AND gf.group_id in (103100,103083,102955,102954,103055,103056
 --,103057,103058,103059, 103272,103273,103274))
 LEFT JOIN staff st_sup ON (g.supervisor_staff_id = st_sup.staff_id)
 LEFT JOIN enum_calendar_item_status cst ON (ci.item_status_cd = cst.value)
 LEFT JOIN enum_calendar_status_reason cir ON (ci.item_status_reason_cd = cir.value)
 LEFT JOIN enum_calendar_item_reason eci ON (ci.ref_id_2 = eci.value AND ci.ref_type_2 = 'REASON')
WHERE ss.assessment_type_cd IN('INTAKE_VISIT','INTAKE_VISIT_NO_MA','REASSESSMENT','APPEAL_HEARING','IVA_PHONE');

/*Grant Statements*/

GRANT SELECT ON MAXDAT_SUPPORT.D_PA_ASSESSMENT_SV TO MAXDAT_SUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.D_PA_ASSESSMENT_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.D_PA_ASSESSMENT_SV TO MAXDAT_REPORTS; 

commit;

