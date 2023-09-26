create or replace procedure TS_QA_AGENT_INSERT_UPDATE
    (in_agent_id in number,
     in_agent_hide_date in date,
     in_agent_active in number,
     in_qa_analyst in varchar2
     )
as
    v_count number;
begin

    if  in_agent_id is null or in_agent_active is null then
        return;
    end if;

    /* Retrieve agent specific information */
    select count(*) into v_count from ts_qa_Agent where AGENT_ID = in_agent_id;

    /* If v_count = 0 -> Insert operation */
    if v_count = 0 then

        INSERT INTO ts_qa_agent (
            agent_id,
            agent_hire_date,
            agent_active,
            create_by,
            create_datetime,
            last_updated_by,
            last_updated_datetime
        ) VALUES (
            in_agent_id,
            in_agent_hide_date,
            in_agent_active,
            in_qa_analyst,
            sysdate,
            in_qa_analyst,
            sysdate
        );

    else -- Update Operation

        UPDATE ts_qa_agent
        SET
            agent_hire_date = in_agent_hide_date,
            agent_active = in_agent_active,
            last_updated_by = in_qa_analyst,
            last_updated_datetime = sysdate
        WHERE
            agent_id = in_agent_id;            

    end if;

    commit;
end;
/

create or replace procedure TS_QA_ANALYST_INSERT_UPDATE
    (in_analyst_name in varchar2,
    in_analyst_id in varchar2
     )
as
    v_count number;
begin

    if  in_analyst_id is null or in_analyst_name is null then
        return;
    end if;

    /* Retrieve analyst specific information */
    select count(*) into v_count from ts_qa_analyst where qa_analyst_id = in_analyst_id;

    /* If v_count = 0 -> Insert operation */
    if v_count = 0 then

        INSERT INTO ts_qa_analyst (
            qa_analyst_id,
            qa_analyst_name
        ) VALUES (
            in_analyst_id,
            in_analyst_name
        );

    else -- Update Operation

        UPDATE ts_qa_analyst
        SET
            qa_analyst_name = in_analyst_name
        WHERE
            qa_analyst_id = in_analyst_id;

    end if;

    commit;
end;
/

create or replace procedure TS_QA_QUESTION_INSERT_UPDATE
    (in_qa_question_desc in varchar,
     in_question_type_id in number,
     in_qa_question_start_date in date,
     in_qa_question_end_date in date,
     in_qa_question_id in number,
     in_question_detail_type_id in number,
     in_qa_question_max_score in number,     
     in_score_type_id in number,
     in_qa_analyst in varchar2
     )
as
    v_qa_question_number number;
    v_qa_question_id number;
    v_qa_question_control number;
    v_qa_question_max_score number;
begin

    if  in_qa_question_desc is null or in_question_type_id is null or in_qa_question_start_date is null or
        in_question_detail_type_id is null or in_qa_question_max_score is null then
        return;
    end if;

    /* If in_question_id is null -> Insert operation */
    if in_qa_question_id is null then

        v_qa_question_id := SEQ_TS_QA_QUESTION.nextval;

        select count(*) + 1 into v_qa_question_number from ts_qa_question;

        INSERT INTO ts_qa_question (
            qa_question_id,
            qa_question_number,
            qa_question_desc,
            question_type_id,
            question_detail_type_id,
            qa_question_start_date,
            qa_question_end_date,
            qa_question_max_score,
            qa_question_control,
            score_type_id,
            create_by,
            create_datetime,
            last_updated_by,
            last_updated_datetime
        ) VALUES (
            v_qa_question_id,
            v_qa_question_number,
            in_qa_question_desc,
            in_question_type_id,
            in_question_detail_type_id,
            in_qa_question_start_date,
            in_qa_question_end_date,
            in_qa_question_max_score,
            0,
            in_score_type_id,
            in_qa_analyst,
            sysdate,
            in_qa_analyst,
            sysdate
        );

        if in_question_detail_type_id = 1 then
            INSERT INTO ts_question_detail (
                question_detail_id,
                qa_question_id,
                question_detail_desc,
                question_detail_enable,
                create_by,
                create_datetime,
                last_updated_by,
                last_updated_datetime
            ) VALUES (
                0,
                v_qa_question_id,
                '-------',
                1,
                in_qa_analyst,
                sysdate,
                in_qa_analyst,
                sysdate
            );
        end if;


    else -- Update Operation
    
        select 
            qa_question_control into v_qa_question_control 
        from ts_qa_question 
        where qa_question_id = in_qa_question_id;
        
        if (v_qa_question_control = 1) then
            v_qa_question_max_score := 0;
        else
            v_qa_question_max_score := in_qa_question_max_score;
        end if;
        
        UPDATE ts_qa_question
        SET
            qa_question_start_date = in_qa_question_start_date,
            qa_question_end_date = in_qa_question_end_date,
            qa_question_max_score = v_qa_question_max_score,
            last_updated_by = in_qa_analyst,
            last_updated_datetime = sysdate
        WHERE
            qa_question_id = in_qa_question_id;            
    end if;

    commit;
