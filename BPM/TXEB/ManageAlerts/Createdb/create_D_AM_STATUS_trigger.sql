  alter session set plsql_code_type = native;

create or replace trigger TRG_BIU_D_AM_STATUS
before insert or update or delete on D_AM_STATUS referencing new as new old as old
for each row
declare
v_dml varchar2(3);
begin
  if inserting then
  v_dml := 'INS';
    if :new.ams_id is null then
      :new.ams_id := SEQ_ams_id.nextval;
    end if;
    if :new.create_dt is null then
      :new.create_dt  := sysdate;
    end if;
    if :new.created_by is null then
      :new.created_by  := user;
    end if;
    if :new.ams_review_status is not null then
      :new.ams_review_status_dt := sysdate;
    end if;
  end if;
  if updating then
    v_dml := 'UPD';
    if :new.ams_review_status <> :old.ams_review_status or (:new.ams_review_status is not null and :old.ams_review_status is null) then
        :new.ams_review_status_dt := sysdate;
        if :new.ams_review_status in ('No Issue','Resolved','Other Word Identified') then
          :new.instance_status := 'Complete';
          :new.complete_dt := :new.ams_review_status_dt;
        end if;
    end if;
    if :new.ams_review_status in ('Cancel') then
      :new.cancel_dt := sysdate;
      if :new.cancel_method is null then
        :new.cancel_method := 'Normal';
      end if;
      if :new.cancel_reason is null then
        :new.cancel_reason := 'Request cancelled by system';
      end if;
      :new.instance_status := 'Complete';
      :new.complete_dt := sysdate;
    end if;
  end if;
  if deleting then
  v_dml := 'DEL';
  end if;

  if updating or deleting then
        insert into d_am_status_hist (
          AMS_ID
        ,AM_ID
        ,DML_TYPE
        ,AMS_REVIEW_STATUS
        ,AMS_REVIEW_STATUS_DT
        ,AMS_ANALYST_NAME
        ,AMS_COMMENTS
        ,AMS_JIRA_NUMBER
        ,INSTANCE_STATUS
        ,CANCEL_DT
        ,CANCEL_BY
        ,CANCEL_REASON
        ,CANCEL_METHOD
        ,COMPLETE_DT
      )
        values
        (
        :old.ams_id
        ,:old.AM_ID
        , v_dml
        ,:old.AMS_REVIEW_STATUS
        ,:old.AMS_REVIEW_STATUS_DT
        ,:old.AMS_ANALYST_NAME
        ,:old.AMS_COMMENTS
        ,:old.AMS_JIRA_NUMBER
        ,:old.INSTANCE_STATUS
        ,:old.CANCEL_DT
        ,:old.CANCEL_BY
        ,:old.CANCEL_REASON
        ,:old.CANCEL_METHOD
        ,:old.COMPLETE_DT
        )
        ;
    end if;
end;
/


create or replace trigger TRG_BIU_D_AM_STATUS_HIST 
before insert or update on D_AM_STATUS_HIST
for each row
begin
  if inserting then
    if :new.amshist_id is null then
      :new.amshist_id := SEQ_amshist_id.nextval;
    end if;
    if :new.create_dt is null then
      :new.create_dt  := sysdate;
    end if;
    if :new.created_by is null then
      :new.created_by  := user;
    end if;
  end if;
end;
/

alter session set plsql_code_type = interpreted;
