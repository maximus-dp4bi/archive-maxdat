DELETE
FROM bpm_update_event_queue
WHERE identifier IN ( '10014107', '10026670', '10039147', '10055798', '10010893', '10029974', '10038616', '10055801', '10007330', '10007331', '10007815', '10033917', '10055796', '10055803', '10014094', '10029976', '10007314', '10014108', '10029975', '10037960', '10055795', '10055799', '10055802', '10014109', '10055800', '10055797', '10009650', '10014106', '10016948', '10033916', '10037918', '10039146', '10055804');
COMMIT;

UPDATE NYHIX_ETL_MAIL_FAX_DOC
SET COMPLETE_DT      = sysdate,
  CANCEL_DT          = sysdate,
  CANCEL_BY          = NULL,
  CANCEL_REASON      = 'SYSTEMS - INACTIVATED',
  CANCEL_METHOD      = 'EXCEPTION',
  INSTANCE_STATUS    = 'Complete',
  DOC_STATUS_CD      = 'TRASH',
  DOC_STATUS_DT      = sysdate,
  INSTANCE_STATUS_DT = sysdate,
  STAGE_DONE_DT      = sysdate ,
  CURRENT_STEP       = 'End - Document Processed'
WHERE DCN            = '10007314';
UPDATE NYHIX_ETL_MAIL_FAX_DOC
SET COMPLETE_DT      = sysdate,
  CANCEL_DT          = sysdate,
  CANCEL_BY          = NULL,
  CANCEL_REASON      = 'SYSTEMS - INACTIVATED',
  CANCEL_METHOD      = 'EXCEPTION',
  INSTANCE_STATUS    = 'Complete',
  DOC_STATUS_CD      = 'TRASH',
  DOC_STATUS_DT      = sysdate,
  INSTANCE_STATUS_DT = sysdate,
  STAGE_DONE_DT      = sysdate ,
  CURRENT_STEP       = 'End - Document Processed'
WHERE DCN            = '10007330';
UPDATE NYHIX_ETL_MAIL_FAX_DOC
SET COMPLETE_DT      = sysdate,
  CANCEL_DT          = sysdate,
  CANCEL_BY          = NULL,
  CANCEL_REASON      = 'SYSTEMS - INACTIVATED',
  CANCEL_METHOD      = 'EXCEPTION',
  INSTANCE_STATUS    = 'Complete',
  DOC_STATUS_CD      = 'TRASH',
  DOC_STATUS_DT      = sysdate,
  INSTANCE_STATUS_DT = sysdate,
  STAGE_DONE_DT      = sysdate ,
  CURRENT_STEP       = 'End - Document Processed'
WHERE DCN            = '10007331';
UPDATE NYHIX_ETL_MAIL_FAX_DOC
SET COMPLETE_DT      = sysdate,
  CANCEL_DT          = sysdate,
  CANCEL_BY          = NULL,
  CANCEL_REASON      = 'SYSTEMS - INACTIVATED',
  CANCEL_METHOD      = 'EXCEPTION',
  INSTANCE_STATUS    = 'Complete',
  DOC_STATUS_CD      = 'TRASH',
  DOC_STATUS_DT      = sysdate,
  INSTANCE_STATUS_DT = sysdate,
  STAGE_DONE_DT      = sysdate ,
  CURRENT_STEP       = 'End - Document Processed'
WHERE DCN            = '10007815';
UPDATE NYHIX_ETL_MAIL_FAX_DOC
SET COMPLETE_DT      = sysdate,
  CANCEL_DT          = sysdate,
  CANCEL_BY          = NULL,
  CANCEL_REASON      = 'SYSTEMS - INACTIVATED',
  CANCEL_METHOD      = 'EXCEPTION',
  INSTANCE_STATUS    = 'Complete',
  DOC_STATUS_CD      = 'TRASH',
  DOC_STATUS_DT      = sysdate,
  INSTANCE_STATUS_DT = sysdate,
  STAGE_DONE_DT      = sysdate ,
  CURRENT_STEP       = 'End - Document Processed'
