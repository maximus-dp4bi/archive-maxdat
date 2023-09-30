---- DDL for NYHIX-32682 

CREATE TABLE MAXDAT.D_PL_QC_COMPLETED
(
  LETTER_REQUEST_ID NUMBER(18,0) NOT NULL 
, QC_CREATE_TS      DATE    
, LAST_UPDATE_TS    DATE    
, QC_CHANGE_ID      NUMBER 
, QC_FLAG           NUMBER(1,0)
, QC_COMPLETE_TS    DATE
, QC_STAFF          VARCHAR2(32)
, QC_CHANGES        NUMBER(18,0)
);

create unique index maxdat.DPL_QC_COMPLETED_NDX on MAXDAT.D_PL_QC_COMPLETED (LETTER_REQUEST_ID) tablespace maxdat_indx;
grant select on MAXDAT.D_PL_QC_COMPLETED to MAXDAT_READ_ONLY;

CREATE OR REPLACE VIEW MAXDAT.D_PL_QC_COMPLETED_SV AS
Select LETTER_REQUEST_ID, QC_CREATE_TS, LAST_UPDATE_TS, QC_CHANGE_ID,QC_FLAG, QC_COMPLETE_TS,QC_STAFF,QC_CHANGES
From MAXDAT.D_PL_QC_COMPLETED;
      


