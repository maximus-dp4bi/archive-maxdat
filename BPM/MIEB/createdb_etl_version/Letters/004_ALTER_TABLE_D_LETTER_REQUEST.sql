alter table d_letter_request add 
(
  EYR_job_ctrl_id         NUMBER(18) ,
  EYR_row_num             NUMBER(18) ,
  EYR_filename            VARCHAR2(1000),
  EYR_source_system       VARCHAR2(32),
  EYR_source_filename     VARCHAR2(200),
  EYR_record_number       VARCHAR2(200),
  EYR_letter_type         VARCHAR2(100),
  EYR_printed_date        VARCHAR2(20),
  EYR_mailed_date         VARCHAR2(20)
);

