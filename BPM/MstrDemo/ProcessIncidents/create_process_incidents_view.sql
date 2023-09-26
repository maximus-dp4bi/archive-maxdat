CREATE OR REPLACE VIEW d_pi_current_sv
AS
SELECT 
	pi.about_plan_code
,	pi.client_id
,	pi.about_provider_id
,	pi.action_comments
,	pi.action_type_code
,	pi.age_in_calendar_days
,	pi.age_in_business_days
, CASE WHEN cancel_date IS NOT NULL THEN CASE WHEN pi.cancel_by_id = '0' THEN 'Unknown' ELSE cb.first_name||' '||cb.last_name END ELSE NULL END cancel_by
,	pi.cancel_date
,	pi.cancel_method
,	pi.cancel_reason
,	pi.case_id
,	pi.channel
,	pi.complete_incident_flag
,	pi.complete_incident_end_dt
,	pi.complete_incident_st_dt
, pi.addr_county county
,	pi.create_date
,	pi.team_name
, CASE WHEN pi.created_by_id = '0' THEN 'Unknown' ELSE cr.first_name||' '||cr.last_name END created_by_name
,	pi.cur_task_id
,	pi.eb_followup_needed_flag
,	pi.cur_enrollment_status
,	pi.escalate_to_state_dt
,	pi.escalate_incident_flag
,	pi.hearing_date
,	pi.incident_about
,	pi.incident_description
,	pi.incident_id
,	pi.incident_reason
,	pi.incident_status
,	pi.cur_incident_status_date
,	pi.incident_tracking_number
,	pi.incident_type
,	pi.instance_status
,	pi.jeopardy_status
,	pi.jeopardy_status_date
, CASE WHEN pi.updated_by = '0' THEN 'Unknown' ELSE ur.first_name||' '||ur.last_name END last_updated_by_name
,	pi.cur_last_update_date
,	pi.notify_client_flag
,	pi.origin_id
,	pi.other_party_name
,	pi.plan_code
,	pi.plan_id
,	pi.priority_code priority
,	pi.process_clnt_notify_end_dt
,	pi.process_clnt_notify_flag
,	pi.process_client_notification_id
,	pi.process_clnt_notify_start_dt
,	pi.process_incident_end_dt
,	pi.process_incident_flag
,	pi.process_incident_st_dt
,	pi.program
,	pi.provider_id
,	pi.receipt_date
,	pi.created_by_id
,	pi.reported_by
,	pi.reporter_first_name
,	pi.reporter_last_name
,	pi.reporter_phone
,	pi.reporter_relationship
,	pi.research_incident_end_dt
,	pi.research_incident_st_dt
,	pi.research_incident_flag
,	pi.resolution_description
,	pi.resolution_type
,	pi.resolution_type_code
,	pi.three_way_call_result_cd
,	pi.return_incident_flag
,	pi.return_to_mms_dt
,	pi.selection_id
,	pi.state_received_appeal_date
,	pi.status_age_in_business_days
,	pi.status_age_in_calendar_days
,	pi.subprogram
,	pi.timeliness_status
,	pi.complete_date
,	pi.app_id
, pi.addr_street_1||CASE WHEN pi.addr_street_2 IS NOT NULL THEN ' '||pi.addr_street_2||' ' ELSE NULL END||pi.addr_city||' '||pi.addr_state_cd||' '||pi.addr_zip||CASE WHEN pi.addr_zip_four IS NOT NULL THEN '-'||pi.addr_zip_four ELSE NULL END case_address
,	pi.case_cin
, pi.case_first_name||' '||pi.case_last_name case_head_name
,	pi.clnt_cin
,	pi.hearing_tracking_number
,	pi.three_way_call_date
,	pi.plan_name
,	pi.action_type
,	pi.generic_field_1
,	pi.generic_field_2
,	pi.generic_field_3
,	pi.generic_field_4
,	pi.generic_field_5
, CASE WHEN pi.complete_date IS NOT NULL AND pi.create_date IS NOT NULL THEN
      (SELECT
          CASE
            WHEN (COUNT(*)-1) < 0
            THEN 0
            ELSE COUNT(*)-1
          END
        FROM bpm_d_dates
        WHERE business_day_flag = 'Y' AND d_date BETWEEN TRUNC(pi.create_date) AND TRUNC(pi.complete_date)) ELSE NULL END cycle_time_in_bus_days
 ,CASE WHEN pi.complete_date IS NOT NULL AND pi.create_date IS NOT NULL THEN TRUNC(pi.complete_date) - TRUNC(pi.create_date) ELSE NULL END cycle_time_in_cal_days
