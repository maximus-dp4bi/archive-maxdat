create or replace TRIGGER TRG_AIU_TS_QA_AGENT 
AFTER INSERT OR UPDATE ON TS_QA_AGENT 
for each row

DECLARE
v_record_type varchar2(10);
v_record_action varchar2(10);

BEGIN

    IF INSERTING THEN

        v_record_type := 'insert';
        v_record_action := 'insert';

    END IF;

    IF UPDATING THEN
    
        INSERT INTO aiu_ts_qa_agent (
            record_type,
            record_action,
            transaction_date,
            agent_id,
            agent_hire_date,
            agent_active,
            create_by,
            create_datetime,
            last_updated_by,
            last_updated_datetime
        ) VALUES (
            'update',
            'delete',
            sysdate,
            :old.agent_id,
            :old.agent_hire_date,
            :old.agent_active,
            :old.create_by,
            :old.create_datetime,
            :old.last_updated_by,
            :old.last_updated_datetime
        );

        v_record_type := 'update';
        v_record_action := 'insert';

    END IF;

    INSERT INTO aiu_ts_qa_agent (
        record_type,
        record_action,
        transaction_date,
        agent_id,
        agent_hire_date,
        agent_active,
        create_by,
        create_datetime,
        last_updated_by,
        last_updated_datetime
    ) VALUES (
        v_record_type,
        v_record_action,
        sysdate,
        :new.agent_id,
        :new.agent_hire_date,
        :new.agent_active,
        :new.create_by,
        :new.create_datetime,
        :new.last_updated_by,
        :new.last_updated_datetime
    );

END;
/

create or replace TRIGGER TRG_AIU_TS_QA_QUESTION
AFTER INSERT OR UPDATE ON TS_QA_QUESTION 
for each row

DECLARE
v_record_type varchar2(10);
v_record_action varchar2(10);

BEGIN

    IF INSERTING THEN

        v_record_type := 'insert';
        v_record_action := 'insert';

    END IF;

    IF UPDATING THEN
    
        INSERT INTO aiu_ts_qa_question (
            record_type,
            record_action,
            transaction_date,
            qa_question_id,
            qa_question_number,
            qa_question_desc,
            question_type_id,
            question_detail_type_id,
            qa_question_start_date,
            qa_question_end_date,
            qa_question_weight,
            qa_question_control,
            create_by,
            create_datetime,
            last_updated_by,
            last_updated_datetime
        ) VALUES (
            'update',
            'delete',
            sysdate,
            :old.qa_question_id,
            :old.qa_question_number,
            :old.qa_question_desc,
            :old.question_type_id,
            :old.question_detail_type_id,
            :old.qa_question_start_date,
            :old.qa_question_end_date,
            :old.qa_question_weight,
            :old.qa_question_control,
            :old.create_by,
            :old.create_datetime,
            :old.last_updated_by,
            :old.last_updated_datetime
        );

        v_record_type := 'update';
        v_record_action := 'insert';

    END IF;

    INSERT INTO aiu_ts_qa_question (
        record_type,
        record_action,
        transaction_date,
        qa_question_id,
        qa_question_number,
        qa_question_desc,
        question_type_id,
        question_detail_type_id,
        qa_question_start_date,
        qa_question_end_date,
        qa_question_weight,
        qa_question_control,
        create_by,
        create_datetime,
        last_updated_by,
        last_updated_datetime
    ) VALUES (
        v_record_type,
        v_record_action,
        sysdate,
        :new.qa_question_id,
        :new.qa_question_number,
        :new.qa_question_desc,
        :new.question_type_id,
        :new.question_detail_type_id,
        :new.qa_question_start_date,
        :new.qa_question_end_date,
        :new.qa_question_weight,
        :new.qa_question_control,
        :new.create_by,
        :new.create_datetime,
        :new.last_updated_by,
        :new.last_updated_datetime
    );        
END;
/

create or replace TRIGGER TRG_AIU_TS_QUESTION_DETAIL 
AFTER INSERT OR UPDATE ON TS_QUESTION_DETAIL 
for each row

DECLARE
v_record_type varchar2(10);
v_record_action varchar2(10);