WHERE DCN            = '10009650';
UPDATE NYHIX_ETL_MAIL_FAX_DOC
SET COMPLETE_DT      = sysdate,
  CANCEL_DT          = sysdate,
  CANCEL_BY          = NULL,
  CANCEL_REASON      = 'SYSTEMS - INACTIVATED',
  CANCEL_METHOD      = 'EXCEPTION',
  INSTANCE_STATUS    = 'Complete',
  DOC_STATUS_CD      = 'TRASH',
  DOC_STATUS_DT      = sysdate,
  INSTANCE_STATUS_DT = sysdate,
  STAGE_DONE_DT      = sysdate ,
  CURRENT_STEP       = 'End - Document Processed'
WHERE DCN            = '10010893';
UPDATE NYHIX_ETL_MAIL_FAX_DOC
SET COMPLETE_DT      = sysdate,
  CANCEL_DT          = sysdate,
  CANCEL_BY          = NULL,
  CANCEL_REASON      = 'SYSTEMS - INACTIVATED',
  CANCEL_METHOD      = 'EXCEPTION',
  INSTANCE_STATUS    = 'Complete',
  DOC_STATUS_CD      = 'TRASH',
  DOC_STATUS_DT      = sysdate,
  INSTANCE_STATUS_DT = sysdate,
  STAGE_DONE_DT      = sysdate ,
  CURRENT_STEP       = 'End - Document Processed'
WHERE DCN            = '10014094';
UPDATE NYHIX_ETL_MAIL_FAX_DOC
SET COMPLETE_DT      = sysdate,
  CANCEL_DT          = sysdate,
  CANCEL_BY          = NULL,
  CANCEL_REASON      = 'SYSTEMS - INACTIVATED',
  CANCEL_METHOD      = 'EXCEPTION',
  INSTANCE_STATUS    = 'Complete',
  DOC_STATUS_CD      = 'TRASH',
  DOC_STATUS_DT      = sysdate,
  INSTANCE_STATUS_DT = sysdate,
  STAGE_DONE_DT      = sysdate ,
  CURRENT_STEP       = 'End - Document Processed'
WHERE DCN            = '10014106';
UPDATE NYHIX_ETL_MAIL_FAX_DOC
SET COMPLETE_DT      = sysdate,
  CANCEL_DT          = sysdate,
  CANCEL_BY          = NULL,
  CANCEL_REASON      = 'SYSTEMS - INACTIVATED',
  CANCEL_METHOD      = 'EXCEPTION',
  INSTANCE_STATUS    = 'Complete',
  DOC_STATUS_CD      = 'TRASH',
  DOC_STATUS_DT      = sysdate,
  INSTANCE_STATUS_DT = sysdate,
  STAGE_DONE_DT      = sysdate ,
  CURRENT_STEP       = 'End - Document Processed'
WHERE DCN            = '10014107';
UPDATE NYHIX_ETL_MAIL_FAX_DOC
SET COMPLETE_DT      = sysdate,
  CANCEL_DT          = sysdate,
  CANCEL_BY          = NULL,
  CANCEL_REASON      = 'SYSTEMS - INACTIVATED',
  CANCEL_METHOD      = 'EXCEPTION',
  INSTANCE_STATUS    = 'Complete',
  DOC_STATUS_CD      = 'TRASH',
  DOC_STATUS_DT      = sysdate,
  INSTANCE_STATUS_DT = sysdate,
  STAGE_DONE_DT      = sysdate ,
  CURRENT_STEP       = 'End - Document Processed'
WHERE DCN            = '10014108';
UPDATE NYHIX_ETL_MAIL_FAX_DOC
SET COMPLETE_DT      = sysdate,
  CANCEL_DT          = sysdate,
  CANCEL_BY          = NULL,
  CANCEL_REASON      = 'SYSTEMS - INACTIVATED',
  CANCEL_METHOD      = 'EXCEPTION',
  INSTANCE_STATUS    = 'Complete',
  DOC_STATUS_CD      = 'TRASH',
  DOC_STATUS_DT      = sysdate,
  INSTANCE_STATUS_DT = sysdate,
  STAGE_DONE_DT      = sysdate ,
  CURRENT_STEP       = 'End - Document Processed'
