--MAXDAT-3533 - Add 2 new columns

alter table CC_S_TMP_CISCO_A_SG_INTERVAL
add (SHORTCALLS NUMBER(10,0), REDIRECTNOANSCALLS NUMBER(10,0));

alter table CC_S_ACD_AGENT_ACTIVITY
add (SHORT_CALLS NUMBER(10,0), CALLS_RETURNED_TO_QUEUE NUMBER(10,0));

alter table CC_F_AGENT_BY_DATE
add (SHORT_CALLS NUMBER(10,0), CALLS_RETURNED_TO_QUEUE NUMBER(10,0));