FROM d_pi_current pi
 LEFT JOIN d_staff cb ON pi.cancel_by_id = cb.staff_id
 LEFT JOIN d_staff cr ON pi.created_by_id = cr.staff_id
 LEFT JOIN d_staff ur ON pi.updated_by = ur.staff_id
 ;
 
GRANT SELECT ON d_pi_current_sv TO maxdat_read_only;

CREATE OR REPLACE VIEW f_pi_by_date_sv 
AS
 
SELECT d_date
  ,SUM(creation_count) creation_count
  ,SUM(completion_count) completion_count
  ,SUM(inventory_count) inventory_count
  ,ROUND(AVG(inv_age_in_calendar_days),2) avg_inv_age_in_calendar_days
  ,ROUND(AVG(inv_age_in_business_days),2) avg_inv_age_in_business_days
  ,MAX(inv_age_in_calendar_days) max_inv_age_in_calendar_days
  ,MAX(inv_age_in_business_days) max_inv_age_in_business_days
FROM(
 SELECT i.incident_id pi_bi_id ,
    d.d_date ,
    i.create_date ,
    i.complete_date,
    (
    CASE
      WHEN i.create_date IS NOT NULL AND (CASE WHEN complete_date IS NOT NULL  THEN i.cur_incident_status_date  ELSE d.d_date END) IS NOT NULL
      THEN
        (SELECT
          CASE
            WHEN (COUNT(*)-1) < 0
            THEN 0
            ELSE COUNT(*)-1
          END
        FROM bpm_d_dates
        WHERE business_day_flag = 'Y' AND d_date BETWEEN i.create_date AND (
          CASE
            WHEN complete_date IS NOT NULL
            THEN
              CASE
                WHEN i.cur_incident_status_date < d.d_date
                THEN i.cur_incident_status_date
                ELSE d.d_date
              END
            ELSE d.d_date
          END)
        )
      ELSE 0
    END ) inv_age_in_business_days ,
    TRUNC(
    CASE
      WHEN complete_date IS NOT NULL THEN
        CASE
          WHEN i.cur_incident_status_date < d.d_date
          THEN i.cur_incident_status_date
          ELSE d.d_date
        END
      ELSE d.d_date
    END) - TRUNC(i.create_date) inv_age_in_calendar_days ,
    CASE
      WHEN complete_date IS NOT NULL AND d.d_date = TRUNC(i.cur_incident_status_date)
      THEN 0
      ELSE 1
    END AS inventory_count ,
    CASE
      WHEN d_date = TRUNC(i.create_date)
      THEN 1
      ELSE 0
    END creation_count ,
    CASE
      WHEN complete_date IS NOT NULL AND d.d_date = TRUNC(i.cur_incident_status_date)
      THEN 1
      ELSE 0
    END AS completion_count ,
    i.cur_last_update_date last_update_date ,
    i.cur_incident_status_date incident_status_date
FROM bpm_d_dates D
  JOIN d_pi_current i ON d.d_date BETWEEN TRUNC(i.create_date) AND CASE WHEN complete_date IS NOT NULL THEN TRUNC(i.cur_incident_status_date) ELSE TRUNC(sysdate) END  
 )
GROUP BY d_date;

GRANT SELECT ON f_pi_by_date_sv TO maxdat_read_only;                                      