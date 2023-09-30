DROP VIEW MAXDAT_SUPPORT.EMRS_D_BH_IDD_CALL_DTL_SV;
CREATE OR REPLACE FORCE EDITIONABLE VIEW "MAXDAT_SUPPORT"."EMRS_D_BH_IDD_CALL_DTL_SV" ("DATE_OF_CALL", "CNDSID", "DOB", "COUNTY_NUMBER", "CALL_REASON") AS 
select cr.call_start_ts DATE_OF_CALL
, crl.EXT_CLIENT_NUM CNDSID
, cl.CLNT_DOB DOB
, cs.addr_county COUNTY_NUMBER
, ecr.report_label CALL_REASON
from eb.call_record cr 
  left join eb.enum_call_reasons ecr on (cr.call_record_field2 = ecr.value)
  left join eb.call_record_link crl on (cr.call_record_ID=crl.call_record_ID)
  left join eb.Client cl on (cl.CLNT_CLIENT_ID = crl.client_id)
  left join EB.CLIENT_SUPPLEMENTARY_INFO cs on (cs.CLIENT_ID = crl.client_id)
  LEFT JOIN MAXDAT_SUPPORT.CORP_ETL_LIST_LKUP LK ON LK.NAME = 'NUM_LOOKBACK_MONTHS'
where cr.Call_record_field2 like 'BH%'
and cr.call_start_ts >= GREATEST(TO_DATE('3/1/2021','MM/DD/YYYY'), ADD_MONTHS(TRUNC(SYSDATE,'MM'), COALESCE(-(lk.out_var),-13)))
;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_BH_IDD_CALL_DTL_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_BH_IDD_CALL_DTL_SV TO MAXDAT_REPORTS;