end;
/

create or replace procedure TS_QUESTION_DETAIL_INSERT
    (in_qa_question_id in number,
     in_question_detail_desc in varchar2,
     in_question_detail_type_id in number,
     in_qa_analyst in varchar2)
as    
begin

    if in_question_detail_type_id <> 1 or in_question_detail_desc is null then
        return;
    end if;

    INSERT INTO ts_question_detail (
        question_detail_id,
        qa_question_id,
        question_detail_desc,
        question_detail_enable,
        create_by,
        create_datetime,
        last_updated_by,
        last_updated_datetime
    ) VALUES (
        SEQ_TS_QUESTION_DETAIL.nextval,
        in_qa_question_id,
        in_question_detail_desc,
        1,
        in_qa_analyst,
        sysdate,
        in_qa_analyst,
        sysdate
    );

    commit;
end;
/

create or replace procedure TS_AUDIT_INSERT
    (in_call_date in DATE,
     in_call_hour in NUMBER,
     in_call_minute in NUMBER,
     in_call_type_id in NUMBER,
     in_call_duration in NUMBER,
     in_call_language in VARCHAR2,
     in_agent_id in NUMBER,
     in_audit_date in DATE,
     in_audit_csl in varchar2,
     in_audit_escalated in number,
     in_audit_appeal in number,
     in_audit_revised in number,
     in_audit_comments in varchar2,
     in_audit_customer_name in varchar2,
     in_qa_analyst in varchar2)
as
    v_audit_id number;
