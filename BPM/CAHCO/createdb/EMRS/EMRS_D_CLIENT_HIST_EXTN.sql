CREATE SEQUENCE  "EMRS_SEQ_CLNT_HIST_EXTN_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 5 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_CLNT_HIST_EXTN_ID" TO "MAXDAT_READ_ONLY";

 Create table EMRS_D_CLIENT_HIST_EXTN ( 
  dp_client_extn_id                    NUMBER not null,
  case_number                          NUMBER,
  client_number                        NUMBER,
  extendeddefaultpathtriggerdate       DATE,
  aidcodemandatoryexpirationdate       DATE,
  cmceligibilitydefaultpathresetdate   DATE,
  mltsseligibilitydefaultpathresetdate DATE,
  denbbmaildate                        DATE,
  medbbmaildate                        DATE,
  medrlmaildate                        DATE,
  denrlmaildate                        DATE,
  ialettersentdate                     DATE,
  idlettersentdate                     DATE,
  dialettersentdate                    DATE,
  didlettersenddate                    DATE,
  didlettersentdate                    DATE,
  mcalmvltrsentdate                    DATE,
  dtlmvltrsentdate                     DATE,
  firstspecialdlmaildate               DATE,
  secspecialdlmaildate                 DATE,
  thirdspecialdlmaildate               DATE,
  ondisenrlpath                        VARCHAR2(1),
  medicalbbasent                       VARCHAR2(1),
  dentalbbasent                        VARCHAR2(1),
  dexemplettersenddate                 DATE,
  mexemptlettersenddate                DATE,
  campaigncompleted                    VARCHAR2(1),
  mincompletesentdate                  DATE,
  incompletechoiceformcounter          VARCHAR2(1),
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

ALTER TABLE "EMRS_D_CLIENT_HIST_EXTN" ADD CONSTRAINT "EXTN_CLIENT_ID_PK" PRIMARY KEY ("DP_CLIENT_EXTN_ID") USING INDEX TABLESPACE "MAXDAT_INDX"  ENABLE;
CREATE INDEX EXTNHIST_CLNT_ENDDT_IDX  ON EMRS_D_CLIENT_HIST_EXTN("CLIENT_NUMBER", "RECORD_END_DATE") TABLESPACE "MAXDAT_INDX";  
  
grant select, insert, update on MAXDAT.EMRS_D_CLIENT_HIST_EXTN to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on MAXDAT.EMRS_D_CLIENT_HIST_EXTN to MAXDAT_OLTP_SIUD;
grant select on MAXDAT.EMRS_D_CLIENT_HIST_EXTN to MAXDAT_READ_ONLY;  

CREATE OR REPLACE TRIGGER MAXDAT."BUIR_CLIENT_HIST_EXTN"
 BEFORE INSERT OR UPDATE
 ON EMRS_D_CLIENT_HIST_EXTN
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_CLIENT_HIST_EXTN.dp_client_extn_id%TYPE;
BEGIN
  IF INSERTING THEN
    IF :NEW.dp_client_extn_id IS NULL THEN
      SElECT EMRS_SEQ_CLNT_HIST_EXTN_ID.NEXTVAL
      INTO v_seq_id
      FROM dual;
      :NEW.dp_client_extn_id   := v_seq_id;
    END IF;

    :NEW.created_by := user;
    :NEW.date_created := sysdate;
    
    Insert into Client_Process ( Code, Client_Number, PK_ID, Modified_On)
    values ('EXTN',:New.Client_Number, v_seq_id, :New.DateLastModified );    
    
  END IF;

  :NEW.updated_by := user;
  :NEW.date_updated := sysdate;

END BUIR_CLIENT_HIST_EXTN;
/
