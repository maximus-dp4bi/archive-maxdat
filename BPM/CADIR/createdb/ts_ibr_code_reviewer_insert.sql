create or replace Procedure TS_IBR_CODE_REVIEWER_INSERT
    (
	IN_FIRST_NAME IN VARCHAR2,
	IN_LAST_NAME IN VARCHAR2,
	IN_SUMMARY_OF_QUALIFICATION IN VARCHAR2,
	IN_LICENSE_NUMBER IN VARCHAR2,
	IN_STATE_OF_PRACTICE IN VARCHAR2,
	IN_LICENSE_CREDENTIAL IN VARCHAR2,
	IN_COMMENTS IN VARCHAR2,
	IN_START_DATE IN DATE,
	IN_END_DATE IN DATE,
	IN_CREATED_BY IN VARCHAR2,
	IN_MODIFIED_BY IN VARCHAR2
   )
    
AS
--NOTE:  IN_CHANGE_STATUS = CHANGE_STATUS_DESC and IN_CHANGE_STATUS_CODE = CHANGE_STATUS
BEGIN
 If  IN_FIRST_NAME is null  
  or IN_LAST_NAME is null 
  or (IN_END_DATE is not null and trunc(IN_END_DATE) < trunc(IN_START_DATE))
  or IN_START_DATE is null  
     
 then
     /*do nothing*/
      null;
   else
      
      insert into TS_IBR_CODE_REVIEWER
(
	CR_ID,
	FIRST_NAME,
	LAST_NAME,
	FULL_NAME,
	SUMMARY_OF_QUALIFICATION,
	LICENSE_NUMBER,
	STATE_OF_PRACTICE,
	LICENSE_CREDENTIAL,
	COMMENTS,
	START_DATE,
	END_DATE,
    CHANGE_STATUS,
    CHANGE_STATUS_DESC,
	CREATED_BY,
	CREATED_DATE,
	MODIFIED_BY,
	MODIFIED_DATE
)
      values
(
    SEQ_CR_ID.Nextval,
	IN_FIRST_NAME,
	IN_LAST_NAME,
	IN_FIRST_NAME || ' ' || IN_LAST_NAME,
	IN_SUMMARY_OF_QUALIFICATION,
	IN_LICENSE_NUMBER,
	IN_STATE_OF_PRACTICE,
	IN_LICENSE_CREDENTIAL,
	IN_COMMENTS,
	IN_START_DATE,
	IN_END_DATE,
	case when IN_END_DATE is not null then 'R' else 'A' end,
	case when IN_END_DATE is not null then 'Removal' else 'Addition' end,
	IN_CREATED_BY,
	SYSDATE,
	IN_MODIFIED_BY,
	SYSDATE
);

       commit;

   end if;
   NULL;
END;

/