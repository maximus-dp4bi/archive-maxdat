Create or replace view EMRS_D_CLNT_ENROLLED_SV as
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
, p.plan_name 
, ss.start_date 
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
left outer join selection_segment ss on ss.client_id = i.client_id
and ss.end_date is null
left outer join eb.plans p on p.plan_id = ss.plan_id
--where ss.selection_segment_id is null
where ss.start_date >= trunc(sysdate-90,'MM')
;

GRANT SELECT ON MAXDAT_SUPPORT.emrs_d_clnt_enrolled_sv TO MAXDAT_REPORTS;   
