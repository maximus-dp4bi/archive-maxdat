create table SQID_TASK_HIST_STG_TEMP
(
  task_id                      NUMBER,
  source_task_id               NUMBER,
  dcn                          VARCHAR2(50),
  document_id                  NUMBER,
  doc_type_cd                  VARCHAR2(255),
  doc_status_cd                VARCHAR2(50),
  channel                      VARCHAR2(50),
  task_status                  VARCHAR2(50),
  task_priority                VARCHAR2(50),
  task_type                    VARCHAR2(100),
  start_date                   DATE,
  end_date                     DATE,
  status_date                  DATE,
  release_date                 DATE,
  received_date                DATE,
  owner_name                   VARCHAR2(50),
  case_id                      VARCHAR2(50),
  execution_id                 VARCHAR2(100),
  create_date                  DATE,
  created_by                   VARCHAR2(50),
  update_date                  DATE,
  updated_by                   VARCHAR2(50),
  in_process                   VARCHAR2(1) default 'Y',
  stg_extraction_complete_date DATE,
  stg_last_update_date         DATE default sysdate
)
tablespace MAXDAT_DATA;

INSERT INTO SQID_TASK_HIST_STG_TEMP 
SELECT * FROM SQID_TASK_HIST_STG;

COMMIT;

DROP TABLE SQID_TASK_HIST_STG;

ALTER TABLE SQID_TASK_HIST_STG_TEMP RENAME TO SQID_TASK_HIST_STG;

CREATE INDEX IDX_SQID_SOURCE_TASK_ID ON SQID_TASK_HIST_STG (SOURCE_TASK_ID) TABLESPACE  MAXDAT_INDX ;
CREATE INDEX IDX_SQID_TASK_ID ON SQID_TASK_HIST_STG (TASK_ID) TABLESPACE  MAXDAT_INDX ;