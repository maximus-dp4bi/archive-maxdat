CREATE OR REPLACE VIEW F_PL_LTR_CNT_SV
 AS
SELECT d.D_DATE AS RECORD_DATE,
  sp.PROGRAM_CODE,
  sp.SUBPROGRAM_CODE,
  cnt.county_code,
  lmdef.LETTER_TYPE,
  lmdef.letter_type_label,
  lmdef.name,
  COUNT(f.lmreq_id) AS letter_count
FROM (select * from MAXDAT_SUPPORT.D_DATES d where d.D_DATE BETWEEN ADD_MONTHS(TRUNC(sysdate, 'mm'), -3) AND TRUNC(sysdate)) d
join (select distinct program_code, subprogram_code from maxdat_support.emrs_d_plan_subprogram_sv) sp on 1=1 and sp.subprogram_code in ('MED','MC','CSHCS','HMP','DUAL')
join maxdat_support.D_PL_COUNTY_SV cnt on 1=1 and plan_service_type = 'MAINSTREAM'
join maxdat_support.D_LETTER_DEFINITION_SV lmdef on lmdef.subprogram_code = sp.subprogram_code and lmdef.subprogram_code is not null
LEFT JOIN (
          select lmreq_id, lmd.name,trunc(sent_on) record_date, z.attrib_county county_code
          from letter_request r
          join letter_definition lmd on lmd.lmdef_id = r.lmdef_id
          join letter_out_header loh on loh.letter_req_id = r.lmreq_id
          join enum_zipcode z on z.value = loh.zip_code
          where r.status_cd in ('SENT','MAIL')
          and r.sent_on BETWEEN ADD_MONTHS(TRUNC(sysdate, 'mm'), -3) AND TRUNC(sysdate)
) f ON (d.D_DATE BETWEEN f.record_date AND COALESCE(f.record_date, TO_DATE('12-Dec-2050', 'dd-Mon-yyyy'))
          and f.name = lmdef.name
          and f.county_code = cnt.county_code
)
GROUP BY   d.D_DATE ,
sp.PROGRAM_CODE,
  sp.SUBPROGRAM_CODE,
  cnt.county_code,
  lmdef.LETTER_TYPE,
  lmdef.letter_type_label,
  lmdef.name
  ;

GRANT SELECT ON MAXDAT_SUPPORT.F_PL_LTR_CNT_SV TO MAXDAT_REPORTS; 
          
 
