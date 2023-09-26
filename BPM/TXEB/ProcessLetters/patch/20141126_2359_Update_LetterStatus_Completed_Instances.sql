/*
Created on 11/26/2014 by Raj A.
Description: TXEB-3911. 
This script updates the Letter status for the completed instances. Per Su's email on 11/24 updating letter status. Below are her comments in the email.
Comments:
There is no process change – these mismatches are the result of manual scripts run by systems for various reasons.   
Please update the completed instances to match the letter request id’s status in MAXeb.  I believe the value in the letter_stg table matches production. 
*/
DECLARE  
  CURSOR temp_cur IS
  select cepl.letter_request_id, let.letter_status
	from corp_etl_proc_letters cepl,
		 letters_stg  let
	where 1=1
	and cepl.complete_dt is not null
	and cepl.letter_request_id = let.letter_id
	and cepl.status <> let.letter_status;   

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
         update corp_etl_proc_letters BPM
           set BPM.status = temp_tab(indx).letter_status
		 where 1=1
           and BPM.letter_request_id = temp_tab(indx).letter_request_id;
		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/