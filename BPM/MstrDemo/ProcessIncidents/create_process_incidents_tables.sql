--create stage table
CREATE TABLE pi_current_stg(
		cancel_date	DATE
,	instance_status_code	NUMBER
,	process_client_notification_id	NUMBER
,	age_in_calendar_days	NUMBER(38,0)
,	age_in_business_days	NUMBER
,	channel_code	VARCHAR2(30 BYTE)
,	origin_id	NUMBER(18,0)
,	created_by_group_id	NUMBER
,	create_date	DATE
,	receipt_date	DATE
,	hearing_tracking_number	VARCHAR2(32 BYTE)
,	incident_tracking_number	VARCHAR2(32 BYTE)
,	client_id	NUMBER
,	app_id	VARCHAR2(128 BYTE)
,	incident_id	NUMBER(18,0)
,	other_party_type_cd	VARCHAR2(50 BYTE)
,	three_way_call_result_cd	VARCHAR2(30 BYTE)
,	three_way_call_date	DATE
,	escalate_date	DATE
,	created_by_id	VARCHAR2(80 BYTE)
,	resolution_description	VARCHAR2(4000 BYTE)
,	incident_description	VARCHAR2(4000 BYTE)
,	action_comments	VARCHAR2(4000 BYTE)
,	cancel_method	CHAR(6 BYTE)
,	cancel_reason	CHAR(18 BYTE)
,	cancel_by_id	VARCHAR2(80 BYTE)
,	research_incident_flag	CHAR(1 BYTE)
,	reporter_phone	VARCHAR2(32 BYTE)
,	generic_field_5	VARCHAR2(50 BYTE)
,	generic_field_4	VARCHAR2(50 BYTE)
,	generic_field_3	VARCHAR2(50 BYTE)
,	generic_field_2	VARCHAR2(50 BYTE)
,	generic_field_1	VARCHAR2(50 BYTE)
,	return_to_mms_dt	DATE
,	complete_incident_flag	VARCHAR2(1 BYTE)
,	complete_incident_end_dt	DATE
,	complete_incident_st_dt	DATE
,	return_incident_flag	VARCHAR2(1 BYTE)
,	process_incident_flag	VARCHAR2(1 BYTE)
,	process_incident_end_dt	DATE
,	process_incident_st_dt	DATE
,	research_incident_end_dt	DATE
,	research_incident_st_dt	DATE
,	other_party_name	VARCHAR2(80 BYTE)
,	eb_followup_needed_flag	CHAR(1 BYTE)
,	timeliness_status	CHAR(2 BYTE)
,	selection_id	NUMBER(18,0)
,	hearing_date	DATE
,	state_received_appeal_date	DATE
,	cur_task_id	NUMBER
,	escalate_to_state_dt	DATE
,	escalate_incident_flag	VARCHAR2(1 BYTE)
,	process_clnt_notify_flag	VARCHAR2(1 BYTE)
,	process_clnt_notify_end_dt	DATE
,	process_clnt_notify_start_dt	DATE
,	notify_client_flag	CHAR(1 BYTE)
,	resolution_type_code	VARCHAR2(50 BYTE)
,	action_type_code	VARCHAR2(50 BYTE)
,	provider_id	VARCHAR2(50 BYTE)
,	plan_code	VARCHAR2(50 BYTE)
,	updated_by	VARCHAR2(80 BYTE)
,	cur_last_update_date	DATE
,	subprogram_code	VARCHAR2(32 BYTE)
,	program	CHAR(8 BYTE)
,	priority_code	VARCHAR2(30 BYTE)
,	cur_enrollment_status	VARCHAR2(50 BYTE)
,	case_id	NUMBER
,	reporter_relationship_code	VARCHAR2(32 BYTE)
,	reported_by_code	VARCHAR2(30 BYTE)
,	complete_date	DATE
,	jeopardy_status_date	DATE
,	jeopardy_status_code	NUMBER
,	status_age_in_calendar_days	NUMBER
,	status_age_in_business_days	NUMBER
,	cur_incident_status_date	DATE
,	incident_status_code	VARCHAR2(30 BYTE)
,	about_plan_code	VARCHAR2(128 BYTE)
,	about_provider_id	VARCHAR2(128 BYTE)
,	incident_reason_code	VARCHAR2(30 BYTE)
,	incident_about_code	VARCHAR2(30 BYTE)
,	incident_type_code	VARCHAR2(30 BYTE)
,	incident_reason	VARCHAR2(64 BYTE)
,	incident_about	VARCHAR2(64 BYTE)
,	incident_type	VARCHAR2(64 BYTE)
,	jeopardy_status	VARCHAR2(64 BYTE)
,	subprogram	VARCHAR2(64 BYTE)
,	resolution_type	VARCHAR2(64 BYTE)
,	reporter_relationship	VARCHAR2(64 BYTE)
,	reported_by	VARCHAR2(64 BYTE)
,	plan_id	NUMBER
,	plan_name	VARCHAR2(256 BYTE)
,	other_party_type	VARCHAR2(64 BYTE)
,	instance_status	VARCHAR2(64 BYTE)
,	incident_status	VARCHAR2(64 BYTE)
,	action_type	VARCHAR2(64 BYTE)
,	channel	VARCHAR2(64 BYTE)
,	team_name	VARCHAR2(256 BYTE)  
) TABLESPACE MAXDAT_DATA;