WHERE DCN            = '10014109';
UPDATE NYHIX_ETL_MAIL_FAX_DOC
SET COMPLETE_DT      = sysdate,
  CANCEL_DT          = sysdate,
  CANCEL_BY          = NULL,
  CANCEL_REASON      = 'SYSTEMS - INACTIVATED',
  CANCEL_METHOD      = 'EXCEPTION',
  INSTANCE_STATUS    = 'Complete',
  DOC_STATUS_CD      = 'TRASH',
  DOC_STATUS_DT      = sysdate,
  INSTANCE_STATUS_DT = sysdate,
  STAGE_DONE_DT      = sysdate ,
  CURRENT_STEP       = 'End - Document Processed'
WHERE DCN            = '10016948';
UPDATE NYHIX_ETL_MAIL_FAX_DOC
SET COMPLETE_DT      = sysdate,
  CANCEL_DT          = sysdate,
  CANCEL_BY          = NULL,
  CANCEL_REASON      = 'SYSTEMS - INACTIVATED',
  CANCEL_METHOD      = 'EXCEPTION',
  INSTANCE_STATUS    = 'Complete',
  DOC_STATUS_CD      = 'TRASH',
  DOC_STATUS_DT      = sysdate,
  INSTANCE_STATUS_DT = sysdate,
  STAGE_DONE_DT      = sysdate ,
  CURRENT_STEP       = 'End - Document Processed'
WHERE DCN            = '10026670';
UPDATE NYHIX_ETL_MAIL_FAX_DOC
SET COMPLETE_DT      = sysdate,
  CANCEL_DT          = sysdate,
  CANCEL_BY          = NULL,
  CANCEL_REASON      = 'SYSTEMS - INACTIVATED',
  CANCEL_METHOD      = 'EXCEPTION',
  INSTANCE_STATUS    = 'Complete',
  DOC_STATUS_CD      = 'TRASH',
  DOC_STATUS_DT      = sysdate,
  INSTANCE_STATUS_DT = sysdate,
  STAGE_DONE_DT      = sysdate ,
  CURRENT_STEP       = 'End - Document Processed'
WHERE DCN            = '10029974';
UPDATE NYHIX_ETL_MAIL_FAX_DOC
SET COMPLETE_DT      = sysdate,
  CANCEL_DT          = sysdate,
  CANCEL_BY          = NULL,
  CANCEL_REASON      = 'SYSTEMS - INACTIVATED',
  CANCEL_METHOD      = 'EXCEPTION',
  INSTANCE_STATUS    = 'Complete',
  DOC_STATUS_CD      = 'TRASH',
  DOC_STATUS_DT      = sysdate,
  INSTANCE_STATUS_DT = sysdate,
  STAGE_DONE_DT      = sysdate ,
  CURRENT_STEP       = 'End - Document Processed'
WHERE DCN            = '10029975';
UPDATE NYHIX_ETL_MAIL_FAX_DOC
SET COMPLETE_DT      = sysdate,
  CANCEL_DT          = sysdate,
  CANCEL_BY          = NULL,
  CANCEL_REASON      = 'SYSTEMS - INACTIVATED',
  CANCEL_METHOD      = 'EXCEPTION',
  INSTANCE_STATUS    = 'Complete',
  DOC_STATUS_CD      = 'TRASH',
  DOC_STATUS_DT      = sysdate,
  INSTANCE_STATUS_DT = sysdate,
  STAGE_DONE_DT      = sysdate ,
  CURRENT_STEP       = 'End - Document Processed'
