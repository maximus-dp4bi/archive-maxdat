drop index LETTER_FLEX_ID_IDX;

alter table D_PL_LETTER_SUBTYPE add constraint DPLLST_PK primary key (LETTER_FLEX_ID) using index tablespace MAXDAT_INDX;
