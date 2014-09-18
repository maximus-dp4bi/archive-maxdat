alter table DOCUMENT_STG drop constraint DCN_PK;
alter table DOCUMENT_STG drop constraint SYS_C0020458;
alter table DOCUMENT_STG drop constraint SYS_C0020459;


alter table DOCUMENT_STG add constraint DOCUMENT_ID_PK primary key (DOCUMENT_ID);
alter table DOCUMENT_STG add constraint DCN_UK unique (DCN);