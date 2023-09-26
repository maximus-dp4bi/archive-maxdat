
  CREATE OR REPLACE FORCE EDITIONABLE VIEW "MAXDAT_SUPPORT"."EMRS_F_OE_TRANSFER_CNT_SV" ("RECORD_DATE", "PROGRAM_CODE", "SUBPROGRAM_CODE", "PLAN_ID", "TTYPE", "TRANSACTION_COUNT") AS 
  SELECT d.D_DATE AS RECORD_DATE,
  sp.PROGRAM_CODE,
  sp.SUBPROGRAM_CODE,
  sp.PLAN_ID,
  coalesce(f.ttype,'FROM') ttype,
  COUNT(f.selection_transaction_id) AS transaction_count
FROM MAXDAT_SUPPORT.D_DATES d
join (select distinct program_code, plan_id, subprogram_code from maxdat_support.emrs_d_plan_subprogram_sv
     union
      SELECT distinct
        c.program_type_cd program_code,
        pl.plan_id,
        eaid.subprogram_codes
      FROM eb.plans pl
      JOIN eb.contract c            ON pl.plan_id = c.plan_id
      JOIN eb.contract_amendment ca ON c.contract_id =ca.contract_id
      JOIN eb.contract_aid_category caid on caid.contract_amendment_id = ca.contract_amendment_id
      JOIN eb.enum_aid_category eaid on eaid.value = caid.aid_category_cd
      JOIN eb.county_contract ccon on ccon.contract_amendment_id = ca.contract_amendment_id
      join eb.enum_subprogram_type esub on esub.value = eaid.subprogram_codes
      WHERE 1=1
      AND ca.end_date IS NULL
      AND ca.status_cd = 'ACTIVE'
      AND c.end_date IS NULL
      and esub.value = 'MC'
      union all
      select distinct program_code, plan_id, subprogram_code from maxdat_support.emrs_d_den_plan_subprogram_sv 
     ) sp on 1=1 and sp.subprogram_code in ('DEN','MED','MC','CSHCS','HMP')
LEFT JOIN (
select 'FROM' ttype, from_plan_id plan_id, oft.program_type_cd, from_subprogram_code subprogram_code, trunc(record_date) record_date, oft.selection_transaction_id
from EMRS_D_OE_TRANSFER_SV oft
) f ON (d.D_DATE BETWEEN ADD_MONTHS(TRUNC(sysdate, 'mm'), -2) AND TRUNC(sysdate)
          AND d.D_DATE BETWEEN f.record_date AND COALESCE(f.record_date, TO_DATE('12-Dec-2050', 'dd-Mon-yyyy'))
          and f.subprogram_code = sp.subprogram_code
          and f.plan_id = sp.plan_id
)
GROUP BY d.D_DATE ,
  sp.PROGRAM_CODE,
  sp.SUBPROGRAM_CODE,
  sp.PLAN_ID,
  ttype
  
union 

  SELECT d.D_DATE AS RECORD_DATE,
  sp.PROGRAM_CODE,
  sp.SUBPROGRAM_CODE,
  sp.PLAN_ID,
  coalesce(f.ttype,'TO') ttype,
  COUNT(f.selection_transaction_id) AS transaction_count
FROM MAXDAT_SUPPORT.D_DATES d
join (select distinct program_code, plan_id, subprogram_code from maxdat_support.emrs_d_plan_subprogram_sv
     union
      SELECT distinct
        c.program_type_cd program_code,
        pl.plan_id,
        eaid.subprogram_codes
      FROM eb.plans pl
      JOIN eb.contract c            ON pl.plan_id = c.plan_id
      JOIN eb.contract_amendment ca ON c.contract_id =ca.contract_id
      JOIN eb.contract_aid_category caid on caid.contract_amendment_id = ca.contract_amendment_id
      JOIN eb.enum_aid_category eaid on eaid.value = caid.aid_category_cd
      JOIN eb.county_contract ccon on ccon.contract_amendment_id = ca.contract_amendment_id
      join eb.enum_subprogram_type esub on esub.value = eaid.subprogram_codes
      WHERE 1=1
      AND ca.end_date IS NULL
      AND ca.status_cd = 'ACTIVE'
      AND c.end_date IS NULL
      and esub.value = 'MC'
      union all
      select distinct program_code, plan_id, subprogram_code from maxdat_support.emrs_d_den_plan_subprogram_sv 
     ) sp on 1=1 and sp.subprogram_code in ('DEN','MED','MC','CSHCS','HMP')
LEFT JOIN (
select 'TO' ttype, to_plan_id plan_id, ot.program_type_cd, to_subprogram_code subprogram_code, trunc(record_date) record_date, ot.selection_transaction_id
from EMRS_D_OE_TRANSFER_SV ot
) f ON (d.D_DATE BETWEEN ADD_MONTHS(TRUNC(sysdate, 'mm'), -2) AND TRUNC(sysdate)
          AND d.D_DATE BETWEEN f.record_date AND COALESCE(f.record_date, TO_DATE('12-Dec-2050', 'dd-Mon-yyyy'))
          and f.subprogram_code = sp.subprogram_code
          and f.plan_id = sp.plan_id
)
GROUP BY d.D_DATE ,
  sp.PROGRAM_CODE,
  sp.SUBPROGRAM_CODE,
  sp.PLAN_ID,
  ttype
order by RECORD_DATE ,
  PROGRAM_CODE,
  SUBPROGRAM_CODE,
  PLAN_ID;
