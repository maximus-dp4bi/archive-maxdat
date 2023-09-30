--------------------------------------------------------
--  File created - Wednesday-April-18-2018   
--------------------------------------------------------
alter session set current_schema = "MAXDAT";


CREATE OR REPLACE VIEW LETTER_EXCEPTIONS_SV AS
WITH tn
       AS (SELECT DISTINCT  '1'                    AS REPORTNUM,
                            'N'                    AS MAXIMUS_TRIGGERED,
                            LR.letter_id           AS LETTER_REQ_ID,
                            LD.name                AS LETTER_TYPE,
                            CSI.clnt_cin           AS CLNT_CIN,
                            floor(months_between(receipt_date,clnt_dob)/12) age,
                            LR.letter_requested_on AS REQUESTED_ON,
                            LR.letter_sent_on      AS LETTER_SENT_ON,
                            S.first_name           AS STAFF_FIRST_NAME,
                            S.last_name            AS STAFF_LAST_NAME,
                            S.staff_type_cd        AS STAFF_TYPE_CD,
                            CSI.clnt_fname         AS FIRST_NAME,
                            CSI.clnt_lname         AS LAST_NAME
FROM LETTERS_STG LR
JOIN CLIENT_STG CSI ON LR.LETTER_CASE_ID = CSI.CASE_ID
--JOIN D_LETTER_DEFINITION LD ON LD.NAME = LR.LETTER_TYPE_CD
JOIN APP_CASE_LINK_STG AC ON LR.LETTER_CASE_ID = AC.CASE_ID
INNER JOIN d_letter_definition_sv ld 
    ON lr.letter_type_cd = ld.name
  LEFT OUTER JOIN letter_request_link_stg ll 
    ON lr.letter_id = ll.lmreq_id
    AND ll.reference_type = 'APP_HEADER' 
LEFT JOIN  APP_HEADER_STG ah ON ll.reference_id = ah.application_id
--JOIN D_DATES ON LR.LETTER_REQUESTED_ON = D_DATE
  --  AND BUSINESS_DAY_FLAG = 'Y'
RIGHT JOIN APP_ELIG_OUTCOME_STG EO ON EO.APPLICATION_ID = AC.APPLICATION_ID
LEFT JOIN APP_MISSING_INFO_STG MI ON MI.APPLICATION_ID = AC.APPLICATION_ID
LEFT JOIN D_STAFF S1 ON S1.STAFF_ID = MI.CREATED_BY
RIGHT JOIN D_STAFF S ON S.STAFF_ID = LR.LETTER_CREATED_BY
where
(EO.ELIG_OUTCOME_CD IN ('STATE REJECTED', 'STATE APPROVED') AND LR.LETTER_STATUS_CD IN ('SENT') AND LR.LETTER_REQUEST_TYPE IN ('L', 'S') 
AND LD.LMDEF_ID NOT IN ('72', '79', '80', '78')AND S.STAFF_TYPE_CD NOT IN ('PROJECT_STAFF') 
--AND TRUNC(LR.LETTER_REQUESTED_ON) > '01-jan-2018'
AND TRUNC(LR.LETTER_SENT_ON) > '01-jan-2018'
)
OR 
(S1.STAFF_TYPE_CD IN ('STATE') AND LR.LETTER_STATUS_CD IN ('SENT') AND LD.LMDEF_ID IN ('62', '63', '64','65', '66', '67', '68', '69', '70', '71', '86', '87', '81', '82')
AND TRUNC (LR.LETTER_REQUESTED_ON) = MI.NOTIFICATION_DATE AND LR.LETTER_REQUEST_TYPE IN ('L', 'S') 
--AND TRUNC(LR.LETTER_REQUESTED_ON) > '01-jan-2018'
AND TRUNC(LR.LETTER_SENT_ON) > '01-jan-2018'
)
OR
(S.STAFF_TYPE_CD IN ('STATE') AND LR.LETTER_STATUS_CD IN ('SENT') AND LD.LMDEF_ID IN ('57', '58', '59', '60', '73', '74', '83', '84') AND LR.LETTER_REQUEST_TYPE IN ('L', 'S') 
--AND TRUNC(LR.LETTER_REQUESTED_ON) > '01-jan-2018'
AND TRUNC(LR.LETTER_SENT_ON) > '01-jan-2018'
)
),
max
       AS (SELECT DISTINCT  '2'                    AS REPORTNUM,
                            'Y'                    AS MAXIMUS_TRIGGERED,
                            LR.letter_id           AS LETTER_REQ_ID,
                            LD.name                AS LETTER_TYPE,
                            CSI.clnt_cin           AS CLNT_CIN,
                            floor(months_between(receipt_date,clnt_dob)/12) age,
                            LR.letter_requested_on AS REQUESTED_ON,
                            LR.letter_sent_on      AS LETTER_SENT_ON,
                            S.first_name           AS STAFF_FIRST_NAME,
                            S.last_name            AS STAFF_LAST_NAME,
                            S.staff_type_cd        AS STAFF_TYPE_CD,
                            CSI.clnt_fname         AS FIRST_NAME,
                            CSI.clnt_lname         AS LAST_NAME
FROM LETTERS_STG LR
JOIN CLIENT_STG CSI ON LR.LETTER_CASE_ID = CSI.CASE_ID
--JOIN D_LETTER_DEFINITION LD ON LD.NAME = LR.LETTER_TYPE_CD
JOIN APP_CASE_LINK_STG AC ON LR.LETTER_CASE_ID = AC.CASE_ID
INNER JOIN d_letter_definition_sv ld 
    ON lr.letter_type_cd = ld.name
  LEFT OUTER JOIN letter_request_link_stg ll 
    ON lr.letter_id = ll.lmreq_id
    AND ll.reference_type = 'APP_HEADER' 
LEFT JOIN  APP_HEADER_STG ah ON ll.reference_id = ah.application_id
LEFT JOIN APP_MISSING_INFO_STG MI ON MI.APPLICATION_ID = AC.APPLICATION_ID
RIGHT JOIN D_STAFF S ON S.STAFF_ID = LR.LETTER_CREATED_BY
--Monday -3, Tuesday >=3, Wednesday-Friday -1
WHERE 
(S.STAFF_TYPE_CD IN ('PROJECT_STAFF') AND LR.LETTER_STATUS_CD IN ('SENT') AND LR.LETTER_REQUEST_TYPE IN ('L', 'S')  AND LD.LMDEF_ID IN ('59', '74', '61', '60', '88', '89', '79') 
--AND TRUNC(LR.LETTER_REQUESTED_ON) > '01-jan-2018'
AND TRUNC(LR.LETTER_SENT_ON) > '01-jan-2018'
)
--Monday -3, Tuesday >=3, Wednesday-Friday -1
OR
(
LR.LETTER_REQUEST_TYPE IN ('L', 'S') AND LR.LETTER_STATUS_CD IN ('SENT') AND LD.LMDEF_ID IN ('80')  
--AND TRUNC(LR.LETTER_REQUESTED_ON) > '01-jan-2018'
AND TRUNC(LR.LETTER_SENT_ON) > '01-jan-2018'
)
OR
(
(S.STAFF_TYPE_CD) IN ('PROJECT_STAFF')AND(LR.LETTER_REQUEST_TYPE)IN ('L', 'S') AND LR.LETTER_STATUS_CD IN ('SENT') AND LD.LMDEF_ID IN ('73') 
--AND TRUNC(LR.LETTER_REQUESTED_ON) > '01-jan-2018'
AND TRUNC(LR.LETTER_SENT_ON) > '01-jan-2018'
    AND  csi.clnt_cin LIKE '456%'
    AND floor(months_between(receipt_date,clnt_dob)/12) < 19
    AND letter_id = (SELECT LETTER_REQ_ID FROM LETTER_OUT_DATA_CONTENT_STG LS WHERE OUTCOMEREASONCDVALUE = 'OVER_INCOME_MED' AND LS.LETTER_REQ_ID = LR.LETTER_ID)
)
),
maxsys AS (SELECT DISTINCT  '3'                    AS REPORTNUM,
                            'Y'                    AS MAXIMUS_TRIGGERED,
                            LR.letter_id           AS LETTER_REQ_ID,
                            LD.name                AS LETTER_TYPE,
                            CSI.clnt_cin           AS CLNT_CIN,
                            floor(months_between(receipt_date,clnt_dob)/12) age,
                            LR.letter_requested_on AS REQUESTED_ON,
                            LR.letter_sent_on      AS LETTER_SENT_ON,
                            S.first_name           AS STAFF_FIRST_NAME,
                            S.last_name            AS STAFF_LAST_NAME,
                            S.staff_type_cd        AS STAFF_TYPE_CD,
                            CSI.clnt_fname         AS FIRST_NAME,
                            CSI.clnt_lname         AS LAST_NAME
FROM LETTERS_STG LR
JOIN CLIENT_STG CSI ON LR.LETTER_CASE_ID = CSI.CASE_ID
--JOIN D_LETTER_DEFINITION LD ON LD.NAME = LR.LETTER_TYPE_CD
JOIN APP_CASE_LINK_STG AC ON LR.LETTER_CASE_ID = AC.CASE_ID
INNER JOIN d_letter_definition_sv ld 
    ON lr.letter_type_cd = ld.name
  LEFT OUTER JOIN letter_request_link_stg ll 
    ON lr.letter_id = ll.lmreq_id
    AND ll.reference_type = 'APP_HEADER' 
LEFT JOIN  APP_HEADER_STG ah ON ll.reference_id = ah.application_id
LEFT JOIN APP_MISSING_INFO_STG MI ON MI.APPLICATION_ID = AC.APPLICATION_ID
RIGHT JOIN D_STAFF S ON S.UNIQUE_STAFF_ID = LR.LETTER_CREATED_BY
--Monday -3, Tuesday >=3, Wednesday-Friday -1
WHERE 
(S.STAFF_TYPE_CD IN ('PROJECT_STAFF') AND LR.LETTER_STATUS_CD IN ('SENT') AND LR.LETTER_REQUEST_TYPE IN ('L', 'S')  
AND TRUNC(LR.LETTER_SENT_ON) > '01-jan-2018'
--AND TRUNC(LR.LETTER_REQUESTED_ON) > '01-jan-2018'
)
--Monday -3, Tuesday >=3, Wednesday-Friday -1
OR
(
LR.LETTER_REQUEST_TYPE IN ('L', 'S') AND S.LAST_NAME = 'System' AND LR.LETTER_STATUS_CD IN ('SENT') AND LD.LMDEF_ID IN ('88','89','56','57','59','60','61','72','73','74','78','79','80','54','55')  
--AND TRUNC(LR.LETTER_REQUESTED_ON) > '01-jan-2018'
AND TRUNC(LR.LETTER_SENT_ON) > '01-jan-2018'
)
OR 
(
(S.STAFF_TYPE_CD) IN ('PROJECT_STAFF')AND(LR.LETTER_REQUEST_TYPE)IN ('L', 'S') AND LR.LETTER_STATUS_CD IN ('SENT') AND LD.LMDEF_ID IN ('73') 
--AND TRUNC(LR.LETTER_REQUESTED_ON) > '01-jan-2018'
AND TRUNC(LR.LETTER_SENT_ON) > '01-jan-2018'
    AND  csi.clnt_cin LIKE '456%'
)
OR
--check 406 later
(
(S.STAFF_TYPE_CD) IN ('PROJECT_STAFF')
AND(LR.LETTER_REQUEST_TYPE)IN ('L', 'S') --THESE ARE REPRINTS REMOVE TO GET TN 406
AND LR.LETTER_STATUS_CD IN ('SENT') AND LR.LETTER_TYPE_CD LIKE 'TN 406%' 
--AND TRUNC(LR.LETTER_REQUESTED_ON) > '01-jan-2018'
AND TRUNC(LR.LETTER_SENT_ON) > '01-jan-2018'
)
),
main AS
(SELECT letter_req_id,
                  letter_type,
                  clnt_cin,
                  age,
                  requested_on,
                  letter_sent_on,
                  staff_first_name,
                  staff_last_name,
                  staff_type_cd,
                  REPORTNUM,
                  MAXIMUS_TRIGGERED,
                  first_name,
                  last_name
           FROM   max
           UNION
           SELECT letter_req_id,
                  letter_type,
                  clnt_cin,
                  age,
                  requested_on,
                  letter_sent_on,
                  staff_first_name,
                  staff_last_name,
                  staff_type_cd,
                  REPORTNUM,
                  MAXIMUS_TRIGGERED,
                  first_name,
                  last_name
           FROM   tn
           UNION
           SELECT letter_req_id,
                  letter_type,
                  clnt_cin,
                  age,
                  requested_on,
                  letter_sent_on,
                  staff_first_name,
                  staff_last_name,
                  staff_type_cd,
                  REPORTNUM,
                  MAXIMUS_TRIGGERED,
                  first_name,
                  last_name
           FROM   maxsys
),
tnreview AS
(SELECT m.letter_req_id,
                  m.letter_type,
                  m.clnt_cin,
                  --m.clnt_dob,
                  --m.receipt_date,
                  --floor(months_between(receipt_date,clnt_dob)/12) age,
                  age,
                  m.requested_on,
                  letter_sent_on,
                  m.staff_first_name,
                  m.staff_last_name,
                  m.staff_type_cd,
                  m.REPORTNUM,
                  m.MAXIMUS_TRIGGERED,
                  h.address_line_1,
                  h.address_line_2,
                  h.city,
                  state,
                  h.zip_code,
                  h.zip_code_ext,
                  m.first_name || ' ' || m.last_name AS MEMBER_NAME,
                  TO_DATE(dateofletter, 'YYYY-MM-DD hh24:mi:ss') dateofletter,
                  TO_DATE(respondbydate, 'YYYY-MM-DD hh24:mi:ss') respondbydate,
                  magimonthlythresholdqmbvalue,
                  coverageenddatevalue,
                  programendmedvalue,
                  magimonthlythresholdmedvalue,
                  medicaidtermdatevalue,
                  outcomereasoncdstdvalue,
                  recipientchoicesindvalue,
                  magimonthlythresholdchipvalue,
                  magimonthlythresholdqdwivalue,
                  spenddownamountvalue,
                  outcomereasoncdchipvalue,
                  magimonthlyincomevalue,
                  CASE WHEN m.letter_type in 'TN 410msp' THEN outcomereasoncdmsponlyvalue ELSE outcomereasoncdmspvalue END outcomereasoncdmspvalue,
                  CASE WHEN m.letter_type = 'TN 404' THEN day40appealdtbusvalue ELSE day40appealdtcalvalue END day40appealdtcalvalue,
                  magimonthlythresholdslmbvalue,
                  outcomereasoncdvalue,
                  --respondbydate,
                  day20appealdtbusvalue,
                  magimonthlythresholdqi1value,
                  effectivedatevalue,
                  origduedatevalue,
                  programendchipvalue
           FROM   letter_out_data_content_stg l
                  join main m
                    ON l.letter_req_id = m.letter_req_id
                  --JOIN main m ON m.letter_req_id = l.letter_req_id
                  --AND lr.lmreq_id = 2805350
                  join letter_out_header_stg h
                    ON l.letter_req_id = h.letter_req_id
)
SELECT letter_req_id,
         letter_type,
         REPORTNUM,
         MAXIMUS_TRIGGERED,
         --exceptions,
         clnt_cin,
        -- clnt_dob,
        -- receipt_date,
         age,
         address_line_1,
         address_line_2,
         city,
         state,
         zip_code,
         zip_code_ext,
         requested_on,
         letter_sent_on,
         --mailed_date,
         effectivedatevalue,
         coverageenddatevalue,
         respondbydate,
         dateofletter,
         --XML_ERROR,DAY40APPEALDTCALname,
         day40appealdtcalvalue,
         --number_20_appeal,
         day20appealdtbusvalue,
         medicaidtermdatevalue,
         magimonthlyincomevalue,
         magimonthlythresholdmedvalue,
         magimonthlythresholdchipvalue,
         magimonthlythresholdqdwivalue,
         magimonthlythresholdqi1value,
         magimonthlythresholdqmbvalue,
         magimonthlythresholdslmbvalue,
         outcomereasoncdvalue,
         outcomereasoncdstdvalue,
         outcomereasoncdchipvalue,
         outcomereasoncdmspvalue,
         staff_name,
         noaddress
         || ' '
         || nocity
         || ' '
         || nozip
         || ' '
         || noname
         || ' '
         || resend
         || ' '
         ||
         --origduedatevalue - dateofletter || ' ' ||
         app40_date_error
         || ' '
         || app20_date_error
         || ' '
         || term_date_error
 --        || ' '
 --        || no_msp_denial || ' ' || no_med_denial  || ' ' || no_std_denial || ' ' || no_chip_denial
          || ' ' ||
            CASE WHEN letter_type in ('TN 408', 'TN 409') AND (OUTCOMEREASONCDSTDVALUE IS NULL AND OUTCOMEREASONCDCHIPVALUE IS NULL AND OUTCOMEREASONCDVALUE IS NULL AND outcomereasoncdmspvalue IS NOT NULL) THEN 'Only MSP Denial' --get msp only denial for 408 and 409
              WHEN letter_type IN ( 'TN 403', 'TN 410msp','TN 408', 'TN 409' ) AND outcomereasoncdmspvalue IS NULL THEN 'No MSP Denial' 
              WHEN letter_type IN ( 'TN 404', 'TN 405', 'TN 405a','TN 408', 'TN 409') AND outcomereasoncdvalue IS NULL THEN 'No Med Denial' 
              WHEN letter_type IN ( 'TN 405', 'TN 405a','TN 408', 'TN 409') AND ( clnt_cin NOT LIKE '456%' ) AND ( outcomereasoncdstdvalue IS NULL ) THEN 'No STD Denial' 
              WHEN Letter_type IN ( 'TN 408', 'TN 409') AND outcomereasoncdchipvalue IS NULL THEN 'No CHIP Denial'
              WHEN letter_type in ('TN 408', 'TN 409') AND (OUTCOMEREASONCDSTDVALUE IS NULL AND OUTCOMEREASONCDCHIPVALUE IS NULL AND OUTCOMEREASONCDVALUE IS NULL AND outcomereasoncdmspvalue IS NULL) THEN 'No Denial Reasons' 
              END  || ' ' 
           -- || ' ' ||
           --|| '**' || no_msp_denial || ' ' || no_med_denial  || ' ' || no_std_denial || ' ' || no_chip_denial
          --|| '** '
         || ' ' 
         || no_qmb_denial
         || ' '
         || no_medicaid_threshold
         || ' '
         || med_inc_less_than_thresh
         || ' '
         || no_qmb_threshhold
         || ' '
         || qmb_inc_less_than_thresh
         || ' '
         || no_qdwi_threshold
         || ' '
         || qdwi_inc_less_than_thresh
         || ' '
         || no_qi1_threshold
         || ' '
         || qi1_inc_less_than_thresh
         || ' '
         || no_slmb_threshold
         || ' '
         || slmb_inc_less_than_thresh
         || ' '
         || no_chip_threshold
         || ' '
         || chip_inc_less_than_thresh
         || ' '
         || no_spendown_amt
         || ' '
         || not_out_of_recon
         || ' '
         || invalid_nr_letter
         || ' '
         || early_nr_letter exceptions
