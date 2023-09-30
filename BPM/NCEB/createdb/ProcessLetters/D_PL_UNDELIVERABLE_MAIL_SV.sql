DROP VIEW MAXDAT_SUPPORT.D_PL_UNDELIVERABLE_MAIL_SV;

CREATE OR REPLACE VIEW MAXDAT_SUPPORT.D_PL_UNDELIVERABLE_MAIL_SV
AS
select "LETTER_REQUEST_ID"
,"LETTER_RETURN_DATE"
,"LETTER_REQUEST_TYPE"
,"RETURN_REASON_CODE"
,"RETURN_REASON"
,"COUNTY_CODE"
,"COUNTY_NAME"
,"AUTHORIZED_ADDRESS"
,"CNDS_ID"
,"HEAD_OF_HOUSEHOLD"
,"AUTHORIZED_NAME"
,"BAD_ADDRESS_STREET1"
,"BAD_ADDRESS_STREET2"
,"BAD_ADDRESS_CITY"
,"BAD_ADDRESS_STATE"
,"BAD_ADDRESS_ZIP"
,"NEW_ADDRESS_STREET1"
,"NEW_ADDRESS_STREET2"
,"NEW_ADDRESS_CITY"
,"NEW_ADDRESS_STATE"
,"NEW_ADDRESS_ZIP"
,"DOCUMENT_NAME"
,"LETTER_TYPE"
,"BAD_ADDRESS_DATE"
,"VENDOR_NAME"
,"REGENERATED_DOCUMENT"
,"ROWN" 
  , case_id
  , authorized_contact_id
  , case_cin
  , family_number
  , clnt_client_id
  , clnt_cin
  , mailing_address_id
  , case_head
  , hoh_id
  , requested_on
  , status_cd
   from (
select * from (   
SELECT lr.lmreq_id letter_request_id
  ,lr.return_date letter_return_date
  ,lr.request_type letter_request_type
  ,ltrim(lr.return_reason_cd,'0') return_reason_code
  ,ltrim(rr.report_label,'0') return_reason
  ,COALESCE(el.admin_county,'UD') county_code
  ,COALESCE(bec.report_label,'Undefined') county_name
  ,'N' authorized_address
  ,cs.case_cin cnds_id --clnt.clnt_cin cnds_id
  , cs.case_head_fname || case when cs.case_head_mi is null then ' ' else ' ' || cs.case_head_mi || ' ' end || cs.case_head_lname head_of_household
  --clnt.clnt_fname || case when clnt.clnt_mi is null then ' ' else ' ' || clnt.clnt_mi || ' ' end || clnt.clnt_lname head_of_household
  ,' ' Authorized_name
  ,bad.addr_street_1 Bad_Address_Street1
  ,bad.addr_street_2 Bad_Address_Street2
  ,bad.addr_city Bad_Address_City 
  ,bad.addr_state_cd Bad_Address_State
  ,bad.addr_zip Bad_Address_Zip
  ,nad.addr_street_1 New_Address_Street1
  ,nad.addr_street_2 New_Address_Street2
  ,nad.addr_city New_Address_City 
  ,nad.addr_state_cd New_Address_State
  ,nad.addr_zip New_Address_Zip
  ,LD.CONTRACT_REFERENCE DOCUMENT_NAME
  ,ld.description letter_type
  ,bad.addr_bad_date bad_address_date
  ,'MAXIMUS' vendor_name
  ,NULL regenerated_document
  , row_number() over(partition by lr.lmreq_id order by el.start_date asc, csi.case_client_id desc) rown
  , cs.case_id
  , null authorized_contact_id
  , cs.case_cin
  , cs.family_number
  , lr.mailing_address_id
  , csi.hoh_id
  , lk.client_id clnt_client_id
  , null clnt_cin
  , case_head_fname||CASE WHEN case_head_mi IS NULL THEN ' ' ELSE ' '||case_head_mi||' ' END||case_head_lname case_head
  , lr.requested_on
  , lr.status_Cd
 FROM eb.letter_request lr
   JOIN eb.letter_definition ld ON lr.lmdef_id = ld.lmdef_id
   join eb.letter_request_link lk on lk.lmreq_id = lr.lmreq_id
   left join eb.client_supplementary_info csi on csi.client_id = lk.client_id --csi.case_id = lr.case_id --client_id = lk.client_id
   left JOIN eb.cases cs ON csi.case_id = cs.case_id
 --  left join eb.client clnt on clnt.clnt_client_id = csi.hoh_id
   LEFT JOIN eb.enum_return_reason rr ON lr.return_reason_cd = rr.value
   LEFT JOIN eb.address bad ON lr.mailing_address_id = bad.addr_id AND bad.addr_bad_date IS NOT NULL
   LEFT JOIN (
            select start_nd,start_date, end_date, client_id, segment_detail_value_3 enroll_county, segment_detail_value_4 admin_county
            from elig_segment_and_details elig
            where segment_type_cd = 'ME'
            and elig.start_nd < elig.end_nd
            ) el on el.client_id = cs.clnt_client_id and (el.start_date >= lr.requested_on or el.end_date >= lr.requested_on)
   LEFT JOIN eb.enum_county bec ON el.admin_county = bec.value
   LEFT JOIN (SELECT *
              FROM(SELECT addr_case_id,nad.addr_street_1,nad.addr_street_2,nad.addr_city,nad.addr_state_cd,nad.addr_zip
                     ,ROW_NUMBER() OVER(PARTITION BY nad.addr_case_id ORDER BY DECODE(addr_type_cd,'ML',1,2)) rn
                   FROM eb.address nad
                   WHERE addr_type_cd IN('ML','MM')
                   AND (addr_end_date IS NULL or addr_end_date > TRUNC(sysdate))
                   AND addr_bad_date IS NULL)
              WHERE rn = 1) nad ON lr.case_id = nad.addr_case_id
 WHERE lr.request_type = 'L'
 AND lr.status_cd = 'RTND'
 AND (return_date IS NOT NULL OR return_reason_cd IS NOT NULL)
 AND nvl(lr.return_reason_cd,999) NOT IN (16,18)
 ) where rown = 1
 --and authorized_address = 'Y'
--and case_cin = '954870612L'
union all
select *
from
(
SELECT /*+ parallel(ac, 10) */lr.lmreq_id letter_request_id
  ,lr.return_date letter_return_date
  ,lr.request_type letter_request_type
  ,ltrim(lr.return_reason_cd,'0')  return_reason_code
  ,ltrim(rr.report_label,'0') return_reason
  ,COALESCE(el.admin_county,'UD') county_code
  ,COALESCE(bec.report_label,'Undefined') county_name
  ,'Y' authorized_address
  ,clnt.clnt_cin cnds_id
  , clnt.clnt_fname || case when clnt.clnt_mi is null then ' ' else ' ' || clnt.clnt_mi || ' ' end || clnt.clnt_lname head_of_household
  , mr.attn Authorized_name
  ,mr.address_1 Bad_Address_Street1
  ,mr.address_2 Bad_Address_Street2
  ,mr.city Bad_Address_City 
  ,mr.state Bad_Address_State
  ,mr.zipcode Bad_Address_Zip
  ,ac.ac_address_street_1 New_Address_Street1
  ,ac.ac_address_street_2 New_Address_Street2
  ,ac.ac_address_city New_Address_City 
  ,ac.ac_address_state_code New_Address_State
  ,ac.ac_address_zip New_Address_Zip
  ,LD.CONTRACT_REFERENCE DOCUMENT_NAME
  ,ld.description letter_type
  ,lr.return_date bad_address_date
  ,'MAXIMUS' vendor_name
  ,NULL regenerated_document
  , row_number() over(partition by lr.lmreq_id order by el.start_date asc, clnt.clnt_client_id desc, ac.ac_start_Date desc) rown
  , lr.case_id
  , null authorized_contact_id
  , cs.case_cin
  , cs.family_number
  , lr.mailing_address_id
  , null hoh_id
  , clnt.clnt_client_id
  , clnt.clnt_cin
  , case_head_fname||CASE WHEN case_head_mi IS NULL THEN ' ' ELSE ' '||case_head_mi||' ' END||case_head_lname case_head
  , lr.requested_on
  , lr.status_cd
  FROM eb.letter_request lr
   JOIN eb.cases cs ON lr.case_id = cs.case_id
   JOIN eb.letter_definition ld ON lr.lmdef_id = ld.lmdef_id
   join eb.letter_request_link lk on lk.lmreq_id = lr.lmreq_id
   join eb.client clnt on clnt.clnt_client_id = lk.client_id
   left join eb.material_request mr on mr.material_request_id = lr.material_request_id
   LEFT JOIN eb.enum_return_reason rr ON lr.return_reason_cd = rr.value
   LEFT JOIN (
            select start_nd,start_date, end_date, client_id, segment_detail_value_3 enroll_county, segment_detail_value_4 admin_county
            from elig_segment_and_details elig
            where segment_type_cd = 'ME'
            and elig.start_nd < elig.end_nd
            ) el on el.client_id = cs.clnt_client_id and (el.start_date >= lr.requested_on or el.end_date >= lr.requested_on)
   LEFT JOIN eb.enum_county bec ON el.admin_county = bec.value
   LEFT JOIN eb.authorized_contact ac on ac.ac_client_id = lk.client_id 
                   and ac.ac_status_code = 'O'
                   and ac.ac_type_code = 'AUTH_REP'
                   and (ac.ac_start_date < ac.ac_End_Date or ac.ac_end_Date is null)
 WHERE lr.request_type = 'S'
 AND lr.mailing_address_id is null
 and lr.material_request_id is not null
 AND lr.status_cd = 'RTND'
 AND (lr.return_date IS NOT NULL OR lr.return_reason_cd IS NOT NULL )
 AND nvl(lr.return_reason_cd,999) NOT IN (16,18)
--and lr.case_id = 2573138
 ) where rown = 1
 --and case_id = 2573138
--and case_id = 1716256
)
;

GRANT SELECT ON MAXDAT_SUPPORT.D_PL_UNDELIVERABLE_MAIL_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.D_PL_UNDELIVERABLE_MAIL_SV TO MAXDAT_REPORTS;
