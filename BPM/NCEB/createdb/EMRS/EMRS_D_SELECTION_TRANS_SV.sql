drop view EMRS_D_SELECTION_TRANS_SV;
CREATE OR REPLACE VIEW EMRS_D_SELECTION_TRANS_SV AS
  select * 
  from 
  (
  SELECT /*+ parallel(10) */
    COALESCE(st.SELECTION_TXN_ID,ss.SELECTION_SEGMENT_ID*-1)  AS SELECTION_TRANSACTION_ID,
    COALESCE(st.SELECTION_TXN_ID,ss.SELECTION_SEGMENT_ID*-1)  AS SOURCE_RECORD_ID,
    ss.SELECTION_SEGMENT_ID  AS SELECTION_SEGMENT_ID,
    st.CLIENT_ID AS CLIENT_ID,      
    COALESCE(st.CLIENT_AID_CATEGORY_CD,  '0' ) AS AID_CATEGORY_CODE,
    COALESCE(st.BENEFITS_PACKAGE_CD, '0') AS BENEFITS_PACKAGE_CD,
    COALESCE(st.DISENROLL_REASON_CD_1, '0') AS CHANGE_REASON_CODE,
    COALESCE(st.CHOICE_REASON_CD, ss.CHOICE_REASON_CD, '0') AS CHOICE_REASON_CD,
    COALESCE(st.CLIENT_AID_CATEGORY_CD, ss.CLIENT_AID_CATEGORY_CD,  '0' ) AS CLIENT_AID_CATEGORY_CD,
    st.CONTRACT_ID AS CONTRACT_ID,
    COALESCE(st.COUNTY, elig.segment_detail_value_3, ss.COUNTY_CD) AS COUNTY_CODE,
    cty.attrib_district_cd AS CSDA_CODE,
    case when COALESCE(st.COUNTY, elig.segment_detail_value_3, ss.COUNTY_CD) in ('102','101') then 'OT' 
         else 'NC' end STATE_CODE,
    COALESCE(st.DISENROLL_REASON_CD_2, ss.DISENROLL_REASON_CD_2) AS DISENROLL_REASON_CD_2,
    st.MISSING_INFO_ID AS MISSING_INFO_ID,
    st.MISSING_SIGNATURE_IND AS MISSING_SIGNATURE_IND,
    st.NETWORK_ID AS NETWORK_ID,
    COALESCE(st.NETWORK_ID, ss.NETWORK_ID, 0) AS PROVIDER_NUMBER,
    NULL AS NEWBORN_FLAG,
    st.ORIGINAL_END_DATE AS ORIGINAL_END_DATE,
    st.ORIGINAL_START_DATE AS ORIGINAL_START_DATE,
    st.OUTREACH_SESSION_ID AS OUTREACH_SESSION_ID,
    COALESCE(st.OVERRIDE_REASON_CD, '0') AS OVERRIDE_REASON_CD,
    COALESCE(st.PLAN_ID, ss.PLAN_ID) AS PLAN_ID,
    COALESCE(st.PLAN_ID_EXT, ss.PLAN_ID_EXT, '0') AS PLAN_ID_EXT,
    COALESCE(st.PLAN_TYPE_CD, ss.PLAN_TYPE_CD, '0') AS PLAN_TYPE,
    COALESCE(st.PRIOR_CHOICE_REASON_CD, stP.CHOICE_REASON_CD) AS PRIOR_CHOICE_REASON_CD,
    COALESCE(st.PRIOR_CLIENT_AID_CATEGORY_CD, stP.CLIENT_AID_CATEGORY_CD) AS PRIOR_CLIENT_AID_CATEGORY_CD,
    COALESCE(st.PRIOR_CONTRACT_ID, STP.CONTRACT_ID) AS PRIOR_CONTRACT_ID,
    COALESCE(st.PRIOR_COUNTY_CD, STP.COUNTY) AS PRIOR_COUNTY_CD,
    COALESCE(st.PRIOR_DISENROLL_REASON_CD_1, STP.DISENROLL_REASON_CD_1) AS PRIOR_DISENROLL_REASON_CD_1,
    COALESCE(st.PRIOR_DISENROLL_REASON_CD_2, STP.DISENROLL_REASON_CD_2) AS PRIOR_DISENROLL_REASON_CD_2,
    COALESCE(st.PRIOR_NETWORK_ID , STP.NETWORK_ID) AS PRIOR_NETWORK_ID,
    COALESCE(st.PRIOR_PLAN_ID, stp.plan_id) AS PRIOR_PLAN_ID,
    coalesce(st.PRIOR_PLAN_ID_EXT, stp.plan_id_ext) AS PRIOR_PLAN_ID_EXT,
    coalesce(st.PRIOR_PROVIDER_FIRST_NAME, stp.PROVIDER_FIRST_NAME) AS PRIOR_PROVIDER_FIRST_NAME,
    coalesce(st.PRIOR_PROVIDER_ID, stp.PROVIDER_ID) AS PRIOR_PROVIDER_ID,
    coalesce(st.PRIOR_PROVIDER_ID_EXT, stp.PROVIDER_ID_EXT) AS PRIOR_PROVIDER_ID_EXT,
    coalesce(st.PRIOR_PROVIDER_LAST_NAME, stp.PROVIDER_LAST_NAME) AS PRIOR_PROVIDER_LAST_NAME,
    st.PRIOR_PROVIDER_MIDDLE_NAME AS PRIOR_PROVIDER_MIDDLE_NAME,
    st.PRIOR_SELECTION_END_DATE AS PRIOR_SELECTION_END_DATE,
    st.PRIOR_SELECTION_SEGMENT_ID AS PRIOR_SELECTION_SEGMENT_ID,
    st.PRIOR_SELECTION_START_DATE AS PRIOR_SELECTION_START_DATE,
    st.PRIOR_ZIPCODE AS PRIOR_ZIPCODE,
    ctyp.attrib_district_cd as PRIOR_CSDA_CODE,
    case when COALESCE(st.PRIOR_COUNTY_CD, STP.COUNTY) in ('101','102') then 'OT' 
           else 'NC' end PRIOR_STATE_CODE,
    COALESCE(st.PROGRAM_TYPE_CD, '0') AS PROGRAM_CODE,
    COALESCE(st.PROGRAM_TYPE_CD,'0') AS PROGRAM_TYPE_CD,
    st.PROVIDER_FIRST_NAME AS PROVIDER_FIRST_NAME,
    st.PROVIDER_ID AS PROVIDER_ID,
    st.PROVIDER_ID_EXT AS PROVIDER_ID_EXT,
    st.PROVIDER_LAST_NAME AS PROVIDER_LAST_NAME,
    st.PROVIDER_MIDDLE_NAME AS PROVIDER_MIDDLE_NAME,
    st.REF_EXT_TXN_ID AS REF_EXT_TXN_ID,
    st.REF_SELECTION_TXN_ID AS REF_SELECTION_TXN_ID,
    st.REF_SOURCE_ID AS REF_SOURCE_ID,
    st.REF_SOURCE_TYPE AS REF_SOURCE_TYPE,
    st.SELECTION_GENERIC_FIELD1_DATE AS SELECTION_GENERIC_FIELD1_DATE,
    st.SELECTION_GENERIC_FIELD10_TXT AS SELECTION_GENERIC_FIELD10_TXT,
    st.SELECTION_GENERIC_FIELD2_DATE AS SELECTION_GENERIC_FIELD2_DATE,
    st.SELECTION_GENERIC_FIELD3_NUM AS SELECTION_GENERIC_FIELD3_NUM,
    st.SELECTION_GENERIC_FIELD4_NUM AS SELECTION_GENERIC_FIELD4_NUM,
    st.SELECTION_GENERIC_FIELD5_TXT AS SELECTION_GENERIC_FIELD5_TXT,
    st.SELECTION_GENERIC_FIELD6_TXT AS SELECTION_GENERIC_FIELD6_TXT,
    st.SELECTION_GENERIC_FIELD7_TXT AS SELECTION_GENERIC_FIELD7_TXT,
    st.SELECTION_GENERIC_FIELD8_TXT AS SELECTION_GENERIC_FIELD8_TXT,
    st.SELECTION_GENERIC_FIELD9_TXT AS SELECTION_GENERIC_FIELD9_TXT,
    COALESCE(st.CHOICE_REASON_CD, ss.CHOICE_REASON_CD, '0') AS SELECTION_REASON_CODE,
    COALESCE(st.SELECTION_SOURCE_CD, '0') AS SELECTION_SOURCE_CD,
    st.STATUS_CD AS SELECTION_STATUS_CODE,
    st.SELECTION_TXN_GROUP_ID AS SELECTION_TXN_GROUP_ID,
    st.START_DATE AS START_DATE,
    st.END_DATE AS END_DATE,
    COALESCE(ss.START_ND,st.START_ND) AS START_ND,
    COALESCE(ss.END_ND,st.END_ND) AS END_ND,
    COALESCE(st.STATUS_CD, ss.STATUS_CD, '0') AS STATUS_CD,
    trunc(COALESCE(st.STATUS_DATE, ss.STATUS_DATE)) AS STATUS_DATE,
    COALESCE(st.TRANSACTION_TYPE_CD, 'NotDefined') AS TRANSACTION_TYPE_CD,
    COALESCE(st.ZIPCODE, ss.ZIPCODE, '0') AS ZIP_CODE,
    trunc(st.CREATE_TS) AS RECORD_DATE,
    st.CREATED_BY AS RECORD_NAME,
    st.CREATE_TS AS RECORD_TIME,
    st.UPDATE_TS AS MODIFIED_DATE,
    st.UPDATED_BY AS MODIFIED_NAME,
    st.UPDATE_TS AS MODIFIED_TIME,
    con.plan_service_type_cd plan_service_type_CD,
    conp.plan_service_type_cd prior_plan_service_type_CD,
    EV.EVENT_ID
    , EV.CALL_RECORD_ID
    , trunc(cr.call_start_ts) call_date
    , EV.EVENT_TYPE_CD
    ,(SELECT MAX(TRUNC(sh.create_ts))
      FROM eb.selection_txn_status_history sh
      WHERE sh.selection_txn_id = st.selection_txn_id AND sh.status_cd = 'acceptedByState'
     ) ACCEPTED_DATE 
    ,(SELECT MAX(TRUNC(sh.create_ts))
      FROM eb.selection_txn_status_history sh
      WHERE sh.selection_txn_id = st.selection_txn_id AND sh.status_cd in ('denied','invalid')
     ) DENIED_DATE 
     , dl.document_id document_id
     , trunc(docs.received_date) document_received_date
     , COALESCE(st.Selection_Generic_Field5_Txt, elig.segment_detail_value_2) MANAGED_CARE_STATUS
     , row_number() over(partition by st.selection_txn_id order by ev.event_id desc, ev.call_record_id desc, dl.document_id desc, elig.elig_segment_and_details_id desc, stp.status_date desc) rown
    FROM eb.selection_txn st 
  left JOIN eb.selection_segment ss on (st.client_id = ss.client_id and st.selection_segment_id = ss.selection_segment_id)
  left join eb.contract con on (st.contract_id = con.contract_id and st.plan_id = con.plan_id)
  left join eb.contract conp on (st.prior_contract_id = conp.contract_id and st.prior_plan_id = conp.plan_id)
  LEFT JOIN eb.event ev on (EV.REF_TYPE = 'SELECTION_TXN' 
  					AND EV.REF_ID = ST.SELECTION_TXN_ID 
  					AND EV.EVENT_TYPE_CD IN ('ENROLL_TRANSFER_SUBMITTED','CHOICE_ENROLLMENT','INCOMPLETE_INVALID_CHOICE') 
  					--AND EV.CALL_RECORD_ID IS NOT NULL
            )
  left join eb.call_record cr on cr.call_record_id = ev.call_record_id
  LEFT JOIN eb.doc_link dl on (dl.link_type_cd = 'SELECTION_TXN'
                               and dl.link_ref_id = st.selection_txn_id
                               )
  left join eb.document doc on doc.document_id = dl.document_id
  left join eb.document_set docs on docs.document_set_id = doc.document_set_id
  left join eb.elig_segment_and_details elig on (elig.segment_type_cd = 'ME'
                                                 and elig.client_id = st.client_id
                                                 and elig.start_nd <= nvl(st.start_nd, to_number(to_char(st.status_date,'YYYYMMDD')))
                                                 and elig.end_nd >= nvl(st.start_nd, to_number(to_char(st.status_date,'YYYYMMDD')))
                                                 )
  left join eb.enum_county cty on (cty.value = coalesce(st.county, elig.segment_detail_value_3))
  left join eb.selection_txn stp on stp.client_id = st.client_id and stp.status_cd = 'acceptedByState' and stp.status_date <= st.status_date and stp.selection_txn_id < st.selection_txn_id
  left join eb.enum_county ctyp on (ctyp.value = coalesce(st.prior_county_cd, stp.county, elig.segment_detail_value_3))
  LEFT JOIN MAXDAT_SUPPORT.CORP_ETL_LIST_LKUP LK ON LK.NAME = 'NUM_LOOKBACK_MONTHS'
  WHERE (st.create_Ts >= ADD_MONTHS(TRUNC(SYSDATE,'MM'), COALESCE(-(lk.out_var),-13)))
 )
  where rown = 1
;
  
GRANT SELECT ON maxdat_support.EMRS_D_SELECTION_TRANS_SV TO MAXDAT_REPORTS;
GRANT SELECT ON maxdat_support.EMRS_D_SELECTION_TRANS_SV TO MAXDATSUPPORT_READ_ONLY;
commit;