begin

    if  in_call_date is null or in_call_hour is null or in_call_minute is null or in_call_type_id is null 
     or in_call_duration is null or in_call_language is null or in_agent_id is null or in_audit_date is null 
     or in_audit_escalated is null or in_audit_appeal is null or in_audit_revised is null 
     or trunc(in_call_date) > trunc(sysdate) or trunc(in_audit_date) > trunc(sysdate)
     or trunc(in_call_date) > trunc(in_audit_date) then
        return;
    end if;

    v_audit_id := SEQ_TS_AUDIT.nextval;

    /* Create the audit record */
    INSERT INTO ts_audit (
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
            audit_csl,
            audit_escalated,
            audit_appeal,
            audit_revised,
            audit_comments,
            audit_answered,
            audit_call_result,
            audit_customer_name,
            create_by,
            create_datetime,
            last_updated_by,
            last_updated_datetime
    ) values (
            v_audit_id,
            in_call_date,
            (select to_char(in_call_date, 'DAY') from dual),
            (select case when 
                    to_number(to_char(in_call_date, 'IW')) < to_number(to_char(to_date('01' || to_char(in_call_date, 'MMYYYY'),'DDMMYYYY'),'IW')) 
                 then 
                    (to_number(to_char(in_call_date, 'IW')) + 1) 
                 else 
                    (to_number(to_char(in_call_date, 'IW')) - to_number(to_char(to_date('01' || to_char(in_call_date, 'MMYYYY'),'DDMMYYYY'),'IW')) + 1) 
            end from dual), 
            (select to_char(in_call_date, 'mm') from dual),
            (select to_char(in_call_date, 'fmMon') from dual),
            (select to_char(in_call_date, 'fmMonth') from dual),
            (select to_char(in_call_date, 'yyyy') from dual),
            in_call_hour,
            in_call_minute,
            in_call_type_id,
            in_call_duration,
            in_call_language,
            in_agent_id,
            in_qa_analyst,
            in_audit_date,
            (select to_char(in_audit_date, 'DAY') from dual),
            (select case when 
                    to_number(to_char(in_audit_date, 'IW')) < to_number(to_char(to_date('01' || to_char(in_audit_date, 'MMYYYY'),'DDMMYYYY'),'IW')) 
                 then 
                    (to_number(to_char(in_audit_date, 'IW')) + 1) 
                 else 
                    (to_number(to_char(in_audit_date, 'IW')) - to_number(to_char(to_date('01' || to_char(in_audit_date, 'MMYYYY'),'DDMMYYYY'),'IW')) + 1) 
            end from dual),    
            (select to_char(in_audit_date, 'mm') from dual),
            (select to_char(in_audit_date, 'fmMon') from dual),
            (select to_char(in_audit_date, 'fmMonth') from dual),
            (select to_char(in_audit_date, 'yyyy') from dual),
            in_audit_csl,
            in_audit_escalated,
            in_audit_appeal,
            in_audit_revised,
            in_audit_comments,
            'No',
            'Incomplete',
            in_audit_customer_name,
            in_qa_analyst,
            sysdate,
            in_qa_analyst,
            sysdate
    );


    INSERT INTO ts_audit_question (
        audit_question_id,
        audit_question_number,
        audit_question_desc,
        audit_id,
        qa_question_id,
        question_type_id,
        question_detail_type_id,
        audit_question_max_score,
        audit_question_control,
        create_by,
        create_datetime,
        last_updated_by,
        last_updated_datetime
    ) SELECT
        SEQ_TS_AUDIT_QUESTION.nextval,
        rownum,
        qa_question_desc,
        v_audit_id,
        qa_question_id,
        question_type_id,
        question_detail_type_id,
        qa_question_max_score,
        qa_question_control,
        in_qa_analyst,
        sysdate,
        in_qa_analyst,
        sysdate
    FROM
        (select * from ts_qa_question order by QA_QUESTION_CONTROL, qa_question_id) qa_question
        where qa_question_start_date <= sysdate
        and  (qa_question_end_date is null or qa_question_end_date >= sysdate);

    INSERT INTO ts_audit_question_answer (
        audit_question_answer_id,
        audit_question_answer_yn,
        audit_question_answer_pf,
        audit_question_answer_date,
        audit_question_answer_numeric,
        audit_question_answer_other,
        audit_quest_answer_max_score,
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
    ) select  SEQ_TS_AUDIT_QUESTION_ANSWER.nextval,
            null,
            null,
            null,
            null,
            null,
            qa_question_max_score,
            null,
            question_detail_id,
            case when question_detail_id is null then null else aq.qa_question_id end,
            null,
            null,
            null,
            aq.audit_question_id,
            in_qa_analyst,
            sysdate,
            in_qa_analyst,
            sysdate
    from 
        TS_QA_QUESTION qaq join TS_AUDIT_QUESTION aq on qaq.qa_question_id = aq.qa_question_id
        left outer join (select * from TS_QUESTION_DETAIL where question_detail_id = 0) d on aq.qa_question_id = d.qa_question_id
    where audit_id = v_audit_id;

    commit;
end;
/

create or replace procedure TS_AUDIT_UPDATE
    (in_call_date in DATE,
     in_call_hour in NUMBER,
     in_call_minute in NUMBER,
     in_call_type_id in NUMBER,
     in_call_duration in NUMBER,
     in_call_language in VARCHAR2,
     in_agent_id in NUMBER,
     in_audit_date in DATE,
     in_audit_id in number,     
     in_audit_csl in varchar2,
     in_audit_escalated in number,
     in_audit_appeal in number,
     in_audit_revised in number,
     in_audit_comments in varchar2,
     in_audit_customer_name in varchar2,
     in_qa_analyst in varchar)
