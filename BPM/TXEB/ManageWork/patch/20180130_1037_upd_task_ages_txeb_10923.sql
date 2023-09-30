

update D_MW_CURRENT
    set
      "Age in Business Days" = manage_work.GET_AGE_IN_BUSINESS_DAYS("Create Date","Complete Date"),
      "Age in Calendar Days" = manage_work.GET_AGE_IN_CALENDAR_DAYS("Create Date","Complete Date"),
      "Jeopardy Flag" = manage_work.GET_JEOPARDY_FLAG("SLA Days Type","Age in Business Days","Age in Calendar Days","SLA Jeopardy Days","Jeopardy Flag"),
      "Status Age in Business Days" = manage_work.GET_STATUS_AGE_IN_BUS_DAYS("Current Status Date","Complete Date"),
      "Status Age in Calendar Days" = manage_work.GET_STATUS_AGE_IN_CAL_DAYS("Current Status Date","Complete Date"),
      "Timeliness Status" = manage_work.GET_TIMELINESS_STATUS("Complete Date","SLA Days Type","Age in Business Days","Age in Calendar Days","SLA Days")
where   ("Complete Date" is not null or "Cancel Work Date" is not null)
and "Timeliness Status" <> manage_work.GET_TIMELINESS_STATUS("Complete Date","SLA Days Type","Age in Business Days","Age in Calendar Days","SLA Days")
;



DECLARE  
  CURSOR temp_cur IS
   select "Task ID" task_id
   from D_MW_CURRENT
   where "Create Date" >= to_date('06/01/2017','mm/dd/yyyy')
   and ("Complete Date" is not null or "Cancel Work Date" is not null)
   and "Age in Business Days" <> manage_work.GET_AGE_IN_BUSINESS_DAYS("Create Date","Complete Date")
   ;    

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
        update D_MW_CURRENT
         set
          "Age in Business Days" = manage_work.GET_AGE_IN_BUSINESS_DAYS("Create Date","Complete Date"),
          "Age in Calendar Days" = manage_work.GET_AGE_IN_CALENDAR_DAYS("Create Date","Complete Date"),
          "Jeopardy Flag" = manage_work.GET_JEOPARDY_FLAG("SLA Days Type","Age in Business Days","Age in Calendar Days","SLA Jeopardy Days","Jeopardy Flag"),
          "Status Age in Business Days" = manage_work.GET_STATUS_AGE_IN_BUS_DAYS("Current Status Date","Complete Date"),
          "Status Age in Calendar Days" = manage_work.GET_STATUS_AGE_IN_CAL_DAYS("Current Status Date","Complete Date"),
          "Timeliness Status" = manage_work.GET_TIMELINESS_STATUS("Complete Date","SLA Days Type","Age in Business Days","Age in Calendar Days","SLA Days")
		     where "Task ID" = temp_tab(indx).task_id;		   
     END;
     COMMIT;
  END LOOP;
  COMMIT;
  CLOSE temp_cur;
END;
/

commit;