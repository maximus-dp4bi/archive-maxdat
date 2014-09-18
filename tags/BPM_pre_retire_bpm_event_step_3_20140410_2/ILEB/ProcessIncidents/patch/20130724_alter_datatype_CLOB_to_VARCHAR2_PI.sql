truncate table process_incidents_oltp;

truncate table process_incidents_wip_bpm;

alter table process_incidents_oltp drop (RESOLUTION_DESCRIPTION);

alter table process_incidents_wip_bpm drop (RESOLUTION_DESCRIPTION);

alter table process_incidents_oltp add (RESOLUTION_DESCRIPTION varchar2(4000));

alter table process_incidents_wip_bpm add (RESOLUTION_DESCRIPTION varchar2(4000));

alter table corp_etl_process_incidents add (dummy varchar2(4000));

update corp_etl_process_incidents
set dummy= dbms_lob.substr( RESOLUTION_DESCRIPTION, 4000, 1 );

commit;

alter table corp_etl_process_incidents drop (RESOLUTION_DESCRIPTION);

alter table corp_etl_process_incidents RENAME COLUMN dummy to RESOLUTION_DESCRIPTION ;