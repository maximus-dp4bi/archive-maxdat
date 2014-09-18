-- NYHIX-4273 "MAXDAT Step Instance Stage Order by issue" applied as corp fix
DECLARE
 c_beg CONSTANT DATE := SYSDATE;
 c_end CONSTANT DATE := TO_DATE('7-JUL-7777','DD-MON-YYYY');
BEGIN
  INSERT INTO corp_etl_list_lkup (name, value, list_type, out_var, start_date, end_date, comments)
  VALUES('MW_TASK_STATUS_ORDER','UNCLAIMED','ORDER','10', c_beg, c_end, 'OLTP creates instance history out of order, this cardinality sets records correctly in MAXDAT. Highest value is end of instance cycle.');
  INSERT INTO corp_etl_list_lkup (name, value, list_type, out_var, start_date, end_date, comments)
  VALUES('MW_TASK_STATUS_ORDER','CLAIMED','ORDER','20', c_beg, c_end, 'OLTP creates instance history out of order, this cardinality sets records correctly in MAXDAT. Highest value is end of instance cycle.');
  INSERT INTO corp_etl_list_lkup (name, value, list_type, out_var, start_date, end_date, comments)
  VALUES('MW_TASK_STATUS_ORDER','INPROCESS','ORDER','30', c_beg, c_end, 'OLTP creates instance history out of order, this cardinality sets records correctly in MAXDAT. Highest value is end of instance cycle.');
  INSERT INTO corp_etl_list_lkup (name, value, list_type, out_var, start_date, end_date, comments)
  VALUES('MW_TASK_STATUS_ORDER','SUSPENDED','ORDER','40', c_beg, c_end, 'OLTP creates instance history out of order, this cardinality sets records correctly in MAXDAT. Highest value is end of instance cycle.');
  INSERT INTO corp_etl_list_lkup (name, value, list_type, out_var, start_date, end_date, comments)
  VALUES('MW_TASK_STATUS_ORDER','TERMINATED','ORDER','50', c_beg, c_end, 'OLTP creates instance history out of order, this cardinality sets records correctly in MAXDAT. Highest value is end of instance cycle.');
  INSERT INTO corp_etl_list_lkup (name, value, list_type, out_var, start_date, end_date, comments)
  VALUES('MW_TASK_STATUS_ORDER','VOIDED','ORDER','80', c_beg, c_end, 'OLTP creates instance history out of order, this cardinality sets records correctly in MAXDAT. Highest value is end of instance cycle.');
  INSERT INTO corp_etl_list_lkup (name, value, list_type, out_var, start_date, end_date, comments)
  VALUES('MW_TASK_STATUS_ORDER','TIMEOUT','ORDER','60', c_beg, c_end, 'OLTP creates instance history out of order, this cardinality sets records correctly in MAXDAT. Highest value is end of instance cycle.');
  INSERT INTO corp_etl_list_lkup (name, value, list_type, out_var, start_date, end_date, comments)
  VALUES('MW_TASK_STATUS_ORDER','COMPLETED','ORDER','100', c_beg, c_end, 'OLTP creates instance history out of order, this cardinality sets records correctly in MAXDAT. Highest value is end of instance cycle.');
  COMMIT;
END;
/