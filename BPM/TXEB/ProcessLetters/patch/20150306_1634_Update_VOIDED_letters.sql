/*
Created on 03/06/2015 by Raj A.
Description: Per TXEB-4610, this script updates the 669840 letters (all are 'H10' i.e., Checkup Due Letters) that are voided on 02/24/2015 by the EB System.
Updating Letters_STG with the current letter_type
Completing the instances in the Process Letters ETL stage table.
*/
declare 

CURSOR letters_cur IS
select letter_id, 
       letter_status, 
	   letter_update_ts, 
	   letter_updated_by
from letters_stg
where 1=1
and letter_type in ('Checkup Due Letter')
and trunc(letter_create_ts) >= to_date('02/21/2015','mm/dd/yyyy')
and trunc(letter_create_ts) <= to_date('02/22/2015','mm/dd/yyyy')
and letter_status = 'Voided'
--and letter_id = 25775061
;

   TYPE t_letter_tab IS TABLE OF letters_cur%ROWTYPE INDEX BY PLS_INTEGER;
   letter_tab   t_letter_tab;
   v_bulk_limit NUMBER := 5000;
    v_err_code   VARCHAR2(30);
    v_err_msg    VARCHAR2(240);
   
begin

OPEN letters_cur;
   LOOP
     FETCH letters_cur BULK COLLECT INTO letter_tab LIMIT v_bulk_limit;
     EXIT WHEN letter_tab.COUNT = 0; -- Exit when missing rows
	 
	  FOR indx IN 1 .. letter_tab.COUNT LOOP
       BEGIN
	   
	   update letters_stg
          set letter_type_cd = 'H10M',
              letter_type = 'Checkup Due Medical Letter'
	    where letter_id = letter_tab(indx).letter_id;
		
	   update corp_etl_proc_letters
        set 
            letter_type = 'Checkup Due Medical Letter',
            status = letter_tab(indx).letter_status,
			      status_dt = letter_tab(indx).letter_update_ts,
            instance_status = 'Complete',
		        complete_dt = letter_tab(indx).letter_update_ts,
			      stage_done_date = letter_tab(indx).letter_update_ts,			      
			      cancel_dt = letter_tab(indx).letter_update_ts,
			      cancel_by = letter_tab(indx).letter_updated_by,
			      cancel_reason = 'Req cancelled by system due to OBE/COMBND status',
			      cancel_method = 'Normal'
		where letter_request_id = letter_tab(indx).letter_id;  
		
		EXCEPTION
         WHEN OTHERS THEN
           v_err_code := SQLCODE;
           v_err_msg := SUBSTR(SQLERRM, 1, 200);
            insert into corp_etl_error_log values(
                SEQ_CEEL_ID.nextval,--CEEL_ID
                sysdate,--ERR_DATE
                'CRITICAL',--ERR_LEVEL
                'LETTERS',--PROCESS_NAME
                'UPD_ADHOC_VOIDED_LETTERS_20150306',--JOB_NAME
                '1',--NR_OF_ERROR
                v_err_msg,--ERROR_DESC
                null,--ERROR_FIELD
                v_err_code,--ERROR_CODES
                sysdate,--CREATE_TS
                sysdate,--UPDATE_TS
                'CORP_ETL_PROC_LETTERS',--DRIVER_TABLE_NAME
                letter_tab(indx).letter_id);--DRIVER_KEY_NUMBER
       END;
     END LOOP;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE letters_cur;
END;