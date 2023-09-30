--state_review_stg
alter table state_review_stg
drop constraint STATE_REVIEW_STG_C12;

alter table state_review_stg
add constraint STATE_REVIEW_STG_C12
check (INSTANCE_STATUS in ('Active','Complete'));

--STATE_REVIEW_STG_TMP
alter table STATE_REVIEW_STG_TMP
drop constraint STATE_REVIEW_STG_TMP_C12;

alter table STATE_REVIEW_STG_TMP
add constraint STATE_REVIEW_STG_TMP_C12
check (INSTANCE_STATUS in ('Active','Complete'));

--NYEC_ETL_STATE_REVIEW
alter table NYEC_ETL_STATE_REVIEW
drop constraint NYEC_ETL_STATE_REVIEW_C12;

alter table NYEC_ETL_STATE_REVIEW
add constraint NYEC_ETL_STATE_REVIEW_C12
check (INSTANCE_STATUS in ('Active','Complete'));