as    
begin

    if  in_call_date is null or in_call_hour is null or in_call_minute is null or in_call_type_id is null 
     or in_call_duration is null or in_call_language is null or in_agent_id is null or in_audit_date is null 
     or in_audit_escalated is null or in_audit_appeal is null or in_audit_revised is null 
     or trunc(in_call_date) > trunc(sysdate) or trunc(in_audit_date) > trunc(sysdate)
     or trunc(in_call_date) > trunc(in_audit_date) or in_audit_id is null then
        return;
    end if;

    UPDATE ts_audit
    SET
        audit_call_date = in_call_date,
        audit_call_date_day_name = (select to_char(in_call_date, 'DAY') from dual),
        audit_call_date_week_number = (select case when 
                                                to_number(to_char(in_call_date, 'IW')) < to_number(to_char(to_date('01' || to_char(in_call_date, 'MMYYYY'),'DDMMYYYY'),'IW')) 
                                              then 
                                                (to_number(to_char(in_call_date, 'IW')) + 1) 
                                              else 
                                                (to_number(to_char(in_call_date, 'IW')) - to_number(to_char(to_date('01' || to_char(in_call_date, 'MMYYYY'),'DDMMYYYY'),'IW')) + 1) 
                                              end from dual), 
        audit_call_date_month_number = (select to_char(in_call_date, 'mm') from dual),
        audit_call_date_month_abv = (select to_char(in_call_date, 'fmMon') from dual),
        audit_call_date_month_name = (select to_char(in_call_date, 'fmMonth') from dual),
        audit_call_date_year = (select to_char(in_call_date, 'yyyy') from dual),
        audit_call_hour = in_call_hour,
        audit_call_minute = in_call_minute,
        call_type_id = in_call_type_id,
        audit_call_duration = in_call_duration,
        audit_call_language = in_call_language,
        agent_id = in_agent_id,
        audit_date = in_audit_date,
        audit_date_day_name = (select to_char(in_audit_date, 'DAY') from dual),
        audit_date_week_number = (select case when 
                                                to_number(to_char(in_audit_date, 'IW')) < to_number(to_char(to_date('01' || to_char(in_audit_date, 'MMYYYY'),'DDMMYYYY'),'IW')) 
                                              then 
                                                (to_number(to_char(in_audit_date, 'IW')) + 1) 
                                              else 
                                                (to_number(to_char(in_audit_date, 'IW')) - to_number(to_char(to_date('01' || to_char(in_audit_date, 'MMYYYY'),'DDMMYYYY'),'IW')) + 1) 
                                              end from dual), 
        audit_date_month_number = (select to_char(in_audit_date, 'mm') from dual),
        audit_date_month_abv = (select to_char(in_audit_date, 'fmMon') from dual),
        audit_date_month_name = (select to_char(in_audit_date, 'fmMonth') from dual),
        audit_date_year = (select to_char(in_audit_date, 'yyyy') from dual),
        audit_csl = in_audit_csl,
        audit_escalated = in_audit_escalated,
        audit_appeal = in_audit_appeal,
        audit_revised = in_audit_revised,
        audit_comments = in_audit_comments,
        audit_customer_name = in_audit_customer_name,
        last_updated_by = in_qa_analyst,
        last_updated_datetime = sysdate        
    WHERE
        audit_id = in_audit_id;
        
    commit;
end;
/

create or replace procedure TS_AUDIT_QUEST_ANSWER_UPDATE
    (in_answer_yn in number,
     in_answer_pf in number,
     in_answer_date in date,
     in_answer_numeric in number,
     in_answer_other in varchar2,
     in_answer_score in NUMBER,
     in_qa_question_max_score number,
     in_question_detail_id in number,
     in_qa_question_id in number,
     in_question_detail_comment in varchar2,
     in_question_detail_date in date,
     in_question_answer_comment in varchar2,
     in_question_answer_id in number,
     in_question_control in varchar2,
     in_qa_analyst in varchar2)
as    
    v_answer_score number;
begin

    if  (in_answer_score is null and in_question_control <> 'Yes' and in_qa_question_max_score > 0 and in_answer_pf is null) or in_question_answer_id is null or (in_answer_yn is null and in_answer_pf is null
        and in_answer_date is null and in_answer_numeric is null and in_answer_other is null) then
        return;
    end if;

    /* validates the score */
    if (in_qa_question_max_score is not null and in_answer_score > in_qa_question_max_score) then
        v_answer_score := in_qa_question_max_score;
    else
        v_answer_score := in_answer_score;    
    end if;

    /* If a Pass/Fail score fails, the score is 0 */
    if (in_answer_pf is not null and in_answer_pf = 0) then
        v_answer_score := 0;
    elsif (in_answer_pf is not null and in_answer_pf = 1) then
        v_answer_score := in_qa_question_max_score;
    end if;

    if (in_question_detail_id is null) then
        UPDATE ts_audit_question_answer
        SET
            audit_question_answer_yn = in_answer_yn,
            audit_question_answer_pf = in_answer_pf,
            audit_question_answer_date = in_answer_date,
            audit_question_answer_numeric = in_answer_numeric,
            audit_question_answer_other = in_answer_other,
            audit_question_answer_score = v_answer_score,
            audit_question_detail_comment = in_question_detail_comment,
            audit_question_detail_date = in_question_detail_date,
            audit_question_answer_comment = in_question_answer_comment,
            last_updated_by = in_qa_analyst,
            last_updated_datetime = sysdate        
        WHERE
            audit_question_answer_id = in_question_answer_id;
    else

        UPDATE ts_audit_question_answer
        SET
            audit_question_answer_yn = in_answer_yn,
            audit_question_answer_pf = in_answer_pf,
            audit_question_answer_date = in_answer_date,
            audit_question_answer_numeric = in_answer_numeric,
            audit_question_answer_other = in_answer_other,
            audit_question_answer_score = v_answer_score,
            question_detail_id = in_question_detail_id,
            qa_question_id = in_qa_question_id,
            audit_question_detail_comment = in_question_detail_comment,
            audit_question_detail_date = in_question_detail_date,
            audit_question_answer_comment = in_question_answer_comment,
            last_updated_by = in_qa_analyst,
            last_updated_datetime = sysdate        
        WHERE
            audit_question_answer_id = in_question_answer_id;            
    end if;

    commit;
