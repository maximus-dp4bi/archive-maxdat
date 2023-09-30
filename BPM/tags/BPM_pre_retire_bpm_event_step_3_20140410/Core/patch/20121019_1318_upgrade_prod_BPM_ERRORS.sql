alter table BPM_ERRORS parallel;
alter index BPM_ERRORS_PK rebuild tablespace MAXDAT_INDX parallel;
alter table BPM_ERRORS add (ERROR_MESSAGE_CLOB clob);

update BPM_ERRORS set ERROR_MESSAGE_CLOB = ERROR_MESSAGE;
commit;

alter table BPM_ERRORS drop (ERROR_MESSAGE);
alter table BPM_ERRORS rename column ERROR_MESSAGE_CLOB to ERROR_MESSAGE;

alter table BPM_ERRORS modify (RUN_DATA_OBJECT varchar2(61));
alter table BPM_ERRORS add (BACKTRACE clob);