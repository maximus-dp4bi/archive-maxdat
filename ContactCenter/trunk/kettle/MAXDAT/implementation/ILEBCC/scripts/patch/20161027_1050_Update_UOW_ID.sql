/*
Created on 10/27/2016 by Raj A.
Project: MI MSS.
Description: Per Steven, fixing UOW_ID to 161 and doing a data fix for the files loaded in UAT and PRD.
*/
update MAXDAT_CC.cc_c_ivr_dnis
   set uow_id = 161
 where destination_dnis = 4060;
 
update MAXDAT_CC.CC_F_ACTUALS_IVR_INTERVAL
  set D_UNIT_OF_WORK_ID = 161
 where D_UNIT_OF_WORK_ID = 201; 

update MAXDAT_CC.cc_f_ivr_self_service_usage
  set D_UNIT_OF_WORK_ID = 161
 where D_UNIT_OF_WORK_ID = 201;
 commit;