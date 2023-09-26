alter table QC_REVIEW_QUESTION_ANSWER 
ADD (
  response_created_by_name    VARCHAR2(100),
  response_updated_by_name    VARCHAR2(100)
);

 grant select on   QC_REVIEW_QUESTION_ANSWER to MAXDAT_READ_ONLY;  