BEGIN

    IF INSERTING THEN

        v_record_type := 'insert';
        v_record_action := 'insert';

    END IF;

    IF UPDATING THEN
    
        INSERT INTO aiu_ts_question_detail (
            record_type,
            record_action,
            transaction_date,
            question_detail_id,
            qa_question_id,
            question_detail_desc,
            question_detail_enable,
            create_by,
            create_datetime,
            last_updated_by,
            last_updated_datetime
        ) VALUES (
            'update',
            'delete',
            sysdate,
            :old.question_detail_id,
            :old.qa_question_id,
            :old.question_detail_desc,
            :old.question_detail_enable,
            :old.create_by,
            :old.create_datetime,
            :old.last_updated_by,
            :old.last_updated_datetime
        );

        v_record_type := 'update';
        v_record_action := 'insert';

    END IF;

    INSERT INTO aiu_ts_question_detail (
        record_type,
        record_action,
        transaction_date,
        question_detail_id,
        qa_question_id,
        question_detail_desc,
        question_detail_enable,
        create_by,
        create_datetime,
        last_updated_by,
        last_updated_datetime
    ) VALUES (
        v_record_type,
        v_record_action,
        sysdate,
        :new.question_detail_id,
        :new.qa_question_id,
        :new.question_detail_desc,
        :new.question_detail_enable,
        :new.create_by,
        :new.create_datetime,
        :new.last_updated_by,
        :new.last_updated_datetime
    );           
END;
/

create or replace TRIGGER TRG_AIU_TS_AUDIT
AFTER INSERT OR UPDATE ON TS_AUDIT 
for each row

DECLARE
v_record_type varchar2(10);
v_record_action varchar2(10);

BEGIN

    IF INSERTING THEN

        v_record_type := 'insert';
        v_record_action := 'insert';

    END IF;

    IF UPDATING THEN

        INSERT INTO aiu_ts_audit (
            record_type,
            record_action,
            transaction_date,
            audit_id,
            audit_call_date,
            audit_call_date_day_name,
            audit_call_date_week_number,    
            audit_call_date_month_number,
            audit_call_date_month_abv,
            audit_call_date_month_name,
            audit_call_date_year,
            audit_call_hour,
            audit_call_minute,
            call_type_id,
            audit_call_duration,
            audit_call_language,
            agent_id,
            qa_analyst_id,
            audit_date,
            audit_date_day_name,
            audit_date_week_number,    
            audit_date_month_number,
            audit_date_month_abv,
            audit_date_month_name,
            audit_date_year,
            create_by,
            create_datetime,
            last_updated_by,
            last_updated_datetime
        ) VALUES (
            'update',
            'delete',
            sysdate,
            :old.audit_id,
            :old.audit_call_date,
            :old.audit_call_date_day_name,
            :old.audit_call_date_week_number,    
            :old.audit_call_date_month_number,
            :old.audit_call_date_month_abv,
            :old.audit_call_date_month_name,
            :old.audit_call_date_year,
            :old.audit_call_hour,
            :old.audit_call_minute,
            :old.call_type_id,
            :old.audit_call_duration,
            :old.audit_call_language,
            :old.agent_id,
            :old.qa_analyst_id,
            :old.audit_date,
            :old.audit_date_day_name,
            :old.audit_date_week_number,    
            :old.audit_date_month_number,
            :old.audit_date_month_abv,
            :old.audit_date_month_name,
            :old.audit_date_year,
            :old.create_by,
            :old.create_datetime,
            :old.last_updated_by,
            :old.last_updated_datetime
        );

        v_record_type := 'update';
        v_record_action := 'insert';

    END IF;

    INSERT INTO aiu_ts_audit (
        record_type,
        record_action,
        transaction_date,
        audit_id,
        audit_call_date,
        audit_call_date_day_name,
        audit_call_date_week_number,    
        audit_call_date_month_number,
        audit_call_date_month_abv,
        audit_call_date_month_name,
        audit_call_date_year,
        audit_call_hour,
        audit_call_minute,
        call_type_id,
        audit_call_duration,
        audit_call_language,
        agent_id,
        qa_analyst_id,
        audit_date,
        audit_date_day_name,
        audit_date_week_number,    
        audit_date_month_number,
        audit_date_month_abv,
        audit_date_month_name,
        audit_date_year,
        create_by,
        create_datetime,
        last_updated_by,
        last_updated_datetime
    ) VALUES (
        v_record_type,
        v_record_action,
        sysdate,
        :new.audit_id,
        :new.audit_call_date,
        :new.audit_call_date_day_name,
        :new.audit_call_date_week_number,    
        :new.audit_call_date_month_number,
        :new.audit_call_date_month_abv,
        :new.audit_call_date_month_name,
        :new.audit_call_date_year,
        :new.audit_call_hour,
        :new.audit_call_minute,
        :new.call_type_id,
        :new.audit_call_duration,
        :new.audit_call_language,
        :new.agent_id,
        :new.qa_analyst_id,
        :new.audit_date,
        :new.audit_date_day_name,
        :new.audit_date_week_number,    
        :new.audit_date_month_number,
        :new.audit_date_month_abv,
        :new.audit_date_month_name,
        :new.audit_date_year,
        :new.create_by,
        :new.create_datetime,
        :new.last_updated_by,
        :new.last_updated_datetime
    );
