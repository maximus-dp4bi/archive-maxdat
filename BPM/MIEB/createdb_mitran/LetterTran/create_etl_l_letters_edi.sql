-- Create table
--drop table etl_l_letters_edi;

create table ETL_L_LETTERS_EDI
(
  job_ctrl_id         NUMBER(18) not null,
  row_num             NUMBER(18) not null,
  xml_filename            VARCHAR2(1000),
  xml_fullpath            varchar2(1000),
  xml_letterType     varchar2(20),
  xml_dateOfLetter        varchar2(30),
  xml_mediaCd             varchar2(30),
  xml_materialCd          varchar2(30),
  xml_letterReqId         varchar2(30),
  xml_caseId              varchar2(30),
  server_file_date        date,
  numOfCopies             varchar2(30),
  extMaterialRefId        varchar2(30),
  detailOccurrences       varchar2(30),
  letter_type         VARCHAR2(100),
  processed_ind       NUMBER(1) default 0,
  process_ts          DATE,
  create_ts           DATE,
  created_by          VARCHAR2(80),
  update_ts           DATE,
  updated_by          VARCHAR2(80),
  tran_date           date
)
tablespace MAXDAT_MITRAN_DATA
  pctfree 10
  initrans 1
  maxtrans 255;
-- Create/Recreate primary, unique and foreign key constraints 
alter table ETL_L_LETTERS_EDI
  add constraint ETL_L_LETTERS_EDI_PK primary key (JOB_CTRL_ID, xml_filename, ROW_NUM)
  using index 
  tablespace MAXDAT_MITRAN_DATA
  pctfree 10
  initrans 2
  maxtrans 255;
-- Grant/Revoke object privileges 
grant select on ETL_L_LETTERS_EDI to MAXDAT_MIEB_READ_ONLY;
grant select, insert, update on ETL_L_LETTERS_EDI to MAXDAT_MITRAN_OLTP_SIU;
grant select, insert, update, delete on ETL_L_LETTERS_EDI to MAXDAT_MITRAN_OLTP_SIUD;
grant select on ETL_L_LETTERS_EDI to MAXDAT_MITRAN_READ_ONLY;

create index LETTERS_EDI_INDX_1 on ETL_L_LETTERS_EDI(tran_date, xml_filename, xml_lettertype, xml_materialcd);
