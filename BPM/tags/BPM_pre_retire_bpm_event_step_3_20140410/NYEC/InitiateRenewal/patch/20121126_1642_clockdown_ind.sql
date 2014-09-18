drop index DNIRCI_UIX1;
alter table D_NYEC_IR_CLOCKDOWN_IND modify ("Clockdown Indicator" varchar2(1));

create or replace view D_NYEC_IR_CLOCKDOWN_IND_SV as
select * from D_NYEC_IR_CLOCKDOWN_IND
with read only;

insert into D_NYEC_IR_CLOCKDOWN_IND (DNIRCI_ID,"Clockdown Indicator") values (SEQ_DNIRCI_ID.nextval,'Y');
insert into D_NYEC_IR_CLOCKDOWN_IND (DNIRCI_ID,"Clockdown Indicator") values (SEQ_DNIRCI_ID.nextval,'N');
commit;