-- add skillsetid column to landing table for ACD agents
alter table cc_s_tmp_avy_agent
add (SKILLSETID number(16));

insert into cc_l_patch_log (PATCH_VERSION, SCRIPT_SEQUENCE, SCRIPT_NAME)
values ('0.3.1',114,'114_ADD_SKILLSETID_TO_TMP_AVY_AGENT');
commit;