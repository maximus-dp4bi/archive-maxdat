-- DWD 8/12/2014
-- Create table
create table RA_IMR_MONTHLY_REPORT (
  rimr_id                   number
, report_date               date
, case_received             number
, poten_case_inelig         number
, case_inelig               number
, case_elig                 number
, case_completed            number
, case_standard_comp        number
, case_stand_comp_timely    number
, case_stand_comp_untimely  number
, case_std_avg_day_comp     number
, case_expedite_comp        number
, case_expedite_comp_timely number
, case_exp_avg_day_comp     number
, ur_overturned             number
, case_single_review_comp   number
, case_multiple_review_comp number
, create_date               date
, last_update_date          date
)
tablespace MAXDAT_DATA;

-- Add comments to the columns 
comment on column RA_IMR_MONTHLY_REPORT.RIMR_ID                   is 'PK for the table';
comment on column RA_IMR_MONTHLY_REPORT.report_date               is 'Reporting month of the aggregated counts';
comment on column RA_IMR_MONTHLY_REPORT.case_received             is 'Number of unique cases received for reporting month';
comment on column RA_IMR_MONTHLY_REPORT.poten_case_inelig         is 'Potentially cases ineligible for IMR';
comment on column RA_IMR_MONTHLY_REPORT.case_inelig               is 'Ineligible cases for IMR - from Entellitrak';
comment on column RA_IMR_MONTHLY_REPORT.case_elig                 is 'Eligible cases for MIR - from Maxdat';
comment on column RA_IMR_MONTHLY_REPORT.case_completed            is 'Cases completed - from Entillitrak';
comment on column RA_IMR_MONTHLY_REPORT.case_standard_comp        is 'Number of standard IMR determinations completed';
comment on column RA_IMR_MONTHLY_REPORT.case_stand_comp_timely    is 'Number of standard IMR completed within timeframe';
comment on column RA_IMR_MONTHLY_REPORT.case_stand_comp_untimely  is 'Number of standard IMR completed outside timeframe';
comment on column RA_IMR_MONTHLY_REPORT.case_std_avg_day_comp     is 'Average number of days to complete standard IMR determination';
comment on column RA_IMR_MONTHLY_REPORT.case_expedite_comp        is 'Number of expedaited IMR determinations completed';
comment on column RA_IMR_MONTHLY_REPORT.case_expedite_comp_timely is 'Number of expedited IMR completed within timeframe';
comment on column RA_IMR_MONTHLY_REPORT.case_exp_avg_day_comp     is 'Average number of days to complete expedited IMR determination';
comment on column RA_IMR_MONTHLY_REPORT.ur_overturned             is 'Number of UR decisions overturned';
comment on column RA_IMR_MONTHLY_REPORT.case_single_review_comp   is 'Should be same as case_completed';
comment on column RA_IMR_MONTHLY_REPORT.case_multiple_review_comp is 'Should be 0;  case_single_review_comp - case_completed';
comment on column RA_IMR_MONTHLY_REPORT.create_date               is 'Creation date';
comment on column RA_IMR_MONTHLY_REPORT.last_update_date          is 'Last updated date';

-- Create sequence 
create sequence SEQ_RIMR_ID
   start with 1 increment by 1;

-- Grant/Revoke object privileges 
grant select on RA_IMR_MONTHLY_REPORT to maxdat_read_only;

-- create trigger
create or replace trigger TRG_BIU_RA_IMR_MONTHLY_REPORT
before insert or update on RA_IMR_MONTHLY_REPORT
for each row
begin
  if inserting then
     if :new.RIMR_ID is null then
        :new.RIMR_ID := SEQ_RIMR_ID.nextval;
     end if;
     if :new.CREATE_DATE is null then
        :new.CREATE_DATE := sysdate;
     end if;
  end if;     
  if :new.LAST_UPDATE_DATE is null then
     :new.LAST_UPDATE_DATE := sysdate;
  end if;
end;
/

-- Add control variables
INSERT INTO corp_etl_control VALUES ('IMR_MONTHLY_DWC_RUN_DAYS','V','1,2,3,4,5,6,22,22,23,24,25,26','Day of the month to run the report (comma or space separated)',SYSDATE,SYSDATE);
INSERT INTO corp_etl_control VALUES ('IMR_MONTHLY_DWC_LAST_RUN','V','201407','Last Month the report was run in YYYYMM',SYSDATE,SYSDATE);
COMMIT;

-- Done
