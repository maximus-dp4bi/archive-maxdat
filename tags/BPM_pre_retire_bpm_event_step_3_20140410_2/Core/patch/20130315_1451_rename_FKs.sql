alter table BPM_ACTIVITY_ATTRIBUTE rename constraint BACL_BACA_FK to BACA_BACL_FK;
alter table BPM_ACTIVITY_EVENTS rename constraint BAA_BACE_FK to BACE_BACA_FK;
alter table BPM_ACTIVITY_EVENTS rename constraint BETL_BACE_FK to BACE_BACETL_FK;
alter table BPM_ACTIVITY_EVENTS rename constraint BI_BACE_FK to BACE_BI_FK;
alter table BPM_ACTIVITY_LKUP rename constraint BACTL_BACL_FK to BACL_BACTL_FK;
alter table BPM_ATTRIBUTE rename constraint BAL_BA_FK to BA_BAL_FK;
alter table BPM_ATTRIBUTE rename constraint BEM_BA_FK to BA_BEM_FK;
alter table BPM_ATTRIBUTE_LKUP rename constraint BDL_BAL_FK to BAL_BDL_FK;
alter table BPM_EVENT_MASTER rename constraint BPRG_BEN_FK to BEM_BPRG_FK;
alter table BPM_EVENT_MASTER rename constraint BPRJ_BEM_FK to BEM_BPRJ_FK;
alter table BPM_EVENT_MASTER rename constraint BRL_BEM_FK to BEM_BRL_FK;
alter table BPM_PROCESS_FLOW rename constraint BAA_BPF_FK1 to BPF_CUR_BACA_FK;
alter table BPM_PROCESS_FLOW rename constraint BAA_BPF_FK2 to BPF_COMP_REQ_BACA_FK;
alter table BPM_SOURCE_LKUP rename constraint BSTL_BSL_FK to BSL_BSTL_FK;

