CREATE SEQUENCE  "EMRS_SEQ_CLNT_HIST_ENRL_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 5 NOORDER  NOCYCLE ;

GRANT SELECT ON "EMRS_SEQ_CLNT_HIST_ENRL_ID" TO "MAXDAT_READ_ONLY";

 Create table EMRS_D_CLIENT_HIST_ENRL ( 
  dp_client_enrl_id                    NUMBER not null,
  case_number                          NUMBER,
  client_number                        NUMBER,
  enrollmentstatus                     VARCHAR2(1),
  sendidltrdate                        DATE,
  importdate                           DATE,
  countychangercvddate                 DATE,
  triggerforvolunmails                 DATE,
  planoflasttrans                      VARCHAR2(3),
  lasttransdate                        DATE,
  lasttransrcvdid                      NUMBER,
  lasttransenrordisenr                 VARCHAR2(1),
  lasttransaccepted                    VARCHAR2(1),
  lastmedenrlrecid                     NUMBER,
  lastdisenrlrecid                     NUMBER,
  lastdisenroldate                     DATE,
  lastdisenrlaccepted                  VARCHAR2(1),
  lastplanid                           VARCHAR2(3),
  lastenrlopenplanid                   NUMBER,
  lastplanactivateddate                DATE,
  lastmcalffstrans                     NUMBER,
  dtllasttransid                       NUMBER,
  dtllastopentrans                     NUMBER,
  dtlenrlstatus                        VARCHAR2(1),
  lastdentalenrleffdate                DATE,
  dentalplanactive                     VARCHAR2(3),
  lastdtltranseord                     VARCHAR2(1),
  planoflastdtltrans                   VARCHAR2(3),
  lastdtlffstrans                      NUMBER,
  gmccombinedchoice                    VARCHAR2(3),
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

ALTER TABLE "EMRS_D_CLIENT_HIST_ENRL" ADD CONSTRAINT "ENRL_CLIENT_ID_PK" PRIMARY KEY ("DP_CLIENT_ENRL_ID") USING INDEX TABLESPACE "MAXDAT_INDX"  ENABLE;
CREATE INDEX ENRLHIST_CLNT_ENDDT_IDX  ON EMRS_D_CLIENT_HIST_ENRL("CLIENT_NUMBER", "RECORD_END_DATE") TABLESPACE "MAXDAT_INDX";    
CREATE INDEX ENRLHIST_CLNT_ENDDT_IDX02  ON EMRS_D_CLIENT_HIST_ENRL(lasttransenrordisenr) TABLESPACE "MAXDAT_INDX";    
CREATE INDEX ENRLHIST_CLNT_ENDDT_IDX03  ON EMRS_D_CLIENT_HIST_ENRL(enrollmentstatus) TABLESPACE "MAXDAT_INDX";    
CREATE INDEX ENRLHIST_CLNT_ENDDT_IDX04  ON EMRS_D_CLIENT_HIST_ENRL(record_start_date,record_end_date) TABLESPACE "MAXDAT_INDX";  
  
grant select, insert, update on MAXDAT.EMRS_D_CLIENT_HIST_ENRL to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on MAXDAT.EMRS_D_CLIENT_HIST_ENRL to MAXDAT_OLTP_SIUD;
grant select on MAXDAT.EMRS_D_CLIENT_HIST_ENRL to MAXDAT_READ_ONLY;    

CREATE OR REPLACE TRIGGER MAXDAT."BUIR_CLIENT_HIST_ENRL"
 BEFORE INSERT OR UPDATE
 ON EMRS_D_CLIENT_HIST_ENRL
 FOR EACH ROW
DECLARE
    v_seq_id     EMRS_D_CLIENT_HIST_ENRL.dp_client_enrl_id%TYPE;
BEGIN
  IF INSERTING THEN
    IF :NEW.dp_client_enrl_id IS NULL THEN
      SElECT EMRS_SEQ_CLNT_HIST_ENRL_ID.NEXTVAL
      INTO v_seq_id
      FROM dual;
      :NEW.dp_client_enrl_id   := v_seq_id;
    END IF;

    :NEW.created_by := user;
    :NEW.date_created := sysdate;

    Insert into Client_Process ( Code, Client_Number, PK_ID, Modified_On)
    values ('ENRL',:New.Client_Number, v_seq_id, :New.DateLastModified );
    
  END IF;

  :NEW.updated_by := user;
  :NEW.date_updated := sysdate;

END BUIR_CLIENT_HIST_ENRL;
/
