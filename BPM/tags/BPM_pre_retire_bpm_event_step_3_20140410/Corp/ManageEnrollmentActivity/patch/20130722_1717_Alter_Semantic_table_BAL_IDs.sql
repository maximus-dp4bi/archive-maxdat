alter table d_me_current
modify (
 THIRD_FOLLOW_UP_ID    varchar2(37),     
 FOURTH_FOLLOW_UP_ID   varchar2(37)     
);  

update BPM_ATTRIBUTE_LKUP
  set bdl_id = 2
 where bal_id = 764; 
 
update BPM_ATTRIBUTE_LKUP
  set bdl_id = 2
 where bal_id = 768;
 commit;