end;
/

create or replace procedure TS_AUDIT_UPDATE_STATUS
    (in_audit_id in number,
     in_audit_answered in varchar2,
     in_audit_call_result in varchar2
     )
as
    v_audit_question_type_pf number;
    v_audit_quest_ans_type_pf number;
    v_audit_quest_ans_fail number;
    v_audit_answered varchar2(3);
    v_audit_call_result varchar2(20);
begin

    /* Audit Answered status */ 
    select 
        case when 
            (select 
                count(audit_question_answer_id) 
             from 
                ts_audit_question_answer aqa join ts_audit_question aq on aq.audit_question_id = aqa.audit_question_id 
             where 
                aq.audit_id = in_audit_id and 
                (AUDIT_QUESTION_ANSWER_YN is not null or 
                AUDIT_QUESTION_ANSWER_PF is not null or 
                AUDIT_QUESTION_ANSWER_DATE is not null or 
                AUDIT_QUESTION_ANSWER_NUMERIC is not null or 
                AUDIT_QUESTION_ANSWER_OTHER is not null)) = (select 
                                                                count(aq.audit_question_id) 
                                                             from 
                                                                ts_audit_question aq 
                                                             where 
                                                                aq.audit_id = in_audit_id)
        then 
            'Yes' 
        else 
            'No' 
        end as audit_answered into v_audit_answered
    from
        dual;

    /* Audit Call Result Status */
    /* Number of pass/Fail Questions */
    select 
        count(audit_question_id) into v_audit_question_type_pf
    from
        ts_audit_question aq
    where
        aq.audit_id = in_audit_id and
        aq.question_type_id = 3;
        
    /* It has Pass/Fail questions */
    if (v_audit_question_type_pf > 0) then
    
        /* Number of Pass/Fail Question Answered */
        select 
            count(audit_question_answer_id) into v_audit_quest_ans_type_pf
        from 
            ts_audit_question_answer aqa join ts_audit_question aq on aq.audit_question_id = aqa.audit_question_id 
        where 
        aq.audit_id = in_audit_id and
        AUDIT_QUESTION_ANSWER_PF is not null;
        
        
        /* No Pass/Fail Questions Anwered */
        if (v_audit_quest_ans_type_pf = 0) then
            v_audit_call_result := 'Incomplete';
        else            
            /* Number of Failed Answers */
            select 
                count(audit_question_answer_id) into v_audit_quest_ans_fail
            from 
                ts_audit_question_answer aqa join ts_audit_question aq on aq.audit_question_id = aqa.audit_question_id 
            where 
                aq.audit_id = in_audit_id and
                AUDIT_QUESTION_ANSWER_PF = 0;
                
            /* At least one Pass/Fail question failed */
            if (v_audit_quest_ans_fail > 0) then
                v_audit_call_result := 'Failed';
            /* All Pass/Fail questions answered Pass */
            elsif (v_audit_quest_ans_type_pf = v_audit_question_type_pf) then
                v_audit_call_result := 'Passed';
            else
                v_audit_call_result := 'Incomplete';
            end if;               
            
        end if;
    /* No Pass/Fail Questions */
    else
        /* All question Ansered */
        if (v_audit_answered = 'Yes') then
            v_audit_call_result := 'Passed';
        /* Not Answered */
        else
            v_audit_call_result := 'Incomplete';
        end if;
    end if;

    /* Update the audit's status */
    if (in_audit_answered <> v_audit_answered or in_audit_call_result <> v_audit_call_result or in_audit_call_result is null or in_audit_answered is null) then
        UPDATE ts_audit
        SET
            audit_answered = v_audit_answered,
            audit_call_result = v_audit_call_result
        WHERE
            audit_id = in_audit_id;

        commit;
    end if;
end;
/
