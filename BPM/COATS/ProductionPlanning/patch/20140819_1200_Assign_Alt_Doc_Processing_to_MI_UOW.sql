INSERT INTO PP_D_UOW_SOURCE_REF SELECT 68, 5, 1, 'Alternate Document Processing', 'TASK ID', TRUNC(SYSDATE), TO_DATE('20770707','YYYYMMDD') FROM DUAL;

TRUNCATE TABLE pp_d_actual_details;
TRUNCATE TABLE pp_f_actuals;

commit;
/
