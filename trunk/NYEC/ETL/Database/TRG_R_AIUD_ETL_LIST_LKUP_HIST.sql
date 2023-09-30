CREATE OR REPLACE TRIGGER MAXDAT.TRG_R_AIUD_ETL_LIST_LKUP_HIST
AFTER INSERT OR UPDATE OR DELETE
 ON CORP_ETL_LIST_LKUP
 FOR EACH ROW
Begin
        If Inserting Then
          insert into CORP_ETL_LIST_LKUP_HIST VALUES
          (CELL_HISTORY_SEQ.nextval,--"CELL_HISTORY_ID" NUMBER NOT NULL ENABLE,
           'INSERT',--"HIST_TYPE" VARCHAR2(100),
           :new.cell_id,--"CELL_ID" NUMBER NOT NULL ENABLE, 
           :new.name,--"NAME" VARCHAR2(30) NOT NULL ENABLE, 
           :new.LIST_TYPE,--"LIST_TYPE" VARCHAR2(30) NOT NULL ENABLE, 
           :new.VALUE,--"VALUE" VARCHAR2(100) NOT NULL ENABLE, 
           :new.OUT_VAR,--"OUT_VAR" VARCHAR2(100), 
           :new.REF_TYPE,--"REF_TYPE" VARCHAR2(100), 
           :new.REF_ID,--"REF_ID" NUMBER(38,0), 
           :new.START_DATE,--"START_DATE" DATE, 
           :new.END_DATE,--"END_DATE" DATE, 
           :new.COMMENTS,--"COMMENTS" VARCHAR2(4000), 
           :new.CREATED_TS,--"CREATED_TS" DATE NOT NULL ENABLE, 
           :new.UPDATED_TS,--"UPDATED_TS" DATE NOT NULL ENABLE,
           sysdate,--"HIST_CREATED_TS" DATE NOT NULL ENABLE, 
           user,   --HIST_USER
           sysdate--"HIST_UPDATED_TS" DATE NOT NULL ENABLE,
           );
        End If;
        If Updating Then
          insert into CORP_ETL_LIST_LKUP_HIST VALUES
          (CELL_HISTORY_SEQ.nextval,--"CELL_HISTORY_ID" NUMBER NOT NULL ENABLE,
           'UPDATE',--"HIST_TYPE" VARCHAR2(100),
           :old.cell_id,--"CELL_ID" NUMBER NOT NULL ENABLE, 
           :old.name,--"NAME" VARCHAR2(30) NOT NULL ENABLE, 
           :old.LIST_TYPE,--"LIST_TYPE" VARCHAR2(30) NOT NULL ENABLE, 
           :old.VALUE,--"VALUE" VARCHAR2(100) NOT NULL ENABLE, 
           :old.OUT_VAR,--"OUT_VAR" VARCHAR2(100), 
           :old.REF_TYPE,--"REF_TYPE" VARCHAR2(100), 
           :old.REF_ID,--"REF_ID" NUMBER(38,0), 
           :old.START_DATE,--"START_DATE" DATE, 
           :old.END_DATE,--"END_DATE" DATE, 
           :old.COMMENTS,--"COMMENTS" VARCHAR2(4000), 
           :old.CREATED_TS,--"CREATED_TS" DATE NOT NULL ENABLE, 
           :old.UPDATED_TS,--"UPDATED_TS" DATE NOT NULL ENABLE,
           sysdate,--"HIST_CREATED_TS" DATE NOT NULL ENABLE, 
           user,   --HIST_USER
           sysdate--"HIST_UPDATED_TS" DATE NOT NULL ENABLE,
           );          
        End If;
        If Deleting Then
          insert into CORP_ETL_LIST_LKUP_HIST VALUES
          (CELL_HISTORY_SEQ.nextval,--"CELL_HISTORY_ID" NUMBER NOT NULL ENABLE,
           'DELETE',--"HIST_TYPE" VARCHAR2(100),
           :old.cell_id,--"CELL_ID" NUMBER NOT NULL ENABLE, 
           :old.name,--"NAME" VARCHAR2(30) NOT NULL ENABLE, 
           :old.LIST_TYPE,--"LIST_TYPE" VARCHAR2(30) NOT NULL ENABLE, 
           :old.VALUE,--"VALUE" VARCHAR2(100) NOT NULL ENABLE, 
           :old.OUT_VAR,--"OUT_VAR" VARCHAR2(100), 
           :old.REF_TYPE,--"REF_TYPE" VARCHAR2(100), 
           :old.REF_ID,--"REF_ID" NUMBER(38,0), 
           :old.START_DATE,--"START_DATE" DATE, 
           :old.END_DATE,--"END_DATE" DATE, 
           :old.COMMENTS,--"COMMENTS" VARCHAR2(4000), 
           :old.CREATED_TS,--"CREATED_TS" DATE NOT NULL ENABLE, 
           :old.UPDATED_TS,--"UPDATED_TS" DATE NOT NULL ENABLE,
           sysdate,--"HIST_CREATED_TS" DATE NOT NULL ENABLE, 
           user,   --HIST_USER
           sysdate--"HIST_UPDATED_TS" DATE NOT NULL ENABLE,
           );          
        End If;
  End;
/          
  
