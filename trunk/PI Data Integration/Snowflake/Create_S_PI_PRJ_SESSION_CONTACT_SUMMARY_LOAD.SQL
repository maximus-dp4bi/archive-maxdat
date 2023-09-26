CREATE or replace PROCEDURE S_PI_PRJ_SESSION_CONTACT_SUMMARY_LOAD(projectid VARCHAR)
  RETURNS VARCHAR
  LANGUAGE javascript
  EXECUTE AS CALLER
  AS
  $$
  
    //set logging on
     var sqlCommand = "set do_log = true;";
     snowflake.execute ({sqlText: sqlCommand});
     sqlCommand = "set log_table = 'RAW.INGEST_PI_DATA_DET_LOG';";
     snowflake.execute ({sqlText: sqlCommand});
     
function log(projectid, object_category, object_name, status_string, msg){
    snowflake.createStatement( { sqlText: `call do_log_det(:1, :2, :3, :4, :5)`, binds:[projectid, object_category, object_name, status_string, msg] } ).execute();
}

   //truncate table
   //log("truncating table");
    sqlCommand = "delete from STAGE.S_PI_SESSION_CONTACT_SUMMARY where projectid = '" + PROJECTID + "';";
    //log(sqlCommand);
    try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
        log(PROJECTID, "SP", "S_PI_PRJ_SESSION_CONTACT_SUMMARY_LOAD", "FAILED", "Failed to truncate table STAGE.S_PI_SESSION_CONTACT_SUMMARY for projectid " + PROJECTID + ": "+ err); 
        return "1";
        }
     

    //ingest data from parquet file    
    var sqlCommand = "INSERT INTO STAGE.S_PI_SESSION_CONTACT_SUMMARY (CONVERSATIONID, SESSIONID, PROJECTID, FIRST_ENDPOINT, CONTRACTUAL_FIRSTQUEUE, FIRSTQUEUE, CONTACTTYPE, SESSIONTYPE) WITH a11(prior_mediatype, prior_transferred, prior_transfertopurpose, prior_username, next_username, conversationid, sessionid, projectid, purpose, sessionindex, sessioncount, originatingdirection, direction, abandoned, transferred, monitoringduration, flowout, agentanswered, mediatype, userhandled, disconnecttype, transfertopurpose, username) AS ( SELECT lag(mediatype) OVER (PARTITION BY conversationid ORDER BY sessionindex) AS prior_mediatype, lag(transferred) OVER (PARTITION BY conversationid ORDER BY sessionindex) AS prior_transferred, lag(transfertopurpose) OVER (PARTITION BY conversationid ORDER BY sessionindex) AS prior_transfertopurpose, lag(username) OVER (PARTITION BY conversationid ORDER BY sessionindex) AS prior_username, lead(username, 1) OVER (PARTITION BY conversationid ORDER BY sessionindex) AS next_username, conversationid, sessionid, projectid, purpose, sessionindex, sessioncount, originatingdirection, direction, abandoned, transferred, monitoringduration, flowout, agentanswered, mediatype, userhandled, disconnecttype, transfertopurpose, username FROM PUBLIC.F_PI_SESSION_SUMMARY_VW WHERE PROJECTID='" + PROJECTID + "') , a12(conversationid, first_endpoint, contractual_firstqueue) AS ( SELECT c11.conversationid, c11.first_endpoint, c12.queuename FROM ( SELECT conversationId, min(sessionIndex) AS first_endpoint FROM ( SELECT lead(username) OVER (PARTITION BY conversationid ORDER BY sessionindex) AS next_username, conversationid, sessionindex, userhandled, mediatype, direction, originatingdirection, username, totalagenttalkduration, sessioncount FROM PUBLIC.F_PI_SESSION_SUMMARY_VW WHERE PROJECTID='" + PROJECTID + "' ) WHERE (userhandled = 1 AND mediatype = 'voice' AND direction = 'outbound' AND originatingdirection = 'inbound' AND nvl(next_username, '') != username) AND totalagenttalkduration > 0 OR originatingdirection = 'outbound' AND direction = 'outbound' OR direction = 'inbound' AND userhandled = 1 OR sessionindex = sessioncount GROUP BY 1) c11 INNER JOIN ( SELECT conversationid, queuename, sessionindex FROM PUBLIC.F_PI_SESSION_SUMMARY_VW WHERE PROJECTID='" + PROJECTID + "' ) c12 ON c11.conversationid = c12.conversationid AND c11.first_endpoint = c12.sessionindex) , a13(conversationid, first_queue_index, firstqueue) AS ( SELECT f11.conversationid, f11.first_queue_index, f12.queuename FROM ( SELECT conversationid, min(sessionindex) AS first_queue_index FROM PUBLIC.F_PI_SESSION_SUMMARY_VW WHERE purpose = 'acd' AND PROJECTID='" + PROJECTID + "' GROUP BY 1) f11 INNER JOIN ( SELECT conversationid, queuename, sessionindex FROM PUBLIC.F_PI_SESSION_SUMMARY_VW WHERE PROJECTID='" + PROJECTID + "' ) f12 ON f11.conversationid = f12.conversationid AND f11.first_queue_index = f12.sessionindex ) SELECT a14.conversationid, a14.sessionid, a14.projectid, a14.first_endpoint, a14.contractual_firstqueue, a14.firstqueue, CASE WHEN a14.sessiontype = 'Transfer Sessions'THEN 'Transfer' WHEN a14.sessiontype = 'Inbound Sessions'THEN 'Inbound' WHEN a14.sessiontype = 'Courtesy Callback Sessions'THEN 'Courtesy Callback' WHEN a14.sessiontype = 'Outbound Sessions'THEN 'Outbound' WHEN a14.sessiontype = 'Outbound Callback Sessions'THEN 'Outbound Callback' WHEN a14.sessiontype = 'Agent Scheduled Callback Sessions'THEN 'Agent Scheduled Callback' WHEN a14.sessiontype = 'IVR Sessions'THEN 'IVR' ELSE 'N / A' END AS contacttype , a14.sessiontype FROM ( SELECT a11.projectid, a11.conversationid, a11.sessionid, a11.sessionIndex, a12.first_endpoint, a12.contractual_firstqueue, a13.firstqueue, CASE WHEN purpose = 'ivr'THEN 'IVR Sessions' WHEN a11.purpose = 'USER' AND a11.originatingdirection = 'inbound' AND a11.direction = 'outbound'THEN 'Wrong Outbound Sessions' WHEN a11.originatingdirection = 'outbound' AND a11.direction = 'outbound' AND a11.userhandled = 1 AND a11.mediatype = 'voice'THEN 'Outbound Sessions' WHEN a11.sessionIndex > a12.first_endpoint AND a11.originatingdirection = 'outbound' AND a11.mediatype = 'callback' AND agentanswered = 1 THEN 'Outbound Callback Screen Sessions' WHEN a11.sessionIndex > a12.first_endpoint AND a11.originatingdirection = 'outbound' AND (a11.mediatype = 'callback' OR (a11.mediatype = 'voice' AND a11.direction = 'outbound')) THEN 'Outbound Callback Sessions' WHEN a11.originatingdirection = 'outbound' AND a11.direction = 'inbound'THEN 'Transfer Sessions' WHEN a11.sessionindex != sessioncount AND a11.abandoned = 1 AND a11.disconnecttype != 'peer'THEN 'Cancel Abandon Sessions' WHEN a11.purpose = 'USER' AND monitoringduration > 0 THEN 'Monitoring Sessions' WHEN a11.flowout = 1 AND a11.purpose = 'acd'THEN 'Inbound Flowout Sessions' WHEN a11.originatingdirection = 'inbound' AND a11.sessionIndex <= a12.first_endpoint AND a11.mediatype = 'callback' AND a11.agentanswered = 1 THEN 'Courtesy Callback Screen Sessions' WHEN a11.originatingdirection = 'inbound' AND a11.sessionIndex <= a12.first_endpoint AND (a11.mediatype = 'callback' OR (mediatype = 'voice' AND a11.direction = 'outbound')) THEN 'Courtesy Callback Sessions' WHEN a11.originatingdirection = 'inbound' AND a11.sessionIndex <= a12.first_endpoint AND a11.mediatype = 'voice' AND a11.purpose != 'callback'THEN 'Inbound Sessions' WHEN a11.sessionIndex > a12.first_endpoint AND a11.mediatype = 'callback' AND a11.agentanswered = 1 THEN 'Agent Scheduled Callback Screen Sessions' WHEN a11.sessionIndex > a12.first_endpoint AND (a11.mediatype = 'callback' OR (a11.mediatype = 'voice' AND a11.direction = 'outbound')) THEN 'Agent Scheduled Callback Sessions' WHEN a11.purpose = 'voicemail'THEN 'Voicemail Sessions' WHEN a11.purpose = 'agent' AND a11.username = a11.prior_username AND a11.direction = 'outbound' AND prior_mediatype = 'voice'THEN 'Agent Followup Sessions' WHEN a11.sessionIndex > a12.first_endpoint AND mediatype = 'voice'THEN 'Transfer Sessions' ELSE 'N/A' END AS sessionType FROM a11 LEFT OUTER JOIN a12 ON a11.conversationid = a12.conversationid LEFT OUTER JOIN a13 ON a11.conversationid = a13.conversationid)a14;";
 //log("ingesting data")
try {
            snowflake.execute (
                {sqlText: sqlCommand}
            );
        }
    catch (err)  {
        log(PROJECTID,"SP", "S_PI_PRJ_SESSION_CONTACT_SUMMARY_LOAD", "FAILED","Failed to load table STAGE.S_PI_SESSION_CONTACT_SUMMARY for projectid " + PROJECTID + ": "+ err);
        return "1";
        }        

        log(PROJECTID, "SP", "S_PI_PRJ_SESSION_CONTACT_SUMMARY_LOAD", "SUCCEEDED","Succeeded loading table STAGE.S_PI_SESSION_CONTACT_SUMMARY for projectid " + PROJECTID);
  return "0";  
  $$;    