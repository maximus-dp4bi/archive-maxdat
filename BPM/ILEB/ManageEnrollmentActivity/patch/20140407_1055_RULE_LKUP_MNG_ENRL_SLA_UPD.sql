--select * from RULE_LKUP_MNG_ENRL_SLA;
update RULE_LKUP_MNG_ENRL_SLA set SLA_DAYS = 10, updated_ts = sysdate where SLA_TYPE = 'FIRST_FOLLOWUP' and newborn_flag = 'Y';
update RULE_LKUP_MNG_ENRL_SLA set SLA_DAYS = 14, updated_ts = sysdate where SLA_TYPE = 'SECOND_FOLLOWUP' and newborn_flag = 'Y';
update RULE_LKUP_MNG_ENRL_SLA set SLA_DAYS = 20, updated_ts = sysdate where SLA_TYPE = 'THIRD_FOLLOWUP' and newborn_flag = 'Y';
update RULE_LKUP_MNG_ENRL_SLA set SLA_DAYS = 30, updated_ts = sysdate where SLA_TYPE = 'FOURTH_FOLLOWUP' and newborn_flag = 'Y';
update RULE_LKUP_MNG_ENRL_SLA set SLA_DAYS = 45, updated_ts = sysdate where SLA_TYPE = 'AUTO_ASSIGNMENT' and newborn_flag = 'Y';
update RULE_LKUP_MNG_ENRL_SLA set SLA_DAYS = 10, updated_ts = sysdate where SLA_TYPE = 'FIRST_FOLLOWUP' and newborn_flag = 'N';
update RULE_LKUP_MNG_ENRL_SLA set SLA_DAYS = 14, updated_ts = sysdate where SLA_TYPE = 'SECOND_FOLLOWUP' and newborn_flag = 'N';
update RULE_LKUP_MNG_ENRL_SLA set SLA_DAYS = 20, updated_ts = sysdate where SLA_TYPE = 'THIRD_FOLLOWUP' and newborn_flag = 'N';
update RULE_LKUP_MNG_ENRL_SLA set SLA_DAYS = 30, updated_ts = sysdate where SLA_TYPE = 'FOURTH_FOLLOWUP' and newborn_flag = 'N';
Commit;
