CREATE TABLE mfb_data_stg(
ExternalBatchId NUMBER
,BatchName VARCHAR2(200)
,CreationStationId VARCHAR2(100)
,CreationUserId VARCHAR2(200)
,CreationUserName VARCHAR2(200)
,BatchClass VARCHAR2(100)
,BatchClassDescription VARCHAR2(100)
,BatchReferenceID VARCHAR2(100)
,TransferId VARCHAR2(100)
,BatchGUID VARCHAR2(100)
,BatchModuleId VARCHAR2(100)
,BatchDescription VARCHAR2(200)
,ModuleLaunchId VARCHAR2(100)
,ModuleCloseUniqueId VARCHAR2(500)
,ModuleName VARCHAR2(100)
,StartDateTime DATE
,EndDateTime DATE
,BatchStatus NUMBER
,Priority NUMBER
,ExpectedPages NUMBER
,ExpectedDocs NUMBER
,Deleted VARCHAR2(1)
,PagesPerDocument NUMBER
,PagesScanned NUMBER
,PagesDeleted NUMBER
,DocumentsCreated NUMBER
,DocumentsDeleted NUMBER
,ChangedFormTypes NUMBER
,PagesReplaced NUMBER
,ErrorCode NUMBER
,ErrorText VARCHAR2(500)
,Orphaned VARCHAR2(1)
,SBMTransferId VARCHAR2(100)
,SMLStartDateTIme DATE
,SMLEndDateTime DATE
,SMLModuleUniqueId VARCHAR2(500)
,SMLModuleName VARCHAR2(100)
,SMLUserId VARCHAR2(200)
,SMLUserName VARCHAR2(100)
,SMLStationId VARCHAR2(100)
,SMLSiteName VARCHAR2(100)
,SMLSiteId NUMBER
,SMLInProcessTID VARCHAR2(100)
,SMLOrphaned VARCHAR2(1)
,SMLCompletedTID VARCHAR2(100) ) TABLESPACE MAXDAT_DATA;

CREATE TABLE kofax_reporting_stg(
BATCH_ID VARCHAR2(50)
,BATCH_GUID VARCHAR2(100)
,BATCH_CLASS VARCHAR2(50)
,BATCH_NAME VARCHAR2(100)
,BATCH_DESCRIPTION VARCHAR2(100)
,BATCH_CREATED_BY VARCHAR2(100)
,BATCH_CREATION_STATION_ID VARCHAR2(100)
,BATCH_CREATE_DATE VARCHAR2(50)
,BATCH_EXPORT_DATE VARCHAR2(50)
,BATCH_DOC_COUNT VARCHAR2(50)
,ECN VARCHAR2(50)
,KOFAX_DCN VARCHAR2(50)
,DOC_TYPE VARCHAR2(50)
,DOC_PAGE_COUNT NUMBER
,DOCUMENT_NUMBER VARCHAR2(50)) TABLESPACE MAXDAT_DATA;

--create MFB events
CREATE TABLE d_mfb_events
AS
SELECT BatchModuleID BATCH_MODULE_ID,
	BatchGUID BATCH_GUID,
	ModuleLaunchID MODULE_LAUNCH_ID,
	SMLModuleUniqueID MODULE_UNIQUE_ID,
	SMLModuleName MODULE_NAME,
	ModuleCloseUniqueID MODULE_CLOSE_UNIQUE_ID,
	ModuleName MODULE_CLOSE_NAME,
	BatchStatus BATCH_STATUS,
	(Case when BatchStatus = 0 then 'N/A'
 		when BatchStatus = 2 then 'Ready'
 		when BatchStatus = 4 then 'In Progress'
 		when BatchStatus = 8 then 'Suspended'
 		when BatchStatus = 32 then 'Error'
 		when BatchStatus = 64 then 'Successful'
 		when BatchStatus = 128 then 'Reserved'
 		when BatchStatus = 512 then 'In Progress' end) as BATCH_STATUS_DESC,
	StartDateTime MODULE_START_DT,
	EndDateTime MODULE_END_DT,
	SMLUserID as MODULE_LAUNCH_USER_NAME,
	SMLStationID STATION_ID,
	SMLSiteName SITE_NAME,
	SMLSiteID SITE_ID,
	Deleted BATCH_DELETED,
	PagesPerDocument PAGES_PER_DOCUMENT,
	PagesScanned PAGES_SCANNED,
	PagesDeleted PAGES_DELETED,
	DocumentsCreated DOCUMENTS_CREATED,
	DocumentsDeleted DOCUMENTS_DELETED,
	PagesReplaced PAGES_REPLACED,
	'Central' SOURCE_SERVER,
	ErrorText ERROR_TEXT
