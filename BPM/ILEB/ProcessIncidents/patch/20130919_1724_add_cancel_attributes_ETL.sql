-- Add cancel attributes to ETL staging tables

alter table CORP_ETL_PROCESS_INCIDENTS add (CANCEL_BY varchar2(50),
                                            CANCEL_REASON varchar2(256),
                                            CANCEL_METHOD varchar2(50));


alter table PROCESS_INCIDENTS_OLTP add (CANCEL_BY varchar2(50),
                                        CANCEL_REASON varchar2(256),
                                        CANCEL_METHOD varchar2(50));


alter table PROCESS_INCIDENTS_WIP_BPM add (CANCEL_BY varchar2(50),
                                           CANCEL_REASON varchar2(256),
                                           CANCEL_METHOD varchar2(50));

commit;