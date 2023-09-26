---- NYHIX-31578
alter session set current_schema = MAXDAT;

update d_nyhix_MFD_current_v2 
set RECVD_TO_SCAN_AGE_IN_BUS_DAYS = bus_days_between(RECEIVED_DT,scan_dt)
where dcn in ('10011608','10011573','10011574','10011591','10011592','10011593',
'10011598','10011599','10011600','10011601','10011603','10007096','10006699');
commit;
