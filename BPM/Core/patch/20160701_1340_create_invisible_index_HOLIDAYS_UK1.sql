alter table HOLIDAYS drop constraint HOLIDAYS_UK1;

alter table HOLIDAYS add constraint HOLIDAYS_UK1 unique (HOLIDAY_DATE) 
using index tablespace MAXDAT_INDX;

alter index HOLIDAYS_UK1 invisible;
