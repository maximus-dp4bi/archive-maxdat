alter table D_NYEC_PMI_CURRENT modify ("MI Channel" varchar2(20) null);

create or replace view D_NYEC_PMI_CURRENT_SV as
select * from D_NYEC_PMI_CURRENT 
with read only;

alter table D_NYEC_PMI_INBOUND_MI_TYPE modify ("Inbound MI Type" varchar2(50) null);

create or replace view D_NYEC_PMI_INBOUND_MI_TYPE_SV as
select * from D_NYEC_PMI_INBOUND_MI_TYPE
with read only;

insert into D_NYEC_PMI_INBOUND_MI_TYPE (DNPMIIMIT_ID,"Inbound MI Type") values (SEQ_DNPMIIMIT_ID.nextval,null);
commit;

alter table D_NYEC_PMI_LETTER_STATUS modify ("MI Letter Status" varchar2(50) null);

create or replace view D_NYEC_PMI_LETTER_STATUS_SV as
select * from D_NYEC_PMI_LETTER_STATUS
with read only;

insert into D_NYEC_PMI_LETTER_STATUS (DNPMILS_ID,"MI Letter Status") values (SEQ_DNPMILS_ID.nextval,null);
commit;

create or replace view D_NYEC_PA_CURRENT_SV as
select * from D_NYEC_PA_CURRENT 
with read only;
