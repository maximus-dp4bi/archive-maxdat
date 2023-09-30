drop view WR_OB_DIALER_SV;
CREATE OR REPLACE VIEW WR_OB_DIALER_SV
AS
SELECT call_start
,call_end
,COALESCE(result,'UNDEFINED') as disposition_code
,CASE WHEN result = 'NOANS' THEN 'Ring no answer'
      WHEN result = 'ANSMACH' THEN 'Answering machine or voicemail answered'
      WHEN result = 'INVLDNUM' THEN 'Invalid phone number'
      WHEN result = 'BUSY' THEN 'Busy signal'
      WHEN result = 'FAX' THEN 'Fax or modem line was encountered'
      WHEN result = 'ERROR NO XFER NUM' THEN 'No transfer number was found'
      WHEN result = 'LIVE' THEN 'Live caller was reached'
      WHEN result = 'HANGUP' THEN 'Caller hung up'
      WHEN result = 'TRANSFER' THEN 'Caller was transferred'
      WHEN result = 'ERROR' THEN 'Unknown error encountered calling phone number'
      WHEN result = 'NOTCALLED' THEN 'Call was not placed due to lack of data in the dial file or an invalid phone number.'
      WHEN result = 'IVR' THEN 'Caller was transferred to IVR'
      WHEN result IS NOT NULL THEN INITCAP(result)
      ELSE 'Undefined' END disposition_description      
