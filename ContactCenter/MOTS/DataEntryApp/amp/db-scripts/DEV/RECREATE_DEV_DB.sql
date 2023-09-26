
@0_CREATE_USER_maxdatdev.sql;

alter session set current_schema=maxdatdev;
@1_CREATE_SEQUENCES.sql;
@2_CREATE_INSERT_GEO.sql;
@3_CREATE_AMP_SCHEMA.sql;
@4_CREATE_TRIGGERS.sql;
@5_INSERT_DIM_DATA.sql;

commit;

alter session set current_schema=SYSTEM;