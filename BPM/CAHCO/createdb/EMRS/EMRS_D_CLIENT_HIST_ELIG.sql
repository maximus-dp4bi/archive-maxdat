CREATE SEQUENCE  "EMRS_SEQ_CLNT_HIST_ELIG_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 5 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_CLNT_HIST_ELIG_ID" TO "MAXDAT_READ_ONLY";

 Create table EMRS_D_CLIENT_HIST_ELIG ( 
  dp_client_elig_id                    NUMBER not null,
  case_number                          NUMBER,
  client_number                        NUMBER,
  cin                                  VARCHAR2(9),
  addressokflag                        VARCHAR2(1),
  aidcode                              VARCHAR2(2),
  aliencode                            VARCHAR2(1),
  assigninthiscounty                   VARCHAR2(1),
  dob                                  DATE,
  hcoclosedate                         DATE,
  othhealthcoveragecode                VARCHAR2(1),
  oldmedicalstatus                     VARCHAR2(1),
  olddentalstaus                       VARCHAR2(1),
  firstname                            VARCHAR2(20),
  middleinitial                        VARCHAR2(1),
  lastname                             VARCHAR2(20),
  sex		                       VARCHAR2(1),
  eligibilityworkernum                 VARCHAR2(4),
  ethniccode                           VARCHAR2(1),
  participantlang                      VARCHAR2(1),
  writtenlangcode                      VARCHAR2(1),
  mcalplnmedsstatus                    VARCHAR2(2),
  dtlmedshcpstatus                     VARCHAR2(2),
  medicalid                            VARCHAR2(14),
  mandatorvolunstatus                  VARCHAR2(1),
  mandatorycounty                      VARCHAR2(1),
  denvolstatus                         VARCHAR2(1),
  maximusstatus                        VARCHAR2(1),
  isdualeligible                       VARCHAR2(1),
  isgrandfatherdlelig                  VARCHAR2(1),
  grandfatherdleligplan                VARCHAR2(3),
  alowedplanfordlelig                  VARCHAR2(3),
  medsfilecreationdate                 DATE,
  transmitdate                         DATE,
  pregnancyduedate                     DATE,
  exemptedbydr                         VARCHAR2(1),
  medicalexemption                     VARCHAR2(1),
  exemptionenddate                     DATE,
  dentalexemption                      VARCHAR2(1),
  dentalexempenddate                   DATE,
  ccsindicator                         VARCHAR2(1),
  icfindicator                         VARCHAR2(1),
  medicarecarriercode                  VARCHAR2(4),
  medicareindicator                    VARCHAR2(3),
  isnonmeds                            VARCHAR2(1),
  switchtomeds                         VARCHAR2(1),
  switchtomedsdate                     DATE,
  medicalpktrequested                  VARCHAR2(1),
  mpacketstatus                        VARCHAR2(1),
  dentalpktrequested                   VARCHAR2(1),
  dpacketstatus                        VARCHAR2(1),
  donotbulkemail                       VARCHAR2(1),
  donotbulkpostalmail                  VARCHAR2(1),
  donotemail                           VARCHAR2(1),
  donotfax                             VARCHAR2(1),
  donotphone                           VARCHAR2(1),
  authorizedrepname                    VARCHAR2(40),
  carriertype                          VARCHAR2(3),
  carrier2type                         VARCHAR2(3),
  carrier3type                         VARCHAR2(3),
  cci_status                           VARCHAR2(1),
  cci_maximusoptout                    DATE,
  cci_paceeligible                     VARCHAR2(1),
  cci_mltssstatus                      VARCHAR2(1),
  cci_espdstatus                       VARCHAR2(1),
  cci_ignorelisind                     VARCHAR2(1),
  cci_ohcfmandatory                    VARCHAR2(1),
  defaultpathextension                 VARCHAR2(1),
  defaultpathextensionexemptionid      NUMBER,
  eaflag                               VARCHAR2(1),
  enrlexclind                          VARCHAR2(1),
  esrdind                              VARCHAR2(1),
  expresslanepin                       VARCHAR2(5),
  expresslaneaffirmation               VARCHAR2(1),
  expresslaneparent                    VARCHAR2(1),
  expresslanestatusmedical             VARCHAR2(2),
  expresslanestatusdental              VARCHAR2(2),
  hcpstatusprevious                    VARCHAR2(2),
  hcbshighind                          VARCHAR2(1),
  hicn                                 VARCHAR2(15),
  institutionalind                     VARCHAR2(1),
  lisind                               VARCHAR2(1),
  mceligstat                           VARCHAR2(3),
  medicarecarrier2code                 VARCHAR2(4),
  medicarecarrier3code                 VARCHAR2(4),
  medicarestatusparta                  VARCHAR2(1),
  medicarestatuspartb                  VARCHAR2(1),
  medicarestatuspartd                  VARCHAR2(1),
  optoutind                            VARCHAR2(1),
  passiveenrollment                    VARCHAR2(1),
  sinsiind                             VARCHAR2(1),
  socamt                               VARCHAR2(5),
  subplanind                           VARCHAR2(1),
  spdstatus	                       VARCHAR2(1),
  recordcreatedate                     DATE,
  recordcreatename                     VARCHAR2(50),
  datelastmodified                     DATE,
  namelastmodified                     VARCHAR2(50),
  record_start_Date              DATE,
  record_end_Date                DATE,
  current_flag                   VARCHAR2(1) default 'Y',
  created_by                     VARCHAR2(20),
  date_created                   DATE,
  updated_by                     VARCHAR2(20),
  date_updated                   DATE ) TABLESPACE MAXDAT_DATA ;