FROM mfb_data_stg;

--create Reporting
--drop table d_mfb_reporting
CREATE TABLE d_mfb_reporting
AS 
SELECT batch_id
,batch_guid
,batch_class
,batch_name
,batch_description
,batch_created_by
,batch_creation_station_id
,TO_DATE(batch_create_date,'mm/dd/yyyy') batch_create_date
,TO_DATE(batch_export_date,'mm/dd/yyyy') batch_export_date
,batch_doc_count
,ecn
,kofax_dcn
,doc_type
,doc_page_count
,document_number
FROM kofax_reporting_stg;

--drop table d_mfb_form
CREATE TABLE d_mfb_form
AS
SELECT TypeEntryID AS FORM_TYPE_ENTRY_ID,
		 	TypeName AS FORM_TYPE_NAME,
		COALESCE(DocumentClassName,'N/A') AS DOCUMENT_CLASS_NAME,
		TO_NUMBER(TRIM(Documents)) AS NUM_DOCUMENTS,
		TO_NUMBER(TRIM(RejectedDocuments)) AS NUM_REJECTED_DOCUMENTS,
		TO_NUMBER(TRIM(Pages)) AS NUM_PAGES,
		TO_NUMBER(TRIM(RejectedPages)) AS NUM_REJECTED_PAGES,
		TO_NUMBER(REPLACE(KSManual,'"','')) AS NUM_KS_MANUAL,
		TO_NUMBER(TRIM(KSOCRRepair)) AS NUM_KS_OCR_REPAIR,
		TO_NUMBER(REPLACE(KSICRRepair,'"','')) AS NUM_KS_ICR_REPAIR,
		TO_NUMBER(TRIM(KSBCRepair)) AS NUM_KS_BC_REPAIR,
		TO_NUMBER(TRIM(KSOMRRepair)) AS NUM_KS_OMR_REPAIR,
		TO_NUMBER(TRIM(CompletedDocuments)) AS NUM_COMPLETED_DOCUMENTS,
		TO_NUMBER(TRIM(CompletedPages)) AS NUM_COMPLETED_PAGES,
		COALESCE(TransferID,'N/A') as TRANSFER_ID
FROM mailfax_forms_stg;

