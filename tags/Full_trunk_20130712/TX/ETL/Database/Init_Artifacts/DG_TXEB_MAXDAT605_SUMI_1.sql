--grant script

Grant select on corp_etl_control to MAXDAT_READ_ONLY;
Grant select on corp_etl_list_lkup to MAXDAT_READ_ONLY; 
Grant select on corp_etl_list_lkup_hist to MAXDAT_READ_ONLY;
Grant select on groups_stg to MAXDAT_READ_ONLY;
Grant select on holidays to MAXDAT_READ_ONLY; 
Grant select on staff_stg to MAXDAT_READ_ONLY;
Grant select on step_definition_stg to MAXDAT_READ_ONLY;
Grant select on step_instance_stg to MAXDAT_READ_ONLY; 
Grant select on GROUP_STEP_DEFINITION_STG to MAXDAT_READ_ONLY; 
Grant select on GROUP_STEP_DEFN_DEFAULT_STG to MAXDAT_READ_ONLY; 
Grant select on seq_cec to MAXDAT_READ_ONLY; 
Grant select on SEQ_CELL_ID to MAXDAT_READ_ONLY; 
Grant select on Seq_cemw_Id to MAXDAT_READ_ONLY; 
Grant select on Seq_holiday_Id to MAXDAT_READ_ONLY; 

Grant execute on Get_WeekDay to MAXDAT_READ_ONLY; 
Grant execute on get_bus_date to MAXDAT_READ_ONLY; 
Grant execute on GET_INLIST_STR3 to MAXDAT_READ_ONLY; 
Grant execute on get_inlist_str2 to MAXDAT_READ_ONLY; 
Grant execute on BUS_DAYS_BETWEEN to MAXDAT_READ_ONLY; 