--Run ETL to populate stage table

--To use existing scrubbed clients in MstrDemo DB
drop table client_stg;
create table client_stg
as SELECT DISTINCT client_id,rank() over(order by client_id) rn
            FROM pi_current_stg
            where client_id > 0;

create table nw_client_stg
as
SELECT client_id new_client_id,case_id new_case_id, rank() over(order by client_id) rn
              FROM scid_consumer_stg;

drop table case_stg;              
create table case_stg
as SELECT DISTINCT incident_id,case_id, rank() over(order by case_id) rn
            FROM pi_current_stg
           where client_id = 0
and case_id != 0; 

drop table nw_case_stg;
create table nw_case_stg
as
select * from(
select new_case_id,rank() over(ORDER BY new_case_id) rn
from(SELECT distinct case_id new_case_id
FROM scid_consumer_stg))
WHERE rn < 29
;

BEGIN
FOR x IN(SELECT * FROM client_stg cl
          JOIN nw_client_stg s on cl.rn = s.rn) LOOP
  UPDATE pi_current_stg
  SET client_id = x.new_client_id
     ,case_id = x.new_case_id
  WHERE client_id = x.client_id;
END LOOP;
END;
/

BEGIN
FOR x IN(SELECT * FROM case_stg cl
          JOIN nw_case_stg s on cl.rn = s.rn) LOOP
  UPDATE pi_current_stg
  SET case_id = x.new_case_id
  WHERE incident_id = x.incident_id;
END LOOP;
END;
/

--to populate main table
CREATE TABLE d_pi_current
AS SELECT pi.* 
        ,cl.case_cin
        ,cl.clnt_cin
        ,cl.case_first_name
        ,cl.case_last_name
        ,cl.addr_street_1
        ,cl.addr_street_2
        ,cl.addr_city
        ,cl.addr_state_cd
        ,cl.addr_county
        ,cl.addr_zip
        ,cl.addr_zip_four
        ,CASE WHEN pi.reporter_relationship = 'Self' THEN cl.case_first_name ELSE NULL END reporter_first_name
        ,CASE WHEN pi.reporter_relationship = 'Self' THEN cl.case_last_name ELSE NULL END reporter_last_name
FROM pi_current_stg pi
JOIN (SELECT  *             
      FROM(SELECT DISTINCT case_id
              , client_id
              , case_cin
              , clnt_cin
              , case_first_name
              , case_last_name
              , addr_street_1
              , addr_street_2
              , addr_city
              , addr_state_cd
              , addr_county
              , addr_zip
              , addr_zip_four
              , address_type
              , RANK() OVER (PARTITION BY client_id ORDER BY contact_record_link_id) rnk              
          FROM d_scid_current d
          WHERE EXISTS(SELECT 1 FROM pi_current_stg p WHERE d.client_id = p.client_id))
          WHERE rnk = 1) cl ON pi.client_id = cl.client_id;