END;
/

create or replace TRIGGER TRG_AIU_TS_AUDIT_QUEST_ANSWER
AFTER UPDATE ON TS_AUDIT_QUESTION_ANSWER 
for each row

DECLARE
v_record_type varchar2(10);
v_record_action varchar2(10);

BEGIN

    if (:old.AUDIT_QUESTION_ANSWER_YN is null and
        :old.AUDIT_QUESTION_ANSWER_PF is null and
        :old.AUDIT_QUESTION_ANSWER_DATE is null and
        :old.AUDIT_QUESTION_ANSWER_NUMERIC is null and 
        :old.AUDIT_QUESTION_ANSWER_OTHER is null) 
    then

        v_record_type := 'insert';
        v_record_action := 'insert';

    else
    
        INSERT INTO aiu_ts_audit_question_answer (
            record_type,
            record_action,
            transaction_date,
            audit_question_answer_id,
            audit_question_answer_yn,
            audit_question_answer_pf,
            audit_question_answer_date,
            audit_question_answer_numeric,
            audit_question_answer_other,
            audit_question_answer_weight,
            audit_question_answer_score,
            question_detail_id,
            qa_question_id,
            audit_question_detail_comment,
            audit_question_detail_date,
            audit_question_answer_comment,
            audit_question_id,
            create_by,
            create_datetime,
            last_updated_by,
            last_updated_datetime
        ) VALUES (
            'update',
            'delete',
            sysdate,
            :old.audit_question_answer_id,
            :old.audit_question_answer_yn,
            :old.audit_question_answer_pf,
            :old.audit_question_answer_date,
            :old.audit_question_answer_numeric,
            :old.audit_question_answer_other,
            :old.audit_question_answer_weight,
            :old.audit_question_answer_score,
            :old.question_detail_id,
            :old.qa_question_id,
            :old.audit_question_detail_comment,
            :old.audit_question_detail_date,
            :old.audit_question_answer_comment,
            :old.audit_question_id,
            :old.create_by,
            :old.create_datetime,
            :old.last_updated_by,
            :old.last_updated_datetime
        );    

        v_record_type := 'update';
        v_record_action := 'insert';

    END IF;

    INSERT INTO aiu_ts_audit_question_answer (
        record_type,
        record_action,
        transaction_date,
        audit_question_answer_id,
        audit_question_answer_yn,
        audit_question_answer_pf,
        audit_question_answer_date,
        audit_question_answer_numeric,
        audit_question_answer_other,
        audit_question_answer_weight,
        audit_question_answer_score,
        question_detail_id,
        qa_question_id,
        audit_question_detail_comment,
        audit_question_detail_date,
        audit_question_answer_comment,
        audit_question_id,
        create_by,
        create_datetime,
        last_updated_by,
        last_updated_datetime
    ) VALUES (
        v_record_type,
        v_record_action,
        sysdate,
        :new.audit_question_answer_id,
        :new.audit_question_answer_yn,
        :new.audit_question_answer_pf,
        :new.audit_question_answer_date,
        :new.audit_question_answer_numeric,
        :new.audit_question_answer_other,
        :new.audit_question_answer_weight,
        :new.audit_question_answer_score,
        :new.question_detail_id,
        :new.qa_question_id,
        :new.audit_question_detail_comment,
        :new.audit_question_detail_date,
        :new.audit_question_answer_comment,
        :new.audit_question_id,
        :new.create_by,
        :new.create_datetime,
        :new.last_updated_by,
        :new.last_updated_datetime
    );
END;
/

