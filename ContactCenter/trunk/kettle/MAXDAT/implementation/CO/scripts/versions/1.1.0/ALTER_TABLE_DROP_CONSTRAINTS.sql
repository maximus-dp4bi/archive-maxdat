ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018748;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018749;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018750;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018751;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018752;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018753;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018754;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018755;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018756;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018757;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018758;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018759;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018760;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018761;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018762;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018763;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018764;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018765;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018766;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018767;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018768;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018769;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018770;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018771;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018772;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018773;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018774;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018775;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018776;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018777;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018778;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018779;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018780;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018781;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018782;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018783;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018784;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018785;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018786;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018787;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018788;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018789;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018790;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018791;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018792;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018793;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018794;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018795;
ALTER TABLE CC_S_TMP_AVY_ECSRSTAT DROP CONSTRAINT SYS_C0018796;


update cc_a_adhoc_job set job_start_date=null, job_end_date=null, is_pending=1 where adhoc_job_id in (30,31,32,33,34);
commit;