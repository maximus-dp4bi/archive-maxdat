/*
Created on 09-Jul-2014 by Raj A.
Project: ILEB
Process: Outbound Calls

Description:
This script sets the Start and End times for the Outbound Calls process.
*/
declare
vStart varchar2(50) := '1600';
vEnd   varchar2(50) := '2100';

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