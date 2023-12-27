CREATE OR REPLACE VIEW MAXDAT.NYHIX_MFB_V2_AI_KOFAX_AUDIT_SV  AS 
  WITH  RM_LAST_MODULE AS (
            SELECT RMDTS.function_name function_name,
                to_date(substr(RMDTS.mailroom_received_dt,1,10),'yyyy-mm-dd') mailroom_received_dt,
                to_date(RMDTS.insertts, 'yyyy-mm-dd hh24:mi:ss') insertts,
                to_date(RMDTS.request_receiveddate, 'yyyy-mm-dd hh24:mi:ss') request_receiveddate,
                es.IMAGETRUST_BATCH_NAME IMAGETRUST_BATCH_NAME,
                es.ECN esECN,
                es.ENVLOPE_BATCH_NAME ENVLOPE_BATCH_NAME,
                es.ENVELOPE_COUNT ENVELOPE_COUNT,
                es.BATCH_CREATE_DT BATCH_CREATE_DT,
                es.INSERT_DT INSERT_DT,
                es.BATCH_CLASS BATCH_CLASS,
                es.DCN DCN,
                rmdts.ecn rmecn,
                rmdts.step_name step_name,
                rmdts.pdf_name pdf_name,
                rmdts.response_code response_code,
                rmdts.batch_name batch_name,
                to_date(min_max.LAST_START_DATE, 'yyyy-mm-dd hh24:mi:ss') LAST_START_DATE,
                to_date(min_max.START_DATE, 'yyyy-mm-dd hh24:mi:ss') START_DATE,
                to_date(substr(min_max.END_DATE,1,10),'yyyy-mm-dd') END_DATE
                from maxdat.EnvelopeStats es
                left join maxdat.rm_document_transaction_summary rmdts
                on rmdts.batch_name = es.envlope_batch_name and es.ecn = rmdts.ecn
                    JOIN (  SELECT BATCH_NAME,
                                   MAX (REQUEST_RECEIVEDDATE)     AS LAST_START_DATE,
                                   MIN (REQUEST_RECEIVEDDATE)     AS START_DATE,
                                   MAX (MAILROOM_RECEIVED_DT)       AS END_DATE
                              FROM MAXDAT.RM_DOCUMENT_TRANSACTION_SUMMARY
                              GROUP BY BATCH_NAME) MIN_MAX
                        ON     RMDTS.BATCH_NAME = MIN_MAX.BATCH_NAME
                           AND RMDTS.REQUEST_RECEIVEDDATE = MIN_MAX.LAST_START_DATE
), envelope as (                           
   select       es.IMAGETRUST_BATCH_NAME,
                es.ECN,
                es.ENVLOPE_BATCH_NAME,
                es.ENVELOPE_COUNT,
                es.BATCH_CREATE_DT,
                es.INSERT_DT,
                es.BATCH_CLASS,
                es.DCN
   from maxdat.EnvelopeStats es
), rmdoc as (
   SELECT RMDTS.function_name,
                to_date(substr(RMDTS.mailroom_received_dt,1,10),'yyyy-mm-dd') mailroom_received_dt,
                to_date(RMDTS.insertts, 'yyyy-mm-dd hh24:mi:ss') insertts,
                to_date(RMDTS.request_receiveddate, 'yyyy-mm-dd hh24:mi:ss') request_receiveddate,
                rmdts.ecn,
                rmdts.step_name,
                rmdts.pdf_name,
                rmdts.response_code,
                rmdts.batch_name
    from maxdat.rm_document_transaction_summary rmdts                         
), batch_count as (
select a.ecn,
       count(a.ecn) RM_ecn_count
       from rm_doc_transaction_summary_sv a
       join envelopestats es
       on es.ecn = a.ecn
       group by a.ecn
), KOFAX_FIRST_MODULE AS (
            SELECT SMRY.BATCH_NAME,
                    SMRY.BATCH_GUID,
                    EV.PAGES_SCANNED         AS KOFAX_PAGES_SCANNED,
                    SMRY.INSTANCE_STATUS     MAXDAT_INSTANCE_STATUS,
                    SMRY.JEOPARDY_FLAG,
                    SMRY.JEOPARDY_DT,
                    SMRY.CREATE_DT           AS SMRY_CREATE_DATE,
                    SMRY.BATCH_CLASS,
                    SMRY.BATCH_DOC_COUNT,
                    SMRY.BATCH_ENVELOPE_COUNT,
                    SMRY.BATCH_PAGE_COUNT,
                    SMRY.FAX_BATCH_SOURCE,
                    SMRY.BATCH_COMPLETE_DT,
                    SMRY.SOURCE_SERVER,                                   --??
                    SMRY.BATCH_DESCRIPTION,
                    SMRY.BATCH_TYPE,
                    SMRY.COMPLETE_DT,
                    SMRY.REPROCESSED_FLAG,
                    SMRY.REPROCESSED_DATE,
                    SMRY.CANCEL_DT,
                    SMRY.CANCEL_REASON,
                    SMRY.BATCH_PRIORITY      AS KOFAX_BATCH_PRIORITY,
                    SMRY.BATCH_DELETED,
                    SMRY.AGE_IN_BUSINESS_DAYS,
                    SMRY.AGE_IN_CALENDAR_DAYS,
                    SMRY.TIMELINESS_STATUS,
                    SMRY.TIMELINESS_DAYS,
                    SMRY.TIMELINESS_DT,
                    SMRY.LAST_EVENT_STATUS,
                    SMRY.LAST_EVENT_MODULE_NAME
   FROM MAXDAT.NYHIX_MFB_V2_BATCH_SUMMARY SMRY
           JOIN MAXDAT.NYHIX_MFB_V2_BATCH_EVENT EV
            ON     smry.BATCH_GUID = EV.BATCH_GUID
            AND (EV.BATCH_GUID, EV.START_DATE_TIME) IN
             (SELECT BATCH_GUID, MIN (START_DATE_TIME)
              FROM MAXDAT.NYHIX_MFB_V2_BATCH_EVENT
              GROUP BY BATCH_GUID)
), DMS_DOC AS (
            SELECT DCN           AS DMS_DCN,
                    BATCH_ID      AS DMS_BATCH_ID,
                    DATE_RECEIVED AS DMS_DATE_RECEIVED,
                    FORM_TYPE     AS DMS_FORM_TYPE,
                    NUMBER_OF_PAGES AS DMS_NUMBER_OF_PAGES,
                    ECN           AS DMS_ECN,
                    KOFAX_DCN     AS DMS_KOFAX_DCN,
                    CREATION_DATE AS DMS_CREATION_DATE,
                    LAST_UPDATE_DATE AS DMS_LAST_UPDATE_DATE
               FROM MAXDAT.D_DOCUMENTS
             ----------
             UNION ALL
             ----------
             SELECT DCN           AS DMS_DCN,
                    BATCH_ID      AS DMS_BATCH_ID,
                    DATE_RECEIVED,
                    FORM_TYPE     AS DMS_FORM_TYPE,
                    NUMBER_OF_PAGES,
                    ECN           AS DMS_ECN,
                    KOFAX_DCN     AS DMS_KOFAX_DCN,
                    CREATION_DATE,
                    LAST_UPDATE_DATE
               FROM MAXDAT.D_NYEC_DOCUMENTS
)
    SELECT distinct --------------------------------
           CASE
                 WHEN     rmdts.batch_name is null 
                    then  'ERROR RM BATCH MISSING' 
                 WHEN     rmdts.Response_Code = 'Rerouted'
                    AND   KOFAX_FIRST_MODULE.BATCH_GUID is null
                    then  'ERROR REROUTED KOFAX BATCH MISSING'
                 WHEN     rmdts.Response_Code = 'Failure'
                    then  'ERROR RM BATCH FAILED'
                 WHEN     bc.RM_ecn_count <> 3
                    then  'ERROR RM BATCH STEPS MISSING' 
                 WHEN     rmdts.function_name like 'Validation%'
                    AND   rmdts.Response_Code = 'Success'
                    AND   dms_doc.DMS_DCN is null 
                    then  'ERROR DMS BATCH MISSING'
                 When   KOFAX_FIRST_MODULE.BATCH_NAME IS NOT NULL
                    AND rmdts.Response_Code = 'Rerouted'
                    AND NVL(es.ENVELOPE_COUNT , 0) =
                        NVL(KOFAX_FIRST_MODULE.KOFAX_PAGES_SCANNED, 0)
                    THEN 'KOFAX_PAGE COUNTS MATCH'
                 When   KOFAX_FIRST_MODULE.BATCH_NAME IS NOT NULL
                    AND rmdts.Response_Code = 'Rerouted'
                    AND NVL(es.ENVELOPE_COUNT , 0) <>
                        NVL(KOFAX_FIRST_MODULE.KOFAX_PAGES_SCANNED, 0)
                    THEN   'KOFAX PAGE COUNTS DO NOT MATCH'
                 When   dms_doc.dms_dcn IS NOT NULL
                    AND rmlm.function_name like 'Validation%'
                    AND rmdts.Response_Code = 'Success'
                    AND NVL(es.ENVELOPE_COUNT , 0) =
                        NVL(dms_doc.dms_number_of_pages, 0)
                    THEN 'DMS_PAGE COUNTS MATCH'
                 When   dms_doc.dms_dcn IS NOT NULL
                    AND rmlm.function_name like 'Validation%'
                    AND rmdts.Response_Code = 'Success'
                    AND NVL(es.ENVELOPE_COUNT , 0) <>
                        NVL(dms_doc.dms_number_of_pages, 0)
                    THEN 'DMS_PAGE COUNTS DO NOT MATCH'
                When    rmdts.function_name not like 'Validation%'
                    AND rmdts.Response_Code = 'Success'
                    THEN 'BATCH IN PROCESS'
                When    rmdts.function_name like 'Validation%'
                    AND rmdts.Response_Code = 'Success'
                    THEN 'BATCH PROCESSED'
          ELSE 'UNKNOWN'
          end BATCH_STATUS,
           --------------------------------
           MAXDAT.BUS_DAYS_BETWEEN ( rmlm.START_DATE,                      
               CASE                                           
                   WHEN     rmlm.function_name like 'Validation%' 
                        AND rmlm.Response_Code = 'Success'                             
                   THEN
                       rmlm.END_DATE  
                   ELSE
                       SYSDATE
               END ) as RM_DOC_AGE_IN_BUSINESS_DAYS,
                es.IMAGETRUST_BATCH_NAME,
                es.ECN Envelope_ECN,
                es.ENVLOPE_BATCH_NAME,
                es.ENVELOPE_COUNT,
                es.BATCH_CREATE_DT,
                es.INSERT_DT,
                es.BATCH_CLASS Envelope_BATCH_CLASS,
                es.DCN,
                RMDTS.function_name,
                rmdts.mailroom_received_dt,
                RMDTS.insertts,
                RMDTS.request_receiveddate,
                rmdts.ecn RM_ecn,
                rmdts.step_name,
                rmdts.pdf_name,
                rmdts.response_code,
                rmdts.batch_name RM_batch_name,
                DMS_DCN,
                DMS_BATCH_ID,
                DMS_DATE_RECEIVED,
                DMS_FORM_TYPE,
                DMS_NUMBER_OF_PAGES,
                DMS_ECN,
                DMS_KOFAX_DCN,
                DMS_CREATION_DATE,
                DMS_LAST_UPDATE_DATE,
           KOFAX_FIRST_MODULE.KOFAX_PAGES_SCANNED,
           KOFAX_FIRST_MODULE.MAXDAT_INSTANCE_STATUS,
           KOFAX_FIRST_MODULE.JEOPARDY_FLAG,
           KOFAX_FIRST_MODULE.JEOPARDY_DT,
           KOFAX_FIRST_MODULE.BATCH_GUID,
           KOFAX_FIRST_MODULE.SMRY_CREATE_DATE,
           KOFAX_FIRST_MODULE.BATCH_CLASS,
           KOFAX_FIRST_MODULE.BATCH_DOC_COUNT,
           KOFAX_FIRST_MODULE.BATCH_ENVELOPE_COUNT,
           KOFAX_FIRST_MODULE.BATCH_PAGE_COUNT,
           KOFAX_FIRST_MODULE.FAX_BATCH_SOURCE,
           KOFAX_FIRST_MODULE.BATCH_COMPLETE_DT,
           KOFAX_FIRST_MODULE.SOURCE_SERVER,      
           KOFAX_FIRST_MODULE.BATCH_DESCRIPTION,
           KOFAX_FIRST_MODULE.BATCH_TYPE,
           KOFAX_FIRST_MODULE.COMPLETE_DT,
           KOFAX_FIRST_MODULE.REPROCESSED_FLAG,
           KOFAX_FIRST_MODULE.REPROCESSED_DATE,
           KOFAX_FIRST_MODULE.CANCEL_DT,
           KOFAX_FIRST_MODULE.CANCEL_REASON,
           KOFAX_FIRST_MODULE.KOFAX_BATCH_PRIORITY,
           KOFAX_FIRST_MODULE.BATCH_DELETED,
           KOFAX_FIRST_MODULE.AGE_IN_BUSINESS_DAYS,
           KOFAX_FIRST_MODULE.AGE_IN_CALENDAR_DAYS,
           KOFAX_FIRST_MODULE.TIMELINESS_STATUS,
           KOFAX_FIRST_MODULE.TIMELINESS_DAYS,
           KOFAX_FIRST_MODULE.TIMELINESS_DT,
           KOFAX_FIRST_MODULE.LAST_EVENT_STATUS,
           KOFAX_FIRST_MODULE.LAST_EVENT_MODULE_NAME
      FROM envelope es
      left outer join rmdoc rmdts
          on rmdts.batch_name = es.envlope_batch_name and rmdts.ecn = es.ecn
      left outer join RM_LAST_MODULE rmlm
          on es.envlope_batch_name = rmlm.envlope_batch_name and es.ecn = rmlm.rmecn
      LEFT OUTER JOIN KOFAX_FIRST_MODULE
          ON rmlm.IMAGETRUST_batch_name = KOFAX_FIRST_MODULE.BATCH_NAME
      left outer join DMS_DOC
          ON es.ecn = dms_doc.dms_ecn
      left outer join batch_count bc
          on es.ecn = bc.ecn
      where to_date(es.BATCH_CREATE_DT,'yyyy-mm-dd hh24:mi:ss') > (sysdate - 30)
          order by es.ENVLOPE_BATCH_NAME
      ;


  GRANT INSERT ON MAXDAT.NYHIX_MFB_V2_AI_KOFAX_AUDIT_SV TO MAXDAT_OLTP_SIUD;
  GRANT SELECT ON "MAXDAT"."NYHIX_MFB_V2_AI_KOFAX_AUDIT_SV" TO "MAXDAT_OLTP_SIUD";
  GRANT UPDATE ON "MAXDAT"."NYHIX_MFB_V2_AI_KOFAX_AUDIT_SV" TO "MAXDAT_OLTP_SIUD";
  GRANT SELECT ON "MAXDAT"."NYHIX_MFB_V2_AI_KOFAX_AUDIT_SV" TO "MAXDAT_READ_ONLY";
  GRANT SELECT ON "MAXDAT"."NYHIX_MFB_V2_AI_KOFAX_AUDIT_SV" TO "MAXDAT_REPORTS";
  GRANT INSERT ON "MAXDAT"."NYHIX_MFB_V2_AI_KOFAX_AUDIT_SV" TO "MAXDAT_OLTP_SIU";
  GRANT SELECT ON "MAXDAT"."NYHIX_MFB_V2_AI_KOFAX_AUDIT_SV" TO "MAXDAT_OLTP_SIU";
  GRANT UPDATE ON "MAXDAT"."NYHIX_MFB_V2_AI_KOFAX_AUDIT_SV" TO "MAXDAT_OLTP_SIU";
  GRANT DELETE ON "MAXDAT"."NYHIX_MFB_V2_AI_KOFAX_AUDIT_SV" TO "MAXDAT_OLTP_SIUD";
