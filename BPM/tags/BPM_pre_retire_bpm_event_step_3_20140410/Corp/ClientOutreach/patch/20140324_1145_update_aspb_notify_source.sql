BEGIN
FOR oc IN(SELECT outreach_id, outcome_notification_task_id,
           (SELECT DISTINCT S.last_name || ',' || S.first_name FROM step_instance_stg tas, staff_stg S WHERE tas.HIST_CREATE_BY = to_char(S.STAFF_ID) AND tas.step_instance_id = oc.outcome_notification_task_id) notify_by
          FROM corp_Etl_clnt_outreach oc
          WHERE aspb_notify_source is null
          AND ased_notify_source is not null) LOOP
          
  UPDATE corp_etl_clnt_outreach
  SET aspb_notify_source = oc.notify_by
  WHERE outreach_id = oc.outreach_id;
END LOOP;
END;


BEGIN
FOR oc IN(SELECT outreach_id, outcome_notification_task_id,
           (SELECT S.last_name || ',' || S.first_name FROM staff_stg S WHERE S.STAFF_ID= 10673) notify_by
          FROM corp_Etl_clnt_outreach oc
          WHERE aspb_notify_source is null
          AND ased_notify_source is not null) LOOP
          
  UPDATE corp_etl_clnt_outreach
  SET aspb_notify_source = oc.notify_by
  WHERE outreach_id = oc.outreach_id;
END LOOP;
END;


COMMIT;