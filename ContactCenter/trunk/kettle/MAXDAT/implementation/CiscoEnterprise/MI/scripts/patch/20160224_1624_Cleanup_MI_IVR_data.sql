/*
Created by Raj A. on 02/24/2016
Description: MAXDAT-3041 cleanup script. Deleting test data to prepare for loading good data.
*/
DELETE cisco_enterprise_cc.cc_f_ivr_self_service_usage;
DELETE cisco_enterprise_cc.CC_F_Actuals_IVR_Interval;
DELETE cisco_enterprise_cc.cc_d_ivr_self_service_path;
DELETE cisco_enterprise_cc.CC_S_IVR_RESPONSE;
COMMIT;