--Insert records where client_id = 0
INSERT INTO d_pi_current(	cancel_date
,	instance_status_code
,	process_client_notification_id
,	age_in_calendar_days
,	age_in_business_days
,	channel_code
,	origin_id
,	created_by_group_id
,	create_date
,	receipt_date
,	hearing_tracking_number
,	incident_tracking_number
,	client_id
,	app_id
,	incident_id
,	other_party_type_cd
,	three_way_call_result_cd
,	three_way_call_date
,	escalate_date
,	created_by_id
,	resolution_description
,	incident_description
,	action_comments
,	cancel_method
,	cancel_reason
,	cancel_by_id
,	research_incident_flag
,	reporter_phone
,	generic_field_5
,	generic_field_4
,	generic_field_3
,	generic_field_2
,	generic_field_1
,	return_to_mms_dt
,	complete_incident_flag
,	complete_incident_end_dt
,	complete_incident_st_dt
,	return_incident_flag
,	process_incident_flag
,	process_incident_end_dt
,	process_incident_st_dt
,	research_incident_end_dt
,	research_incident_st_dt
,	other_party_name
,	eb_followup_needed_flag
,	timeliness_status
,	selection_id
,	hearing_date
,	state_received_appeal_date
,	cur_task_id
,	escalate_to_state_dt
,	escalate_incident_flag
,	process_clnt_notify_flag
,	process_clnt_notify_end_dt
,	process_clnt_notify_start_dt
,	notify_client_flag
,	resolution_type_code
,	action_type_code
,	provider_id
,	plan_code
,	updated_by
,	cur_last_update_date
,	subprogram_code
,	program
,	priority_code
,	cur_enrollment_status
,	case_id
,	reporter_relationship_code
,	reported_by_code
,	complete_date
,	jeopardy_status_date
,	jeopardy_status_code
,	status_age_in_calendar_days
,	status_age_in_business_days
,	cur_incident_status_date
,	incident_status_code
,	about_plan_code
,	about_provider_id
,	incident_reason_code
,	incident_about_code
,	incident_type_code
,	incident_reason
,	incident_about
,	incident_type
,	jeopardy_status
,	subprogram
,	resolution_type
,	reporter_relationship
,	reported_by
,	plan_id
,	plan_name
,	other_party_type
,	instance_status
,	incident_status
,	action_type
,	channel
,	team_name
,	case_cin
,	clnt_cin
,	case_first_name
,	case_last_name
,	addr_street_1
,	addr_street_2
,	addr_city
,	addr_state_cd
,	addr_county
,	addr_zip
,	addr_zip_four
,	reporter_first_name
,	reporter_last_name
)
SELECT pi.* 
        ,cl.case_cin
        ,cl.clnt_cin
        ,cl.case_first_name
        ,cl.case_last_name
        ,cl.addr_street_1
        ,cl.addr_street_2
        ,cl.addr_city
        ,cl.addr_state_cd
        ,cl.addr_county
        ,cl.addr_zip
        ,cl.addr_zip_four
        ,CASE WHEN pi.reporter_relationship = 'Self' THEN cl.case_first_name ELSE NULL END reporter_first_name
        ,CASE WHEN pi.reporter_relationship = 'Self' THEN cl.case_last_name ELSE NULL END reporter_last_name
FROM pi_current_stg pi
JOIN (SELECT  *             
      FROM(SELECT DISTINCT case_id
              , client_id
              , case_cin
              , clnt_cin
              , case_first_name
              , case_last_name
              , addr_street_1
              , addr_street_2
              , addr_city
              , addr_state_cd
              , addr_county
              , addr_zip
              , addr_zip_four
              , address_type
              , RANK() OVER (PARTITION BY case_id ORDER BY contact_record_link_id) rnk              
            FROM d_scid_current d
            WHERE EXISTS(SELECT 1 FROM pi_current_stg p WHERE d.case_id = p.case_id))
            WHERE rnk = 1) cl ON pi.case_id = cl.case_id
WHERE pi.client_id = 0;

--Populate reporter name if relationship is other than 'Self'
UPDATE d_pi_current
SET reporter_first_name = 'BEVERLY'
  ,reporter_last_name = 'CHAPMAN'
