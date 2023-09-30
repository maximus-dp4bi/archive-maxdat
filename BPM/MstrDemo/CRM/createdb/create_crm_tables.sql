--drop table sci_current_stg;
 CREATE TABLE sci_current_stg
 (ased_create_route_work	DATE
,ased_handle_contact	DATE
,asf_create_route_work	CHAR(1)
,asf_handle_contact	CHAR(1)
,assd_create_route_work	DATE
,assd_handle_contact	DATE
,complete_dt	DATE
,contact_end_dt	DATE
,contact_group	VARCHAR2(256)
,contact_record_id	NUMBER(18)
,contact_start_dt	DATE
,contact_type	VARCHAR2(64)
,create_dt	DATE
,ext_telephony_ref	VARCHAR2(32)
,gwf_work_identified	CHAR(1)
,handle_time	NUMBER
,language	VARCHAR2(256)
,language_cd	VARCHAR2(32)
,last_update_date	DATE
,note_present	CHAR(1)
,supp_contact_group_cd	VARCHAR2(64)
,supp_contact_type_cd	VARCHAR2(64)
,supp_created_by	VARCHAR2(32)
,supp_update_by	VARCHAR2(32)
,supp_worker_id	VARCHAR2(32)
,translation_req	CHAR(1)) TABLESPACE MAXDAT_DATA;

CREATE TABLE sci_current_contact_seq_stg(
contact_record_id NUMBER
,contact_sequence NUMBER) TABLESPACE MAXDAT_DATA;

--create fake users
--drop table staff_fname_stg;
--drop table staff_lname_stg;
CREATE TABLE staff_fname_stg(first_name VARCHAR2(50));
CREATE TABLE staff_lname_stg(last_name VARCHAR2(50));

--drop table crm_staff_stg;
CREATE TABLE crm_staff_stg(staff_id,first_name,last_name)
AS
SELECT  supp_created_by, MAX(first_name)  KEEP(DENSE_RANK FIRST ORDER BY flrv,frv,lrv) first_name
  ,MAX(last_name) KEEP(DENSE_RANK FIRST ORDER BY flrv,frv,lrv) last_name
FROM (
    SELECT first_name, last_name,dbms_random.value flrv,frv,lrv
    FROM(SELECT first_name, dbms_random.value frv
         FROM staff_fname_stg ) f
      CROSS JOIN (SELECT last_name, dbms_random.value lrv
                 FROM staff_lname_stg ) f 
     ORDER BY frv,lrv            ) fl
  CROSS JOIN ( SELECT DISTINCT supp_created_by FROM sci_current_stg
              UNION
              SELECT DISTINCT supp_update_by FROM sci_current_stg
              UNION
             SELECT DISTINCT supp_worker_id FROM sci_current_stg) d    
GROUP BY supp_created_by
;

CREATE TABLE d_sci_staff
AS
SELECT first_name,last_name,staff_id
FROM crm_staff_stg;

--Supervisors
INSERT INTO crm_staff_stg(staff_id,first_name,last_name)
VALUES(281,'Jordan', 'Lim');

INSERT INTO crm_staff_stg(staff_id,first_name,last_name)
VALUES(121,'Scott', 'Paras');

INSERT INTO crm_staff_stg(staff_id,first_name,last_name)
VALUES(10038,'Allan', 'Barkley');

INSERT INTO crm_staff_stg(staff_id,first_name,last_name)
VALUES(10038,'Allan', 'Barkley');

INSERT INTO crm_staff_stg(staff_id,first_name,last_name)
VALUES(129,'Hillary', 'Mather');

CREATE TABLE d_sci_team(
team_id NUMBER
,team_name VARCHAR2(100)
,supervisor_staff_id VARCHAR2(32));

INSERT INTO d_sci_team(team_id,team_name,supervisor_staff_id)
VALUES(1,'Team 1', '128');

INSERT INTO d_sci_team(team_id,team_name,supervisor_staff_id)
VALUES(2,'Team 2', '121');

INSERT INTO d_sci_team(team_id,team_name,supervisor_staff_id)
VALUES(3,'Team 3', '10038');

INSERT INTO d_sci_team(team_id,team_name,supervisor_staff_id)
VALUES(4,'Team 4', '121');

INSERT INTO d_sci_team(team_id,team_name,supervisor_staff_id)
VALUES(5,'Team 5', '281');

CREATE TABLE d_sci_staff_team
AS
SELECT 1 team_id,staff_id
FROM crm_staff_stg
WHERE staff_id in(42,
124,
128,
136,
142,
465,
485,
521,
581,
601,
746,
921,
923,
929,
931);

INSERT INTO d_sci_staff_team(team_id,staff_id)
SELECT 2 team_id,staff_id
FROM crm_staff_stg
WHERE staff_id in(932,
1004,
1021,
1023,
1024,
1044,
1069,
1081,
1082,
1083,
1085,
1086,
1087,
1091,
1092);