,recipient_id
,matched_client_id
,job_id
,row_num
,TO_DATE(substr(ivr.call_start,1,10),'yyyy/mm/dd') as report_date
,CASE WHEN TO_DATE(substr(ivr.call_start,1,19),'yyyy/mm/dd hh24:mi:ss') 
    BETWEEN TO_DATE(substr(ivr.call_start,1,10)||' 06:00:00','yyyy/mm/dd hh24:mi:ss') AND TO_DATE(substr(ivr.call_start,1,10)||' 06:29:59','yyyy/mm/dd hh24:mi:ss') THEN '6:00AM-6:29AM'
   WHEN TO_DATE(substr(ivr.call_start,1,19),'yyyy/mm/dd hh24:mi:ss') 
    BETWEEN TO_DATE(substr(ivr.call_start,1,10)||' 06:30:00','yyyy/mm/dd hh24:mi:ss') AND TO_DATE(substr(ivr.call_start,1,10)||' 06:59:59','yyyy/mm/dd hh24:mi:ss') THEN '6:30AM-6:59AM'
   WHEN TO_DATE(substr(ivr.call_start,1,19),'yyyy/mm/dd hh24:mi:ss') 
    BETWEEN TO_DATE(substr(ivr.call_start,1,10)||' 07:00:00','yyyy/mm/dd hh24:mi:ss') AND TO_DATE(substr(ivr.call_start,1,10)||' 07:29:59','yyyy/mm/dd hh24:mi:ss') THEN '7:00AM-7:29AM'
   WHEN TO_DATE(substr(ivr.call_start,1,19),'yyyy/mm/dd hh24:mi:ss') 
    BETWEEN TO_DATE(substr(ivr.call_start,1,10)||' 07:30:00','yyyy/mm/dd hh24:mi:ss') AND TO_DATE(substr(ivr.call_start,1,10)||' 07:59:59','yyyy/mm/dd hh24:mi:ss') THEN '7:30AM-7:59AM'
   WHEN TO_DATE(substr(ivr.call_start,1,19),'yyyy/mm/dd hh24:mi:ss') 
    BETWEEN TO_DATE(substr(ivr.call_start,1,10)||' 08:00:00','yyyy/mm/dd hh24:mi:ss') AND TO_DATE(substr(ivr.call_start,1,10)||' 08:29:59','yyyy/mm/dd hh24:mi:ss') THEN '8:00AM-8:29AM'
   WHEN TO_DATE(substr(ivr.call_start,1,19),'yyyy/mm/dd hh24:mi:ss') 
    BETWEEN TO_DATE(substr(ivr.call_start,1,10)||' 08:30:00','yyyy/mm/dd hh24:mi:ss') AND TO_DATE(substr(ivr.call_start,1,10)||' 08:59:59','yyyy/mm/dd hh24:mi:ss') THEN '8:30AM-8:59AM'
   WHEN TO_DATE(substr(ivr.call_start,1,19),'yyyy/mm/dd hh24:mi:ss') 
    BETWEEN TO_DATE(substr(ivr.call_start,1,10)||' 09:00:00','yyyy/mm/dd hh24:mi:ss') AND TO_DATE(substr(ivr.call_start,1,10)||' 09:29:59','yyyy/mm/dd hh24:mi:ss') THEN '9:00AM-9:29AM'
   WHEN TO_DATE(substr(ivr.call_start,1,19),'yyyy/mm/dd hh24:mi:ss') 
    BETWEEN TO_DATE(substr(ivr.call_start,1,10)||' 09:30:00','yyyy/mm/dd hh24:mi:ss') AND TO_DATE(substr(ivr.call_start,1,10)||' 09:59:59','yyyy/mm/dd hh24:mi:ss') THEN '9:30AM-9:59AM'
   WHEN TO_DATE(substr(ivr.call_start,1,19),'yyyy/mm/dd hh24:mi:ss') 
    BETWEEN TO_DATE(substr(ivr.call_start,1,10)||' 10:00:00','yyyy/mm/dd hh24:mi:ss') AND TO_DATE(substr(ivr.call_start,1,10)||' 10:29:59','yyyy/mm/dd hh24:mi:ss') THEN '10:00AM-10:29AM'   
   WHEN TO_DATE(substr(ivr.call_start,1,19),'yyyy/mm/dd hh24:mi:ss') 
    BETWEEN TO_DATE(substr(ivr.call_start,1,10)||' 10:30:00','yyyy/mm/dd hh24:mi:ss') AND TO_DATE(substr(ivr.call_start,1,10)||' 10:59:59','yyyy/mm/dd hh24:mi:ss') THEN '10:30AM-10:59AM' 
   WHEN TO_DATE(substr(ivr.call_start,1,19),'yyyy/mm/dd hh24:mi:ss') 
    BETWEEN TO_DATE(substr(ivr.call_start,1,10)||' 11:00:00','yyyy/mm/dd hh24:mi:ss') AND TO_DATE(substr(ivr.call_start,1,10)||' 11:29:59','yyyy/mm/dd hh24:mi:ss') THEN '11:00AM-11:29AM' 
   WHEN TO_DATE(substr(ivr.call_start,1,19),'yyyy/mm/dd hh24:mi:ss') 
    BETWEEN TO_DATE(substr(ivr.call_start,1,10)||' 11:30:00','yyyy/mm/dd hh24:mi:ss') AND TO_DATE(substr(ivr.call_start,1,10)||' 11:59:59','yyyy/mm/dd hh24:mi:ss') THEN '11:30AM-11:59AM' 
   WHEN TO_DATE(substr(ivr.call_start,1,19),'yyyy/mm/dd hh24:mi:ss') 
    BETWEEN TO_DATE(substr(ivr.call_start,1,10)||' 12:00:00','yyyy/mm/dd hh24:mi:ss') AND TO_DATE(substr(ivr.call_start,1,10)||' 12:29:59','yyyy/mm/dd hh24:mi:ss') THEN '12:00PM-12:29PM' 
   WHEN TO_DATE(substr(ivr.call_start,1,19),'yyyy/mm/dd hh24:mi:ss') 
    BETWEEN TO_DATE(substr(ivr.call_start,1,10)||' 12:30:00','yyyy/mm/dd hh24:mi:ss') AND TO_DATE(substr(ivr.call_start,1,10)||' 12:59:59','yyyy/mm/dd hh24:mi:ss') THEN '12:30PM-12:59PM'     
   WHEN TO_DATE(substr(ivr.call_start,1,19),'yyyy/mm/dd hh24:mi:ss') 
    BETWEEN TO_DATE(substr(ivr.call_start,1,10)||' 13:00:00','yyyy/mm/dd hh24:mi:ss') AND TO_DATE(substr(ivr.call_start,1,10)||' 13:29:59','yyyy/mm/dd hh24:mi:ss') THEN '1:00PM-1:29PM' 
   WHEN TO_DATE(substr(ivr.call_start,1,19),'yyyy/mm/dd hh24:mi:ss') 
    BETWEEN TO_DATE(substr(ivr.call_start,1,10)||' 13:30:00','yyyy/mm/dd hh24:mi:ss') AND TO_DATE(substr(ivr.call_start,1,10)||' 13:59:59','yyyy/mm/dd hh24:mi:ss') THEN '1:30PM-1:59PM'     
   WHEN TO_DATE(substr(ivr.call_start,1,19),'yyyy/mm/dd hh24:mi:ss') 
    BETWEEN TO_DATE(substr(ivr.call_start,1,10)||' 14:00:00','yyyy/mm/dd hh24:mi:ss') AND TO_DATE(substr(ivr.call_start,1,10)||' 14:29:59','yyyy/mm/dd hh24:mi:ss') THEN '2:00PM-2:29PM' 
   WHEN TO_DATE(substr(ivr.call_start,1,19),'yyyy/mm/dd hh24:mi:ss') 
    BETWEEN TO_DATE(substr(ivr.call_start,1,10)||' 14:30:00','yyyy/mm/dd hh24:mi:ss') AND TO_DATE(substr(ivr.call_start,1,10)||' 14:59:59','yyyy/mm/dd hh24:mi:ss') THEN '2:30PM-2:59PM'         
   WHEN TO_DATE(substr(ivr.call_start,1,19),'yyyy/mm/dd hh24:mi:ss') 
    BETWEEN TO_DATE(substr(ivr.call_start,1,10)||' 15:00:00','yyyy/mm/dd hh24:mi:ss') AND TO_DATE(substr(ivr.call_start,1,10)||' 15:29:59','yyyy/mm/dd hh24:mi:ss') THEN '3:00PM-3:29PM' 
   WHEN TO_DATE(substr(ivr.call_start,1,19),'yyyy/mm/dd hh24:mi:ss') 
    BETWEEN TO_DATE(substr(ivr.call_start,1,10)||' 15:30:00','yyyy/mm/dd hh24:mi:ss') AND TO_DATE(substr(ivr.call_start,1,10)||' 15:59:59','yyyy/mm/dd hh24:mi:ss') THEN '3:30PM-3:59PM'             
   WHEN TO_DATE(substr(ivr.call_start,1,19),'yyyy/mm/dd hh24:mi:ss') 
    BETWEEN TO_DATE(substr(ivr.call_start,1,10)||' 16:00:00','yyyy/mm/dd hh24:mi:ss') AND TO_DATE(substr(ivr.call_start,1,10)||' 16:29:59','yyyy/mm/dd hh24:mi:ss') THEN '4:00PM-4:29PM' 
   WHEN TO_DATE(substr(ivr.call_start,1,19),'yyyy/mm/dd hh24:mi:ss') 
    BETWEEN TO_DATE(substr(ivr.call_start,1,10)||' 16:30:00','yyyy/mm/dd hh24:mi:ss') AND TO_DATE(substr(ivr.call_start,1,10)||' 16:59:59','yyyy/mm/dd hh24:mi:ss') THEN '4:30PM-4:59PM'                 
   WHEN TO_DATE(substr(ivr.call_start,1,19),'yyyy/mm/dd hh24:mi:ss') 
    BETWEEN TO_DATE(substr(ivr.call_start,1,10)||' 17:00:00','yyyy/mm/dd hh24:mi:ss') AND TO_DATE(substr(ivr.call_start,1,10)||' 17:29:59','yyyy/mm/dd hh24:mi:ss') THEN '5:00PM-5:29PM' 
   WHEN TO_DATE(substr(ivr.call_start,1,19),'yyyy/mm/dd hh24:mi:ss') 
    BETWEEN TO_DATE(substr(ivr.call_start,1,10)||' 17:30:00','yyyy/mm/dd hh24:mi:ss') AND TO_DATE(substr(ivr.call_start,1,10)||' 17:59:59','yyyy/mm/dd hh24:mi:ss') THEN '5:30PM-5:59PM'                     
   WHEN TO_DATE(substr(ivr.call_start,1,19),'yyyy/mm/dd hh24:mi:ss') 
    BETWEEN TO_DATE(substr(ivr.call_start,1,10)||' 18:00:00','yyyy/mm/dd hh24:mi:ss') AND TO_DATE(substr(ivr.call_start,1,10)||' 18:29:59','yyyy/mm/dd hh24:mi:ss') THEN '6:00PM-6:29PM' 
   WHEN TO_DATE(substr(ivr.call_start,1,19),'yyyy/mm/dd hh24:mi:ss') 
    BETWEEN TO_DATE(substr(ivr.call_start,1,10)||' 18:30:00','yyyy/mm/dd hh24:mi:ss') AND TO_DATE(substr(ivr.call_start,1,10)||' 18:59:59','yyyy/mm/dd hh24:mi:ss') THEN '6:30PM-6:59PM'                         
   WHEN TO_DATE(substr(ivr.call_start,1,19),'yyyy/mm/dd hh24:mi:ss') 
    BETWEEN TO_DATE(substr(ivr.call_start,1,10)||' 19:00:00','yyyy/mm/dd hh24:mi:ss') AND TO_DATE(substr(ivr.call_start,1,10)||' 19:29:59','yyyy/mm/dd hh24:mi:ss') THEN '7:00PM-7:29PM' 
   WHEN TO_DATE(substr(ivr.call_start,1,19),'yyyy/mm/dd hh24:mi:ss') 
    BETWEEN TO_DATE(substr(ivr.call_start,1,10)||' 19:30:00','yyyy/mm/dd hh24:mi:ss') AND TO_DATE(substr(ivr.call_start,1,10)||' 19:59:59','yyyy/mm/dd hh24:mi:ss') THEN '7:30PM-7:59PM'                           
   WHEN TO_DATE(substr(ivr.call_start,1,19),'yyyy/mm/dd hh24:mi:ss') 
    BETWEEN TO_DATE(substr(ivr.call_start,1,10)||' 20:00:00','yyyy/mm/dd hh24:mi:ss') AND TO_DATE(substr(ivr.call_start,1,10)||' 20:29:59','yyyy/mm/dd hh24:mi:ss') THEN '8:00PM-8:29PM' 
   WHEN TO_DATE(substr(ivr.call_start,1,19),'yyyy/mm/dd hh24:mi:ss') 
    BETWEEN TO_DATE(substr(ivr.call_start,1,10)||' 20:30:00','yyyy/mm/dd hh24:mi:ss') AND TO_DATE(substr(ivr.call_start,1,10)||' 20:59:59','yyyy/mm/dd hh24:mi:ss') THEN '8:30PM-8:59PM'                                   
   ELSE '-' END time_period
,1 call_attempt
,CASE WHEN result IN('ANSMACH','LIVE','TRANSFER','IVR') THEN 'Successful' 
      WHEN result IN('NOANS','INVLDNUM','BUSY','FAX','ERROR NO XFER NUM','HANGUP','ERROR','NOTCALLED') THEN 'Unsuccessful' 
   ELSE 'Other' END disposition_group
, ivr.campaign_name
, ivr.process_ts
, ivr.error_count
FROM eb.etl_init_obd_ivr ivr;

GRANT SELECT ON MAXDAT_SUPPORT.WR_OB_DIALER_SV TO MAXDAT_REPORTS;
GRANT SELECT ON MAXDAT_SUPPORT.WR_OB_DIALER_SV TO MAXDAT_SUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.WR_OB_DIALER_SV TO MAXDATSUPPORT_READ_ONLY;
