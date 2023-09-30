USE DATABASE PUREINSIGHTS_DEV;
USE SCHEMA RAW;

ALTER TABLE C_SOURCE_ERROR_CODES ADD
(
    MMS_ERROR_TYPE              VARCHAR(2000)
);


UPDATE
    C_SOURCE_ERROR_CODES
SET
    mms_error_type  =   'Call Failure'
WHERE
    errorcode IN 
    (
        'error.ininedgecontrol.callflow',
        'error.ininedgecontrol.callflow.document.connect',
        'error.ininedgecontrol.callflow.document.dialogprepare',
        'error.ininedgecontrol.callflow.document.dialogprepare.media',
        'error.ininedgecontrol.callflow.document.dialogstart',
        'error.ininedgecontrol.callflow.document.join',
        'error.ininedgecontrol.callflow.document.join.media',
        'error.ininedgecontrol.callflow.document.pickup',
        'error.ininedgecontrol.callflow.document.pickup.media',
        'error.ininedgecontrol.callflow.document.progressing',
        'error.ininedgecontrol.callflow.document.progressing.media',
        'error.ininedgecontrol.callflow.document.redirect',
        'error.ininedgecontrol.callflow.document.redirect.media',
        'error.ininedgecontrol.callflow.document.rejoin',
        'error.ininedgecontrol.callflow.document.rejoin.media',
        'error.ininedgecontrol.connection.timeout',
        'error.ininedgecontrol.dialog.noConnected',
        'error.ininedgecontrol.dialog.noRemoteTone'      
    );