-- TODO: When these projects become part of BPM, 
-- separate inserts into their own BPM/{program}/createdb/populate_BPM_PROJECT_LKUP.sql
insert into BPM_PROJECT_LKUP(BPRJ_ID,NAME) values (1,'Texas Eligibility');
insert into BPM_PROJECT_LKUP(BPRJ_ID,NAME) values (2,'Texas Enrollment');
insert into BPM_PROJECT_LKUP(BPRJ_ID,NAME) values (3,'Texas Eligibility Support');
insert into BPM_PROJECT_LKUP(BPRJ_ID,NAME) values (4,'Colorado EEMAP');
insert into BPM_PROJECT_LKUP(BPRJ_ID,NAME) values (5,'California Eligibility');

commit;