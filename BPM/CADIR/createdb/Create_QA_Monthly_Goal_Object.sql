-- QA Monthy Goal table 

CREATE TABLE D_QA_MONTHLY_GOAL
(
  MGOAL_ID        NUMBER(10) NOT NULL,
  CHECKSHEET_ID   NUMBER(10),
  MONTHLY_GOAL    NUMBER(10),  
  START_DATE      DATE,
  END_DATE	  DATE,
  CREATED_DATE    DATE,
  CREATED_BY      VARCHAR2(45 CHAR),
  UPDATED_DATE    DATE,
  UPDATED_BY      VARCHAR2(45 CHAR)
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
  
create unique index MGOAL_ID_IX1 on D_QA_MONTHLY_GOAL (MGOAL_ID)
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
  
  
grant select, insert, update, delete on MAXDAT_CADR.D_QA_MONTHLY_GOAL to MAXDAT_OLTP_SIUD;
grant select on MAXDAT_CADR.D_QA_MONTHLY_GOAL to MAXDAT_READ_ONLY;   
  
  
-- Create Semantic Views 

CREATE OR REPLACE VIEW MAXDAT_CADR.D_QA_MONTHLY_GOAL_SV AS SELECT * FROM MAXDAT_CADR.D_QA_MONTHLY_GOAL WITH READ ONLY;