--drop table d_mfb_current
CREATE TABLE d_mfb_current
AS
SELECT sb.BatchGuid mfb_bi_id
 ,sb.BatchGUID batch_guid
 ,sb.ExternalBatchID batch_id
 ,sb.BatchName batch_name
 ,sb.CreationStationID creation_station_id
 ,sb.CreationUserName batch_created_by
 ,sb.CreationUserID creation_user_id
 ,sb.BatchClass batch_class
 ,COALESCE(sb.BatchClassDescription,'N/A') batch_class_description
 ,'N/A' batch_type
 ,sb.StartDateTime create_dt
 ,ex.EndDateTime complete_dt
 ,(CASE WHEN COALESCE(blm.CancelDateTime,ex.EndDateTime) IS NOT NULL THEN 'Complete' ELSE 'Active' END) instance_status
 ,blm.EndDateTime instance_status_dt
 ,blm.CancelDateTime cancel_dt
 ,blm.CancelBy cancel_by
 ,'N/A' cancel_reason
 ,(CASE WHEN blm.CancelDateTime IS NULL THEN 'N/A' ELSE blm.ModuleName end) cancel_method
 ,'Y' scan_batch_flag
 ,(CASE WHEN qc.BatchGUID IS NOT NULL THEN 'Y' ELSE 'N' END) perform_qc_flag
 ,qc.EndDateTime perform_qc_end
 ,(CASE WHEN ktmv.BatchGUID IS NOT NULL THEN 'Y' ELSE 'N' END) validate_data_flag
 ,ktmv.UserName validate_data_performed_by
 ,(CASE WHEN pdf.BatchGUID IS NOT NULL THEN 'Y' ELSE 'N' END) create_pdf_flag
 ,(CASE WHEN ex.BatchGUID IS NOT NULL THEN 'Y' ELSE 'N' END) populate_reports_data_flag
 ,(CASE WHEN ex.BatchGUID IS NOT NULL THEN 'Y' ELSE 'N' END) release_to_dms_flag
 ,sb.Priority batch_priority
 ,CASE WHEN blm.CancelDateTime IS NOT NULL THEN 'Y' ELSE 'N' END batch_deleted
 ,sb.PagesScanned pages_scanned
 ,sb.DocumentsCreated documents_created
 ,sb.DocumentsDeleted documents_deleted
 ,sb.PagesReplaced pages_replaced
 ,sb.PagesDeleted pages_deleted
 ,ard.bd_num-crd.bd_num age_in_business_days
 ,ard.cd_num-crd.cd_num age_in_calendar_days
 ,(CASE WHEN blm.CancelDateTime IS NOT NULL THEN 'Not Required' 
			WHEN COALESCE(TRUNC(ex.EndDateTime),TRUNC(sysdate))<=crd.timeliness_dt THEN 'Timely' 
			WHEN COALESCE(TRUNC(ex.EndDateTime),TRUNC(sysdate))>crd.timeliness_dt THEN 'Untimely' ELSE 'FAIL' END) timeliness_status
 ,crd.timeliness_dt
 ,(CASE WHEN COALESCE(ex.EndDateTime,blm.CancelDateTime) IS NOT NULL THEN 'N' 
			 WHEN TRUNC(sysdate) >=crd.jeopardy_dt THEN 'Y' ELSE 'N' END) jeopardy_flag
 ,crd.jeopardy_dt
 ,ex.EndDateTime batch_complete_dt
 ,blm.BatchModuleID current_batch_module_id
 ,blm.ModuleName current_batch_module_name
 ,blm.StartDateTime current_batch_module_start_dt
 ,blm.EndDateTime current_batch_module_end_dt
 ,(CASE WHEN qc.BatchGUID IS NOT NULL THEN 'Y' ELSE 'N' END) gwf_qc_required
 ,(CASE WHEN blm.CancelDateTime IS NOT NULL THEN 'Cancelled'
				WHEN (CASE WHEN ex.BatchGUID IS NOT NULL THEN 'Y' ELSE 'N' END) ='Y' THEN 'Completed'
				WHEN (CASE WHEN pdf.BatchGUID IS NOT NULL THEN 'Y' ELSE 'N' END) ='Y' THEN 'Create PDF'
				WHEN (CASE WHEN ktmv.BatchGUID IS NOT NULL THEN 'Y' ELSE 'N' END) ='Y' THEN 'Validation'
				WHEN (CASE WHEN ktms.BatchGUID IS NOT NULL THEN 'Y' ELSE 'N' END) ='Y' THEN 'Recognition'
				WHEN (CASE WHEN qc.BatchGUID IS NOT NULL THEN 'Y' ELSE 'N' END) ='Y' THEN 'QC'
				WHEN (CASE WHEN bm.BatchGUID IS NOT NULL THEN 'Y' ELSE 'N' END) ='Y' THEN 'Batch Manager'
				ELSE 'SCAN'
				END) current_step
 ,sb.BatchDescription batch_description
 ,(CASE WHEN re.BatchGUID IS NOT NULL THEN 'Y' ELSE 'N' END) reprocessed_flag
 ,blm.batch_suspended_flag
 ,sysdate extract_date  
 ,sb.StartDateTime perform_scan_start
 ,sb.EndDateTime perform_scan_end
 ,sb.CreationUserName perform_scan_performed_by
 ,qc.StartDateTime perform_qc_start 
 ,qc.SMLUserName perform_qc_performed_by
 ,'N/A' kofax_qc_reason
 ,(CASE WHEN ktms.BatchGUID IS NOT NULL THEN 'Y' ELSE 'N' END) classification_flag
 ,ktms.StartDateTime classification_start
 ,ktms.EndDateTime classification_end
 ,ktms.EndDateTime classification_dt
 ,(CASE WHEN ktms.BatchGUID IS NOT NULL THEN 'Y' ELSE 'N' END) recognition_flag
 ,ktms.StartDateTime recognition_start
 ,ktms.EndDateTime recognition_end
 ,ktms.EndDateTime recognition_dt
 ,ktmv.StartDateTime validate_data_start
 ,ktmv.EndDateTime validate_data_end 
 ,ktmv.StartDateTime validation_dt 
 ,pdf.StartDateTime create_pdfs_start
 ,pdf.EndDateTime create_pdfs_end 
 ,ex.StartDateTime populate_reports_data_start
 ,ex.EndDateTime populate_reports_data_end 
 ,ex.StartDateTime release_to_dms_start
 ,ex.EndDateTime release_to_dms_end
 ,2 timeliness_days
 ,'B' timeliness_days_type
 ,1 jeopardy_days
 ,'B' jeopardy_days_type
 ,0 target_days
 ,'Central' source_server
 ,COALESCE(sb.TransferID,'N/A') transfer_id
 ,sb.BatchReferenceID batch_reference_id 
 ,ROUND((COALESCE(blm.CancelDateTime,ex.StartDateTime)- sb.startdatetime),2) batch_cycle_time
 ,CASE WHEN ard.bd_num-crd.bd_num = 0 THEN '0'
       WHEN ard.bd_num-crd.bd_num = 1 THEN '1'
       WHEN ard.bd_num-crd.bd_num >= 2 THEN '2+'
   ELSE 'N/A' END age_in_business_days_group    
 --,null batch_envelope_count   
