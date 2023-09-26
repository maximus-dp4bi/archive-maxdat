-- NYHIX-35000
-- Drop semantic view
declare  c int;
begin
    select count(*) into c from user_views where view_name ='F_MFD_RECEIVED_COUNTS_SV';
    if c = 1 then
       execute immediate 'drop view F_MFD_RECEIVED_COUNTS_SV cascade constraints';
    end if;
end;
/

Create or replace view F_MFD_RECEIVED_COUNTS_SV as
Select F_RECEIVED_COUNTS_ID,
NYHIX_MFD_BI_ID,
RECEIVED_DATE,
RECEIVED_COUNT,
create_date,
created_by,
update_date,
updated_by
From F_MFD_RECEIVED_COUNTS with read only;

Grant select on F_MFD_RECEIVED_COUNTS_SV to MAXDAT_READ_ONLY;
