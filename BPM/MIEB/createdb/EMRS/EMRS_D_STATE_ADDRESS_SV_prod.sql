CREATE OR REPLACE VIEW EMRS_D_STATE_ADDRESS_SV AS
select
 COALESCE(ac.addr_begin_date, acs.addr_begin_date,  TO_DATE('01/01/1900','MM/DD/YYYY')) AS SOURCE_ADDR_BEGIN_DATE ,
    COALESCE(TO_CHAR(ac.last_update_date,'HH24MI'), TO_CHAR(acs.last_update_date,'HH24MI')) AS MODIFIED_TIME ,
    COALESCE(ac.creation_date, acs.creation_date,  TO_DATE('01/01/1900','MM/DD/YYYY')) AS DATE_CREATED ,
    COALESCE(ac.created_by, acs.created_by) AS CREATED_BY ,
    COALESCE(ac.addr_id, acs.addr_id, -1*acs.cscl_clnt_client_id) AS ADDRESS_ID ,
    COALESCE(ac.addr_id, acs.addr_id, -1*acs.cscl_clnt_client_id) AS SOURCE_RECORD_ID ,
    COALESCE(ac.addr_street_1, acs.addr_street_1) AS ADDR_STREET_1 ,
    COALESCE(ac.addr_street_2, acs.addr_street_2) AS ADDR_STREET_2 ,
    COALESCE(ac.addr_city, acs.addr_city) AS ADDR_CITY ,
    COALESCE(ac.addr_state_cd, acs.addr_state_cd) AS ADDR_STATE_CD ,
    COALESCE(ac.addr_zip, acs.addr_zip) AS ADDR_ZIP ,
    COALESCE(ac.addr_zip_four, acs.addr_zip_four) AS ADDR_ZIP_FOUR ,
    COALESCE(ac.addr_type_cd, acs.addr_type_cd) AS ADDR_TYPE_CD ,
    COALESCE(atc.description, atcs.description) AS ADDR_TYPE ,
    COALESCE(ac.addr_country, acs.addr_country) AS ADDR_COUNTRY ,
    acs.cscl_clnt_client_id AS CLIENT_NUMBER ,
    COALESCE(ac.addr_attn, acs.addr_attn) AS ADDR_ATTN ,
    COALESCE(ac.addr_house_code, acs.addr_house_code) AS ADDR_HOUSE_CODE ,
    COALESCE(ac.addr_bar_code, acs.addr_bar_code) AS ADDR_BAR_CODE ,
    COALESCE(ac.addr_origin_cd, acs.addr_origin_cd) AS ADDR_ORIGIN_CD ,
    COALESCE(ac.addr_staff_id, acs.addr_staff_id) AS ADDR_STAFF_ID ,
    COALESCE(ac.addr_ctlk_id, acs.addr_ctlk_id) AS ADDR_CTLK_ID ,
    COALESCE(ac.addr_dolk_id, acs.addr_dolk_id) AS ADDR_DOLK_ID ,
    COALESCE(ac.addr_prov_id, acs.addr_prov_id) AS ADDR_PROV_ID ,
    COALESCE(ac.addr_payc_id, acs.addr_payc_id) AS ADDR_PAYC_ID ,
    COALESCE(ac.addr_verified, acs.addr_verified) AS ADDR_VERIFIED ,
    COALESCE(ac.addr_verified_date, acs.addr_verified_date) AS ADDR_VERIFIED_DATE ,
    COALESCE(ac.advy_id, acs.advy_id) AS ADVY_ID ,
    COALESCE(ac.addr_bad_date, acs.addr_bad_date) AS ADDR_BAD_DATE ,
    COALESCE(ac.addr_bad_date_satisfied, acs.addr_bad_date_satisfied) AS ADDR_BAD_DATE_SATISFIED ,
    acs.cscl_CASE_ID AS CASE_NUMBER,
    COALESCE(ac.start_ndt, acs.start_ndt, 19990101000000000) AS START_NDT ,
    COALESCE(ac.end_ndt, acs.end_ndt, 99991231235959999) AS END_NDT ,
    COALESCE(ac.comparable_key, acs.comparable_key) AS COMPARABLE_KEY ,
    COALESCE(ac.creation_date, acs.creation_date,  TO_DATE('01/01/1900','MM/DD/YYYY')) AS RECORD_DATE ,
    COALESCE(TO_CHAR(ac.creation_date,'HH24MI'), TO_CHAR(acs.creation_date,'HH24MI'), '0000') AS RECORD_TIME ,
    COALESCE(ac.created_by, acs.created_by) AS RECORD_NAME ,
    COALESCE(ac.last_update_date, acs.last_update_date) AS MODIFIED_DATE ,
    COALESCE(ac.last_updated_by, acs.last_updated_by) AS MODIFIED_NAME ,
    COALESCE(ac.addr_end_date, acs.addr_end_date) AS SOURCE_ADDR_END_DATE,
    COALESCE(ac.addr_bad_date_1, acs.addr_bad_date_1) AS ADDR_BAD_DATE_1 ,
    elig.segment_detail_value_1 service_county,
    elig.segment_detail_value_2 worker_district,
    elap.segment_detail_value_1 worker_section,
    elap.segment_detail_value_2 worker_unit,
    elap.segment_detail_value_3 worker_number,
    elme.segment_detail_value_1 pama_program_code,
    acs.subprogram_code,
    rtn.rtn_addr_process_date,
    case when dob_order = 1 then 'Y' else 'N' end is_oldest,
    ss.plan_id_ext
