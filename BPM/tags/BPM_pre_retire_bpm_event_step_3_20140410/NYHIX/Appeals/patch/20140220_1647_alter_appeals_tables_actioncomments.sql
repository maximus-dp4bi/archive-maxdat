ALTER TABLE NYHBE_PROCESS_APPEALS_WIP_BPM
RENAME COLUMN ACTION_COMMENTS TO ACTION_COMMENT;

ALTER TABLE NYHBE_PROCESS_APPEALS_WIP_BPM
ADD(ACTION_COMMENTS VARCHAR2(4000));

ALTER TABLE NYHBE_PROCESS_APPEALS_WIP_BPM
DROP (ACTION_COMMENT);


ALTER TABLE NYHBE_PROCESS_APPEALS_OLTP
RENAME COLUMN ACTION_COMMENTS TO ACTION_COMMENT;

ALTER TABLE NYHBE_PROCESS_APPEALS_OLTP
ADD(ACTION_COMMENTS VARCHAR2(4000));

ALTER TABLE NYHBE_PROCESS_APPEALS_OLTP
DROP (ACTION_COMMENT);


ALTER TABLE NYHBE_ETL_PROCESS_APPEALS
RENAME COLUMN ACTION_COMMENTS TO ACTION_COMMENT;

ALTER TABLE NYHBE_ETL_PROCESS_APPEALS
ADD(ACTION_COMMENTS VARCHAR2(4000));

ALTER TABLE NYHBE_ETL_PROCESS_APPEALS
DROP (ACTION_COMMENT);