create table D_BONUS_SCORES
(
  dbs_id                 NUMBER not null,
  employee_id            VARCHAR2(20),
  score_type             VARCHAR2(100),
  score                  NUMBER,
  start_date             DATE,
  end_date               DATE,
  notes                  VARCHAR2(4000),
  create_ts              DATE,
  update_ts              DATE
);

alter table D_BONUS_SCORES
  add primary key (dbs_id);

alter table D_BONUS_SCORES
  add constraint BONUS_SCORES_UNIQUE unique (employee_id, score_type, start_date);
  
create sequence SEQ_DBS_ID
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

CREATE OR REPLACE VIEW D_BONUS_SCORES_SV AS
select 
dbs_id, 
employee_id, 
score_type, 
score,
start_date, 
end_date,
to_char(start_date,'mm/yyyy') as start_month, 
notes, 
create_ts,
update_ts
from d_bonus_scores;
/

create or replace trigger TRG_BIU_D_BONUS_SCORES
before insert or update on D_BONUS_SCORES
for each row

begin

  if inserting then
          if :new.dbs_id is null then
             :new.dbs_id := SEQ_DBS_ID.nextval;
          end if;
          :new.create_ts := SYSDATE;
          :new.update_ts := SYSDATE;

        end if;

     if updating then
          :new.update_ts :=SYSDATE;
      end if;
end;
/

CREATE OR REPLACE PUBLIC SYNONYM D_BONUS_SCORES FOR D_BONUS_SCORES ;
CREATE OR REPLACE PUBLIC SYNONYM D_BONUS_SCORES_SV FOR D_BONUS_SCORES_SV ;

-- Grant/Revoke object privileges 
grant select, insert, update on D_BONUS_SCORES to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on D_BONUS_SCORES to MAXDAT_OLTP_SIUD;
grant select on D_BONUS_SCORES to MAXDAT_READ_ONLY;

grant select, insert, update on D_BONUS_SCORES_SV to MAXDAT_OLTP_SIU;
grant select, insert, update, delete on D_BONUS_SCORES_SV to MAXDAT_OLTP_SIUD;
grant select on D_BONUS_SCORES_SV to MAXDAT_READ_ONLY;

commit;

/
