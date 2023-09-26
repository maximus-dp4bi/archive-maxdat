
Insert into AMP_USER (ID,ACCOUNT_EXPIRED,ACCOUNT_LOCKED,ADDRESS,CITY,COUNTRY,POSTAL_CODE,PROVINCE,CREDENTIALS_EXPIRED,EMAIL,ACCOUNT_ENABLED,FIRST_NAME,LAST_NAME,PASSWORD,PASSWORD_HINT,PHONE_NUMBER,USERNAME,VERSION,WEBSITE) values (-2,0,0,null,'Denver','US','80210','CO',0,'ampadmin@maximus.com',1,'Amp','Admin','$2a$10$bH/ssqW8OhkTlIso9/yakubYODUOmh.6m5HEJvcBq3t3VdBh7ebqO','Whoami',null,'admin',1,'http://raibledesigns.com');
Insert into AMP_USER (ID,ACCOUNT_EXPIRED,ACCOUNT_LOCKED,ADDRESS,CITY,COUNTRY,POSTAL_CODE,PROVINCE,CREDENTIALS_EXPIRED,EMAIL,ACCOUNT_ENABLED,FIRST_NAME,LAST_NAME,PASSWORD,PASSWORD_HINT,PHONE_NUMBER,USERNAME,VERSION,WEBSITE) values (-1,0,0,null,'Denver','US','80210','CO',0,'ampuser@maximus.com',1,'Amp','User','$2a$10$CnQVJ9bsWBjMpeSKrrdDEeuIptZxXrwtI6CZ/OgtNxhIgpKxXeT9y','Whoami',null,'user',1,'http://tomcat.apache.org');
Insert into AMP_USER (ID,ACCOUNT_EXPIRED,ACCOUNT_LOCKED,ADDRESS,CITY,COUNTRY,POSTAL_CODE,PROVINCE,CREDENTIALS_EXPIRED,EMAIL,ACCOUNT_ENABLED,FIRST_NAME,LAST_NAME,PASSWORD,PASSWORD_HINT,PHONE_NUMBER,USERNAME,VERSION,WEBSITE) values (-5,0,0,null,'Charleston','US','29464','SC',0,'clay.rowland@modus21.com',1,'Clay','Rowland','NA',null,null,'56205',1,null);

Insert into AMP_USER (ID,ACCOUNT_EXPIRED,ACCOUNT_LOCKED,ADDRESS,CITY,COUNTRY,POSTAL_CODE,PROVINCE,CREDENTIALS_EXPIRED,EMAIL,ACCOUNT_ENABLED,FIRST_NAME,LAST_NAME,PASSWORD,PASSWORD_HINT,PHONE_NUMBER,USERNAME,VERSION,WEBSITE) values (-10,0,0,null,'Denver','US','80210','CO',0,'backoffice@maximus.com',1,'Backoffice','User','$2a$10$CnQVJ9bsWBjMpeSKrrdDEeuIptZxXrwtI6CZ/OgtNxhIgpKxXeT9y','Whoami',null,'backoffice',1,'http://tomcat.apache.org');
Insert into AMP_USER (ID,ACCOUNT_EXPIRED,ACCOUNT_LOCKED,ADDRESS,CITY,COUNTRY,POSTAL_CODE,PROVINCE,CREDENTIALS_EXPIRED,EMAIL,ACCOUNT_ENABLED,FIRST_NAME,LAST_NAME,PASSWORD,PASSWORD_HINT,PHONE_NUMBER,USERNAME,VERSION,WEBSITE) values (-11,0,0,null,'Denver','US','80210','CO',0,'contactcenter@maximus.com',1,'contactcenter','User','$2a$10$CnQVJ9bsWBjMpeSKrrdDEeuIptZxXrwtI6CZ/OgtNxhIgpKxXeT9y','Whoami',null,'contactcenter',1,'http://tomcat.apache.org');
Insert into AMP_USER (ID,ACCOUNT_EXPIRED,ACCOUNT_LOCKED,ADDRESS,CITY,COUNTRY,POSTAL_CODE,PROVINCE,CREDENTIALS_EXPIRED,EMAIL,ACCOUNT_ENABLED,FIRST_NAME,LAST_NAME,PASSWORD,PASSWORD_HINT,PHONE_NUMBER,USERNAME,VERSION,WEBSITE) values (-12,0,0,null,'Denver','US','80210','CO',0,'approver@maximus.com',1,'approver','User','$2a$10$CnQVJ9bsWBjMpeSKrrdDEeuIptZxXrwtI6CZ/OgtNxhIgpKxXeT9y','Whoami',null,'approver',1,'http://tomcat.apache.org');
Insert into AMP_USER (ID,ACCOUNT_EXPIRED,ACCOUNT_LOCKED,ADDRESS,CITY,COUNTRY,POSTAL_CODE,PROVINCE,CREDENTIALS_EXPIRED,EMAIL,ACCOUNT_ENABLED,FIRST_NAME,LAST_NAME,PASSWORD,PASSWORD_HINT,PHONE_NUMBER,USERNAME,VERSION,WEBSITE) values (-13,0,0,null,'Denver','US','80210','CO',0,'cthix@maximus.com',1,'cthix','User','$2a$10$CnQVJ9bsWBjMpeSKrrdDEeuIptZxXrwtI6CZ/OgtNxhIgpKxXeT9y','Whoami',null,'cthix',1,'http://tomcat.apache.org');

