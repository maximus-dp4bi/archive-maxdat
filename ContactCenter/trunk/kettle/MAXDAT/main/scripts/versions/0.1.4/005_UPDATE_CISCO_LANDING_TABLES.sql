DROP TABLE CC_S_TMP_CISCO_C_T_INTERVAL;
DROP TABLE CC_S_TMP_CISCO_A_SG_INTERVAL;

CREATE TABLE CC_S_TMP_CISCO_C_T_INTERVAL
  (
    CALLTYPEID               NUMBER ,
    TIMEZONE                 NUMBER ,
    DATETIME 				 DATE ,
    DBDATETIME               DATE ,
    ANSWERWAITTIME           NUMBER ,
    CALLSHANDLED             NUMBER ,
    CALLSOFFERED             NUMBER ,
    HANDLETIME               NUMBER ,
    TALKTIME                 NUMBER ,
    HOLDTIME                 NUMBER ,
    CALLSANSWERED            NUMBER ,
    ANSINTERVAL1             NUMBER ,
    ANSINTERVAL2             NUMBER ,
    ANSINTERVAL3             NUMBER ,
    ANSINTERVAL4             NUMBER ,
    ANSINTERVAL5             NUMBER ,
    ANSINTERVAL6             NUMBER ,
    ANSINTERVAL7             NUMBER ,
    ANSINTERVAL8             NUMBER ,
    ANSINTERVAL9             NUMBER ,
    ANSINTERVAL10            NUMBER ,
    ABANDINTERVAL1           NUMBER ,
    ABANDINTERVAL2           NUMBER ,
    ABANDINTERVAL3           NUMBER ,
    ABANDINTERVAL4           NUMBER ,
    ABANDINTERVAL5           NUMBER ,
    ABANDINTERVAL6           NUMBER ,
    ABANDINTERVAL7           NUMBER ,
    ABANDINTERVAL8           NUMBER ,
    ABANDINTERVAL9           NUMBER ,
    ABANDINTERVAL10          NUMBER ,
    TOTALCALLSABAND          NUMBER ,
    ROUTERQUEUEWAITTIME      NUMBER ,
    ROUTERQUEUECALLTYPELIMIT NUMBER ,
    ROUTERQUEUEGLOBALLIMIT   NUMBER ,
    CALLSONHOLD              NUMBER ,
    MAXHOLDTIME              NUMBER ,
    MAXCALLWAITTIME          NUMBER ,
    SERVICELEVELCALLS        NUMBER ,
    SERVICELEVELABAND        NUMBER ,
    CALLDELAYABANDTIME       NUMBER ,
    MAXCALLSQUEUED           NUMBER ,
    SHORTCALLS               NUMBER ,
    REPORTING_INTERVAL       NUMBER ,
    VRUSCRIPTEDXFERREDCALLS  NUMBER ,
    VRUFORCEDXFERREDCALLS    NUMBER ,
    OVERFLOWOUT              NUMBER ,
    CTVRUTIME                NUMBER ,
    ICRDEFAULTROUTED         NUMBER ,
    NETWORKDEFAULTROUTED     NUMBER ,
    RETURNBUSY               NUMBER ,
    CALLSRONA                NUMBER ,
    RETURNRELEASE            NUMBER ,
    CALLSROUTEDNONAGENT      NUMBER ,
    ERRORCOUNT               NUMBER ,
    AGENTERRORCOUNT          NUMBER
  )
  LOGGING ENABLE ROW MOVEMENT ;
CREATE INDEX TMP_CISCO_CTYPE_INT_CLTPID_IDX ON CC_S_TMP_CISCO_C_T_INTERVAL
  (
    CALLTYPEID ASC
  )
  COMPUTE STATISTICS ;
CREATE INDEX TMP_CISCO_CTYPE_INT_DTTIME_IDX ON CC_S_TMP_CISCO_C_T_INTERVAL
  (
    DATETIME ASC
  )
  COMPUTE STATISTICS ;

  CREATE TABLE CC_S_TMP_CISCO_A_SG_INTERVAL
  (
    DATETIME 				DATE ,
    DBDATETIME              DATE ,
    SKILLTARGETID           NUMBER ,
    SKILLGROUPSKILLTARGETID NUMBER ,
    TIMEZONE                NUMBER ,
    AVAILTIME               NUMBER ,
    LOGGEDONTIME            NUMBER ,
    NOTREADYTIME            NUMBER ,
    TALKRESERVETIME         NUMBER ,
    RESERVEDSTATETIME       NUMBER ,
    TALKINTIME              NUMBER ,
    TALKOTHERTIME           NUMBER ,
    TALKOUTTIME             NUMBER ,
    TALKAUTOOUTTIME         NUMBER ,
    TALKPREVIEWTIME         NUMBER ,
    HOLDTIME                NUMBER ,
    WORKNOTREADYTIME        NUMBER ,
    WORKREADYTIME           NUMBER ,
    AGENTOUTCALLS           NUMBER ,
    CALLSHANDLED            NUMBER ,
    AUTOOUTCALLS            NUMBER ,
    PREVIEWCALLS            NUMBER ,
    INTERNALCALLS           NUMBER
  )
  LOGGING ENABLE ROW MOVEMENT ;
CREATE INDEX TMP_CISCO_AGTSG_INT_DTTIME_IDX ON CC_S_TMP_CISCO_A_SG_INTERVAL
  (
    DATETIME ASC
  )
  COMPUTE STATISTICS ;
CREATE INDEX TMP_CISCO_AGTSG_INT_STGID_IDX ON CC_S_TMP_CISCO_A_SG_INTERVAL
  (
    SKILLTARGETID ASC
  )
  COMPUTE STATISTICS ;
CREATE INDEX TMP_CSCO_AGTSG_INT_SGTGTID_IDX ON CC_S_TMP_CISCO_A_SG_INTERVAL
  (
    SKILLGROUPSKILLTARGETID ASC
  )
  COMPUTE STATISTICS ;

  INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
  VALUES ('0.1.4','005','005_UPDATE_CISCO_LANDING_TABLES');
  
  COMMIT;