FROM mfb_data_stg sb
  JOIN (SELECT sbm.BatchGUID,sbm.BatchModuleID,sbm.StartDateTime
          ,COALESCE(sbm.EndDateTime,sbm.StartDateTime) EndDateTime
          ,(CASE WHEN (sbm.SMLModuleName<>'Export' AND sbm.deleted=1) THEN COALESCE(sbm.EndDateTime,sbm.StartDateTime) ELSE NULL END) CancelDateTime
          ,(CASE WHEN (sbm.SMLModuleName<>'Export' AND sbm.deleted=1) THEN sbm.SMLUserName ELSE NULL END) CancelBy
          ,sbm.SMLModuleName ModuleName,(CASE WHEN sbm.batchstatus=8 THEN 'Y' ELSE 'N' END) batch_suspended_flag
          ,ROW_NUMBER() OVER(PARTITION BY sbm.BatchGUID ORDER BY sbm.StartDateTime DESC) as rn
				FROM mfb_data_stg sbm
				WHERE sbm.BatchStatus in(8,64)) blm ON (sb.BatchGUID=blm.BatchGUID AND blm.rn = 1)
  LEFT JOIN (SELECT sbm_qc.BatchGUID
                    ,sbm_qc.StartDateTime
                    ,sbm_qc.EndDateTime
                    ,sbm_qc.SMLUserName
                    ,CASE WHEN sbm_qc.Deleted=1 THEN sbm_qc.EndDateTime END CancelDateTime
                    ,CASE WHEN sbm_qc.Deleted=1 THEN sbm_qc.SMLUserName END CancelBy
                    ,ROW_NUMBER() OVER(PARTITION BY sbm_qc.BatchGUID ORDER BY sbm_qc.StartDateTime) as rn
              FROM mfb_data_stg sbm_qc
              WHERE sbm_qc.SMLModuleName='Quality Control'
              AND BatchStatus=64) qc ON (sb.BatchGUID=qc.BatchGUID AND qc.rn = 1)  
	 LEFT JOIN (SELECT sbm_ktms.BatchGUID
                    ,sbm_ktms.StartDateTime
                    ,sbm_ktms.EndDateTime
                    ,CASE WHEN sbm_ktms.Deleted=1 THEN sbm_ktms.EndDateTime END CancelDateTime
                    ,CASE WHEN sbm_ktms.Deleted=1 THEN sbm_ktms.SMLUserName END CancelBy
                    ,ROW_NUMBER() OVER(PARTITION BY sbm_ktms.BatchGUID ORDER BY sbm_ktms.StartDateTime) as rn
              FROM mfb_data_stg sbm_ktms
              WHERE sbm_ktms.SMLModuleName like 'KTM Server%' 
              AND BatchStatus=64) ktms ON (sb.BatchGUID=ktms.BatchGUID AND ktms.rn = 1)                
	 LEFT JOIN (SELECT sbm_bm.BatchGUID
                        ,sbm_bm.StartDateTime
                        ,sbm_bm.EndDateTime
                        ,CASE WHEN sbm_bm.Deleted=1 THEN sbm_bm.EndDateTime END CancelDateTime
                        ,CASE WHEN sbm_bm.Deleted=1 THEN sbm_bm.SMLUserName END CancelBy
                        ,ROW_NUMBER() OVER(PARTITION BY sbm_bm.BatchGUID ORDER BY sbm_bm.StartDateTime) as rn
              FROM mfb_data_stg sbm_bm
              WHERE sbm_bm.SMLModuleName='Batch Manager'
              AND BatchStatus=64) bm ON (sb.BatchGUID=bm.BatchGUID AND bm.rn = 1)  
	 LEFT JOIN (SELECT sbm_ktmv.BatchGUID
                        ,sbm_ktmv.StartDateTime
                        ,sbm_ktmv.EndDateTime
                        ,sbm_ktmv.SMLUserName UserName
                        ,CASE WHEN sbm_ktmv.Deleted=1 THEN sbm_ktmv.EndDateTime END CancelDateTime
                        ,CASE WHEN sbm_ktmv.Deleted=1 THEN sbm_ktmv.SMLUserName END CancelBy
                        ,ROW_NUMBER() OVER(PARTITION BY sbm_ktmv.BatchGUID ORDER BY sbm_ktmv.StartDateTime) as rn
               FROM mfb_data_stg sbm_ktmv
               WHERE sbm_ktmv.SMLModuleName='KTM Validation'
               AND BatchStatus=64) ktmv ON (sb.BatchGUID=ktmv.BatchGUID AND ktmv.rn = 1)
  LEFT JOIN (SELECT sbm_pdf.BatchGUID
                    ,sbm_pdf.StartDateTime
                    ,sbm_pdf.EndDateTime
                    ,case when sbm_pdf.Deleted=1 then sbm_pdf.EndDateTime end CancelDateTime
                    ,case when sbm_pdf.Deleted=1 then sbm_pdf.SMLUserName end CancelBy
                    ,ROW_NUMBER() OVER(PARTITION BY sbm_pdf.BatchGUID ORDER BY sbm_pdf.StartDateTime) as rn
            	FROM mfb_data_stg sbm_pdf 
				      WHERE sbm_pdf.SMLModuleName='PDF Generator' 
				      AND sbm_pdf.BatchStatus=64 ) pdf ON (sb.BatchGUID=pdf.BatchGUID AND pdf.rn = 1)      
	LEFT JOIN (SELECT sbm_re.BatchGUID
                     ,sbm_re.BatchDescription
                     ,ROW_NUMBER() OVER(PARTITION BY sbm_re.BatchGUID ORDER BY sbm_re.StartDateTime) as rn
             FROM mfb_data_stg sbm_re 
             WHERE sbm_re.SMLModuleName='Scan'
             AND BatchStatus=64 ) re ON (sb.BatchGUID<>re.BatchGUID AND sb.BatchName=re.BatchDescription AND re.rn = 1)
  LEFT JOIN (SELECT sbm_ex.BatchGUID
                ,sbm_ex.StartDateTime
                ,sbm_ex.EndDateTime
                ,sbm_ex.Deleted
                ,ROW_NUMBER() OVER(PARTITION BY sbm_ex.BatchGUID ORDER BY sbm_ex.StartDateTime) as rn
             FROM mfb_data_stg sbm_ex 
				     WHERE sbm_ex.smlModuleName = 'Export') ex ON (sb.BatchGUID=ex.BatchGUID AND ex.rn = 1)     
             
	LEFT JOIN
			(
			SELECT TO_DATE(cdays.d_date,'mm/dd/yyyy') d_date,
				cdays.cd_num,
        cdays.bd_num
			FROM mfb_d_dates cdays
			) ard on (ard.d_date=TRUNC(COALESCE(blm.CancelDateTime,ex.StartDateTime,sysdate)))
      
	LEFT JOIN
			(
			SELECT TO_DATE(cdays.d_date,'mm/dd/yyyy') d_date,
				cdays.cd_num,
        cdays.bd_num,
        TO_DATE(cdays.jeopardy_dt,'mm/dd/yyyy') jeopardy_dt,
        TO_DATE(cdays.timeliness_dt,'mm/dd/yyyy') timeliness_dt
			FROM mfb_d_dates cdays
			) crd on (TRUNC(sb.startdatetime) = crd.d_date)     
