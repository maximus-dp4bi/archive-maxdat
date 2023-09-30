-- Populate D_MW_V2_HISTORY table.

-- Commented out because requirements incomplete, uncompiled and untested.
/*
if OBJECT_ID ('MAXDAT.TRG_AIU_D_MW_V2_CURRENT','TR') is not null
begin
  drop trigger MAXDAT.TRG_AIU_D_MW_V2_CURRENT;
end;
go

create trigger MAXDAT.TRG_AIU_D_MW_V2_CURRENT
on MAXDAT.D_MW_V2_CURRENT
after insert,update
as
begin

  declare @MIN_DATE date = convert(date,'0001-01-01',121);
  declare @MAX_DATE date = convert(date,'9999-12-31',121);

  declare @v_mw_bi_id int = null;
  declare @v_last_update_dt datetime = null;
  declare @v_task_status varchar(32) = null;
  declare @v_business_unit_id int = null;
  declare @v_team_id int = null;
  declare @v_status_date datetime = null;
  declare @v_work_receipt_date datetime = null;

  declare @v_num_history int = null;
  declare @v_max_last_update_dt datetime = null;
  declare @v_max_bucket_start_date date = null;

  declare c_inserted cursor for 
    select
	  MW_BI_ID,
	  CURR_LAST_UPDATE_DATE,
	  CURR_TASK_STATUS
	  CURR_BUSINESS_UNIT_ID,
	  CURR_TEAM_ID,
	  CURR_STATUS_DATE,
	  CURR_WORK_RECEIPT_DATE
	from INSERTED;
  open c_inserted;
  fetch next from c_inserted into @v_mw_bi_id,@v_last_update_dt,@v_task_status,@v_business_unit_id,@v_team_id,@v_status_date,@v_work_receipt_date;
  while @@fetch_status = 0
    begin

      select @v_num_history = count(*) from MAXDAT.D_MW_V2_HISTORY where MW_BI_ID = @v_mw_bi_id;

	  if @v_num_history = 0
		begin
		  
	     -- First history row.
	     insert into MAXDAT.D_MW_V2_HISTORY 
	       (MW_BI_ID,LAST_UPDATE_DT,BUCKET_START_DATE,BUCKET_END_DATE,TASK_STATUS,BUSINESS_UNIT_ID,TEAM_ID,STATUS_DATE,WORK_RECEIPT_DATE)
         values 
	   	   (@v_mw_bi_id,@v_last_update_dt,@MIN_DATE,@MAX_DATE,@v_task_status,@v_business_unit_id,@v_team_id,@v_status_date,@v_work_receipt_date)

		end;

      else

		begin

		  -- Assumes last event date and last bucket date are in the same history row.
		  select
		    @v_max_last_update_dt = max(LAST_UPDATE_DT),
		    @v_max_bucket_start_date = max(BUCKET_START_DATE)
		  from MAXDAT.D_MW_V2_HISTORY 
		  where MW_BI_ID = @v_mw_bi_id;

		  if @v_max_bucket_start_date = @MIN_DATE and convert(date,@v_last_update_dt) = convert(date,@v_max_last_update_dt)
		    begin

			  -- Same bucket date for initial history date.
			  update MAXDAT.D_MW_V2_HISTORY
			  set 
			    LAST_UPDATE_DT = @v_last_update_dt,
			    TASK_STATUS = @v_task_status,
				BUSINESS_UNIT_ID = @v_business_unit_id,
				TEAM_ID = @v_team_id,
				STATUS_DATE = @v_status_date,
				WORK_RECEIPT_DATE = @v_work_receipt_date
              where 
			    MW_BI_ID = @v_mw_bi_id
				and BUCKET_START_DATE = @MIN_DATE
				and BUCKET_END_DATE = @MAX_DATE;

			end;

		  else if convert(date,@v_last_update_dt) = @v_max_bucket_start_date
		    begin

			  -- Same bucket date (non-initial) for latest history date.
			  update MAXDAT.D_MW_BI_HISTORY
			  set 
			    LAST_UPDATE_DT = @v_last_update_dt,
			    TASK_STATUS = @v_task_status,
				BUSINESS_UNIT_ID = @v_business_unit_id,
				TEAM_ID = @v_team_id,
				STATUS_DATE = @v_status_date,
				WORK_RECEIPT_DATE = @v_work_receipt_date
              where 
			    MW_BI_ID = @v_mw_bi_id
				and BUCKET_START_DATE = @v_max_bucket_start_date
				and BUCKET_END_DATE = @MAX_DATE;

			end;

		  else

		  	begin

			  -- Different bucket date for latest history date.

			  update MAXDAT.D_MW_V2_HISTORY
			  set BUCKET_END_DATE = convert(date,@v_last_update_dt - 1)
              where 
			    MW_BI_ID = @v_mw_bi_id
				and BUCKET_START_DATE = @v_max_bucket_start_date
				and BUCKET_END_DATE = @MAX_DATE;

			  insert into MAXDAT.D_MW_V2_HISTORY 
	            (MW_BI_ID,LAST_UPDATE_DT,BUCKET_START_DATE,BUCKET_END_DATE,TASK_STATUS,BUSINESS_UNIT_ID,TEAM_ID,STATUS_DATE,WORK_RECEIPT_DATE)
              values 
	   	        (@v_mw_bi_id,@v_last_update_dt,convert(date,@v_last_update_dt),@MAX_DATE,@v_task_status,@v_business_unit_id,@v_team_id,@v_status_date,@v_work_receipt_date)

			end;

        end;

	   fetch next from c_inserted into @v_mw_bi_id,@v_last_update_dt,@v_task_status,@v_business_unit_id,@v_team_id,@v_status_date,@v_work_receipt_date;

    end;

  close c_inserted;
  deallocate c_inserted;

end;
go
*/