---- NYHIX-31578
alter session set current_schema = MAXDAT;

update d_nyhix_MFD_current_v2 
set RECVD_TO_SCAN_AGE_IN_BUS_DAYS = bus_days_between(RECEIVED_DT,scan_dt)
where dcn in 
('10005303',
'10005304',
'11736800',
'11736801',
'11736799',
'10011251',
'DCN1112223334567',
'DCN1112223338867');

commit;
    