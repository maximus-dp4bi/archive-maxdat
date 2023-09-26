
alter session set current_schema = MAXDAT;
--pop letters
DECLARE  
  CURSOR temp_cur IS 
SELECT ci.application_id
           ,cl.TN408ftp_mail_date    
FROM tn_ci_redetermination ci
join (
  SELECT    
       ETL_PROCESS_LETTERS_PKG.get_min_mail_date(acl.case_id,'TN 408ftp') TN408ftp_mail_date
       ,acl.application_id
  FROM app_case_link_stg acl
   ) cl on ci.application_id = cl.application_id
where ci.tn408ftp_mail_date is null  
and cl.TN408ftp_mail_date is not null;

  TYPE t_tab IS TABLE OF temp_cur%ROWTYPE INDEX BY PLS_INTEGER;
  temp_tab t_tab;
  v_bulk_limit NUMBER := 500;

BEGIN  
   OPEN temp_cur;
   LOOP
     FETCH temp_cur BULK COLLECT INTO temp_tab LIMIT v_bulk_limit;
     EXIT WHEN temp_tab.COUNT = 0; -- Exit when missing rows
  
     BEGIN
       FORALL indx IN 1..temp_tab.COUNT
         UPDATE tn_ci_redetermination
         SET 		TN408FTP_MAIL_DATE	=	temp_tab(indx).TN408FTP_MAIL_DATE
         WHERE application_id = temp_tab(indx).application_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/