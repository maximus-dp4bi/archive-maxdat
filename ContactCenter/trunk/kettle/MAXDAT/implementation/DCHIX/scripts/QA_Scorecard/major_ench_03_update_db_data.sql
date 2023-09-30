insert into ts_quest_answer_detail (SELECT
                                        audit_question_answer_id,
                                        question_detail_id,
                                        qa_question_id,
                                        1,
                                        create_by,
                                        create_datetime,
                                        last_updated_by,
                                        last_updated_datetime
                                    FROM
                                        ts_audit_question_answer
                                    where 
                                        question_detail_id <> 0 and 
                                        question_detail_id is not null);
commit;