WHERE sb.smlmodulename = 'Scan'
AND sb.batchstatus = 64;

ALTER TABLE d_mfb_current
ADD (batch_envelope_count NUMBER);

CREATE TABLE f_mfb_by_date
AS
SELECT * FROM
(SELECT mfb.FMFBBH_ID,
       ddates.D_DATE,
       mfb.BATCH_GUID BATCH_GUID,
      (CASE WHEN mfb.CREATE_DT = ddates.D_DATE THEN 1 ELSE 0 END) CREATION_COUNT,
      (CASE WHEN ddates.D_DATE >= mfb.CREATE_DT and ddates.D_DATE<coalesce(mfb.COMPLETE_DT,TO_DATE('12/25/2199','mm/dd/yyyy')) THEN 1 ELSE 0 END) INVENTORY_COUNT,
      (CASE WHEN mfb.COMPLETE_DT=ddates.D_DATE THEN 1 ELSE 0 END) COMPLETION_COUNT
  FROM( --mfb
	SELECT *
	FROM(SELECT ROW_NUMBER() OVER(ORDER BY bfs.BatchGUID) AS FMFBBH_ID,bfs.BatchGUID BATCH_GUID,bfs.CREATE_DT,bfe.COMPLETE_DT
		FROM	(
				SELECT sb.BatchGUID,
				 MIN(TRUNC(sb.StartDateTime)) create_dt
				 FROM mfb_data_stg sb
				 WHERE sb.SMLModuleName = 'Scan'				 
				 GROUP BY sb.BatchGUID) bfs 
    LEFT OUTER JOIN
       (SELECT sb.BatchGUID,
				 MIN(TRUNC(sb.EndDateTime)) complete_dt
				 FROM mfb_data_stg sb 
         WHERE ((sb.SMLModuleName ='Export') OR (sb.SMLModuleName <>'Export' and sb.Deleted=1))				 
				 GROUP BY sb.BatchGUID
		) bfe ON bfs.BatchGUID=bfe.BatchGUID --order by bfs."BatchGUID"
		)a	)mfb,
  (SELECT d_date from bpm_d_dates) ddates
	) fv 
  WHERE (creation_count>0 OR inventory_count>0 OR completion_count>0);
