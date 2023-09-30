
/* PAXDELIVRY-3140 */

CREATE OR REPLACE VIEW MAXDAT_SUPPORT.D_PA_APP_CLIENT_SV
AS select /*+ PARALLEL(5) */ DISTINCT A.CLIENT_ID,A.STATUS
,B.CLNT_FNAME
,B.CLNT_LNAME
,B.CLNT_DOB
--,Round(Round(sysdate-B.CLNT_DOB)/365) AS ""Client Age""
, trunc((to_number(to_char(sysdate,'YYYYMMDD'))- to_number(to_char(B.clnt_dob,'YYYYMMDD')))/10000) as Client_Age
,B.STATE_LANGUAGE   
,A.Step_definition_id 
, B.CLNT_GENERIC_FIELD5_TXT AS HARMONY_ID
,TO_CHAR(A.CREATE_TS, 'DD-MON-YYYY HH24:MI:SS') AS CREATE_TS
,ad.addr_street_1
,ad.addr_street_2
,ad.addr_city
,ad.addr_state_cd
,ad.addr_zip as ZIPCODE 
,EC.DESCRIPTION AS COUNTY 
from STEP_INSTANCE A
LEFT JOIN CLIENT B ON B.CLNT_CLIENT_ID = A.CLIENT_ID
left join app_individual C ON C.CLIENT_ID =B.CLNT_CLIENT_ID
LEFT JOIN  APP_CASE_LINK D ON D.APPLICATION_ID= C.APPLICATION_ID
left join (SELECT *
           FROM (SELECT ad.addr_case_id,ad.addr_zip
                  ,ROW_NUMBER() OVER (PARTITION BY addr_case_id ORDER BY ad.creation_date DESC,ad.addr_id DESC) rn,
                  ad.addr_street_1,ad.addr_street_2,ad.addr_zip As zipcode,ad.addr_city,ad.addr_state_cd
           FROM address ad 
           )
           WHERE rn = 1) ad
ON (a.case_id = ad.addr_case_id)
left join enum_zipcode EZ on AD.addr_zip=EZ.value
left join enum_county EC on EZ.attrib_county=EC.value
WHERE A.Step_definition_id = 40137554 AND TRUNC(A.CREATE_TS) = trunc(sysdate-1)
;


GRANT SELECT ON MAXDAT_SUPPORT.D_PA_APP_CLIENT_SV TO MAXDAT_SUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.D_PA_APP_CLIENT_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.D_PA_APP_CLIENT_SV TO MAXDAT_REPORTS; 
