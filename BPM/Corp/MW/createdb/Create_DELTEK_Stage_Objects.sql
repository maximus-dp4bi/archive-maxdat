
-- Create table
CREATE TABLE D_DELTEK_HOURS_TMP
(
  tmp_ddh_id       NUMBER not null,
  employee_id      VARCHAR2(30),
  labor_grp_type   VARCHAR2(400),
  last_name        VARCHAR2(400),
  first_name       VARCHAR2(400),
  title            VARCHAR2(400),
  empl_org_id      VARCHAR2(400),
  empl_org_name    VARCHAR2(400),
  approval_name    VARCHAR2(400),
  project_id       VARCHAR2(400),
  project_name     VARCHAR2(400),
  org_id           VARCHAR2(400),
  org_name         VARCHAR2(400),
  pay_type         VARCHAR2(400),
  plc_id           VARCHAR2(400),
  hours_date       VARCHAR2(20),
  entered_hours    VARCHAR2(20),
  productive_hours NUMBER,
  comments         VARCHAR2(4000),
  notes            VARCHAR2(4000),
  processed        VARCHAR2(1) default 'N',
  create_dt        DATE,
  update_dt        DATE
)
tablespace MAXDAT_DATA
;
  
  
-- Create/Recreate primary, unique and foreign key constraints 
alter table D_DELTEK_HOURS_TMP
  add primary key (TMP_DDH_ID)
  using index 
  tablespace MAXDAT_INDX
;
  
  
-- Grant/Revoke object privileges 
grant select on D_DELTEK_HOURS_TMP to MAXDAT_READ_ONLY;

CREATE SEQUENCE SEQ_TMP_DDH_ID START WITH 1 INCREMENT BY 1 MAXVALUE 9999999999999999999 MINVALUE 1 CACHE 20 ;

create or replace trigger TRG_BIU_D_DELTEK_HOURS_TMP
before insert or update on D_DELTEK_HOURS_TMP
for each row

begin

  if inserting then
          if :new.TMP_DDH_ID is null then
             :new.TMP_DDH_ID := seq_tmp_ddh_id.nextval;
          end if;
          :new.CREATE_DT := SYSDATE;
          :new.UPDATE_DT := SYSDATE;

        end if;

     if updating then
          :new.UPDATE_DT :=SYSDATE;
      end if;
end;
/
