DROP VIEW MAXDAT_SUPPORT.D_PI_COMPLAINT_CALL_SV;

CREATE OR REPLACE VIEW MAXDAT_SUPPORT.D_PI_COMPLAINT_CALL_SV
AS
SELECT /*+ parallel(10) */ distinct    
    i.incident_header_id AS INCIDENT_HEADER_ID
    , cr.call_record_id AS CONTACT_RECORD_ID
    , i.case_id AS CASE_ID --Link to EMRS_D_CASE_SV, EMRS_D_CASE_RES_ADDRESS_SV --But there is no requirement so far for CASE information, this is used for the case Address
    , COALESCE(crl.client_id,i.client_id) AS CLIENT_ID --connect to EMRS_D_CLIENT_SV in the Client Attribute
    , COALESCE(cr.call_start_ts, i.create_ts) AS COMPLAINT_DATE --Link to D_DATES to D_MONTH
    , i.origin_cd AS INCIDENT_ORIGIN_CD  --Link to D_PI_INCIDENT_ORIGIN_SV
    , i.status_cd AS INCIDENT_STATUS_CD -- Link to D_PI_INCIDENT_STATUS_SV
    , i.reporter_type_cd AS COMPLAINT_SOURCE  --cannot find a lookup
    , COALESCE(i.affected_party_type_cd, 'UD') AS AFFECTED_PARTY_TYPE_CD --Connect to EMRS_D_AFFECTED_PARTY_TYPE_SV lookup
    , COALESCE(i.affected_party_subtype_cd, 'UD') AS AFFECTED_PARTY_SUBTYPE_CD --Connect to EMRS_D_AFFECTED_PARTY_SUBTYPE_SV lookup
    , COALESCE(cl.clnt_fname, i.reporter_first_name) AS MEMBER_FIRST_NAME_FOR_RPT_115
    , COALESCE(cl.clnt_lname, i.reporter_last_name) AS MEMBER_LAST_NAME_FOR_RPT_115
    , CASE WHEN cl.clnt_client_id IS NOT NULL THEN 
            cl.clnt_fname||
                CASE
                  WHEN SUBSTR(cl.clnt_mi,1,1) IS NULL
                  THEN ' '
                  ELSE ' '||SUBSTR(cl.clnt_mi,1,1)||' '
                END ||cl.clnt_lname
       ELSE         
                CASE WHEN LENGTH(i.reporter_last_name) > 1
                    THEN i.reporter_first_name||' '||i.reporter_last_name
                    ELSE NULL
                    END
       END AS MEMBER_FULL_NAME_FOR_RPT_115
    , i.reporter_first_name AS REPORTER_FIRST_NAME
    , i.reporter_last_name AS REPORTER_LAST_NAME
    , CASE WHEN LENGTH(reporter_last_name) > 1
          THEN i.reporter_first_name||' '||i.reporter_last_name
          ELSE NULL
          END AS REPORTER_FULL_NAME
    , CASE WHEN i.reporter_phone IS NOT NULL 
            THEN '('||SUBSTR( i.reporter_phone,1,3)||')'||SUBSTR( i.reporter_phone,4,3)||'-'||SUBSTR( i.reporter_phone,7) END AS REPORTER_PHONE
    , dbms_lob.substr(i.description, 3999, 1) AS COMPLAINT_ABOUT
    , incaction.action_taken AS COMPLAINT_ACTION_TAKEN 
FROM eb.incident_header i
JOIN eb.event e  ON (i.incident_header_id = e.ref_id AND e.ref_type = 'INCIDENT' AND e.event_type_cd = 'COMPLAINT_INITIATED')
LEFT JOIN eb.call_record cr ON e.call_record_id = cr.call_record_id
LEFT JOIN eb.call_record_link crl ON (cr.call_record_id = crl.call_record_id)
LEFT JOIN eb.client cl ON (cl.clnt_client_id = COALESCE(crl.client_id,i.client_id))
LEFT JOIN (SELECT inc.incident_header_id, LISTAGG(extractValue(value(l),'//date') || ' ' || extractValue(value(l),'//action'), ';') WITHIN GROUP (ORDER BY TO_DATE(extractValue(value(l),'//date'),'mm/dd/yyyy, hh:mi:ss pm') desc) action_taken
                    FROM eb.incident_header inc, TABLE(xmlsequence(EXTRACT(XMLTYPE(inc.actions_taken),'//action_taken'))) l
                    GROUP BY inc.incident_header_id
            ) incaction on incaction.incident_header_id = i.incident_header_id
LEFT JOIN client c on c.clnt_client_id = COALESCE(crl.client_id,i.client_id)
WHERE i.incident_header_type_cd = 'COMPLAINT'
ORDER BY i.incident_header_id;

GRANT SELECT ON MAXDAT_SUPPORT.D_PI_COMPLAINT_CALL_SV TO DP4BI_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.D_PI_COMPLAINT_CALL_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.D_PI_COMPLAINT_CALL_SV TO MAXDAT_SUPPORT_READ_ONLY;