from
(
SELECT addr.*,
cscl.cscl_clnt_client_id
, cscl.cscl_case_id
, row_number() over(partition by cscl.cscl_case_id,  cscl.cscl_clnt_client_id order by cscl.status_end_ndt desc) client_order
, dense_rank() over(partition by cscl.cscl_case_id order by clnt.clnt_dob desc) dob_order
, CASE WHEN eca.subprogram_codes IN('CONV','MC') THEN 'MED' ELSE eca.subprogram_codes END subprogram_code
FROM eb.address addr
LEFT JOIN case_client cscl on (cscl.cscl_case_id = addr.addr_case_id and nvl(cscl_status_end_date,sysdate) >= add_months(sysdate,-15))
LEFT JOIN client clnt on (clnt.clnt_client_id = cscl.cscl_clnt_client_id and clnt.clnt_dod is null)
left join enum_aid_category eca on eca.value = cscl.cscl_adlk_id and eca.value not in ('CSHCS','UNKNOWN')
WHERE addr.addr_type_cd IN ('RS', 'ML')
      AND addr.addr_bad_date_1 is not null
      AND addr.END_NDT >= to_number(to_char(addr.addr_bad_date_1, 'yyyymmddHH24misssss'))
      AND addr.addr_bad_date_1 >= to_date(add_months(sysdate,-2))
) acs
left join eb.address ac on (acs.cscl_clnt_client_id = ac.clnt_client_id
                              and ac.addr_type_cd IN ('RS', 'ML')
                              AND ac.addr_bad_date_1 is not null
                              AND ac.END_NDT >= to_number(to_char(ac.addr_bad_date_1, 'yyyymmddHH24misssss'))
                              AND ac.addr_bad_date_1 >= to_date(add_months(sysdate,-2)))
LEFT JOIN (SELECT matched_addr_id,MAX(process_ts) rtn_addr_process_date
           FROM eb.etl_l_returnaddresses rtn
             JOIN eb.letter_definition ld ON rtn.letter_type = ld.name
           WHERE ld.description LIKE '%HMP%'
           GROUP BY matched_addr_id) rtn ON acs.addr_id = rtn.matched_addr_id
LEFT JOIN eb.elig_segment_and_details elig ON (acs.cscl_clnt_client_id = elig.client_id AND elig.segment_type_cd = 'SERVICE' AND elig.end_nd = 99991231)
LEFT JOIN eb.elig_segment_and_details elap ON (acs.cscl_clnt_client_id = elap.client_id AND elap.segment_type_cd = 'APW01' AND elap.end_nd = 99991231)
LEFT JOIN eb.elig_segment_and_details elme ON (acs.cscl_clnt_client_id = elme.client_id AND elme.segment_type_cd = 'ME01_EL' AND elme.end_nd = 99991231)
LEFT JOIN eb.enum_address_type atc ON (ac.addr_type_cd = atc.value)
LEFT JOIN eb.enum_address_type atcs ON (acs.addr_type_cd = atcs.value)
LEFT JOIN eb.selection_segment ss ON (cscl_clnt_client_id = ss.client_id AND ss.STATUS_CD = 'OPEN' AND ss.END_ND = 99991231
                                      AND ss.program_type_cd = 'MEDICAID' AND ss.plan_type_cd = 'MEDICAL')
where client_order = 1
--and dob_order = 1
;