WHERE DCN            = '10029976';
UPDATE NYHIX_ETL_MAIL_FAX_DOC
SET COMPLETE_DT      = sysdate,
  CANCEL_DT          = sysdate,
  CANCEL_BY          = NULL,
  CANCEL_REASON      = 'SYSTEMS - INACTIVATED',
  CANCEL_METHOD      = 'EXCEPTION',
  INSTANCE_STATUS    = 'Complete',
  DOC_STATUS_CD      = 'TRASH',
  DOC_STATUS_DT      = sysdate,
  INSTANCE_STATUS_DT = sysdate,
  STAGE_DONE_DT      = sysdate ,
  CURRENT_STEP       = 'End - Document Processed'
WHERE DCN            = '10033916';
UPDATE NYHIX_ETL_MAIL_FAX_DOC
SET COMPLETE_DT      = sysdate,
  CANCEL_DT          = sysdate,
  CANCEL_BY          = NULL,
  CANCEL_REASON      = 'SYSTEMS - INACTIVATED',
  CANCEL_METHOD      = 'EXCEPTION',
  INSTANCE_STATUS    = 'Complete',
  DOC_STATUS_CD      = 'TRASH',
  DOC_STATUS_DT      = sysdate,
  INSTANCE_STATUS_DT = sysdate,
  STAGE_DONE_DT      = sysdate ,
  CURRENT_STEP       = 'End - Document Processed'
WHERE DCN            = '10033917';
UPDATE NYHIX_ETL_MAIL_FAX_DOC
SET COMPLETE_DT      = sysdate,
  CANCEL_DT          = sysdate,
  CANCEL_BY          = NULL,
  CANCEL_REASON      = 'SYSTEMS - INACTIVATED',
  CANCEL_METHOD      = 'EXCEPTION',
  INSTANCE_STATUS    = 'Complete',
  DOC_STATUS_CD      = 'TRASH',
  DOC_STATUS_DT      = sysdate,
  INSTANCE_STATUS_DT = sysdate,
  STAGE_DONE_DT      = sysdate ,
  CURRENT_STEP       = 'End - Document Processed'
WHERE DCN            = '10037918';
UPDATE NYHIX_ETL_MAIL_FAX_DOC
SET COMPLETE_DT      = sysdate,
  CANCEL_DT          = sysdate,
  CANCEL_BY          = NULL,
  CANCEL_REASON      = 'SYSTEMS - INACTIVATED',
  CANCEL_METHOD      = 'EXCEPTION',
  INSTANCE_STATUS    = 'Complete',
  DOC_STATUS_CD      = 'TRASH',
  DOC_STATUS_DT      = sysdate,
  INSTANCE_STATUS_DT = sysdate,
  STAGE_DONE_DT      = sysdate ,
  CURRENT_STEP       = 'End - Document Processed'
WHERE DCN            = '10037960';
UPDATE NYHIX_ETL_MAIL_FAX_DOC
SET COMPLETE_DT      = sysdate,
  CANCEL_DT          = sysdate,
  CANCEL_BY          = NULL,
  CANCEL_REASON      = 'SYSTEMS - INACTIVATED',
  CANCEL_METHOD      = 'EXCEPTION',
  INSTANCE_STATUS    = 'Complete',
  DOC_STATUS_CD      = 'TRASH',
  DOC_STATUS_DT      = sysdate,
  INSTANCE_STATUS_DT = sysdate,
  STAGE_DONE_DT      = sysdate ,
  CURRENT_STEP       = 'End - Document Processed'
WHERE DCN            = '10038616';
UPDATE NYHIX_ETL_MAIL_FAX_DOC
SET COMPLETE_DT      = sysdate,
  CANCEL_DT          = sysdate,
  CANCEL_BY          = NULL,
  CANCEL_REASON      = 'SYSTEMS - INACTIVATED',
  CANCEL_METHOD      = 'EXCEPTION',
  INSTANCE_STATUS    = 'Complete',
  DOC_STATUS_CD      = 'TRASH',
  DOC_STATUS_DT      = sysdate,
  INSTANCE_STATUS_DT = sysdate,
  STAGE_DONE_DT      = sysdate ,
  CURRENT_STEP       = 'End - Document Processed'
