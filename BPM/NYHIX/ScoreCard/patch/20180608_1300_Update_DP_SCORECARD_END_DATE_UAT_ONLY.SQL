update DP_SCORECARD.PP_WFM_JOB_CLASSIFICATION t1
set end_date = ( select end_date FROM RESTORE.PP_WFM_JOB_CLASSIFICATION t2
where t2.staff_id = t1.staff_id
  and t2.start_date = t1.start_date
  and t2.job_classification_code_id = t1.job_classification_code_id
  and t2.category_of_classification_id = t1.category_of_classification_id
)
where exists 
    ( select 'x' FROM RESTORE.PP_WFM_JOB_CLASSIFICATION t3
    where t3.staff_id = t1.staff_id
    and t3.start_date = t1.start_date
    and t3.job_classification_code_id = t1.job_classification_code_id
    and t3.category_of_classification_id = t1.category_of_classification_id
    )
and not exists
    ( select 'x' FROM RESTORE.PP_WFM_JOB_CLASSIFICATION t4
    where t4.staff_id = t1.staff_id
    and t4.start_date = t1.start_date
    and t4.job_classification_code_id = t1.job_classification_code_id
    and t4.category_of_classification_id = t1.category_of_classification_id
    and trunc(nvl(t4.end_date,sysdate)) = trunc(nvl(t1.end_date,sysdate))  
    );

COMMIT;

----------------------------------------------------------------------	
----------------------------------------------------------------------	

update DP_SCORECARD.PP_WFM_STAFF_ELIGIBILITY t1
set end_date = ( select end_date FROM RESTORE.PP_WFM_STAFF_ELIGIBILITY t2
where t2.staff_id = t1.staff_id
  and t2.start_date = t1.start_date
  and t2.event_id = t1.event_id
)
where exists ( select 'x' FROM RESTORE.PP_WFM_STAFF_ELIGIBILITY t3
where t3.staff_id = t1.staff_id
  and t3.start_date = t1.start_date
  and t3.event_id = t1.event_id
)
AND NOT EXISTS ( select 'x' FROM RESTORE.PP_WFM_STAFF_ELIGIBILITY T4
where t4.staff_id = t1.staff_id
  and t4.start_date = t1.start_date
  and t4.event_id = t1.event_id
  and trunc(nvl(t4.end_date,sysdate)) = trunc(nvl(t1.end_date,sysdate))  
);

commit;

----------------------------------------------------------------------	
----------------------------------------------------------------------	

update DP_SCORECARD.PP_WFM_STAFF_TO_department t1
set end_date = ( select end_date FROM RESTORE.PP_WFM_STAFF_TO_department t2
where t2.staff_id = t1.staff_id
  and t2.effective_date = t1.effective_date
  and t2.department_id = t1.department_id
)
where exists ( select 'x' FROM RESTORE.PP_WFM_STAFF_TO_department t3
where t3.staff_id = t1.staff_id
  and t3.effective_date = t1.effective_date
  and t3.department_id = t1.department_id
)
AND not exists ( select end_date FROM RESTORE.PP_WFM_STAFF_TO_department t4
where t4.staff_id = t1.staff_id
  and t4.effective_date = t1.effective_date
  and t4.department_id = t1.department_id
  and trunc(nvl(t4.end_date,sysdate)) = trunc(nvl(t1.end_date,sysdate))  
);

commit;

----------------------------------------------------------------------	
----------------------------------------------------------------------	

update DP_SCORECARD.PP_WFM_STAFF_TO_OFFICE t1
set end_date = ( select end_date FROM RESTORE.PP_WFM_STAFF_TO_OFFICE t2
where t2.staff_id = t1.staff_id
  and t2.effective_date = t1.effective_date
  and t2.office_id = t1.office_id
)
where exists ( select 'x' FROM RESTORE.PP_WFM_STAFF_TO_OFFICE t3
where t3.staff_id = t1.staff_id
  and t3.effective_date = t1.effective_date
  and t3.office_id = t1.office_id
)
AND NOT exists ( select 'x' FROM RESTORE.PP_WFM_STAFF_TO_OFFICE t4
where t4.staff_id = t1.staff_id
  and t4.effective_date = t1.effective_date
  and t4.office_id = t1.office_id
  and trunc(nvl(t4.end_date,sysdate)) = trunc(nvl(t1.end_date,sysdate))  
);

commit;

