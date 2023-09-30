CREATE TABLE HCO_F_RESEARCH
(
  Research_Track_id NUMBER
, ControlNum Varchar2(20)
, DateReqUnitLetter Varchar2(20)
, DateRecdLoginBy date
, Benes Number
, BeneLastName  Varchar2(20)
, BeneFirstName  Varchar2(20)
, CIN  Varchar2(10)
, CountyCode  Varchar2(2)
, Reason  Varchar2(200)
, Findings  Varchar2(500)
, ActionTaken  Varchar2(200)
, DateClose date
, IsValid Varchar2(1)
, RequestType  Varchar2(2)
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

grant select, insert, update on HCO_F_RESEARCH to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on HCO_F_RESEARCH to MAXDAT_OLTP_SIUD;
grant select on HCO_F_RESEARCH to MAXDAT_READ_ONLY;

CREATE OR REPLACE VIEW MAXDAT.HCO_F_RESEARCH_BY_DATE_SV AS
SELECT D_date as REFERRAL_DATE
     , ( Select count(1) from HCO_F_RESEARCH referred Where d_date = trunc(referred.daterecdloginby)) as ISSUES_REFERRED
     , ( Select count(1) from HCO_F_RESEARCH general Where d_date = trunc(general.daterecdloginby) and general.RequestType = 1) as ISSUES_GENERAL
     , ( Select count(1) from HCO_F_RESEARCH mer Where d_date = trunc(mer.daterecdloginby) and mer.RequestType = 2) as ISSUES_MER
     , ( Select count(1) from HCO_F_RESEARCH eder Where d_date = trunc(eder.daterecdloginby) and eder.RequestType = 3 ) as ISSUES_EDER
     , ( Select count(1) from HCO_F_RESEARCH other Where d_date = trunc(other.daterecdloginby) and other.RequestType = 4) as ISSUES_OTHER
     , ( Select count(1) from HCO_F_RESEARCH closed Where d_date = trunc(closed.dateclose)) as ISSUES_CLOSED     
  FROM MAXDAT.BPM_D_DATES B 
WITH READ ONLY;  

GRANT SELECT ON MAXDAT.HCO_F_RESEARCH_BY_DATE_SV TO MAXDAT_READ_ONLY;


  