WHERE DCN            = '10039146';
UPDATE NYHIX_ETL_MAIL_FAX_DOC
SET COMPLETE_DT      = sysdate,
  CANCEL_DT          = sysdate,
  CANCEL_BY          = NULL,
  CANCEL_REASON      = 'SYSTEMS - INACTIVATED',
  CANCEL_METHOD      = 'EXCEPTION',
  INSTANCE_STATUS    = 'Complete',
  DOC_STATUS_CD      = 'TRASH',
  DOC_STATUS_DT      = sysdate,
  INSTANCE_STATUS_DT = sysdate,
  STAGE_DONE_DT      = sysdate ,
  CURRENT_STEP       = 'End - Document Processed'
WHERE DCN            = '10039147';
UPDATE NYHIX_ETL_MAIL_FAX_DOC
SET COMPLETE_DT      = sysdate,
  CANCEL_DT          = sysdate,
  CANCEL_BY          = NULL,
  CANCEL_REASON      = 'SYSTEMS - INACTIVATED',
  CANCEL_METHOD      = 'EXCEPTION',
  INSTANCE_STATUS    = 'Complete',
  DOC_STATUS_CD      = 'TRASH',
  DOC_STATUS_DT      = sysdate,
  INSTANCE_STATUS_DT = sysdate,
  STAGE_DONE_DT      = sysdate ,
  CURRENT_STEP       = 'End - Document Processed'
WHERE DCN            = '10055795';
UPDATE NYHIX_ETL_MAIL_FAX_DOC
SET COMPLETE_DT      = sysdate,
  CANCEL_DT          = sysdate,
  CANCEL_BY          = NULL,
  CANCEL_REASON      = 'SYSTEMS - INACTIVATED',
  CANCEL_METHOD      = 'EXCEPTION',
  INSTANCE_STATUS    = 'Complete',
  DOC_STATUS_CD      = 'TRASH',
  DOC_STATUS_DT      = sysdate,
  INSTANCE_STATUS_DT = sysdate,
  STAGE_DONE_DT      = sysdate ,
  CURRENT_STEP       = 'End - Document Processed'
WHERE DCN            = '10055796';
UPDATE NYHIX_ETL_MAIL_FAX_DOC
SET COMPLETE_DT      = sysdate,
  CANCEL_DT          = sysdate,
  CANCEL_BY          = NULL,
  CANCEL_REASON      = 'SYSTEMS - INACTIVATED',
  CANCEL_METHOD      = 'EXCEPTION',
  INSTANCE_STATUS    = 'Complete',
  DOC_STATUS_CD      = 'TRASH',
  DOC_STATUS_DT      = sysdate,
  INSTANCE_STATUS_DT = sysdate,
  STAGE_DONE_DT      = sysdate ,
  CURRENT_STEP       = 'End - Document Processed'
WHERE DCN            = '10055797';
UPDATE NYHIX_ETL_MAIL_FAX_DOC
SET COMPLETE_DT      = sysdate,
  CANCEL_DT          = sysdate,
  CANCEL_BY          = NULL,
  CANCEL_REASON      = 'SYSTEMS - INACTIVATED',
  CANCEL_METHOD      = 'EXCEPTION',
  INSTANCE_STATUS    = 'Complete',
  DOC_STATUS_CD      = 'TRASH',
  DOC_STATUS_DT      = sysdate,
  INSTANCE_STATUS_DT = sysdate,
  STAGE_DONE_DT      = sysdate ,
  CURRENT_STEP       = 'End - Document Processed'
