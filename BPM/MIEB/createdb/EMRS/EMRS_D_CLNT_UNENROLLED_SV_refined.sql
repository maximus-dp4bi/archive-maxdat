Create or replace view emrs_d_clnt_unenrolled_sv as
select /*+ parallel(10) */
i.case_cin 
, i.client_cin 
, i.clnt_full_name
, es.elig_status_cd elig_status_cd 
, cc.cscl_adlk_id||'-'||a.report_label aid_category_label
,cen.value enroll_status_cd
, cen.report_label enroll_status_label  
, ad.addr_ctlk_id||' - '||cty.report_label county_label
, cty.value county_code
, null plan_name 
, null start_date
, row_number() over (order by null) rank
from (
--select * from (
select /*+ parallel(10) first_rows(5000) */ en1.client_id, en1.enroll_status_cd
, ic.case_client_id 
, ic.addr_id
, ic.case_cin 
, ic.client_cin 
, ic.last_name||', '||ic.first_name||' '||ic.middle_initial clnt_full_name
--, round(DBMS_RANDOM.value(10000000,99999999)) rown
from client_enroll_status en1
join client_supplementary_info ic on en1.client_id = ic.client_id
where en1.enroll_status_cd in ('A','B','C','AAR') and en1.end_date is null
order by dbms_random.value(10000000,99999999)
--) en2
--where mod(en2.rown,7)) = mod(to_number(to_char(sysdate, 'YYYYMMDDHH24MISS')),7)
) i 
--join client_supplementary_info i on en.client_id = i.client_id
join client_elig_status es on es.client_id = i.client_id
and es.end_date is null
and es.elig_status_cd <> 'X'
join enum_client_enroll_status cen on cen.value = i.enroll_status_cd
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
--where en.enroll_status_cd in ('A','B','C','AAR')
;

GRANT SELECT ON MAXDAT_SUPPORT.emrs_d_clnt_unenrolled_sv TO MAXDAT_REPORTS;   
