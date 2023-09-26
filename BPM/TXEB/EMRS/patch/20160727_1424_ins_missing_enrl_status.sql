DECLARE  
  CURSOR temp_cur IS
   SELECT *
FROM (
SELECT t.* , row_number() over (partition by client_number,plan_type_id order by source_record_id) new_version
FROM 
(SELECT null client_enroll_status_id
       ,(SELECT plan_type_id FROM emrs_d_plan_type t WHERE t.plan_type = k.plan_type_cd and t.managed_care_program = k.program_cd) plan_type_id
       ,(SELECT enrollment_status_id FROM emrs_d_enrollment_status es where es.enrollment_status_code = k.enroll_status_cd and es.managed_care_program = k.program_cd) enrollment_status_id
       ,null current_enrollment_status_id
       ,user created_by
       ,create_ts date_created
       ,start_date date_of_validity_start
       ,CASE WHEN end_date IS NULL THEN to_date('12/31/2050','mm/dd/yyyy') ELSE end_date END date_of_validity_end
       ,update_ts date_updated
       ,user updated_by
       ,CASE WHEN end_date IS NULL THEN 'Y' ELSE 'N' END current_flag
       ,client_enroll_status_id source_record_id
       ,client_id client_number       
       ,null version
from client_enroll_status_bak k
--where client_id = 20462065
UNION
SELECT  client_enroll_status_id
       ,plan_type_id
       ,enrollment_status_id
       ,current_enrollment_status_id
       ,created_by
       ,date_created
       ,date_of_validity_start
       ,date_of_validity_end
       ,date_updated
       ,updated_by
       ,current_flag
       ,source_record_id
       ,client_number       
       ,version
from emrs_d_client_plan_enrl_status p
where exists(select 1 from client_enroll_status_bak k where p.client_number = k.client_id)
--and client_number = 20462065 
) t ) f
WHERE (client_enroll_status_id IS NULL
  OR version <> new_version)
and exists(select 1 from  emrs_d_client_ref r where r.client_number = f.client_number)
;
   
  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FOR indx IN 1..temp_tab.COUNT
       LOOP
         IF temp_tab(indx).client_enroll_status_id IS NULL THEN
           INSERT INTO emrs_d_client_plan_enrl_status(plan_type_id
       ,enrollment_status_id
       ,current_enrollment_status_id
       ,created_by
       ,date_created
       ,date_of_validity_start
       ,date_of_validity_end
       ,date_updated
       ,updated_by
       ,current_flag
       ,source_record_id
       ,client_number       
       ,version)
           VALUES(temp_tab(indx).plan_type_id
       ,temp_tab(indx).enrollment_status_id
       ,temp_tab(indx).current_enrollment_status_id
       ,temp_tab(indx).created_by
       ,temp_tab(indx).date_created
       ,temp_tab(indx).date_of_validity_start
       ,temp_tab(indx).date_of_validity_end
       ,temp_tab(indx).date_updated
       ,temp_tab(indx).updated_by
       ,temp_tab(indx).current_flag
       ,temp_tab(indx).source_record_id
       ,temp_tab(indx).client_number       
       ,temp_tab(indx).new_version);
         ELSE
           update emrs_d_client_plan_enrl_status
           set version = temp_tab(indx).new_version             
           where client_enroll_status_id = temp_tab(indx).client_enroll_status_id ;		   
        END IF;
       END LOOP;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

create table selection_txn_bak
as
select * from selection_Txn_stg s
where not exists(select 1 from emrs_d_selection_transaction t where t.source_record_id = s.selection_Txn_id);


