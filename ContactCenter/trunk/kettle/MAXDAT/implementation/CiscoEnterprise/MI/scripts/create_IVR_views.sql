/*
Created on 02/18/2016 by Raj A.
Description: Created views for MAXDAT-3041
*/
create or replace view cc_c_ivr_dnis_sv as
select "C_DNIS_UOW_ID","DESTINATION_DNIS","UOW_ID","CREATE_DATE","RECORD_EFF_DATE","RECORD_END_DATE" 
from cc_c_ivr_dnis;

create or replace view cc_c_ivr_call_result_sv as
select "C_IVR_CALL_RES_ID","COMPLETION_CODE","COUNT_CREATED","COUNT_OFFERED_TO_ACD","COUNT_CONTAINED","CREATE_DATE","RECORD_EFF_DATE","RECORD_END_DATE" 
from cc_c_ivr_call_result;

grant select on CISCO_ENTERPRISE_CC.cc_c_ivr_dnis_sv to maxdat_read_only;
grant select on CISCO_ENTERPRISE_CC.cc_c_ivr_call_result_sv to maxdat_read_only;