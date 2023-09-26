create or replace Procedure TS_IBR_CODE_REVIEWER_UPDATE
    (
    IN_CR_ID IN NUMBER
	,IN_FIRST_NAME IN VARCHAR2
	,IN_LAST_NAME IN VARCHAR2
	,IN_FULL_NAME IN VARCHAR2
	,IN_SUMMARY_OF_QUALIFICATION IN VARCHAR2
	,IN_LICENSE_NUMBER IN VARCHAR2
	,IN_STATE_OF_PRACTICE IN VARCHAR2
	,IN_LICENSE_CREDENTIAL IN VARCHAR2
	,IN_COMMENTS IN VARCHAR2
	,IN_START_DATE IN DATE
	,IN_END_DATE IN DATE
	,IN_CHANGE_STATUS_DESC IN VARCHAR2
	,IN_CHANGE_STATUS IN VARCHAR2
	,IN_CREATED_BY IN VARCHAR2
	,IN_CREATED_DATE IN DATE
	,IN_MODIFIED_BY IN VARCHAR2
	,IN_MODIFIED_DATE IN DATE
	--,IN_IBR_CODE_REVIEWER_DELETE_FLAG IN NUMBER
   )
     
AS
--NOTE:  IN_CHANGE_STATUS = CHANGE_STATUS_DESC and IN_CHANGE_STATUS_CODE = CHANGE_STATUS
BEGIN
/*
if IN_IBR_CODE_REVIEWER_DELETE_FLAG = 1 then
     delete from TS_IBR_CODE_REVIEWER where CR_ID = IN_CR_ID;
     commit;
*/
if
length(IN_FIRST_NAME) is NULL AND
length(IN_LAST_NAME) is NULL AND
length(IN_SUMMARY_OF_QUALIFICATION) is NULL AND 
length(IN_LICENSE_NUMBER) is NULL AND
length(IN_STATE_OF_PRACTICE) is NULL AND 
length(IN_LICENSE_CREDENTIAL) is NULL AND 
length(IN_COMMENTS) is NULL AND
length(IN_MODIFIED_BY) is NULL 
or (IN_END_DATE is not null and trunc(IN_END_DATE) < trunc(IN_START_DATE))
then
     /*do nothing*/
      null;
   else
 
      update TS_IBR_CODE_REVIEWER
       set    FIRST_NAME = case when (length(IN_FIRST_NAME)> 0) then IN_FIRST_NAME else  FIRST_NAME end,
	          LAST_NAME = case when (length(IN_LAST_NAME)> 0) then IN_LAST_NAME else  LAST_NAME end,
			  FULL_NAME = case when (length(IN_FULL_NAME)> 0) then IN_FIRST_NAME || ' ' || IN_LAST_NAME else  IN_FIRST_NAME || ' ' || IN_LAST_NAME end,
	          SUMMARY_OF_QUALIFICATION = case when (length(IN_SUMMARY_OF_QUALIFICATION)> 0) then IN_SUMMARY_OF_QUALIFICATION else null end,
              LICENSE_NUMBER = case when (length(IN_LICENSE_NUMBER)> 0) then IN_LICENSE_NUMBER else  null end,
              STATE_OF_PRACTICE = case when (length(IN_STATE_OF_PRACTICE)> 0) then IN_STATE_OF_PRACTICE else null end,
              LICENSE_CREDENTIAL = case when (length(IN_LICENSE_CREDENTIAL)> 0) then IN_LICENSE_CREDENTIAL else null end,
              START_DATE = case when (length(IN_START_DATE)> 0) then IN_START_DATE else START_DATE end,
              END_DATE = IN_END_DATE,
              CHANGE_STATUS = case when IN_END_DATE is not null then 'R' else 'M' end,
              CHANGE_STATUS_DESC = case when IN_END_DATE is not null then 'Removal' else 'Modification' end,
              CREATED_BY = case when (length(IN_CREATED_BY)> 0) then IN_CREATED_BY else CREATED_BY end,
              COMMENTS = case when (length(IN_COMMENTS)> 0) then IN_COMMENTS else  null end,
              MODIFIED_BY = case when (length(IN_MODIFIED_BY)> 0) then IN_MODIFIED_BY else  MODIFIED_BY end,
              MODIFIED_DATE = sysdate
        where CR_ID = IN_CR_ID;

       commit;

   end if;
   NULL;

END;

/