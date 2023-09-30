CREATE OR REPLACE VIEW MAXDAT_SUPPORT.D_PL_CURRENT_SV
AS
SELECT LR.LMREQ_ID AS LMREQ_ID,
          LR.REQUESTED_ON AS REQUEST_TIMESTAMP,
          TRUNC(LR.REQUESTED_ON) AS REQUEST_DATE,
          to_number(extract(month from LR.REQUESTED_ON)) AS REQUEST_MONTH_NO,
          SUBSTR(to_char(LR.REQUESTED_ON,'Month'),1,3) AS REQUEST_MONTH,
          to_number(extract(year from LR.REQUESTED_ON)) AS REQUEST_YEAR,
          LR.CASE_ID AS CASE_ID,
          LR.SENT_ON AS SENT_TIMESTAMP,
          TRUNC(LR.SENT_ON) AS SENT_DATE,
          to_number(extract(month from LR.SENT_ON)) AS SENT_MONTH_NO,
          SUBSTR(to_char(LR.SENT_ON,'Month'),1,3) AS SENT_MONTH,
          to_number(extract(year from LR.SENT_ON)) AS SENT_YEAR,
          LR.STATUS_CD,
          LR.UPDATE_TS,
          ST.DESCRIPTION AS LETTER_STATUS,
          LN.DESCRIPTION AS LANGUAGE,
          LD.DESCRIPTION AS LETTER_TYPE,
          CL.CLNT_CLIENT_ID as CLIENT_ID,
          CL.CLNT_FNAME as FIRST_NAME,
          CL.CLNT_LNAME as LAST_NAME,
          CL.CLNT_GENERIC_FIELD5_TXT as HARMONY_ID,
          EC.DESCRIPTION as COUNTY_NAME,
          case when LL.reference_type = 'APP_HEADER' then LL.REFERENCE_ID else NULL end 
           as APPLICATION_ID,
          CASE
             WHEN COALESCE (NC.RECIPIENT_TYPE, 'CLIENT') IN
                     ('CLIENT', 'NONE')
             THEN
                LH.ADDRESS_LINE_1
                || CASE
                      WHEN LH.ADDRESS_LINE_2 IS NULL THEN NULL
                      ELSE ' ' || LH.ADDRESS_LINE_2
                   END
                || ' '
                || LH.CITY
                || ' '
                || LH.STATE
             ELSE
                recipient_address
          END
             RECIPIENT_ADDRESS,
          CASE
             WHEN LR.status_cd IN
                     ('COMPLETED', 'DMS_SUCCESS',
                      'EMAIL_SUCCESS', 'FAX_SENT',
                      'FAX_SUCCESS', 'GATEWAY_REQ_RECEIVED',
                      'MAILMERGE_SUCCESS', 'PRINTED',
                      'PRINT_SUCCESS', 'REQ',
                      'REQUEST_VALID', 'SENT')
             THEN 'S'
             WHEN lr.status_cd IN
                     ('DMS_INVALID', 'EMAIL_FAIL',
                      'ERR', 'FAX_FAIL', 'FAX_NOT_FOUND',
                      'FAX_SEND_ERROR', 'MAILMERGE_FAIL',
                      'RTND', 'VOID')
             THEN 'F'
             ELSE 'NA'
          END
             AS DOCUMENT_OUTCOME_FLAG,
          CASE WHEN lr.sent_on IS NOT NULL THEN 'Y' ELSE 'N' END
             AS STATUS_COMPLETE_FLAG,
          CASE
             WHEN ld.scope IS NULL
             THEN
                CASE WHEN lr.sent_on IS NOT NULL THEN 'Y' ELSE 'N' END
             ELSE
                NULL
          END
             AS FILE_DELIVERY_FLAG,
          LR.LMDEF_ID,
          case when LR.SENT_ON is not NULL then (case when (TRUNC(LR.SENT_ON) - TRUNC(LR.REQUESTED_ON)) <=3 then 'Y' else 'N' end) else ' ' end AS PROCESSED_TIMELY,
          CASE
             WHEN LR.SENT_ON IS NOT NULL
             THEN
                ( (SELECT CASE
                             WHEN (COUNT (*) - 1) < 0 THEN 0
                             ELSE (COUNT (*))
                          END
                     FROM MAXDAT_SUPPORT.D_DATES D1
                    WHERE D1.business_day_flag = 'Y'
                          AND D1.d_date BETWEEN LR.REQUESTED_ON
                                            AND LR.SENT_ON))
             ELSE
                0
          END
             AS AGE_IN_BUS_DAYS_CUMULATIVE,
          CASE
             WHEN LR.SENT_ON IS NOT NULL
             THEN
                TRUNC (LR.SENT_ON) - TRUNC (LR.REQUESTED_ON)
             ELSE
                0
          END
             AS AGE_IN_CAL_DAYS_CUMULATIVE
     FROM LETTER_REQUEST LR
          LEFT OUTER JOIN letter_request_link LL ON LR.lmreq_id = LL.lmreq_id
         LEFT OUTER JOIN (SELECT *
                             FROM (SELECT ca.case_id,
                                          ca.agency_id,
                                          ag.street_address_1
                                          || CASE
                                          WHEN ag.street_address_2
                                          IS NULL
                                          THEN
                                          NULL
                                          ELSE
                                                   ' ' || ag.street_address_2
                                             END
                                          || ' '
                                          || ag.city
                                             recipient_address,
                                          ag.state_cd,
                                          ag.zipcode,
                                          ag.county_cd,
                                          ag.phone_number,
                                          ag.fax_number,
                                          ag.email,
                                          ROW_NUMBER ()
                                          OVER (PARTITION BY ca.case_id
                                                ORDER BY ca.end_date)
                                             crn
                                     FROM    case_agency ca
                                          JOIN
                                             agency ag
                                          ON ca.agency_id = ag.agency_id
                                    WHERE ca.end_date IS NULL
                                          AND ag.end_date IS NULL)
                            WHERE crn = 1) cag
             ON lr.case_id = cag.case_id
          LEFT OUTER JOIN CLIENT CL ON LL.CLIENT_ID = CL.CLNT_CLIENT_ID
          LEFT OUTER JOIN letter_out_header LH ON LR.LMREQ_ID = LH.LETTER_REQ_ID
          LEFT OUTER JOIN LETTER_DEFINITION LD ON LR.LMDEF_ID = LD.LMDEF_ID and LD.SCOPE IS NULL
          LEFT OUTER JOIN address AD ON lr.mailing_address_id = ad.addr_id
          LEFT OUTER JOIN APP_HEADER AH ON LL.REFERENCE_ID=AH.APPLICATION_ID
and LL.reference_type = 'APP_HEADER'
          LEFT OUTER JOIN ENUM_NOTIFICATION_CONFIG NC ON LD.LMDEF_ID = NC.LMDEF_ID
          LEFT OUTER JOIN ENUM_LM_STATUS ST ON LR.STATUS_CD = ST.VALUE
          LEFT OUTER JOIN ENUM_LANGUAGE LN ON LR.LANGUAGE_CD = LN.VALUE
          LEFT OUTER JOIN ENUM_COUNTY ec ON AD.addr_ctlk_id = ec.value
    WHERE  (REQUESTED_ON >= (SYSDATE - (365)));


GRANT SELECT ON MAXDAT_SUPPORT.D_PL_CURRENT_SV TO MAXDAT_SUPPORT_READ_ONLY; 
GRANT SELECT ON MAXDAT_SUPPORT.D_PL_CURRENT_SV TO MAXDAT_REPORTS; 