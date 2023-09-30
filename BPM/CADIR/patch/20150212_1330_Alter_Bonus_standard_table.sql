alter table d_bonus_standards add role_name varchar2(100);

update d_bonus_standards set Role_name = 'Clinical Consultant Supervisor' where BID = 1;
update d_bonus_standards set Role_name = 'Clinical Consultant' where BID = 2;
update d_bonus_standards set Role_name = 'Document Review Clerk' where BID = 3;
update d_bonus_standards set Role_name = 'Document Review Clerk Supervisor' where BID = 4;
update d_bonus_standards set Role_name = 'Preliminary Reviewer' where BID = 5;
update d_bonus_standards set Role_name = 'Preliminary Reviewer Supervisor' where BID = 6;
update d_bonus_standards set Role_name = 'Letter Writer Supervisor' where BID = 7;
update d_bonus_standards set Role_name = 'Letter Writer' where BID = 8;
update d_bonus_standards set Role_name = 'Terminator' where BID = 9;
update d_bonus_standards set Role_name = 'Terminator Supervisor' where BID = 10;

CREATE OR REPLACE VIEW D_BONUS_STANDARDS_SV AS
SELECT BID
      ,TASK_TYPE
      ,BONUS_STANDARD
      ,BONUS_POINT_1
      ,BONUS_POINT_2
      ,BONUS_POINT_3
      ,ACTIVE
      ,START_DATE
      ,END_DATE
      ,ROLE_NAME
FROM D_BONUS_STANDARDS
with read only;

commit;