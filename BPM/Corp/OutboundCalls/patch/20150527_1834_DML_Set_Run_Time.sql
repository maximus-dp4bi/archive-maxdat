/*
Created on 27-Apr-2015 by Raj A.
Project: ILEB
Process: Outbound Calls

Description:
This script sets the Start and End times for the Outbound Calls process.
*/
declare
vStart varchar2(50) := '16:00:00';
vEnd   varchar2(50) := '21:00:00';

begin
   
   update corp_etl_control
   set value = vStart,
   updated_ts = sysdate
   where name = 'OUTBOUNDCALL_DAILY_START';

   update corp_etl_control
   set value = vEnd,
   updated_ts = sysdate
   where name='OUTBOUNDCALL_DAILY_END';

commit;

end;