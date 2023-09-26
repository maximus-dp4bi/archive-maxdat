CREATE OR REPLACE VIEW F_DAILY_LETTERS_COUNT_SV
AS
select letter, record_date, sum(dly_letter_count) dly_letter_count , filename letter_filename
from (
SELECT 
case 
when lmd.name = 'XX' and d1.material_cd = 'A' then 'MCAPP'
when lmd.name = 'XX' and d1.material_cd = 'B' then 'MIRXAPP'
when lmd.name = 'XX' and d1.material_cd = 'C' then 'PHCR'
when lmd.name = 'XX' and d1.material_cd = 'D' then 'SDFC'
when lmd.name = 'XX' and d1.material_cd = 'E' then 'BCF'
when lmd.name = 'XX' and d1.material_cd = 'F' then 'HRF'
when lmd.name = 'XX' and d1.material_cd = 'G' then 'MCIB'
when lmd.name = 'XX' and d1.material_cd = 'H' then 'MCFL'
when lmd.name = 'XX' and d1.material_cd = 'I' then 'RRB'
when lmd.name = 'XX' and d1.material_cd = 'J' then 'MFFS'
when lmd.name = 'XX' and d1.material_cd = 'K' then 'HMPH'
when lmd.name = 'XX' and d1.material_cd = 'F' then '  HLEF'
when lmd.name = 'XX' and d1.material_cd = 'MCOA' then 'OAOM'
when lmd.name = 'XX' and d1.material_cd = 'PFOA' then 'OAOP'
when lmd.name = 'XX' and d1.material_cd = 'F1' then 'SDFC'
when lmd.name = 'XX' and d1.material_cd = 'F2' then 'BCF'
when lmd.name = 'XX' and d1.material_cd = 'F3' then 'HRF'
when lmd.name = 'XX' and d1.material_cd = 'F4' then 'HLEF'
else lmd.name
end letter
, trunc(r.sent_on) record_date, COUNT(distinct r.lmreq_id) dly_letter_count
, regexp_substr(j.filename,'[^/]+$') filename
FROM letter_request r 
  LEFT JOIN letter_definition lmd ON lmd.lmdef_id = r.lmdef_id
--  CROSS JOIN maxdat_support.d_dates  d
  left join material_request m on r.material_request_id = m.material_request_id
  left JOIN material_request_details d1 ON d1.material_request_id = m.material_request_id 
  left JOIN enum_material e ON e.value = d1.material_cd
  left join letter_out_data_content lo on lo.letter_req_id = r.lmreq_id
  left join job_run_data j on j.job_run_data_id = lo.job_id  
WHERE  r.status_cd in ('SENT','MAIL') AND  TRUNC(r.sent_on) >= TRUNC(sysdate-7) 
and lmd.name <> 'MIHC' 
GROUP BY 
case 
when lmd.name = 'XX' and d1.material_cd = 'A' then 'MCAPP'
when lmd.name = 'XX' and d1.material_cd = 'B' then 'MIRXAPP'
when lmd.name = 'XX' and d1.material_cd = 'C' then 'PHCR'
when lmd.name = 'XX' and d1.material_cd = 'D' then 'SDFC'
when lmd.name = 'XX' and d1.material_cd = 'E' then 'BCF'
when lmd.name = 'XX' and d1.material_cd = 'F' then 'HRF'
when lmd.name = 'XX' and d1.material_cd = 'G' then 'MCIB'
when lmd.name = 'XX' and d1.material_cd = 'H' then 'MCFL'
when lmd.name = 'XX' and d1.material_cd = 'I' then 'RRB'
when lmd.name = 'XX' and d1.material_cd = 'J' then 'MFFS'
when lmd.name = 'XX' and d1.material_cd = 'K' then 'HMPH'
when lmd.name = 'XX' and d1.material_cd = 'F' then '  HLEF'
when lmd.name = 'XX' and d1.material_cd = 'MCOA' then 'OAOM'
when lmd.name = 'XX' and d1.material_cd = 'PFOA' then 'OAOP'
when lmd.name = 'XX' and d1.material_cd = 'F1' then 'SDFC'
when lmd.name = 'XX' and d1.material_cd = 'F2' then 'BCF'
when lmd.name = 'XX' and d1.material_cd = 'F3' then 'HRF'
when lmd.name = 'XX' and d1.material_cd = 'F4' then 'HLEF'
else lmd.name
end 
 , trunc(r.sent_on)  
 , regexp_substr(j.filename,'[^/]+$')
/*union
select letter, record_date, 0 dly_letter_count, '' filename
from (
select
case 
when lmd.name = 'XX' and e.value = 'A' then 'MCAPP'
when lmd.name = 'XX' and e.value = 'B' then 'MIRXAPP'
when lmd.name = 'XX' and e.value = 'C' then 'PHCR'
when lmd.name = 'XX' and e.value = 'D' then 'SDFC'
when lmd.name = 'XX' and e.value = 'E' then 'BCF'
when lmd.name = 'XX' and e.value = 'F' then 'HRF'
when lmd.name = 'XX' and e.value = 'G' then 'MCIB'
when lmd.name = 'XX' and e.value = 'H' then 'MCFL'
when lmd.name = 'XX' and e.value = 'I' then 'RRB'
when lmd.name = 'XX' and e.value = 'J' then 'FFS'
when lmd.name = 'XX' and e.value = 'K' then 'HMPH'
when lmd.name = 'XX' and e.value = 'F' then '  HLEF'
when lmd.name = 'XX' and e.value = 'MCOA' then 'OAOM'
when lmd.name = 'XX' and e.value = 'PFOA' then 'OAOP'
when lmd.name = 'XX' and e.value = 'F1' then 'SDFC'
when lmd.name = 'XX' and e.value = 'F2' then 'BCF'
when lmd.name = 'XX' and e.value = 'F3' then 'HRF'
when lmd.name = 'XX' and e.value = 'F4' then 'HLEF'
else lmd.name
end letter
, d_date record_date, ' ' filename, 0 dly_letter_count
 FROM letter_definition lmd
  left join enum_material e on lmd.name = 'XX'
  CROSS JOIN maxdat_support.d_dates  d
WHERE  d.D_DATE >= TRUNC(sysdate-7) and d.d_date <= trunc(sysdate)
) sv1
group by sv1.letter, record_date
*/
) sv
group by letter, record_date, filename
order by letter, record_date, filename
;


GRANT SELECT ON MAXDAT_SUPPORT.F_DAILY_LETTERS_COUNT_SV TO MAXDAT_REPORTS;
 
