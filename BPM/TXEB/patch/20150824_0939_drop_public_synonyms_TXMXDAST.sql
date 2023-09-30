/*
select 'drop public synonym "' || SYNONYM_NAME || '";'
from ALL_SYNONYMS  
where 
  TABLE_OWNER like 'MAXDAT%'
  and OWNER = 'PUBLIC'
order by 
  OWNER asc,
  SYNONYM_NAME asc;
*/
drop public synonym "/f3e59263_CC_D_PRODUCTION_PLAN";
drop public synonym "DSSCSADDRESS";
drop public synonym "DSSCSCONTACT";
drop public synonym "DSSCSCONTENT";
drop public synonym "DSSCSMSGINFO";
drop public synonym "DSSCSPSNLZTN";
drop public synonym "DSSCSRCOLCON";
drop public synonym "DSSCSRINSTRG";
drop public synonym "DSSCSRPTCACH";
drop public synonym "DSSCSSUBINST";
drop public synonym "DSSCSSYSPROP";
drop public synonym "DSSMDJRNINFO";
drop public synonym "DSSMDJRNLNKS";
drop public synonym "DSSMDJRNOBJC";
drop public synonym "DSSMDJRNOBJD";
drop public synonym "DSSMDJRNOBJS";
drop public synonym "DSSMDLNKITEM";
drop public synonym "DSSMDLNKPROP";
drop public synonym "DSSMDOBJBLOB";
drop public synonym "DSSMDOBJCMNT";
drop public synonym "DSSMDOBJDEF2";
drop public synonym "DSSMDOBJDEFN";
drop public synonym "DSSMDOBJDEPN";
drop public synonym "DSSMDOBJINFO";
drop public synonym "DSSMDOBJLOCK";
drop public synonym "DSSMDOBJPROP";
drop public synonym "DSSMDOBJSECU";
drop public synonym "DSSMDOBJTRNS";
drop public synonym "DSSMDSYSPROP";
drop public synonym "DSSMDUSRACCT";
drop public synonym "IS_CACHE_HIT_STATS";
drop public synonym "IS_CUBE_REP_STATS";
drop public synonym "IS_DOCUMENT_STATS";
drop public synonym "IS_DOC_STEP_STATS";
drop public synonym "IS_INBOX_ACT_STATS";
drop public synonym "IS_MESSAGE_STATS";
drop public synonym "IS_PERF_MON_STATS";
drop public synonym "IS_PROJ_SESS_STATS";
drop public synonym "IS_PR_ANS_STATS";
drop public synonym "IS_REPORT_STATS";
drop public synonym "IS_REP_COL_STATS";
drop public synonym "IS_REP_MANIP_STATS";
drop public synonym "IS_REP_SEC_STATS";
drop public synonym "IS_REP_SQL_STATS";
drop public synonym "IS_REP_STEP_STATS";
drop public synonym "IS_SCHEDULE_STATS";
drop public synonym "IS_SESSION_STATS";