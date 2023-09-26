-- MARS_DP4BI_UAT."PUBLIC".ECMS_D_INBOUND_CORRESPONDENCE_DOCUMENTS_TASK_INSTANCE_SV source

CREATE OR REPLACE VIEW ECMS_D_INBOUND_CORRESPONDENCE_DOCUMENTS_TASK_INSTANCE_SV AS
WITH TASK_DETAILS AS (
SELECT
	*
FROM
	(
	SELECT
		project_id ,
		task_id ,
		task_field_id ,
		selection
	FROM
		(
		SELECT
			task_id ,
			task_field_name ,
			project_id ,
			COALESCE(selection_varchar,
			selection_numeric) AS selection ,
			task_field_id ,
			updated_on ,
			RANK() OVER (PARTITION BY task_field_id,
			task_id,
			project_id
		ORDER BY
			task_detail_history_id DESC) tdcarn
		FROM
			MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW ) r
	WHERE
		tdcarn = 1) pivot (MAX(selection) FOR task_field_id IN (1, 2, 3, 4, 11, 12, 16, 40, 41, 42, 44, 47, 48, 52, 55, 59, 71, 91, 95, 96, 97, 98, 99, 100, 101, 104, 111, 112, 113, 114, 115, 119, 122, 123, 124, 154, 157)) AS P ),
task_date AS (
SELECT
	*
FROM
	(
	SELECT
		project_id ,
		task_id ,
		task_field_id ,
		SELECTION_DATE
	FROM
		(
		SELECT
			task_id ,
			task_field_name ,
			project_id ,
			SELECTION_DATE ,
			task_field_id ,
			updated_on ,
			RANK() OVER (PARTITION BY task_field_id,
			task_id,
			project_id
		ORDER BY
			task_detail_history_id DESC) tdcarn
		FROM
			MARSDB.MARSDB_TASK_DETAIL_HISTORY_VW ) r
	WHERE
		tdcarn = 1) pivot (MAX(SELECTION_DATE) FOR task_field_id IN (104,105,106,132,152,176)) AS P)
SELECT
	ic.project_id AS PROJECT_ID ,
	ic.INBOUND_CORRESPONDENCE_ID AS INBOUND_CORRESPONDENCE_ID ,
	ic.CREATE_DATE_TIME AS INBOUND_CORRESPONDENCE_CREATE_DATE_TIME ,
	t.CREATE_DATE_TIME AS TASK_CREATE_DATE_TIME ,
	ic.INBOUND_CORRESPONDENCE_CHANNEL_TYPE AS INBOUND_CORRESPONDENCE_CHANNEL_TYPE ,
	TO_DATE(ic.RECEIVED_DATE_TIME) AS RECEIVED_DATE ,
	tdat."1" AS Provider_First_Name ,
	tdat."2" AS Provider_Last_Name ,
	tdat."3" AS Case_Worker_First_Name ,
	tdat."4" AS Case_Worker_Last_Name ,
	tdat."11" AS document_about ,
	tdat."12" AS Channel ,
	tdat."16" AS Returned_Mail_Reason ,
	tdat."40" AS From_Phone ,
	tdat."41" AS From_Name ,
	tdat."42" AS ACTION_TAKEN ,
	tdat."44" AS Program ,
	tdat."47" AS Contact_Reason ,
	tdat."48" AS Preferred_Language ,
	tdat."52" AS Provider_Phone ,
	tdat."55" AS application_id ,
	tdat."59" AS Inbound_Correspondence_Type ,
	tdat."71" AS Disposition ,
	tdat."91" AS vacms_case_id ,
	tdat."95" AS Address_Line_1 ,
	tdat."96" AS Address_Line_2 ,
	tdat."97" AS address_city ,
	tdat."98" AS Address_State ,
	tdat."99" AS Address_Zip_Code ,
	tdat."100" AS Business_Unit_100 ,
	tdat."101" AS Email ,
	tdat."104" AS escalation_reason ,
	tdat."111" AS mmis_member_id ,
	tdat."112" AS Facility_Name ,
	tdat."113" AS Facility_Type ,
	tdat."114" AS First_Name ,
	tdat."115" AS Last_Name ,
	tdat."119" AS Locality ,
	tdat."122" AS Organization ,
	tdat."123" AS Phone ,
	tdat."124" AS Provider_Email ,
	dt."132" AS Received_Date_132 ,
	dt."152" AS Date_Resent ,
	tdat."154" AS Issue_Type ,
	tdat."157" AS Request_Type ,
	dt."176" AS Returned_Mail_Received_Date,
	dt."104" AS Date_Translation_Escalated,
	dt."105" AS Date_Translation_Mailed,
	dt."106" AS Date_Translation_Received
	-- Document Type definitions
	--,icd.DESCRIPTION AS DOCUMENT_TYPE
	,ic.DOCUMENT_TYPE AS DOCUMENT_TYPE ,
	ctt.SLA_DAYS AS document_sla_days ,
	ctt.SLA_DAYS_TYPE AS document_sla_type ,
	t.BUSINESS_UNIT_NAME AS BUSINESS_UNIT ,
	t.CURR_OWNER_USER_ID AS document_assignee_user_id ,
	ats.MAXIMUS_ID AS document_assignee_maximus_id ,
	ats.FIRST_NAME AS document_assignee_first_name ,
	ats.LAST_NAME AS document_assignee_last_name
	--,'UNKNOWN' as document_assignee_user_role   