insert into emrs_d_selection_transaction(
SOURCE_RECORD_ID,			
SELECTION_TXN_GROUP_ID			,
PROGRAM_TYPE_CD			,
TRANSACTION_TYPE_CD	,		
SELECTION_SOURCE_CD	,		
REF_SOURCE_ID			,
REF_SOURCE_TYPE		,	
REF_EXT_TXN_ID		,	
PLAN_TYPE_CD			,
SOURCE_PLAN_ID		,	
PLAN_ID_EXT			,
CONTRACT_ID			,
NETWORK_ID			,
SOURCE_PROVIDER_ID			,
PROVIDER_ID_EXT			,
PROVIDER_FIRST_NAME	,		
PROVIDER_MIDDLE_NAME,			
PROVIDER_LAST_NAME	,		
START_DATE			,
END_DATE			,
CHOICE_REASON_CD			,
DISENROLL_REASON_CD_1	,		
DISENROLL_REASON_CD_2	,		
OVERRIDE_REASON_CD		,	
FOLLOWUP_REASON_CD		,	
FOLLOWUP_CALL_DATE		,	
FOLLOWUP_FORM_RCV_DATE,			
FOLLOWUP_BY			,
MISSING_INFO_ID	,		
MISSING_SIGNATURE_IND			,
OUTREACH_SESSION_ID			,
BENEFITS_PACKAGE_CD			,
SELECTION_SEGMENT_ID		,	
CLIENT_NUMBER			,
STATUS_DATE			,
CLIENT_AID_CATEGORY_CD			,
COUNTY			,
ZIP_CODE		,	
CLIENT_RESIDENCE_ADDRESS_ID			,
PRIOR_SELECTION_SEGMENT_ID			,
PRIOR_SELECTION_START_DATE			,
PRIOR_SELECTION_END_DATE			,
SOURCE_PRIOR_PLAN_ID			,
PRIOR_PLAN_ID_EXT			,
SOURCE_PRIOR_PROVIDER_ID			,
PRIOR_PROVIDER_ID_EXT			,
PRIOR_PROVIDER_FIRST_NAME	,		
PRIOR_PROVIDER_MIDDLE_NAME,			
PRIOR_PROVIDER_LAST_NAME	,		
REF_SELECTION_TXN_ID			,
SURPLUS_INFO			,
PRIOR_CONTRACT_ID	,		
PRIOR_NETWORK_ID	,		
START_ND			,
END_ND			,
PRIOR_CHOICE_REASON_CD			,
PRIOR_DISENROLL_REASON_CD_1	,		
PRIOR_DISENROLL_REASON_CD_2	,		
PRIOR_CLIENT_AID_CATEGORY_CD,			
PRIOR_COUNTY_CD			,
PRIOR_ZIPCODE			,
ORIGINAL_START_DATE,			
ORIGINAL_END_DATE		,	
SELECTION_GENERIC_FIELD1_DATE			,
SELECTION_GENERIC_FIELD2_DATE			,
SELECTION_GENERIC_FIELD3_NUM			,
SELECTION_GENERIC_FIELD4_NUM			,
SELECTION_GENERIC_FIELD5_TXT			,
SELECTION_GENERIC_FIELD6_TXT			,
SELECTION_GENERIC_FIELD7_TXT			,
SELECTION_GENERIC_FIELD8_TXT			,
SELECTION_GENERIC_FIELD9_TXT			,
SELECTION_GENERIC_FIELD10_TXT			,
RECORD_DATE			,
RECORD_TIME			,
RECORD_NAME			,
MODIFIED_DATE		,	
MODIFIED_NAME		,	
MODIFIED_TIME		,	
CURRENT_SELECTION_STATUS_ID			)
select
selection_txn_id source_record_id
,selection_txn_group_id
,program_type_cd
,transaction_type_cd
,selection_source_cd
,ref_source_id
,ref_source_type
,ref_ext_txn_id
,plan_type_cd
,plan_id source_plan_id
,plan_id_ext
,contract_id
,network_id
,provider_id source_provider_id
,provider_id_ext
,provider_first_name
,provider_middle_name
,provider_last_name
,start_date
,end_date
,choice_reason_cd
,disenroll_reason_cd_1
,disenroll_reason_cd_2
,override_reason_cd
,followup_reason_cd
,followup_call_date
,followup_form_rcv_date
,followup_by
,missing_info_id
,missing_signature_ind
,outreach_session_id
,benefits_package_cd
,selection_segment_id
,client_id client_number
,status_date
,client_aid_category_cd
,county
,zipcode zip_code
,client_residence_address_id
,prior_selection_segment_id
,prior_selection_start_date
,prior_selection_end_date
,prior_plan_id source_prior_plan_id
,prior_plan_id_ext
,prior_provider_id source_prior_provider_id
,prior_provider_id_ext
,prior_provider_first_name
,prior_provider_middle_name
,prior_provider_last_name
,ref_selection_txn_id
,surplus_info
,prior_contract_id
,prior_network_id
,start_nd
,end_nd
,prior_choice_reason_cd
,prior_disenroll_reason_cd_1
,prior_disenroll_reason_cd_2
,prior_client_aid_category_cd
,prior_county_cd
,prior_zipcode
,original_start_date
,original_end_date
,selection_generic_field1_date
,selection_generic_field2_date
,selection_generic_field3_num
,selection_generic_field4_num
,selection_generic_field5_txt
,selection_generic_field6_txt
,selection_generic_field7_txt
,selection_generic_field8_txt
,selection_generic_field9_txt
,selection_generic_field10_txt
,create_ts record_date
,TO_CHAR(create_ts, 'hh24mi') record_time
,created_by record_name
,update_ts modified_date
,updated_by modified_name
,TO_CHAR(update_ts, 'hh24mi') modified_time
,(SELECT selection_status_id FROM EMRS_D_SELECTION_STATUS ss WHERE ss.selection_status_code = t.status_cd AND ss.managed_care_program = t.program_type_cd) slct_status_id
FROM selection_txn_bak t
;
