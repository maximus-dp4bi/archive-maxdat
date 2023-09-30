/*
Created on 29-Apr-2014 by Raj A.
Description:
This script was created in an effort to change the subprogram_type calculation and also to include the followup_type_code as a creation attribute.
*/
truncate table RULE_LKUP_MNG_ENRL_FOLLOWUP;

alter table RULE_LKUP_MNG_ENRL_FOLLOWUP add subprogram_type varchar2(32);

alter table RULE_LKUP_MNG_ENRL_FOLLOWUP
drop constraint Mng_Enrl_FU_UNQ;

alter table Rule_lkup_mng_enrl_followup
add constraint Mng_Enrl_FU_UNQ unique (followup_type_code, plan_type, program_type, subprogram_type, start_date); 