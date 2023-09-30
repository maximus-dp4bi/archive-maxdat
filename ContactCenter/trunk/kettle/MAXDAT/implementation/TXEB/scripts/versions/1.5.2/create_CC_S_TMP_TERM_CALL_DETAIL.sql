CREATE TABLE CC_S_TMP_TERMINATN_CALL_DETAIL
(
  DATETIME DATE,
  TIMEZONE NUMBER,
  AGENTSKILLTARGETID NUMBER,
  PERIPHERALID NUMBER,
  CALLTYPEID NUMBER,
  CALLDISPOSITIONFLAG NUMBER,
  TALKTIME NUMBER,
  HOLDTIME NUMBER,
  WORKTIME NUMBER
)
      TABLESPACE MAXDAT_DATA 
        LOGGING 
;

CREATE TABLE CC_S_TMP_AGENT
(
  SKILLTARGETID NUMBER,
  PERSONID NUMBER,
  PERIPHERALID NUMBER,
  ENTERPRISENAME VARCHAR2(100),
  PERIPHERALNUMBER VARCHAR2(30),
  DELETED VARCHAR2(2),
  SUPERVISORAGENT VARCHAR2(2),
  USERDELETABLE VARCHAR2(2)
)
      TABLESPACE MAXDAT_DATA 
        LOGGING 
;