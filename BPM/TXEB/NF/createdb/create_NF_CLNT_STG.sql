CREATE TABLE NF_CLNT_STG
(
  NF_CLNT_STG_ID	NUMBER(18,0) NOT NULL ENABLE
, Client_ID NUMBER
, Case_ID NUMBER
, Name VARCHAR2(100)
, Sex VARCHAR2(1)
, Race NUMBER(10,0)
, Voucher NUMBER(18,0)
, Birthdate DATE
, Age NUMBER(18,2)
, SIG NUMBER(18,0)
, Alias VARCHAR2(100)
, Trans_Hld VARCHAR2(2000)
, RG_Page NUMBER(18,0)
, Elig_YYYYMM NUMBER(6,0)
, Risk_Grp NUMBER(5,0)
, HMO_ID NUMBER(18,0)
, Plan_CD VARCHAR2(2)
, County NUMBER(3,0)
, Contract VARCHAR2(9)
, Status VARCHAR2(100)
, CAT NUMBER(18,0)
, COV CHAR(1)
, TP NUMBER(5,0)
, Pure_Rate NUMBER(18,2)
, Admin_Rate NUMBER(18,2)
, From_dt DATE
, To_dt DATE
, sas_nh_spw_ID NUMBER(18,0)
, Clnt NUMBER
, YYYYMM NUMBER(6,0)
, NH NUMBER(5,0)
, NHBegin DATE
, NHEnd DATE
, NHFirst VARCHAR2(3)
, NHGap VARCHAR2(3)
, NHLast VARCHAR2(3)
, SPW NUMBER(18,0)
, SPWBegin VARCHAR2(15)
, SPWEnd VARCHAR2(15)
, SPWFirst VARCHAR2(3)
, SPWGap VARCHAR2(3)
, SPWLast VARCHAR2(3)
, filename varchar2(100)
, file_rownumber NUMBER(18,0)
, STG_EXTRACT_DATE date
, STG_last_update_date date
)
tablespace MAXDAT_DATA  ;

grant all on nf_clnt_stg to maxdat_read_only;

CREATE SEQUENCE  SEQ_NF_CLNT_STG;

	alter session set plsql_code_type = native;

create or replace trigger TRG_BIU_NF_CLNT_STG
before insert or update on NF_CLNT_STG
for each row
begin
  if inserting then
    if :new.NF_CLNT_STG_ID is null then
      :new.NF_CLNT_STG_ID := SEQ_NF_CLNT_STG.nextval;
    end if;
    if :new.STG_EXTRACT_DATE is null then
      :new.STG_EXTRACT_DATE  := sysdate;
    end if;
  end if;
  :new.STG_LAST_UPDATE_DATE := sysdate;
end;
/

alter session set plsql_code_type = interpreted;