ALTER TABLE "EMRS_D_CLIENT_HIST_ELIG" ADD CONSTRAINT "ELIG_CLIENT_ID_PK" PRIMARY KEY ("DP_CLIENT_ELIG_ID") USING INDEX TABLESPACE "MAXDAT_INDX"  ENABLE;
CREATE INDEX ELIGHIST_CLNT_ENDDT_IDX  ON EMRS_D_CLIENT_HIST_ELIG("CLIENT_NUMBER", "RECORD_END_DATE") TABLESPACE "MAXDAT_INDX";  

grant select, insert, update on MAXDAT.EMRS_D_CLIENT_HIST_ELIG to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on MAXDAT.EMRS_D_CLIENT_HIST_ELIG to MAXDAT_OLTP_SIUD;
grant select on MAXDAT.EMRS_D_CLIENT_HIST_ELIG to MAXDAT_READ_ONLY;  

CREATE TABLE MAXDAT.CLIENT_PROCESS (
CODE VARCHAR2(10),
CLIENT_NUMBER NUMBER,
PK_ID NUMBER,
MODIFIED_ON DATE);


  create index CLNTPROCESS_CLNT_IDX on CLIENT_PROCESS (CODE, CLIENT_NUMBER, PK_ID)
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


grant select, insert, update on MAXDAT.CLIENT_PROCESS to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on MAXDAT.CLIENT_PROCESS to MAXDAT_OLTP_SIUD;
grant select on MAXDAT.CLIENT_PROCESS to MAXDAT_READ_ONLY; 

CREATE OR REPLACE TRIGGER MAXDAT."BUIR_CLIENT_HIST_ELIG"
 BEFORE INSERT OR UPDATE
 ON EMRS_D_CLIENT_HIST_ELIG
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_CLIENT_HIST_ELIG.dp_client_elig_id%TYPE;
BEGIN
  IF INSERTING THEN
    IF :NEW.dp_client_elig_id IS NULL THEN
      SElECT EMRS_SEQ_CLNT_HIST_ELIG_ID.NEXTVAL
      INTO v_seq_id
      FROM dual;
      :NEW.dp_client_elig_id   := v_seq_id;
    END IF;

    :NEW.created_by := user;
    :NEW.date_created := sysdate;
    
    Insert into Client_Process ( Code, Client_Number, PK_ID, Modified_On)
    values ('ELIG',:New.Client_Number, v_seq_id, :New.DateLastModified );
    
  END IF;

  :NEW.updated_by := user;
  :NEW.date_updated := sysdate;

END BUIR_CLIENT_HIST_ELIG;
 /

  
