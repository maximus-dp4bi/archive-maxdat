/*
Created on 07/22/2016 by Raj A.
Description: Created using the original script created by Randall Kolb ( BPM/Core/patch/20160701_1340_create_invisible_index_HOLIDAYS_UK1.sql )
Added dropping index part.
*/
alter table HOLIDAYS drop constraint HOLIDAYS_UK1;
drop INDEX HOLIDAYS_UK1;

alter table HOLIDAYS add constraint HOLIDAYS_UK1 unique (HOLIDAY_DATE) 
using index tablespace MAXDAT_INDX;

alter index HOLIDAYS_UK1 invisible;
