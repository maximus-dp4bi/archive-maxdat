REM INSERTING into STAFF_GROUP
SET DEFINE OFF;
Insert into STAFF_GROUP (STAFF_GROUP_ID,PFUSER_ID,NAME,CATEGORY,DESCRIPTION,OWNER_USER,MODIFY_USER,OWNER_DATE,MODIFY_DATE,DELETE_DATE) values (1000,1002,'EEV Staff to be scheduled',0,null,1002,null,to_date('06-FEB-13','DD-MON-RR'),null,null);
Insert into STAFF_GROUP (STAFF_GROUP_ID,PFUSER_ID,NAME,CATEGORY,DESCRIPTION,OWNER_USER,MODIFY_USER,OWNER_DATE,MODIFY_DATE,DELETE_DATE) values (1001,2,'CES Staff to be scheduled',0,null,2,null,to_date('26-FEB-13','DD-MON-RR'),null,null);
COMMIT;