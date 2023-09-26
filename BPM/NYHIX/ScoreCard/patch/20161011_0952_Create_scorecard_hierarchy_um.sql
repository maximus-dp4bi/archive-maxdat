declare  c int;
begin
   select count(*) into c from user_tables where table_name ='SCORECARD_HIERARCHY_UM';
   if c = 1 then
      execute immediate 'drop table SCORECARD_HIERARCHY_UM cascade constraints';
   end if;
end;
/

CREATE TABLE SCORECARD_HIERARCHY_UM 
(UM_Staff_id NUMBER(38,0)
,UM_Natid VARCHAR2(250)
,UM_Name VARCHAR2(100)
)
TABLESPACE maxdat_data PARALLEL;

GRANT SELECT,INSERT,UPDATE,DELETE  ON scorecard_hierarchy_um TO MAXDAT;
GRANT SELECT ON scorecard_hierarchy_um TO MAXDAT_READ_ONLY;

CREATE OR REPLACE VIEW scorecard_hierarchy_um_sv
 (
UM_Staff_id 
,UM_Natid 
,UM_Name 
) AS
SELECT 
UM_Staff_id 
,UM_Natid 
,UM_Name 
FROM SCORECARD_HIERARCHY_UM
WITH read only;

GRANT SELECT ON scorecard_hierarchy_um_sv TO MAXDAT;
GRANT SELECT ON scorecard_hierarchy_um_sv TO MAXDAT_READ_ONLY;