INSERT INTO d_sci_staff_team(team_id,staff_id)
SELECT 3 team_id,staff_id
FROM crm_staff_stg
WHERE staff_id in(1121,
1122,
1123,
1124,
1125,
1127,
1145,
1146,
1151,
1162,
1164,
1165,
1166,
1167,
1169);

INSERT INTO d_sci_staff_team(team_id,staff_id)
SELECT 4 team_id,staff_id
FROM crm_staff_stg
WHERE staff_id in(1170,
1171,
1201,
1202,
1203,
1205,
1209,
1210,
1212,
1213,
1216,
1221,
1222,
1223,
1224);

INSERT INTO d_sci_staff_team(team_id,staff_id)
SELECT 5 team_id,staff_id
FROM crm_staff_stg
WHERE staff_id in(1225,
1226,
1227,
1228,
1229,
1230,
1231,
1233,
1234,
1235,
1236,
1237,
1238,
1240,
1241,
1242,
1243);


 CREATE TABLE d_sci_current
 (complete_dt	DATE
,contact_end_dt	DATE
,contact_record_id	NUMBER(18)
,contact_start_dt	DATE
,contact_type	VARCHAR2(64)
,create_dt	DATE
,ext_telephony_ref	VARCHAR2(32)
,gwf_work_identified	CHAR(1)
,handle_time	NUMBER
,language	VARCHAR2(256)
,language_cd	VARCHAR2(32)
,last_update_date	DATE
,note_present	CHAR(1)
,supp_contact_type_cd	VARCHAR2(64)
,supp_created_by	VARCHAR2(32)
,supp_update_by	VARCHAR2(32)
,supp_worker_id	VARCHAR2(32)
,translation_req	CHAR(1)
,consumer_type VARCHAR2(100)
,consumer_role VARCHAR2(100)
,consumer_type_cd VARCHAR2(32)
,consumer_role_cd VARCHAR2(32)
,contact_record_type VARCHAR2(100)
,contact_record_type_cd VARCHAR2(32)
,contact_source VARCHAR2(100)
,contact_source_cd VARCHAR2(32)
,contact_channel VARCHAR2(100)
,contact_channel_cd VARCHAR2(32)
,contact_disposition VARCHAR2(256)
,contact_disposition_cd VARCHAR2(32)
,contact_outcome VARCHAR2(256)
,contact_outcome_cd VARCHAR2(32)
,createdby_operations_group VARCHAR2(100)
,createdby_operations_group_cd VARCHAR2(32)
,createdby_sup_staff_id VARCHAR2(32)
,createdby_sup_staff_name VARCHAR2(100)
,createdby_team_name VARCHAR2(100)
,createdby_team_id NUMBER
,project_id NUMBER
,created_by_first_name VARCHAR2(50)
,created_by_last_name VARCHAR2(50)
,created_by VARCHAR2(100)
,last_update_by_name VARCHAR2(100)
,supp_worker_name VARCHAR2(100)
,created_by_user_role VARCHAR2(50)
,contact_sequence NUMBER
,contact_wrapup_time NUMBER
) TABLESPACE MAXDAT_DATA;

CREATE TABLE D_PROJECT_CONFIGURATION(project_id NUMBER
,project_name VARCHAR2(100)
,project_state VARCHAR2(2)
,project_full_name VARCHAR2(256)) TABLESPACE MAXDAT_DATA;

CREATE OR REPLACE VIEW d_sci_current_sv
AS
SELECT complete_dt
,contact_end_dt
,contact_record_id
,contact_start_dt
,contact_type
,create_dt
,ext_telephony_ref
,gwf_work_identified
,handle_time
,language
,language_cd
,last_update_date
,note_present
,supp_contact_type_cd
,supp_created_by
,supp_update_by
,supp_worker_id
,translation_req
,consumer_type
,consumer_role
,consumer_type_cd
,consumer_role_cd
,contact_record_type
,contact_record_type_cd
,contact_source
,contact_source_cd
,contact_channel
,contact_channel_cd
,contact_disposition
,contact_disposition_cd
,contact_outcome
,contact_outcome_cd
,createdby_operations_group
,createdby_operations_group_cd
,createdby_sup_staff_id
,createdby_sup_staff_name
,createdby_team_name
,createdby_team_id
,sci.project_id
,p.project_name
,p.project_full_name
,p.project_state
,created_by_first_name
,created_by_last_name
,created_by
,last_update_by_name
,supp_worker_name
,created_by_user_role
,CASE WHEN contact_disposition_cd = 'COMPLETE' THEN 'Yes' ELSE 'No' END fcr_indicator
,contact_wrapup_time
,contact_sequence
FROM d_sci_current sci
JOIN d_project_configuration p ON sci.project_id = p.project_id;

GRANT SELECT ON D_SCI_CURRENT_SV TO MAXDAT_READ_ONLY; 

