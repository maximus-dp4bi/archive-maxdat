
  CREATE OR REPLACE FORCE EDITIONABLE VIEW MAXDAT_SUPPORT.EMRS_D_CLNT_UNENROLLED_SV  AS 
  select
i.case_cin
, i.client_cin
, i.last_name||', '||i.first_name||' '||i.middle_initial clnt_full_name
, es.elig_status_cd elig_status_cd
, cc.cscl_adlk_id||'-'||a.report_label aid_category_label
,cen.value enroll_status_cd
, cen.report_label enroll_status_label
, ad.addr_ctlk_id||' - '||cty.report_label county_label
, cty.value county_code
, null plan_name
, null start_date
, row_number() over (order by dbms_random.random) rank
from client_supplementary_info i
join client_elig_status es on es.client_id = i.client_id
and es.end_date is null
and es.elig_status_cd <> 'X'
join client_enroll_status en on en.client_id = i.client_id
and en.end_date is null
join enum_client_enroll_status cen on cen.value = en.enroll_status_cd
join case_client cc on cc.cscl_id = i.case_client_id
join enum_aid_category a on a.value = cc.cscl_adlk_id
join address ad on ad.addr_id = i.addr_id
join enum_county cty on cty.value = ad.addr_ctlk_id
and cty.attrib_district_cd <> '1'
--join client_enroll_status en on en.client_id = i.client_id
--and en.end_date is null
--left outer join selection_segment ss on ss.client_id = i.client_id
--and ss.end_date is null
--and ss.selection_segment_id is null
--left outer join eb.plans p on p.plan_id = ss.plan_id
--where ss.selection_segment_id is null
--where ss.start_date >= to_date('01-DEC-2017')
where en.enroll_status_cd in ('A','B','C','AAR')
;


  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CLNT_UNENROLLED_SV TO MAXDAT_REPORTS;
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CLNT_UNENROLLED_SV TO MAXDATSUPPORT_READ_ONLY;
  GRANT DELETE ON MAXDAT_SUPPORT.EMRS_D_CLNT_UNENROLLED_SV TO MAXDATSUPPORT_OLTP_SIUD;
  GRANT INSERT ON MAXDAT_SUPPORT.EMRS_D_CLNT_UNENROLLED_SV TO MAXDATSUPPORT_OLTP_SIUD;
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CLNT_UNENROLLED_SV TO MAXDATSUPPORT_OLTP_SIUD;
  GRANT UPDATE ON MAXDAT_SUPPORT.EMRS_D_CLNT_UNENROLLED_SV TO MAXDATSUPPORT_OLTP_SIUD;
  GRANT INSERT ON MAXDAT_SUPPORT.EMRS_D_CLNT_UNENROLLED_SV TO MAXDATSUPPORT_OLTP_SIU;
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_CLNT_UNENROLLED_SV TO MAXDATSUPPORT_OLTP_SIU;
  GRANT UPDATE ON MAXDAT_SUPPORT.EMRS_D_CLNT_UNENROLLED_SV TO MAXDATSUPPORT_OLTP_SIU;