,
	t.TASK_DISPOSITION AS document_disposition ,
	t.TASK_CLAIM_STATUS AS document_claim_status ,
	t.STAFF_WORKED_BY_USER_ID AS document_worked_user_id ,
	wbs.MAXIMUS_ID AS document_worked_by_maximus_id ,
	wbs.FIRST_NAME AS document_worked_by_first_name ,
	wbs.LAST_NAME AS document_worked_by_last_name
	--,'UNKNOWN' as document_worked_by_user_role
,
	t.COMPLETE_DATE_TIME AS document_complete_date_time ,
	t.TASK_AGE AS total_time_worked ,
	t.ESCALATED_TO_USER_ID AS escalated_to_user_id ,
	ets.MAXIMUS_ID AS escalated_to_maximus_id ,
	ets.FIRST_NAME AS escalated_to_last_name ,
	ets.LAST_NAME AS escalated_to_first_name ,
	t.task_id AS source_reference_id
	-- task_id
,
	'Connection Point' AS source_reference_id_type
	-- Connection Point - static
,
	t.TASK_INFO AS document_info ,
	t.TASK_NOTES AS document_notes ,
	t.TASK_AGE AS document_age ,
	'days' AS document_age_type ,
	t.TASK_CYCLE_TIME AS document_cycle_time
	--  ,case when UPPER(tdat.SELECTION_VARCHAR) = 'MAILED_REQUESTED_DOCS' then tdat.updated_on else null end as document_resent_date_time
,
	t.task_priority AS document_priority ,
	t.task_source AS document_source ,
	'Inbound Correspondence' AS escalation_type ,
	ic.INBOUND_CRRESPONDENCE_SCANNED_ON_DATE_TIME AS SCANNED_ON_DATE_TIME ,
	ic.INBOUND_CRRESPONDENCE_LINKED_ON_DATE_TIME AS LINKED_ON_DATE_TIME ,
	ic.DUE_DATE AS DUE_DATE ,
	marsdb.get_business_difference_days (TO_DATE(ic.RECEIVED_DATE_TIME),to_date(ic.INBOUND_CRRESPONDENCE_SCANNED_ON_DATE_TIME),	ic.PROJECT_ID) AS SCANNED_IN_DAYS ,
	marsdb.get_business_difference_days (TO_DATE(ic.RECEIVED_DATE_TIME),to_date(ic.INBOUND_CRRESPONDENCE_LINKED_ON_DATE_TIME),ic.PROJECT_ID) AS LINKED_IN_DAYS ,
	ic.created_by_business_unit_name AS CREATED_BY_BUSINESS_UNIT ,
	t.sla_days_type ,
	t.jeopardy_flag ,
	t.inventory_sla_age_group ,
	T.timeliness_status
FROM
	PUBLIC.ECMS_D_INBOUND_CORRESPONDENCE_DOCUMENTS_INSTANCE_SV ic /*left join
    (select
                    *
                from
                MARSDB.MARSDB_EXTERNAL_LINKS_VW
                where 
                INTERNAL_REF_TYPE = 'INBOUND_CORRESPONDENCE' and
                EXTERNAL_REF_TYPE = 'TASK' AND
                EFFECTIVE_END_DATE IS NULL) lict
                on
                lict.INTERNAL_ID = ic.INBOUND_CORRESPONDENCE_ID and
                lict.PROJECT_ID = ic.PROJECT_ID
*/
	--- Task Info
LEFT JOIN PUBLIC.MW_D_TASK_INSTANCE_SV T ON
	-- lict.EXTERNAL_REF_ID = t.TASK_ID and
 ic.inbound_correspondence_id = t.dcn
	AND ic.project_id = t.project_id
	--- Task type Info
LEFT JOIN MARSDB.CFG_TASK_TYPE ctt ON
	t.task_type_id = ctt.task_type_id
	AND ic.project_id = ctt.project_id
	--- Assignee to info
LEFT JOIN PUBLIC.D_STAFF_SV ats ON
	t.CURR_OWNER_USER_ID = ats.user_id
	AND ic.project_id = ats.project_id
	--- Worked by info
LEFT JOIN PUBLIC.D_STAFF_SV wbs ON
	t.CURR_OWNER_USER_ID = wbs.user_id
	AND ic.project_id = wbs.project_id
	--- Escalated to info
LEFT JOIN PUBLIC.D_STAFF_SV ets ON
	t.CURR_OWNER_USER_ID = ets.user_id
	AND ic.project_id = ets.project_id
	--- Document Type (changed to be the correspondence_type from the inbound correspondence document)
 /*left join
    MARSDB.MARSDB_INBOUND_CORRESPONDENCE_TASK_RULE_VW ictr on
    ictr.task_type_id = t.task_type_id
left join
    MARSDB.MARSDB_INBOUND_CORRESPONDENCE_DEFINITION_VW icd on
    ictr.INBOUND_CORRESPONDENCE_DEFINITION_ID = icd.INBOUND_CORRESPONDENCE_DEFINITION_ID and
    ic.project_id = icd.project_id*/	
LEFT JOIN TASK_DETAILS tdat ON
	t.TASK_ID = tdat.task_id
	AND ic.project_id = tdat.project_id
LEFT JOIN TASK_DATE DT ON
	t.TASK_ID = DT.task_id
	AND ic.project_id = DT.project_id;