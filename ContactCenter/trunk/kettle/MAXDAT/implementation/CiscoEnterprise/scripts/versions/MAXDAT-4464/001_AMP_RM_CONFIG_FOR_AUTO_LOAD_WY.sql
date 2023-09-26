alter session set current_schema = CISCO_ENTERPRISE_CC;

delete from CC_A_LIST_LKUP where NAME = 'AMPEXP_PROJECT_SOURCE_LIST' and VALUE = 'Wyoming Dept of Health';

commit;
