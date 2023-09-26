alter session set current_schema = MAXDAT;

alter index BUEQ_PK parallel 2;
alter index BUEQ_IX1 parallel 2;
alter index BUEQ_IX2 parallel 2;
alter index BUEQ_IX3 parallel 2;
alter index BUEQ_IX4 parallel 2;
