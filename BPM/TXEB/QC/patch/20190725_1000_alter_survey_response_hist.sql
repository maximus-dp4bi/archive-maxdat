--Alter SURVEY_RESPONSE_HIST
--TXEB-14654
ALTER TABLE SURVEY_RESPONSE_HIST
      ADD (
		  SURVEY_STATUS_HISTORY_ID NUMBER(18,0)
      );
