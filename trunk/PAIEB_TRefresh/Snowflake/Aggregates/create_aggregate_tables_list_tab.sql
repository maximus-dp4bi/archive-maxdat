drop table control.paieb_aggregate_tables_list;
CREATE TABLE control.paieb_aggregate_tables_list(
    Aggregate_Process_Name VARCHAR,
    Source_Table_Name VARCHAR, 
    Source_Table_Schema VARCHAR,
    Destination_Table_Name VARCHAR, 
    Destination_Table_Schema VARCHAR,
    Insert_Fields VARCHAR, 
    Select_Fields VARCHAR,
    Where_Clause VARCHAR,
    Merge_Join VARCHAR,
    Is_Active VARCHAR);

ALTER TABLE control.paieb_aggregate_tables_list ADD PRIMARY KEY(Aggregate_Process_Name);    

INSERT INTO control.paieb_aggregate_tables_list(Aggregate_Process_Name,Source_Table_Name,Source_Table_Schema,Destination_Table_Name,Destination_Table_Schema,Insert_Fields,Select_Fields,Where_Clause,Merge_Join,Is_Active)
VALUES('CHC_DAILY_ENROLL_COUNTS','F_CHC_DAILY_ENRL_CNTS_SV','MAXDAT_SUPPORT','D_CHC_ENRL_AGGREGATES','PAIEB_UAT',
        'REPORTDATE,CHANNEL,WEEK_NUM,FIRST_DAY_OF_WEEK,REPORT_MONTH,SELECTIONS_PROCESSED,ENROLL_COUNT,CREATE_TS'
       ,'DDATE,CHANNEL,WEEK,FIRST_DAY_OF_WEEK,MONTH,SELECTIONS_PROCESSED,ENROLL_COUNT,CURRENT_TIMESTAMP()'
       ,'WHERE 1=1'
       ,'src.DDATE = tgt.REPORTDATE AND src.CHANNEL = tgt.CHANNEL'
       ,'Y');