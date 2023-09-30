-- Drop table
declare  c int;
begin
    select count(*) into c from user_tables where table_name ='F_MFD_RECEIVED_COUNTS';
    if c = 1 then
       execute immediate 'drop table F_MFD_RECEIVED_COUNTS cascade constraints';
    end if;
end;
/

-- Drop semantic view
declare  c int;
begin
    select count(*) into c from user_views where view_name ='F_MFD_RECEIVED_COUNTS_SV';
    if c = 1 then
       execute immediate 'drop view F_MFD_RECEIVED_COUNTS_SV cascade constraints';
    end if;
end;
/

-- Drop Sequence
declare  c int;
begin
    select count(*) into c from user_sequences where sequence_name ='SEQ_F_RECEIVED_COUNTS';
    if c = 1 then
       execute immediate 'drop sequence SEQ_F_RECEIVED_COUNTS';
    end if;
end;
/

-- Drop trigger
declare  c int;
begin
    select count(*) into c from user_triggers where trigger_name = 'F_MFD_RECEIVED_COUNTS';
    if c = 1 then
       execute immediate 'drop trigger F_MFD_RECEIVED_COUNTS';
    end if;
end;
/

-----------------------------------------------------------------------------------------------------
Create table MAXDAT.F_MFD_RECEIVED_COUNTS
(F_RECEIVED_COUNTS_ID NUMBER(19) NOT NULL,
 RECEIVED_DATE       DATE,
 RECEIVED_COUNT   NUMBER,
 CREATE_DATE   DATE,
 CREATED_BY     VARCHAR2(50),
 LAST_MODIFIED_DATE  DATE,
 UPDATED_BY   VARCHAR2(50)
)
  tablespace MAXDAT_DATA
  STORAGE (BUFFER_POOL DEFAULT);

Create index MAXDAT.F_MFD_RECEIVED_COUNTS_IDXV2 on MAXDAT.F_MFD_RECEIVED_COUNTS (RECEIVED_DATE)
  tablespace MAXDAT_INDX
  STORAGE (BUFFER_POOL DEFAULT);

alter table MAXDAT.F_MFD_RECEIVED_COUNTS
  add constraint F_MFD_RECEIVED_COUNTS_PK primary key (F_RECEIVED_COUNTS_ID)
  using index
  tablespace MAXDAT_DATA
  STORAGE (BUFFER_POOL DEFAULT);

Create or replace view F_MFD_RECEIVED_COUNTS_SV as
Select F_RECEIVED_COUNTS_ID,
RECEIVED_DATE,
RECEIVED_COUNT
From F_MFD_RECEIVED_COUNTS with read only;

Grant select on F_MFD_RECEIVED_COUNTS_SV to MAXDAT_READ_ONLY;

Create sequence MAXDAT.SEQ_F_RECEIVED_COUNTS
minvalue 1
maxvalue 9999999999999999999
start with 1
increment by 1
cache 20
cycle;

CREATE OR REPLACE TRIGGER MAXDAT.F_MFD_RECEIVED_COUNTS
    BEFORE INSERT OR UPDATE ON MAXDAT.F_MFD_RECEIVED_COUNTS
    FOR EACH ROW

BEGIN
IF INSERTING AND :NEW.F_RECEIVED_COUNTS_ID IS NULL THEN
     SELECT MAXDAT.SEQ_F_RECEIVED_COUNTS.NEXTVAL INTO :NEW.F_RECEIVED_COUNTS_ID FROM DUAL;
  :NEW.CREATE_DATE := SYSDATE;
  :NEW.CREATED_BY := USER;
END IF;
:NEW.UPDATED_BY := USER;
:NEW.LAST_MODIFIED_DATE := SYSDATE;
END;
