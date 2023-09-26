
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
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
  
  
-- Create/Recreate primary, unique and foreign key constraints 
alter table D_DELTEK_HOURS_TMP
  add primary key (TMP_DDH_ID)
  using index 
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
  
  
-- Grant/Revoke object privileges 
grant select, insert, update on D_DELTEK_HOURS_TMP to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on D_DELTEK_HOURS_TMP to MAXDAT_OLTP_SIUD;
grant select on D_DELTEK_HOURS_TMP to MAXDAT_READ_ONLY;

CREATE PUBLIC SYNONYM D_DELTEK_HOURS_TMP FOR D_DELTEK_HOURS_TMP ;

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
