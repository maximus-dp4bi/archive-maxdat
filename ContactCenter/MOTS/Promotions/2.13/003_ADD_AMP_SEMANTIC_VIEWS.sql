create or replace view AMP_USER_SV  as select * from AMP_USER;
create or replace view AMP_PROJECT_ROLE_SV  as select * from AMP_ROLE WHERE TYPE = 'PROJECT' ; 
create or replace view AMP_APPLICATION_ROLE_SV  as select * from AMP_ROLE   WHERE TYPE = 'APPLICATION' ; 
create or replace view D_METRIC_PROJECT_SV  as select * from D_METRIC_PROJECT; 
create or replace view D_PROJECT_USER_SV  as select * from D_PROJECT_USER; 

grant select on AMP_USER_SV to MAXDAT_REPORTS;
grant select on AMP_PROJECT_ROLE_SV to MAXDAT_REPORTS;
grant select on AMP_APPLICATION_ROLE_SV to MAXDAT_REPORTS;
grant select on D_METRIC_PROJECT_SV to MAXDAT_REPORTS;
grant select on D_PROJECT_USER_SV to MAXDAT_REPORTS;

grant select on AMP_USER_SV to MOTS_READ_ONLY;
grant select on AMP_PROJECT_ROLE_SV to MOTS_READ_ONLY;
grant select on AMP_APPLICATION_ROLE_SV to MOTS_READ_ONLY;
grant select on D_METRIC_PROJECT_SV to MOTS_READ_ONLY;
grant select on D_PROJECT_USER_SV to MOTS_READ_ONLY;