-- Commented out because code started but very incomplete.

/*

create procedure MAXDAT.MW_V2_TEST_DATA_CREATE_INSTANCE
as
begin

  -- Configure test data generation.
  declare @v_oldest_instance_age_days int = 365;
  declare @v_avg_instance_lifetime_days int = 7;
  declare @v_avg_events_per_instance int = 4;
  declare @v_number_canceled_per_event = 0.01; -- 1 = all

  -- Randomize values.
  declare @v_instance_start_date datetime = getdate() - (@v_oldest_instance_age_days * rand());
  declare @v_instance_end_date datetime = @v_instance_start_date + (2 * @v_avg_instance_lifetime_days * rand());
  declare @v_events_per_instance int = round(2 * @v_avg_events_per_instance * rand(),0);

  -- Set initial attribute values.
  declare @v_mw_bi_id                   int = next value for MAXDAT.SEQ_MW_BI_ID;
  declare @v_age_in_business_days       int = 0;
  declare @v_age_in_calendar_days       int = 0;
  declare @v_cancelled_by_staff_id      int = null;
  declare @v_cancel_method              varchar(50) = null;
  declare @v_cancel_reason              varchar(256) = null;
  declare @v_cancel_work_date           datetime = null;
  declare @v_case_id                    int = null;
  declare @v_client_id                  int = null; 
  declare @v_complete_date              datetime = null;
  declare @v_create_date                datetime = @v_instance_end_date;
  declare @v_curr_created_by_staff_id   int = null;
  declare @v_escalated_flag             varchar(1) = 'N';
  declare @v_curr_escalated_to_staff_id int = null;
  declare @v_curr_forwarded_by_staff_id int = null;
  declare @v_forwarded_flag             varchar(1) = 'N';
  declare @v_curr_business_unit_id      int = null;
  declare @v_jeopardy_flag              varchar(1) = 'N';
  declare @v_curr_last_upd_by_staff_id  int = null;
  declare @v_curr_last_update_date      datetime = null;
  declare @v_last_event_date            datetime = null;
  declare @v_curr_owner_staff_id        int = null;
  declare @v_parent_task_id             int = null;
  declare @v_source_reference_id        int = null;
  declare @v_source_reference_type      varchar(30)  = null;
  declare @v_curr_status_date           datetime = null;
  declare @v_status_age_in_bus_days     int = 0;
  declare @v_status_age_in_cal_days     int = 0;
  declare @v_stg_extract_date           datetime = null;
  declare @v_stg_last_update_date       datetime = null;
  declare @v_stage_done_date            datetime = null;
  declare @v_task_id                    int = null;
  declare @v_task_priority              varchar(50) = null;
  declare @v_curr_task_status           varchar(50) = null;
  declare @v_task_type_id               int = null;
  declare @v_curr_team_id               int = null;
  declare @v_timeliness_status          varchar(20) = 'not complete'
  declare @v_unit_of_work               varchar(30) = null;
  declare @v_curr_work_receipt_date     datetime = null;
  declare @v_source_process_id          int = null;
  declare @v_source_process_instance_id int = null;



end;
go
*/