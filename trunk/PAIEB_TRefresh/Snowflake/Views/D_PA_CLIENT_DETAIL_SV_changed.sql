create or replace view MAXDAT_SUPPORT.D_PA_CLIENT_DETAIL_SV(
  APP_ID,
  CLIENT_ID,
  CASE_ID,
  CASE_CIN,
  DISPOSITION_DT,
  APP_START_DT,
  CLNT_DOB,
  AGE,
  OVER_60,
  APP_INDIVIDUAL_ID,
  MEDICAID_ENROLLED,
  APPLICANT_IND,
  HOH_IND,
  MI_IND
) as
 SELECT /*+ parallel(8) */ i.application_id AS app_id
  ,i.client_id
  ,ac.case_id
  ,ac.case_cin
  ,CASE WHEN ah.status_cd IN('CLOSED','COMPLETED','TIMEOUT','DISREGARDED') THEN COALESCE(he.close_app_ts,sh_comp.status_dt) ELSE ah.status_date END disposition_dt
  ,CAST(he.app_start_date AS DATE) as app_start_dt
  ,c.clnt_dob
//  ,to_char((to_number(to_char(he.app_start_date,'YYYYMMDD')) - to_number(to_char(c.clnt_dob,'YYYYMMDD')))/10000) as age
  ,trunc(to_char((to_number(to_char(he.app_start_date,'YYYYMMDD')) - to_number(to_char(c.clnt_dob,'YYYYMMDD')))/10000)) as age
  ,CASE WHEN trunc((to_number(to_char(he.app_start_date,'YYYYMMDD')) - to_number(to_char(c.clnt_dob,'YYYYMMDD')))/10000) > 60 THEN 'Over 60'
   ELSE '60 and Under'
   END as over_60
  ,i.app_individual_id
  ,CASE WHEN he.applicant_med_assistance_ind = 1 OR c.clnt_generic_field6_txt IS NOT NULL THEN 1 ELSE 0 END medicaid_enrolled
  ,i.applicant_ind
  ,i.hoh_ind
  ,i.mi_ind
 FROM PAIEB_PRD.app_header ah
 JOIN PAIEB_PRD.app_individual i ON (ah.application_id = i.application_id)
 JOIN PAIEB_PRD.client c ON (i.client_id = c.clnt_client_id)
 JOIN PAIEB_PRD.app_case_link ac ON (ah.application_id = ac.application_id)
 LEFT JOIN PAIEB_PRD.app_header_ext he ON ah.application_id = he.application_id
 --LEFT JOIN harmony_conv.openclose oc ON (oc.openid = ah.application_id)
 LEFT JOIN (SELECT *
            FROM (SELECT sh.application_id,sh.status_date status_dt,sh.status_cd,ROW_NUMBER() OVER (PARTITION BY sh.application_id ORDER BY app_status_history_id DESC) rn
                  FROM PAIEB_PRD.app_status_history sh
                  WHERE sh.status_cd IN('CLOSED', 'COMPLETED' ,'TIMEOUT','DISREGARDED')
                  AND sh.app_status_history_id >= 1530000
                  )
            WHERE rn = 1) sh_comp  ON ah.application_id = sh_comp.application_id
 where ah.application_id >= 343555
and ah.create_ts >= ADD_MONTHS(CURRENT_DATE::DATE,-13) ;
