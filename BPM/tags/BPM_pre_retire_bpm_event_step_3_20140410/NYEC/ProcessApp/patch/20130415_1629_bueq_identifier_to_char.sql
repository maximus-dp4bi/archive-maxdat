update BPM_INSTANCE
set IDENTIFIER = to_char(to_number(IDENTIFIER)/10) || '_0'
where BEM_ID = 2;

commit;


alter table BPM_UPDATE_EVENT_QUEUE add (IDENTIFIER_CHAR varchar2(35));

update BPM_UPDATE_EVENT_QUEUE 
set IDENTIFIER_CHAR = to_char(to_number(IDENTIFIER)/10) || '_0'
where BSL_ID = 2;

commit;

update BPM_UPDATE_EVENT_QUEUE
set IDENTIFIER_CHAR = to_char(IDENTIFIER)
where BSL_ID != 2;

commit;

alter table BPM_UPDATE_EVENT_QUEUE drop (IDENTIFIER);
alter table BPM_UPDATE_EVENT_QUEUE rename column IDENTIFIER_CHAR to IDENTIFIER;
alter table BPM_UPDATE_EVENT_QUEUE modify (IDENTIFIER not null);
create index BUEQ_LX3 on BPM_UPDATE_EVENT_QUEUE (IDENTIFIER) local online tablespace MAXDAT_INDX parallel compute statistics;

alter table BPM_UPDATE_EVENT_QUEUE_ARCHIVE add (IDENTIFIER_CHAR varchar2(35));

update BPM_UPDATE_EVENT_QUEUE_ARCHIVE 
set IDENTIFIER_CHAR = to_char(to_number(IDENTIFIER)/10) || '_0'
where BSL_ID = 2;

commit;

update BPM_UPDATE_EVENT_QUEUE_ARCHIVE 
set IDENTIFIER_CHAR = to_char(IDENTIFIER)
where BSL_ID != 2;

commit;

alter table BPM_UPDATE_EVENT_QUEUE_ARCHIVE drop (IDENTIFIER);
alter table BPM_UPDATE_EVENT_QUEUE_ARCHIVE rename column IDENTIFIER_CHAR to IDENTIFIER;
alter table BPM_UPDATE_EVENT_QUEUE_ARCHIVE modify (IDENTIFIER not null);