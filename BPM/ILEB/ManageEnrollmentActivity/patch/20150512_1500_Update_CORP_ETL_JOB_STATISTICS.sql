--Update control table for testing purposes

update corp_etl_control
set value = TO_CHAR(sysdate-1, 'yyyy/mm/dd')
where name = 'MANAGEENRL_RUN_RUNALL_TODAY';
 
 commit;