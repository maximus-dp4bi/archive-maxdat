UPDATE d_pi_current
SET "Cur Jeopardy Status" = DPY_PROCESS_INCIDENTS.GET_JEOPARDY_STATUS("Receipt Date","Cur Instance Status",PRIORITY)
,"Jeopardy Status Date" = to_date(DPY_PROCESS_INCIDENTS.GET_JEOPARDY_STATUS_DATE("Receipt Date","Cur Instance Status",PRIORITY),'yyyy/mm/dd hh24:mi:ss')
,"Timeliness Status" = DPY_PROCESS_INCIDENTS.GET_TIMELINESS_STATUS("Receipt Date","Cur Incident Status Date","Cur Instance Status","Cancel Date",PRIORITY)
WHERE trunc("Create Date") >= to_date('02/01/2014','mm/dd/yyyy');

commit;