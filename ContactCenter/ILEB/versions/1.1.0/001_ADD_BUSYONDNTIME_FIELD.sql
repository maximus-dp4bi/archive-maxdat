-- add BUSYONDNTIME column to CC_S_ACD_AGENT_ACTIVITY and CC_F_AGENT_BY_DATE tables
alter table cc_s_acd_agent_activity
add BUSYONDNTIME number(10,2);

alter table cc_f_agent_by_date
add BUSYONDNTIME number(10,2);

insert into cc_l_patch_log (PATCH_VERSION, SCRIPT_SEQUENCE, SCRIPT_NAME)
values ('1.1.0',001,'001_ADD_BUSYONDNTIME_FIELD');

commit;
