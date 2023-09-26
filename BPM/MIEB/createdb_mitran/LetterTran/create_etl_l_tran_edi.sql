-- Create table
--drop table etl_l_tran_edi;

CREATE TABLE MAXDAT_MITRAN.ETL_L_TRAN_EDI
(
  job_ctrl_id         NUMBER(18) not null,
  row_num             NUMBER(18) not null,
  tran_filename            VARCHAR2(1000),
  Project_name VARCHAR2(32)
, tran_job_id NUMBER(32)
, Tran_date DATE
, Letter_type VARCHAR2(20)
, Ltr_filename VARCHAR2(100)
, requested_qty NUMBER(32)
, resent VARCHAR2(10)
, preqa_eyr_ltr_filename VARCHAR2(100)
, preqa_eyr_ltr_qty NUMBER(32)
, qa_abort_userid VARCHAR2(100)
, qa_split_qty NUMBER(32)
, qa_rejected_qty NUMBER(32)
, qa_comments VARCHAR2(1000)
, qa_signed VARCHAR2(100)
, eyr_mailed_date DATE
, eyr_mailed_qty NUMBER(32)
, eyr_ps_checked VARCHAR2(100)
, eyr_ps_comments VARCHAR2(1000)
,  create_ts           DATE
,  created_by          VARCHAR2(80)
,  update_ts           DATE
,  updated_by          VARCHAR2(80)
)
tablespace MAXDAT_MITRAN_DATA
  pctfree 10
  initrans 1
  maxtrans 255;
-- Create/Recreate primary, unique and foreign key constraints 

alter table ETL_L_tran_EDI
  add constraint ETL_L_tran_EDI_PK primary key (JOB_CTRL_ID, tran_filename, ROW_NUM)
  using index 
  tablespace MAXDAT_MITRAN_DATA
  pctfree 10
  initrans 2
  maxtrans 255;
-- Grant/Revoke object privileges 
grant select on ETL_L_tran_EDI to MAXDAT_MIEB_READ_ONLY;
grant select, insert, update on ETL_L_tran_EDI to MAXDAT_MITRAN_OLTP_SIU;
grant select, insert, update, delete on ETL_L_tran_EDI to MAXDAT_MITRAN_OLTP_SIUD;
grant select on ETL_L_tran_EDI to MAXDAT_MITRAN_READ_ONLY;

create index TRAN_EDI_INDX_1 on ETL_L_tran_EDI(tran_date, tran_filename, letter_type);
