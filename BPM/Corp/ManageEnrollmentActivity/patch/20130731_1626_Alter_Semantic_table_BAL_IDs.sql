alter table d_me_current
modify (
first_follow_up_id varchar2(37),
second_follow_up_id varchar2(37)
);

update BPM_ATTRIBUTE_LKUP
  set bdl_id = 2
 where bal_id = 756;
 
update BPM_ATTRIBUTE_LKUP
  set bdl_id = 2
 where bal_id = 760;
 commit;