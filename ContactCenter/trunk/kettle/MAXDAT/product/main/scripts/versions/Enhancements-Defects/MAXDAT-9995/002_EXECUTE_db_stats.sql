execute DBMS_STATS.GATHER_TABLE_STATS(OWNNAME => 'CISCO_ENTERPRISE_CC',TABNAME => 'CC_F_V2_CALL',CASCADE => TRUE,DEGREE  => 4,ESTIMATE_PERCENT => 100,METHOD_OPT => 'FOR ALL COLUMNS SIZE AUTO'); 