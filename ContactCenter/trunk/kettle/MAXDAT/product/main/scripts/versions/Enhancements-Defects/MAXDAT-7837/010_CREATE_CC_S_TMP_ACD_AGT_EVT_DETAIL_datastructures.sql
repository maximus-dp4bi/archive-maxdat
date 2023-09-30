CREATE TABLE CC_S_TMP_ACD_AGT_EVT_DETAIL
(
DBDATETIME	DATE,
DATETIME	TIMESTAMP,
SKILLTARGETID	NUMBER(19,0),
LOGINDATETIME	DATE,
DURATION	NUMBER(19,0),
REASONCODE	NUMBER(19,0),
REASONTEXT	VARCHAR2(100 BYTE),
AGENTDESKSETTINGID	NUMBER(19,0),
DATETIME_END	TIMESTAMP,
EVENT	VARCHAR2(10 BYTE),
UTC_DATETIME TIMESTAMP(6),
UTC_DATETIME_END TIMESTAMP(6)
);