WHERE case_id = 3465;

UPDATE d_pi_current
SET reporter_first_name = 'DANNY'
  ,reporter_last_name = 'SMITH'
WHERE case_id = 4482;

UPDATE d_pi_current
SET reporter_first_name = 'DIANA'
  ,reporter_last_name = 'TROI'
WHERE case_id = 2430;

UPDATE d_pi_current
SET reporter_first_name = case_first_name
   ,reporter_last_name = case_last_name
WHERE reported_by  = 'CLIENT'
AND reporter_relationship IS NULL;   

UPDATE d_pi_current
SET reporter_first_name = 'JOHN'
    ,reporter_last_name = 'KIM'
WHERE reported_by_code = '0'
AND reporter_first_name IS NULL;

UPDATE d_pi_current
SET reporter_first_name = CASE WHEN SUBSTR(case_first_name,1,1) = 'A' THEN 'JANE'
                               WHEN SUBSTR(case_first_name,1,1) = 'S' THEN 'JOHN'
                               WHEN SUBSTR(case_first_name,1,1) = 'W' THEN 'WESLEY'
                               WHEN SUBSTR(case_first_name,1,1) = 'M' THEN 'MATILDA'
                               WHEN SUBSTR(case_first_name,1,1) = 'N' THEN 'NANCY'
                               WHEN SUBSTR(case_first_name,1,1) = 'B' THEN 'BRIANA'
                           ELSE 'PETER' END    
    ,reporter_last_name = case_last_name
WHERE reported_by_code != '0'
AND reporter_first_name IS NULL;  

--scrub hearing_tracking_number

MERGE INTO d_pi_current pi
USING(
  SELECT incident_id,hearing_tracking_number 
       ,CASE WHEN INSTR(hearing_tracking_number,'2') >0 THEN REPLACE(hearing_tracking_number,'2','8')
             WHEN INSTR(hearing_tracking_number,'3') >0 THEN REPLACE(hearing_tracking_number,'3','6')
             WHEN INSTR(hearing_tracking_number,'4') >0 THEN REPLACE(hearing_tracking_number,'4','1')
             WHEN INSTR(hearing_tracking_number,'5') >0 THEN REPLACE(hearing_tracking_number,'5','7')
             WHEN INSTR(hearing_tracking_number,'6') >0 THEN REPLACE(hearing_tracking_number,'6','2')            
             WHEN INSTR(hearing_tracking_number,'7') >0 THEN REPLACE(hearing_tracking_number,'7','4')
             WHEN INSTR(hearing_tracking_number,'8') >0 THEN REPLACE(hearing_tracking_number,'8','5')
             WHEN INSTR(hearing_tracking_number,'9') >0 THEN REPLACE(hearing_tracking_number,'9','3')
        ELSE REPLACE(hearing_tracking_number,'1','9')     END new_hearing_tracking_number
 FROM d_pi_current
 WHERE hearing_Tracking_number IS NOT NULL) tmp ON (pi.incident_id = tmp.incident_id)
WHEN MATCHED THEN
UPDATE SET pi.hearing_tracking_number = tmp.new_hearing_tracking_number;

-- Change staff ids to existing staff ids in d_staff table
CREATE TABLE pi_staff_stg
AS
SELECT staff_id,rownum rn 
FROM(
SELECT created_by_id staff_id
FROM d_pi_current
UNION
SELECT updated_by
FROM d_pi_current);
 
BEGIN
FOR x IN(SELECT staff_id, new_staff_id,first_name,last_name
         FROM pi_staff_stg pi
         JOIN(SELECT staff_id new_staff_id,first_name,last_name, RANK() OVER(ORDER BY staff_id) rn FROM d_staff WHERE staff_id > 12000) s ON pi.rn = s.rn)
LOOP
  UPDATE d_pi_current
  SET created_by_id = x.new_staff_id
  WHERE created_by_id = x.staff_id;
  
  UPDATE d_pi_current
  SET updated_by = x.new_staff_id
  WHERE updated_by = x.staff_id;
  
END LOOP;
END;
/

CREATE OR REPLACE VIEW d_pi_current_sv
AS
SELECT
