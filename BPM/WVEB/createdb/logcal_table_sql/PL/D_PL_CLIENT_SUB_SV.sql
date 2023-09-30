select distinct
  lr.LMREQ_ID letter_request_id,
  lr.CREATE_TS create_dt,
  lrl.CLIENT_ID,
  ces.ELIG_STATUS_CD,
  (select REPORT_LABEL from EB.ENUM_SUBPROGRAM_TYPE where value = ces.SUBPROGRAM_TYPE) sub_program
from EB.LETTER_REQUEST lr
inner join ENUM_LM_STATUS els on lr.STATUS_CD = els.VALUE
left outer join EB.LETTER_REQUEST_LINK lrl on lrl.LMREQ_ID = lr.LMREQ_ID
left outer join EB.CLIENT_ELIG_STATUS ces on ces.CLIENT_ID = lrl.CLIENT_ID
where 
  (lr.CREATE_TS >= (add_months(trunc(sysdate,'MM'),-2))  
  or els.DESCRIPTION not in ('Mailed','Combined similar Requests','Rejected','Voided','Errored','Canceled','Overcome by Events') )
  and ces.END_DATE is null 

