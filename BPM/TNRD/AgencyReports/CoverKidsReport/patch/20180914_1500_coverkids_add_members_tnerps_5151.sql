INSERT INTO tn_coverkids_exception(application_id,client_id,case_id,effective_date,letter_id,directive,exception_comments,exclude_flag,create_date,created_by)
VALUES(919314,1547295,1547495,to_date('09/27/2018','mm/dd/yyyy'),3852333,'TERMINATE','TN 408ftp was mailed but application is Disregarded.','Y',sysdate,user);

--those that were included in the gap file have to appear on next week's weekly file
update coverkids_approval_stg
set create_date = sysdate + 1
where trunc(create_date) = TO_DATE('09/21/2018','mm/dd/yyyy')
and cumulative_ind = 'N';


commit;