Insert into AMP_ROLE (ID,DESCRIPTION,NAME,TYPE) values (1,'Administrator role (can edit Users)','ROLE_ADMIN','APPLICATION');
Insert into AMP_ROLE (ID,DESCRIPTION,NAME,TYPE) values (2,'Default role for all Users','ROLE_USER','APPLICATION');
Insert into AMP_ROLE (ID,DESCRIPTION,NAME,TYPE) values (3,'Metric approver for projects','ROLE_PROJECT_APPROVER','PROJECT');
Insert into AMP_ROLE (ID,DESCRIPTION,NAME,TYPE) values (4,'Metric reporter for projects','ROLE_PROJECT_REPORTER','PROJECT');

Insert into AMP_USER_AMP_ROLE (USER_ID,ROLE_ID) values (-2,1);
Insert into AMP_USER_AMP_ROLE (USER_ID,ROLE_ID) values (-1,2);
Insert into AMP_USER_AMP_ROLE (USER_ID,ROLE_ID) values (-5,1);
Insert into AMP_USER_AMP_ROLE (USER_ID,ROLE_ID) values (-10,2);
Insert into AMP_USER_AMP_ROLE (USER_ID,ROLE_ID) values (-11,2);
Insert into AMP_USER_AMP_ROLE (USER_ID,ROLE_ID) values (-12,2);
Insert into AMP_USER_AMP_ROLE (USER_ID,ROLE_ID) values (-13,2);

insert into d_project_user(d_project_user_id, d_project_id, app_user_id, d_project_role_id, functional_area, is_active_flag)
values (-1, 2, -1, 4, 'Contact Center', 'Y');

insert into d_project_user(d_project_user_id, d_project_id, app_user_id, d_project_role_id, functional_area, is_active_flag)
values (-2, 2, -1, 3, 'Contact Center', 'Y');

insert into d_project_user(d_project_user_id, d_project_id, app_user_id, d_project_role_id, functional_area, is_active_flag)
values (-3, 2, -10, 4, 'Back Office', 'Y'); -- NY HIX Back Office Reporter

insert into d_project_user(d_project_user_id, d_project_id, app_user_id, d_project_role_id, functional_area, is_active_flag)
values (-4, 2, -11, 4, 'Contact Center', 'Y'); -- NY HIX Contact Center Reporter

insert into d_project_user(d_project_user_id, d_project_id, app_user_id, d_project_role_id, functional_area, is_active_flag)
values (-5, 2, -12, 3, 'Contact Center', 'Y'); -- NY HIX Contact Center Approver

insert into d_project_user(d_project_user_id, d_project_id, app_user_id, d_project_role_id, functional_area, is_active_flag)
values (-6, 3, -10, 4, 'Back Office', 'Y'); -- VT HIX Back Office Reporter

insert into d_project_user(d_project_user_id, d_project_id, app_user_id, d_project_role_id, functional_area, is_active_flag)
values (-7, 3, -11, 4, 'Contact Center', 'Y'); -- VT HIX Contact Center Reporter

insert into d_project_user(d_project_user_id, d_project_id, app_user_id, d_project_role_id, functional_area, is_active_flag)
values (-8, 3, -12, 3, 'Contact Center', 'Y'); -- VT HIX Contact Center Approver

insert into d_project_user(d_project_user_id, d_project_id, app_user_id, d_project_role_id, functional_area, is_active_flag)
values (-9, 3, -13, 4, 'Back Office', 'Y'); -- CT HIX Back Office Reporter

insert into d_project_user(d_project_user_id, d_project_id, app_user_id, d_project_role_id, functional_area, is_active_flag)
values (-10, 3, -13, 4, 'Contact Center', 'Y'); -- CT HIX Contact Center Reporter

commit;