FROM   (SELECT letter_req_id,
                 REPORTNUM,
                 MAXIMUS_TRIGGERED,
                 letter_type,
                 dateofletter,
                 respondbydate,
                 clnt_cin,
                 --clnt_dob,
--                 receipt_date,
                 age,
                 address_line_1,
                 address_line_2,
                 city,
                 state,
                 zip_code,
                 zip_code_ext,
                 requested_on,
                 letter_sent_on,
                 --mailed_date,
                 effectivedatevalue,
                 coverageenddatevalue,
                 ( staff_first_name
                   || ' '
                   || staff_last_name )                          AS staff_name,
                 --AddressOver30, NoAddress, NoCity, NoZip, NoName, Resend,
                 --CASE
                   --WHEN Length(address_line_1) > 30 THEN 'Addr. Over 30'
                 --END                                             AddressOver30,  --removed 4_23_2018 by request
                 CASE
                   WHEN address_line_1 IS NULL THEN 'No Addr. Line 1'
                 END                                             NoAddress,
                 --CASE WHEN LENGTH(SUBSTR(lh.ADDRESS_LINE_1, 1, 8)) > 8 THEN ('Addr. Exceed Consec. Digits') END AddrExceed,
                 CASE
                   WHEN zip_code IS NULL THEN 'No Zip'
                 END                                             NoZip,
                 CASE
                   WHEN city IS NULL THEN 'No City'
                 END                                             NoCity,
                 CASE
                   WHEN member_name IS NULL THEN 'No Name'
                 END                                             NoName,
                 CASE
                   WHEN letter_type IN ( 'TN 401R', 'TN 401aR' ) THEN 'RESEND'
                 END                                             ReSend,
                 --Day40AppealDtCalName,
                 day40appealdtcalvalue,
                 magimonthlyincomevalue,
                 magimonthlythresholdmedvalue,
                 magimonthlythresholdchipvalue,
                 magimonthlythresholdqdwivalue,
                 magimonthlythresholdqi1value,
                 magimonthlythresholdqmbvalue,
                 magimonthlythresholdslmbvalue,
                 outcomereasoncdvalue,
                 outcomereasoncdstdvalue,
                 outcomereasoncdchipvalue,
                 outcomereasoncdmspvalue,
                 medicaidtermdatevalue,
                 programendchipvalue,
                 spenddownamountvalue,
                 programendchipvalue,
                 day20appealdtbusvalue,
                 programendmedvalue,
                 recipientchoicesindvalue,
                 origduedatevalue,
                 --40APP Date Err
                 --20APP Date Err
                 --(CASE WHEN Day40AppealDtCalName like 'Member%' THEN 'XML_ERROR' END) XML_ERROR,
                 CASE
                   WHEN Round(( day40appealdtcalvalue - dateofletter )) < 40
                 THEN
                   '40APP Date Err'
                 END APP40_Date_Error,
                 Round(( day20appealdtbusvalue - dateofletter )) number_20_appeal,
                 CASE
                   WHEN Round(( day20appealdtbusvalue - dateofletter )) < 20
                        AND letter_type IN ( 'TN 408', 'TN 408ftp', 'TN 411',
                                             'TN412' )
                        THEN
                   '20APP Date Err'
                 END
                 APP20_Date_Error,
                 CASE
                   WHEN Round(( coverageenddatevalue - dateofletter )) < 20
                        AND letter_type IN ( 'TN 408', 'TN 408ftp', 'TN 411',
                                             'TN412' )
                        THEN
                   'TERM Date Error'
                 END                                             TERM_DATE_ERROR
                 ,
                 ( CASE
                     WHEN letter_type IN ( 'TN 403', 'TN 410msp' )
                          AND outcomereasoncdmspvalue IS NULL THEN
                     'No MSP Denial'
                   END )                                         NO_MSP_DENIAL,
                 ( CASE
                     WHEN letter_type IN ( 'TN 404', 'TN 405', 'TN 405a',
                                           'TN 408'
                                           ,'TN 409' )
                          AND outcomereasoncdvalue IS NULL THEN 'No Med Denial'
                   END )                                         NO_MED_DENIAL,
                 ( CASE
                     WHEN letter_type IN ( 'TN 405', 'TN 405a', 'TN 408',
                                           'TN 409'
                                         )
                          AND ( outcomereasoncdstdvalue IS NULL )
                          AND ( clnt_cin NOT LIKE '456%' ) THEN 'No STD Denial'
                   END )                                         NO_STD_DENIAL,
                 ( CASE
                     WHEN letter_type IN ( 'TN 408', 'TN 409' )
                          AND outcomereasoncdchipvalue IS NULL THEN
                     'No CHIP Denial'
                   END )                                         NO_CHIP_DENIAL,
                 ( CASE
                     WHEN letter_type = 'TN 403'
                          AND outcomereasoncdmspvalue NOT IN (
                                  'OVER_INCOME_QMB', 'OVER_RESOURCES_QMB',
                                  'QMB_INCOME_CHANGE,RESOURCE_INCREASE_QMB'
                                                             ) THEN
                     'No QMB Denial'
                   END )                                         NO_QMB_DENIAL,
                 ( CASE
                     WHEN letter_type IN ( 'TN 404', 'TN 405', 'TN 405a',
                                           'TN 408','TN 409', 'TN 413', 'TN 413a' )
                          AND outcomereasoncdvalue in ('OVER_INCOME_MED','OVER_INCOME_PICKLE_PASS_ALONG')
                          AND Nvl(magimonthlythresholdmedvalue, 0) = 0 THEN  --ROW 64
                     'NO Threshold' END ) NO_MEDICAID_THRESHOLD,
                 ( CASE
                     WHEN letter_type IN ( 'TN 404', 'TN 405', 'TN 405a',
                                           'TN 408','TN 409', 'TN 413', 'TN 413a' )
                          AND outcomereasoncdvalue in ('OVER_INCOME_MED', 'OVER_INCOME_PICKLE_PASS_ALONG')
                          AND Nvl(magimonthlythresholdmedvalue, 0) >
                              Nvl(magimonthlyincomevalue, 0)
                   THEN 'INC Less Than THRESH'
                   END ) MED_INC_LESS_THAN_THRESH
                        ,
                 ( CASE
                     WHEN letter_type IN ( 'TN 403', 'TN 408', 'TN 409', 'TN 410msp' )
                          AND outcomereasoncdmspvalue = 'OVER_INCOME_QMB'
                          AND Nvl(magimonthlythresholdqmbvalue, 0) = 0 THEN
                     'NO Threshold'
                   END ) NO_QMB_THRESHHOLD
                 ,
                 ( CASE
                     WHEN letter_type IN ( 'TN 403', 'TN 408', 'TN 409', 'TN 410msp' )
                          AND outcomereasoncdmspvalue = 'OVER_INCOME_QMB'
                          AND Nvl(magimonthlythresholdqmbvalue, 0) >
                              Nvl(magimonthlyincomevalue, 0)
                   THEN 'INC Less Than THRESH'
                   END ) QMB_INC_LESS_THAN_THRESH
                        ,
                 ( CASE
                     WHEN letter_type IN ( 'TN 408', 'TN 409' )
                          AND outcomereasoncdmspvalue = 'OVER_INCOME_QDWI'
                          AND Nvl(magimonthlythresholdqdwivalue, 0) = 0 THEN
                     'NO Threshold'
                   END ) NO_QDWI_THRESHOLD
                 ,
                 ( CASE
                     WHEN letter_type IN ( 'TN 408', 'TN 409' )
                          AND outcomereasoncdmspvalue = 'OVER_INCOME_QDWI'
                          AND Nvl(magimonthlythresholdqdwivalue, 0) >
                              Nvl(magimonthlyincomevalue, 0) THEN
                     'INC Less Than THRESH'
                   END ) QDWI_INC_LESS_THAN_THRESH,
                 ( CASE
                     WHEN letter_type IN ( 'TN 408', 'TN 409', 'TN 410msp' )
                          AND outcomereasoncdmspvalue = 'OVER_INCOME_QI1'
                          AND Nvl(magimonthlythresholdqi1value, 0) = 0 THEN
                     'NO Threshold'
                   END ) NO_QI1_THRESHOLD,
                 ( CASE
                     WHEN letter_type IN ( 'TN 408', 'TN 409', 'TN 410msp' )
                          AND outcomereasoncdmspvalue = 'OVER_INCOME_QI1'
                          AND Nvl(magimonthlythresholdqi1value, 0) >
                              Nvl(magimonthlyincomevalue, 0)
                   THEN 'INC Less Than THRESH'
                   END ) QI1_INC_LESS_THAN_THRESH
                        ,
                 ( CASE
                     WHEN letter_type IN ( 'TN 408', 'TN 409' )
                          AND outcomereasoncdmspvalue = 'OVER_INCOME_SLMB'
                          AND Nvl(magimonthlythresholdslmbvalue, 0) = 0 THEN
                     'NO Threshold'
                   END ) NO_SLMB_THRESHOLD
                 ,
                 ( CASE
                     WHEN letter_type IN ( 'TN 408', 'TN 409' )
                          AND outcomereasoncdmspvalue = 'OVER_INCOME_SLMB'
                          AND Nvl(magimonthlythresholdslmbvalue, 0) >
                              Nvl(magimonthlyincomevalue, 0) THEN
                     'INC Less Than THRESH'
                   END ) SLMB_INC_LESS_THAN_THRESH,
                 ( CASE
                     WHEN letter_type IN ( 'TN 408', 'TN 409' )
                          AND outcomereasoncdchipvalue = 'OVER_INCOME_CHIP'
                          AND Nvl(magimonthlythresholdchipvalue, 0) = 0 THEN
                     'NO Threshold'
                   END ) NO_CHIP_THRESHOLD
                 ,
                 ( CASE
                     WHEN letter_type IN ( 'TN 408', 'TN 409' )
                          AND outcomereasoncdchipvalue = 'OVER_INCOME_CHIP'
                          AND Nvl(magimonthlythresholdchipvalue, 0) >
                              Nvl(magimonthlyincomevalue, 0) THEN
                     'INC Less Than THRESH'
                   END ) CHIP_INC_LESS_THAN_THRESH,
                 ( CASE
                     WHEN letter_type = 'TN 406m'
                          AND spenddownamountvalue = 0 THEN 'No Spend Down AMT'
                   END ) NO_SPENDOWN_AMT
                 ,
                 CASE
                   WHEN letter_type = 'TN 412'
                        AND ( ( dateofletter - origduedatevalue ) < 140 ) THEN
                   'Not Out of Recon'
                 END NOT_OUT_OF_RECON,
                 CASE
                   WHEN letter_type = 'TN 411'
                        AND ( origduedatevalue > dateofletter ) THEN
                   'Invalid NR Letter'
                 END INVALID_NR_LETTER
                 ,
                 CASE
                   WHEN letter_type = 'TN 411'
                        AND ( ( dateofletter - origduedatevalue) < 10 ) THEN
                   'Early NR Letter'
                 END EARLY_NR_LETTER
--                 ,
--                   CASE WHEN letter_type in ('TN 408', 'TN 409') AND (OUTCOMEREASONCDSTDVALUE IS NULL AND OUTCOMEREASONCDCHIPVALUE IS NULL AND OUTCOMEREASONCDVALUE IS NULL AND outcomereasoncdmspvalue IS NULL)
--                 THEN 'No Denial Reasons' 
--                 WHEN letter_type in ('TN 408', 'TN 409') AND (OUTCOMEREASONCDSTDVALUE IS NULL AND OUTCOMEREASONCDCHIPVALUE IS NULL AND OUTCOMEREASONCDVALUE IS NULL AND outcomereasoncdmspvalue IS NOT NULL)
--                 THEN 'Only MSP Denial' END DENIAL_REASONS
                 --CASE WHEN letter_type = 'TN 408' AND age < 19 AND OUTCOMEREASONCDVALUE = 'OVER_INCOME_MED' THEN 'Under19_Income' END UNDER19_INCOME
          FROM   tnreview);
          
GRANT SELECT ON LETTER_EXCEPTIONS_SV to MAXDAT_READ_ONLY; 