WHERE DCN            = '10055798';
UPDATE NYHIX_ETL_MAIL_FAX_DOC
SET COMPLETE_DT      = sysdate,
  CANCEL_DT          = sysdate,
  CANCEL_BY          = NULL,
  CANCEL_REASON      = 'SYSTEMS - INACTIVATED',
  CANCEL_METHOD      = 'EXCEPTION',
  INSTANCE_STATUS    = 'Complete',
  DOC_STATUS_CD      = 'TRASH',
  DOC_STATUS_DT      = sysdate,
  INSTANCE_STATUS_DT = sysdate,
  STAGE_DONE_DT      = sysdate ,
  CURRENT_STEP       = 'End - Document Processed'
WHERE DCN            = '10055799';
UPDATE NYHIX_ETL_MAIL_FAX_DOC
SET COMPLETE_DT      = sysdate,
  CANCEL_DT          = sysdate,
  CANCEL_BY          = NULL,
  CANCEL_REASON      = 'SYSTEMS - INACTIVATED',
  CANCEL_METHOD      = 'EXCEPTION',
  INSTANCE_STATUS    = 'Complete',
  DOC_STATUS_CD      = 'TRASH',
  DOC_STATUS_DT      = sysdate,
  INSTANCE_STATUS_DT = sysdate,
  STAGE_DONE_DT      = sysdate ,
  CURRENT_STEP       = 'End - Document Processed'
WHERE DCN            = '10055800';
UPDATE NYHIX_ETL_MAIL_FAX_DOC
SET COMPLETE_DT      = sysdate,
  CANCEL_DT          = sysdate,
  CANCEL_BY          = NULL,
  CANCEL_REASON      = 'SYSTEMS - INACTIVATED',
  CANCEL_METHOD      = 'EXCEPTION',
  INSTANCE_STATUS    = 'Complete',
  DOC_STATUS_CD      = 'TRASH',
  DOC_STATUS_DT      = sysdate,
  INSTANCE_STATUS_DT = sysdate,
  STAGE_DONE_DT      = sysdate ,
  CURRENT_STEP       = 'End - Document Processed'
WHERE DCN            = '10055801';
UPDATE NYHIX_ETL_MAIL_FAX_DOC
SET COMPLETE_DT      = sysdate,
  CANCEL_DT          = sysdate,
  CANCEL_BY          = NULL,
  CANCEL_REASON      = 'SYSTEMS - INACTIVATED',
  CANCEL_METHOD      = 'EXCEPTION',
  INSTANCE_STATUS    = 'Complete',
  DOC_STATUS_CD      = 'TRASH',
  DOC_STATUS_DT      = sysdate,
  INSTANCE_STATUS_DT = sysdate,
  STAGE_DONE_DT      = sysdate ,
  CURRENT_STEP       = 'End - Document Processed'
WHERE DCN            = '10055802';
UPDATE NYHIX_ETL_MAIL_FAX_DOC
SET COMPLETE_DT      = sysdate,
  CANCEL_DT          = sysdate,
  CANCEL_BY          = NULL,
  CANCEL_REASON      = 'SYSTEMS - INACTIVATED',
  CANCEL_METHOD      = 'EXCEPTION',
  INSTANCE_STATUS    = 'Complete',
  DOC_STATUS_CD      = 'TRASH',
  DOC_STATUS_DT      = sysdate,
  INSTANCE_STATUS_DT = sysdate,
  STAGE_DONE_DT      = sysdate ,
  CURRENT_STEP       = 'End - Document Processed'
WHERE DCN            = '10055803';
UPDATE NYHIX_ETL_MAIL_FAX_DOC
SET COMPLETE_DT      = sysdate,
  CANCEL_DT          = sysdate,
  CANCEL_BY          = NULL,
  CANCEL_REASON      = 'SYSTEMS - INACTIVATED',
  CANCEL_METHOD      = 'EXCEPTION',
  INSTANCE_STATUS    = 'Complete',
  DOC_STATUS_CD      = 'TRASH',
  DOC_STATUS_DT      = sysdate,
  INSTANCE_STATUS_DT = sysdate,
  STAGE_DONE_DT      = sysdate ,
  CURRENT_STEP       = 'End - Document Processed'
WHERE DCN            = '10055804';

commit;