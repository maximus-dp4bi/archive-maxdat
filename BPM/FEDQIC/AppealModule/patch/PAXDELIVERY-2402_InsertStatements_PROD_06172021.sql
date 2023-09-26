insert into MAXDAT.CORP_ETL_LIST_LKUP ( name, list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments ) values 
('Part_D_Filter_Drug','FILTER','Part ID',1580,NULL,NULL,to_Date('17-JUN-21','dd-MON-yy'), 
to_Date('07-JUL-77','dd-MON-yy'),'Used for Filtering Part-D data under Capture_OLTP_Parts.ktr')  ;


insert into MAXDAT.CORP_ETL_LIST_LKUP ( name, list_type, value, out_var, ref_type, ref_id, start_date, end_date, comments ) values 
('Part_D_Filter_LEP','FILTER','Part ID',1581,NULL,NULL,to_Date('17-JUN-21','dd-MON-yy'), 
to_Date('07-JUL-77','dd-MON-yy'),'Used for Filtering Part-D data under Capture_OLTP_Parts.ktr')  ;

commit;