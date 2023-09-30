/*
Created on 12/19/2014 for NYHIX-12475 by Raj A.
Description:
Sequence, seq_pp_uow_id, hasn't been used after creation, so bumping the nextval to sync up dev/uat/prd. Max UOW_ID (in dev/uat/prd) = 19.
So, start inserting new records with UOW_ID = 20.
*/
drop sequence seq_pp_uow_id;
create sequence MAXDAT.SEQ_PP_UOW_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 20
increment by 1
cache 20;

insert into PP_D_UNIT_OF_WORK (UOW_ID, UNIT_OF_WORK_NAME, HANDLE_TIME_UNIT, JEOPARDY_INV_AGE, LABEL)
values (seq_pp_uow_id.nextval,'NON_EE_PIPKINS','Minutes','0','NON EE PIPKINS');

insert into PP_D_UNIT_OF_WORK (UOW_ID, UNIT_OF_WORK_NAME, HANDLE_TIME_UNIT, JEOPARDY_INV_AGE, LABEL)
values (seq_pp_uow_id.nextval,'NYHIX_APPEAL_3','Minutes','3','Appeals');

insert into PP_D_UNIT_OF_WORK (UOW_ID, UNIT_OF_WORK_NAME, HANDLE_TIME_UNIT, JEOPARDY_INV_AGE, LABEL)
values (seq_pp_uow_id.nextval,'NYHIX_DOCRES_1','Minutes','2','DocRes 1');

insert into PP_D_UNIT_OF_WORK (UOW_ID, UNIT_OF_WORK_NAME, HANDLE_TIME_UNIT, JEOPARDY_INV_AGE, LABEL)
values (seq_pp_uow_id.nextval,'NYHIX_LINKING_2','Minutes','2','Linking');

insert into PP_D_UNIT_OF_WORK (UOW_ID, UNIT_OF_WORK_NAME, HANDLE_TIME_UNIT, JEOPARDY_INV_AGE, LABEL)
values (seq_pp_uow_id.nextval,'NYHIX_NA1','Minutes','50','NA1');

insert into PP_D_UNIT_OF_WORK (UOW_ID, UNIT_OF_WORK_NAME, HANDLE_TIME_UNIT, JEOPARDY_INV_AGE, LABEL)
values (seq_pp_uow_id.nextval,'NYHIX_RESEARCH_1','Minutes','1','RESEARCH 1');

insert into PP_D_UNIT_OF_WORK (UOW_ID, UNIT_OF_WORK_NAME, HANDLE_TIME_UNIT, JEOPARDY_INV_AGE, LABEL)
values (seq_pp_uow_id.nextval,'NYHIX_RESEARCH_15_FM','Minutes','15','Returned Mail');

insert into PP_D_UNIT_OF_WORK (UOW_ID, UNIT_OF_WORK_NAME, HANDLE_TIME_UNIT, JEOPARDY_INV_AGE, LABEL)
values (seq_pp_uow_id.nextval,'NYHIX_RESEARCH_15_OD','Minutes','15','Orphan Documents');

insert into PP_D_UNIT_OF_WORK (UOW_ID, UNIT_OF_WORK_NAME, HANDLE_TIME_UNIT, JEOPARDY_INV_AGE, LABEL)
values (seq_pp_uow_id.nextval,'NYHIX_RESEARCH_2','Minutes','2','RESEARCH 2');

insert into PP_D_UNIT_OF_WORK (UOW_ID, UNIT_OF_WORK_NAME, HANDLE_TIME_UNIT, JEOPARDY_INV_AGE, LABEL)
values (seq_pp_uow_id.nextval,'NYHIX_RESEARCH_NA','Minutes','50','RESEARCH NA');

insert into PP_D_UNIT_OF_WORK (UOW_ID, UNIT_OF_WORK_NAME, HANDLE_TIME_UNIT, JEOPARDY_INV_AGE, LABEL)
values (seq_pp_uow_id.nextval,'NYHIX_VERIF_5','Minutes','5','VERIF');

update PP_D_UNIT_OF_WORK
  set JEOPARDY_INV_AGE = 3
where UNIT_OF_WORK_NAME = 'NYHIX_QC';

commit;	