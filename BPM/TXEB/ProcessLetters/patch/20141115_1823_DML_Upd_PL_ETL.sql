/*
Created on 11/15/2014 by Raj A.
Description: TXEB-3911. Below is Arlene's comments from the ticket.
We need to update the complete date to null for those instances in the ETL table where the instance status is Active but complete date is not null. 
These instances have a NULL value in the current dimension. If we don't update the complete date to null in the ETL table, the updates to these 
instances will not get processed. I ran the queries to check the counts by letter status and there are huge discrepancies between the counts 
(see spreadsheet attached).
*/
DECLARE  
  CURSOR temp_cur IS
  SELECT t.letter_request_id
    FROM corp_etl_proc_letters t
    where instance_status = 'Active'
    and complete_dt is not null;   

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
         UPDATE corp_etl_proc_letters
            SET complete_dt = null, stage_done_date = null
         WHERE letter_request_id = temp_tab(indx).letter_request_id;
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/