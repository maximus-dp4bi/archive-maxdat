-- Create D_PL_MEDIA_CD in MAXDAT
declare  c int;
begin
   select count(*) into c from user_tables where table_name ='D_PL_MEDIA_CD';
   if c = 1 then
      execute immediate 'drop table D_PL_MEDIA_CD cascade constraints';
   end if;
end;
/

CREATE TABLE D_PL_MEDIA_CD 
(
  LETTER_ID	NUMBER(18,0) not null ,
  MEDIA_CD	VARCHAR2(32 BYTE) not null, 
  CONSTRAINT media_PK primary key
  (
    letter_id, 
    media_cd
  )
enable
)
tablespace MAXDAT_DATA;

grant select on D_PL_MEDIA_CD to MAXDAT_READ_ONLY; 

execute MAXDAT_ADMIN.GATHER_TABLE_STATS('MAXDAT','D_PL_MEDIA_CD',4);

--create view D_PL_MEDIA_CD_SV

CREATE OR REPLACE FORCE VIEW D_PL_MEDIA_CD_SV
(LETTER_ID
,MEDIA_CD
) 
as
select 
letter_id
, media_cd 
from D_PL_MEDIA_CD
WITH READ ONLY;
