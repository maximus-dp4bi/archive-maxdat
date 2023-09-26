create table d_crs_dx_lkup 
(
dx_id number,
dx_code varchar2(10),
dx_description varchar2(200),
value varchar2(10),
active_flag varchar2(10),
m_flag varchar2(15),
a_flag varchar2(10),
startdate date,
enddate date
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
alter table d_crs_dx_lkup
  add constraint DX_ID primary key (DX_ID)
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
alter table D_CRS_DX_LKUP
  add constraint DX_CODE__UN unique (DX_CODE)
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

create sequence SEQ_DX_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 2;


grant select, insert, update on d_crs_dx_lkup to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on d_crs_dx_lkup to MAXDAT_OLTP_SIUD;
grant select on d_crs_dx_lkup to MAXDAT_READ_ONLY;

