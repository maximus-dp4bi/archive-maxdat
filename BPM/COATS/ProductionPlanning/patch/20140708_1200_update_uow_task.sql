delete from PP_D_UOW_SOURCE_REF where usr_id in (3,11,26,38,42,44,53);
delete from PP_D_UOW_SOURCE_REF where end_date < sysdate;

INSERT INTO PP_D_UOW_SOURCE_REF SELECT 66, 2, 1, 'Disenrollment Paris', 'TASK ID', TRUNC(SYSDATE), TO_DATE('20770707','YYYYMMDD') FROM DUAL;
INSERT INTO PP_D_UOW_SOURCE_REF SELECT 67, 6, 1, 'State Data Entry', 'TASK ID', TRUNC(SYSDATE), TO_DATE('20770707','YYYYMMDD') FROM DUAL; 

commit;

