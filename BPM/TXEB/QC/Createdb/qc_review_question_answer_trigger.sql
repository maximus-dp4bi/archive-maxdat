alter session set plsql_code_type = native;

create or replace trigger TRG_BIU_QC_RQA
before insert or update on QC_REVIEW_QUESTION_ANSWER 
for each row
begin
  if inserting then
  :new.rqa_created_by := user;
  :new.rqa_updated_by := user;
      :new.rqa_create_ts := sysdate;
      :new.rqa_update_ts := sysdate;
  end if;
  if updating then
  :new.rqa_updated_by := user;
      :new.rqa_update_ts := sysdate;
  end if;
  
end;
/

alter session set plsql_code_type = interpreted;    
