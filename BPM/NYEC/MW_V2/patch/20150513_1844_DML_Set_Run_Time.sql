/*
Created on 13-May-2015 by Raj A.
Project: NYEC
Process: MW V2

Description:
This script sets the Start and End times for the Manage Work V2 process.
*/
declare
vStart varchar2(50) := '09:00:00';
vEnd   varchar2(50) := '22:00:00';

begin
   
   update corp_etl_control
   set value = vStart,
   updated_ts = sysdate
   where name = 'MW_V2_SCHEDULE_START';

   update corp_etl_control
   set value = vEnd,
   updated_ts = sysdate
   where name='MW_V2_SCHEDULE_END';

commit;

end;