-- NYHIX-35000
-- Drop table
DECLARE c INT;
BEGIN
  SELECT COUNT(*) INTO c FROM user_tables WHERE table_name = 'F_MFD_RECEIVED_COUNTS';
  IF c = 1 THEN
    EXECUTE IMMEDIATE 'drop table F_MFD_RECEIVED_COUNTS cascade constraints';
  END IF;
END;
/
-- Create table
create table MAXDAT.F_MFD_RECEIVED_COUNTS
(
  f_received_counts_id NUMBER(19) not null,
  NYHIX_MFD_BI_ID      NUMBER,
  received_date		   DATE,
  received_count       NUMBER,
  create_date          DATE,
  created_by           VARCHAR2(50),
  update_date          DATE,
  updated_by           VARCHAR2(50)
)
tablespace MAXDAT_DATA
STORAGE (BUFFER_POOL DEFAULT);

-- Create/Recreate indexes 
create index MAXDAT.F_MFD_RECEIVED_COUNTS_IDXV2 on MAXDAT.F_MFD_RECEIVED_COUNTS (NYHIX_MFD_BI_ID)
  tablespace MAXDAT_INDX
STORAGE (BUFFER_POOL DEFAULT);

-- Create/Recreate primary, unique and foreign key constraints 
alter table MAXDAT.F_MFD_RECEIVED_COUNTS
  add constraint F_MFD_RECEIVED_COUNTS_PK primary key (F_RECEIVED_COUNTS_ID)
  using index 
  tablespace MAXDAT_DATA
STORAGE (BUFFER_POOL DEFAULT);

-- Grant/Revoke object privileges 
grant select, insert, update on MAXDAT.F_MFD_RECEIVED_COUNTS to MAXDAT_OLTP_SIU;

grant select, insert, update, delete on MAXDAT.F_MFD_RECEIVED_COUNTS to MAXDAT_OLTP_SIUD;

grant select on MAXDAT.F_MFD_RECEIVED_COUNTS to MAXDAT_READ_ONLY;
