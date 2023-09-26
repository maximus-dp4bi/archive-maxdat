-- Populate APPOINTMENT_STATUS_HISTORY table.
if OBJECT_ID ('MAXDAT.TRG_AI_APPOINTMENTS','TR') is not null
begin
  drop trigger MAXDAT.TRG_AI_APPOINTMENTS;
end;
go

create trigger MAXDAT.TRG_AI_APPOINTMENTS
on MAXDAT.APPOINTMENTS
after insert
as
begin

  declare @MAX_DATETIME datetime = convert(datetime,'9999-12-31 00:00:00',121);
  
  insert into MAXDAT.APPOINTMENT_STATUS_HISTORY 
	(APPOINTMENT_ID,APPOINTMENT_STATUS_EFFECTIVE_DT,APPOINTMENT_STATUS_END_DT,APPOINTMENT_STATUS_ID)
  select 
    APPOINTMENT_ID,
	APPOINTMENT_STATUS_DT,
	@MAX_DATETIME,
	APPOINTMENT_STATUS_ID
  from INSERTED 
  order by 
	APPOINTMENT_ID asc, 
	APPOINTMENT_STATUS_DT asc;

end;
go


if OBJECT_ID ('MAXDAT.TRG_AU_APPOINTMENTS','TR') is not null
begin
  drop trigger MAXDAT.TRG_AU_APPOINTMENTS;
end;
go

create trigger MAXDAT.TRG_AU_APPOINTMENTS
on MAXDAT.APPOINTMENTS
after update
as
begin

  declare @MAX_DATETIME datetime = convert(datetime,'9999-12-31 00:00:00',121);
    
  declare @v_appointment_id int = null;
  declare @v_appointment_status_dt datetime = null;
  declare @v_appointment_status_id int = null;

  declare @v_old_appointment_status_id int = null;

  declare c_inserted cursor local for 
    select
	  APPOINTMENT_ID,
	  APPOINTMENT_STATUS_DT,
	  APPOINTMENT_STATUS_ID
	from INSERTED
	order by 
	  APPOINTMENT_ID asc, 
	  APPOINTMENT_STATUS_DT asc;
  open c_inserted;
  fetch next from c_inserted into @v_appointment_id,@v_appointment_status_dt,@v_appointment_status_id;
  while @@fetch_status = 0
    begin

      select @v_old_appointment_status_id = APPOINTMENT_STATUS_ID 
	  from MAXDAT.APPOINTMENT_STATUS_HISTORY
	  where 
	  	APPOINTMENT_ID = @v_appointment_id
		and APPOINTMENT_STATUS_END_DT = @MAX_DATETIME;

	  if @v_old_appointment_status_id != @v_appointment_status_id
	    begin

	      update MAXDAT.APPOINTMENT_STATUS_HISTORY
	      set APPOINTMENT_STATUS_END_DT = @v_appointment_status_dt
          where 
	        APPOINTMENT_ID = @v_appointment_id
		    and APPOINTMENT_STATUS_END_DT = @MAX_DATETIME; 

	      insert into MAXDAT.APPOINTMENT_STATUS_HISTORY 
	        (APPOINTMENT_ID,APPOINTMENT_STATUS_EFFECTIVE_DT,APPOINTMENT_STATUS_END_DT,APPOINTMENT_STATUS_ID)
          values 
	        (@v_appointment_id,@v_appointment_status_dt,@MAX_DATETIME,@v_appointment_status_id);

	    end;

	  fetch next from c_inserted into @v_appointment_id,@v_appointment_status_dt,@v_appointment_status_id;

    end;

  close c_inserted;
  deallocate c_inserted;

end;
go


-- Populate D_APPOINTMENT_STATUS_HISTORY table.
if OBJECT_ID ('MAXDAT.TRG_AI_APPOINTMENT_STATUS_HISTORY','TR') is not null
begin
  drop trigger MAXDAT.TRG_AI_APPOINTMENT_STATUS_HISTORY;
end;
go

create trigger MAXDAT.TRG_AI_APPOINTMENT_STATUS_HISTORY
on MAXDAT.APPOINTMENT_STATUS_HISTORY
after insert 
as
begin

  declare @MIN_DATE date = convert(date,'0001-01-01',121);
  declare @MAX_DATE date = convert(date,'9999-12-31',121);

  declare @v_appointment_id int = null;
  declare @v_appointment_status_effective_dt datetime = null;
  declare @v_appointment_status_end_dt datetime = null;
  declare @v_appointment_status_id int = null;

  declare @v_num_history int = null;
  declare @v_max_last_event_dt datetime = null;
  declare @v_max_bucket_start_date date = null;

  declare c_inserted cursor local for 
    select
	  APPOINTMENT_ID,
	  APPOINTMENT_STATUS_EFFECTIVE_DT,
	  APPOINTMENT_STATUS_END_DT,
	  APPOINTMENT_STATUS_ID
	from INSERTED
	order by 
	  APPOINTMENT_ID asc, 
	  APPOINTMENT_STATUS_EFFECTIVE_DT asc;
  open c_inserted;
  fetch next from c_inserted into @v_appointment_id,@v_appointment_status_effective_dt,@v_appointment_status_end_dt,@v_appointment_status_id;
  while @@fetch_status = 0
    begin

      select @v_num_history = count(*) from MAXDAT.D_APPOINTMENT_STATUS_HISTORY where APPOINTMENT_ID = @v_appointment_id;

	  if @v_num_history = 0
		begin

		  -- First history row.
		  insert into MAXDAT.D_APPOINTMENT_STATUS_HISTORY 
	        (APPOINTMENT_ID,LAST_EVENT_DT,BUCKET_START_DATE,BUCKET_END_DATE,APPOINTMENT_STATUS_ID)
          values 
	        (@v_appointment_id,@v_appointment_status_effective_dt,@MIN_DATE,@MAX_DATE,@v_appointment_status_id);

		end;

      else

		begin

		  -- Assumes last event date and last bucket date are in the same history row.
		  select
		    @v_max_last_event_dt = max(LAST_EVENT_DT),
		    @v_max_bucket_start_date = max(BUCKET_START_DATE)
		  from MAXDAT.D_APPOINTMENT_STATUS_HISTORY 
		  where APPOINTMENT_ID = @v_appointment_id;

		  if @v_max_bucket_start_date = @MIN_DATE and convert(date,@v_appointment_status_effective_dt) = convert(date,@v_max_last_event_dt)
		    begin

			  -- Same bucket date for initial history date.
			  update MAXDAT.D_APPOINTMENT_STATUS_HISTORY
			  set 
			    LAST_EVENT_DT = @v_appointment_status_effective_dt,
			    APPOINTMENT_STATUS_ID = @v_appointment_status_id
              where 
			    APPOINTMENT_ID = @v_appointment_id
				and BUCKET_START_DATE = @MIN_DATE
				and BUCKET_END_DATE = @MAX_DATE;

			end;

		  else if convert(date,@v_appointment_status_effective_dt) = @v_max_bucket_start_date
		    begin

			  -- Same bucket date (non-initial) for latest history date.
			  update MAXDAT.D_APPOINTMENT_STATUS_HISTORY
			  set 
			    LAST_EVENT_DT = @v_appointment_status_effective_dt,
			    APPOINTMENT_STATUS_ID = @v_appointment_status_id
              where 
			    APPOINTMENT_ID = @v_appointment_id
				and BUCKET_START_DATE = @v_max_bucket_start_date
				and BUCKET_END_DATE = @MAX_DATE;

			end;

		  else

		  	begin

			  -- Different bucket date for latest history date.

			  update MAXDAT.D_APPOINTMENT_STATUS_HISTORY
			  set BUCKET_END_DATE = convert(date,@v_appointment_status_effective_dt - 1)
              where 
			    APPOINTMENT_ID = @v_appointment_id
				and BUCKET_START_DATE = @v_max_bucket_start_date
				and BUCKET_END_DATE = @MAX_DATE;

			  insert into MAXDAT.D_APPOINTMENT_STATUS_HISTORY 
	            (APPOINTMENT_ID,LAST_EVENT_DT,BUCKET_START_DATE,BUCKET_END_DATE,APPOINTMENT_STATUS_ID)
              values 
	            (@v_appointment_id,@v_appointment_status_effective_dt,convert(date,@v_appointment_status_effective_dt),@MAX_DATE,@v_appointment_status_id);

			end;

        end;
		
	  fetch next from c_inserted into @v_appointment_id,@v_appointment_status_effective_dt,@v_appointment_status_end_dt,@v_appointment_status_id;

    end;

  close c_inserted;
  deallocate c_inserted;

end;
go


-- Populate ASSESSMENT_STATUS_HISTORY table.
if OBJECT_ID ('MAXDAT.TRG_AI_ASSESSMENTS','TR') is not null
begin
  drop trigger MAXDAT.TRG_AI_ASSESSMENTS;
end;
go

create trigger MAXDAT.TRG_AI_ASSESSMENTS
on MAXDAT.ASSESSMENTS
after insert
as
begin

  declare @MAX_DATETIME datetime = convert(datetime,'9999-12-31 00:00:00',121);
  
  insert into MAXDAT.ASSESSMENT_STATUS_HISTORY 
	(ASSESSMENT_ID,ASSESSMENT_STATUS_EFFECTIVE_DT,ASSESSMENT_STATUS_END_DT,ASSESSMENT_STATUS_ID)
  select 
    ASSESSMENT_ID,
	ASSESSMENT_STATUS_DT,
	@MAX_DATETIME,
	ASSESSMENT_STATUS_ID
  from INSERTED 
  order by 
	ASSESSMENT_ID asc, 
	ASSESSMENT_STATUS_DT asc;

end;
go


if OBJECT_ID ('MAXDAT.TRG_AU_ASSESSMENTS','TR') is not null
begin
  drop trigger MAXDAT.TRG_AU_ASSESSMENTS;
end;
go

create trigger MAXDAT.TRG_AU_ASSESSMENTS
on MAXDAT.ASSESSMENTS
after update
as
begin
  
  declare @MAX_DATETIME datetime = convert(datetime,'9999-12-31 00:00:00',121);
    
  declare @v_assessment_id int = null;
  declare @v_assessment_status_dt datetime = null;
  declare @v_assessment_status_id int = null;

  declare @v_old_assessment_status_id int = null;

  declare c_inserted cursor local for 
    select
	  ASSESSMENT_ID,
	  ASSESSMENT_STATUS_DT,
	  ASSESSMENT_STATUS_ID
	from INSERTED
	order by 
	  ASSESSMENT_ID asc, 
	  ASSESSMENT_STATUS_DT asc;
  open c_inserted;
  fetch next from c_inserted into @v_assessment_id,@v_assessment_status_dt,@v_assessment_status_id;
  while @@fetch_status = 0
    begin

      select @v_old_assessment_status_id = ASSESSMENT_STATUS_ID 
	  from MAXDAT.ASSESSMENT_STATUS_HISTORY
	  where 
	  	ASSESSMENT_ID = @v_assessment_id
		and ASSESSMENT_STATUS_END_DT = @MAX_DATETIME;

	  if @v_old_assessment_status_id != @v_assessment_status_id
	    begin

	      update MAXDAT.ASSESSMENT_STATUS_HISTORY
	      set ASSESSMENT_STATUS_END_DT = @v_assessment_status_dt
          where 
	        ASSESSMENT_ID = @v_assessment_id
		    and ASSESSMENT_STATUS_END_DT = @MAX_DATETIME;

	      insert into MAXDAT.ASSESSMENT_STATUS_HISTORY 
	        (ASSESSMENT_ID,ASSESSMENT_STATUS_EFFECTIVE_DT,ASSESSMENT_STATUS_END_DT,ASSESSMENT_STATUS_ID)
          values 
	        (@v_assessment_id,@v_assessment_status_dt,@MAX_DATETIME,@v_assessment_status_id);

		end;

	  fetch next from c_inserted into @v_assessment_id,@v_assessment_status_dt,@v_assessment_status_id;

    end;

  close c_inserted;
  deallocate c_inserted;

end;
go


-- Populate D_ASSESSMENT_STATUS_HISTORY table.
if OBJECT_ID ('MAXDAT.TRG_AI_ASSESSMENT_STATUS_HISTORY','TR') is not null
begin
  drop trigger MAXDAT.TRG_AI_ASSESSMENT_STATUS_HISTORY;
end;
go

create trigger MAXDAT.TRG_AI_ASSESSMENT_STATUS_HISTORY
on MAXDAT.ASSESSMENT_STATUS_HISTORY
after insert 
as
begin

  declare @MIN_DATE date = convert(date,'0001-01-01',121);
  declare @MAX_DATE date = convert(date,'9999-12-31',121);

  declare @v_assessment_id int = null;
  declare @v_assessment_status_effective_dt datetime = null;
  declare @v_assessment_status_end_dt datetime = null;
  declare @v_assessment_status_id int = null;

  declare @v_num_history int = null;
  declare @v_max_last_event_dt datetime = null;
  declare @v_max_bucket_start_date date = null;

  declare c_inserted cursor local for 
    select
	  ASSESSMENT_ID,
	  ASSESSMENT_STATUS_EFFECTIVE_DT,
	  ASSESSMENT_STATUS_END_DT,
	  ASSESSMENT_STATUS_ID
	from INSERTED
	order by 
	  ASSESSMENT_ID asc, 
	  ASSESSMENT_STATUS_EFFECTIVE_DT asc;
  open c_inserted;
  fetch next from c_inserted into @v_assessment_id,@v_assessment_status_effective_dt,@v_assessment_status_end_dt,@v_assessment_status_id;
  while @@fetch_status = 0
    begin

      select @v_num_history = count(*) from MAXDAT.D_ASSESSMENT_STATUS_HISTORY where ASSESSMENT_ID = @v_assessment_id;

	  if @v_num_history = 0
		begin

		  -- First history row.
		  insert into MAXDAT.D_ASSESSMENT_STATUS_HISTORY 
	        (ASSESSMENT_ID,LAST_EVENT_DT,BUCKET_START_DATE,BUCKET_END_DATE,ASSESSMENT_STATUS_ID)
          values 
	        (@v_assessment_id,@v_assessment_status_effective_dt,@MIN_DATE,@MAX_DATE,@v_assessment_status_id);

		end;

      else

		begin

		  -- Assumes last event date and last bucket date are in the same history row.
		  select
		    @v_max_last_event_dt = max(LAST_EVENT_DT),
		    @v_max_bucket_start_date = max(BUCKET_START_DATE)
		  from MAXDAT.D_ASSESSMENT_STATUS_HISTORY 
		  where ASSESSMENT_ID = @v_assessment_id;

		  if @v_max_bucket_start_date = @MIN_DATE and convert(date,@v_assessment_status_effective_dt) = convert(date,@v_max_last_event_dt)
		    begin

			  -- Same bucket date for initial history date.
			  update MAXDAT.D_ASSESSMENT_STATUS_HISTORY
			  set 
			    LAST_EVENT_DT = @v_assessment_status_effective_dt,
			    ASSESSMENT_STATUS_ID = @v_assessment_status_id
              where 
			    ASSESSMENT_ID = @v_assessment_id
				and BUCKET_START_DATE = @MIN_DATE
				and BUCKET_END_DATE = @MAX_DATE;

			end;

		  else if convert(date,@v_assessment_status_effective_dt) = @v_max_bucket_start_date
		    begin

			  -- Same bucket date (non-initial) for latest history date.
			  update MAXDAT.D_ASSESSMENT_STATUS_HISTORY
			  set 
			    LAST_EVENT_DT = @v_assessment_status_effective_dt,
			    ASSESSMENT_STATUS_ID = @v_assessment_status_id
              where 
			    ASSESSMENT_ID = @v_assessment_id
				and BUCKET_START_DATE = @v_max_bucket_start_date
				and BUCKET_END_DATE = @MAX_DATE;

			end;

		  else

		  	begin

			  -- Different bucket date for latest history date.
			  update MAXDAT.D_ASSESSMENT_STATUS_HISTORY
			  set BUCKET_END_DATE = convert(date,@v_assessment_status_effective_dt - 1)
              where 
			    ASSESSMENT_ID = @v_assessment_id
				and BUCKET_START_DATE = @v_max_bucket_start_date
				and BUCKET_END_DATE = @MAX_DATE;

			  insert into MAXDAT.D_ASSESSMENT_STATUS_HISTORY 
	            (ASSESSMENT_ID,LAST_EVENT_DT,BUCKET_START_DATE,BUCKET_END_DATE,ASSESSMENT_STATUS_ID)
              values 
	            (@v_assessment_id,@v_assessment_status_effective_dt,convert(date,@v_assessment_status_effective_dt),@MAX_DATE,@v_assessment_status_id);

			end;

        end;
		
	  fetch next from c_inserted into @v_assessment_id,@v_assessment_status_effective_dt,@v_assessment_status_end_dt,@v_assessment_status_id;

    end;

  close c_inserted;
  deallocate c_inserted;

end;
go


-- Get the next assessment sequence number.
if OBJECT_ID ('MAXDAT.TRG_AI_ASSESSMENTS','TR') is not null
begin
  drop trigger MAXDAT.TRG_AI_ASSESSMENTS;
end;
go

create trigger MAXDAT.TRG_AI_ASSESSMENTS
on MAXDAT.ASSESSMENTS
after insert 
as
begin

  declare @v_assessment_id int = null;
  declare @v_case_id int = null;

  declare c_inserted cursor local for 
    select 
	  ASSESSMENT_ID,
	  CASE_ID 
	from INSERTED
	order by 
	  CASE_ID asc, 
	  ASSESSMENT_START_DT asc;
  open c_inserted;
  fetch next from c_inserted into @v_assessment_id,@v_case_id;
  while @@fetch_status = 0
    begin

      declare @v_assessment_sequence int = MAXDAT.ASSESSMENTS_GET_NEXT_ASSESSMENT_SEQUENCE(@v_case_id);

      update MAXDAT.ASSESSMENTS 
      set ASSESSMENT_SEQUENCE = @v_assessment_sequence
	  where ASSESSMENT_ID = @v_assessment_id;

      update MAXDAT.ASSESSMENTS
      set ASSESSMENT_REQUIRED_DT = MAXDAT.ASSESSMENTS_GET_ASSESSMENT_REQUIRED_DT(@v_case_id,@v_assessment_sequence)
	  where ASSESSMENT_ID = @v_assessment_id;

	  fetch next from c_inserted into @v_assessment_id,@v_case_id;

    end;

  close c_inserted;
  deallocate c_inserted;

end;
go

-- Populate CASE_STATUS_HISTORY table.
if OBJECT_ID ('MAXDAT.TRG_AI_CASES','TR') is not null
begin
  drop trigger MAXDAT.TRG_AI_CASES;
end;
go

create trigger MAXDAT.TRG_AI_CASES
on MAXDAT.CASES
after insert
as
begin

  declare @MAX_DATETIME datetime = convert(datetime,'9999-12-31 00:00:00',121);
  print 'TRG_AU_CASES ins'; 
  insert into MAXDAT.CASE_STATUS_HISTORY 
	(CASE_ID,CASE_STATUS_EFFECTIVE_DT,CASE_STATUS_END_DT,CASE_STATUS_ID)
  select 
    CASE_ID,
	CURRENT_STATUS_DT,
	@MAX_DATETIME,
	CASE_STATUS_ID
  from INSERTED 
  order by 
	CASE_ID asc, 
	CURRENT_STATUS_DT asc;

end;
go


if OBJECT_ID ('MAXDAT.TRG_AU_CASES','TR') is not null
begin
  drop trigger MAXDAT.TRG_AU_CASES;
end;
go

create trigger MAXDAT.TRG_AU_CASES
on MAXDAT.CASES
after update
as
begin

  declare @MAX_DATETIME datetime = convert(datetime,'9999-12-31 00:00:00',121);
    
  declare @v_case_id int = null;
  declare @v_current_status_dt datetime = null;
  declare @v_case_status_id int = null;

  declare @v_old_case_status_id int = null;

  declare c_inserted cursor local for 
    select
	  CASE_ID,
	  CURRENT_STATUS_DT,
	  CASE_STATUS_ID
	from INSERTED
	order by 
	  CASE_ID asc, 
	  CURRENT_STATUS_DT asc;
  open c_inserted;
  fetch next from c_inserted into @v_case_id,@v_current_status_dt,@v_case_status_id;
  while @@fetch_status = 0
    begin

      select @v_old_case_status_id = CASE_STATUS_ID 
	  from MAXDAT.CASE_STATUS_HISTORY
	  where 
	  	CASE_ID = @v_case_id
		and CASE_STATUS_END_DT = @MAX_DATETIME;

	  if @v_old_case_status_id != @v_case_status_id
	    begin

	      update MAXDAT.CASE_STATUS_HISTORY
	      set CASE_STATUS_END_DT = @v_current_status_dt
          where 
	        CASE_ID = @v_case_id
		    and CASE_STATUS_END_DT = @MAX_DATETIME;
	  
	      insert into MAXDAT.CASE_STATUS_HISTORY 
	        (CASE_ID,CASE_STATUS_EFFECTIVE_DT,CASE_STATUS_END_DT,CASE_STATUS_ID)
          values 
	        (@v_case_id,@v_current_status_dt,@MAX_DATETIME,@v_case_status_id);
	    
		end;

	  fetch next from c_inserted into @v_case_id,@v_current_status_dt,@v_case_status_id;

    end;

  close c_inserted;
  deallocate c_inserted;

end;
go


-- Populate D_CASE_STATUS_HISTORY table.
if OBJECT_ID ('MAXDAT.TRG_AI_CASE_STATUS_HISTORY','TR') is not null
begin
  drop trigger MAXDAT.TRG_AI_CASE_STATUS_HISTORY;
end;
go

create trigger MAXDAT.TRG_AI_CASE_STATUS_HISTORY
on MAXDAT.CASE_STATUS_HISTORY
after insert 
as
begin

  declare @MIN_DATE date = convert(date,'0001-01-01',121);
  declare @MAX_DATE date = convert(date,'9999-12-31',121);

  declare @v_case_id int = null;
  declare @v_case_status_effective_dt datetime = null;
  declare @v_case_status_end_dt datetime = null;
  declare @v_case_status_id int = null;

  declare @v_num_history int = null;
  declare @v_max_last_event_dt datetime = null;
  declare @v_max_bucket_start_date date = null;

  declare c_inserted cursor local for 
    select
	  CASE_ID,
	  CASE_STATUS_EFFECTIVE_DT,
	  CASE_STATUS_END_DT,
	  CASE_STATUS_ID
	from INSERTED
	order by 
	  CASE_ID asc, 
	  CASE_STATUS_EFFECTIVE_DT asc;
  open c_inserted;
  fetch next from c_inserted into @v_case_id,@v_case_status_effective_dt,@v_case_status_end_dt,@v_case_status_id;
  while @@fetch_status = 0
    begin

      select @v_num_history = count(*) from MAXDAT.D_CASE_STATUS_HISTORY where CASE_ID = @v_case_id;

	  if @v_num_history = 0
		begin

		  -- First history row.
		  insert into MAXDAT.D_CASE_STATUS_HISTORY 
	        (CASE_ID,LAST_EVENT_DT,BUCKET_START_DATE,BUCKET_END_DATE,CASE_STATUS_ID)
          values 
	        (@v_case_id,@v_case_status_effective_dt,@MIN_DATE,@MAX_DATE,@v_case_status_id);

		end;

      else

		begin

		  -- Assumes last event date and last bucket date are in the same history row.
		  select
		    @v_max_last_event_dt = max(LAST_EVENT_DT),
		    @v_max_bucket_start_date = max(BUCKET_START_DATE)
		  from MAXDAT.D_CASE_STATUS_HISTORY 
		  where CASE_ID = @v_case_id;

		  if @v_max_bucket_start_date = @MIN_DATE and convert(date,@v_case_status_effective_dt) = convert(date,@v_max_last_event_dt)
		    begin

			  -- Same bucket date for initial history date.
			  update MAXDAT.D_CASE_STATUS_HISTORY
			  set 
			    LAST_EVENT_DT = @v_case_status_effective_dt,
			    CASE_STATUS_ID = @v_case_status_id
              where 
			    CASE_ID = @v_case_id
				and BUCKET_START_DATE = @MIN_DATE
				and BUCKET_END_DATE = @MAX_DATE;

			end;

		  else if convert(date,@v_case_status_effective_dt) = @v_max_bucket_start_date
		    begin

			  -- Same bucket date (non-initial) for latest history date.
			  update MAXDAT.D_CASE_STATUS_HISTORY
			  set 
			    LAST_EVENT_DT = @v_case_status_effective_dt,
			    CASE_STATUS_ID = @v_case_status_id
              where 
			    CASE_ID = @v_case_id
				and BUCKET_START_DATE = @v_max_bucket_start_date
				and BUCKET_END_DATE = @MAX_DATE;

			end;

		  else

		  	begin

			  -- Different bucket date for latest history date.

			  update MAXDAT.D_CASE_STATUS_HISTORY
			  set BUCKET_END_DATE = convert(date,@v_case_status_effective_dt - 1)
              where 
			    CASE_ID = @v_case_id
				and BUCKET_START_DATE = @v_max_bucket_start_date
				and BUCKET_END_DATE = @MAX_DATE;

			  insert into MAXDAT.D_CASE_STATUS_HISTORY 
	            (CASE_ID,LAST_EVENT_DT,BUCKET_START_DATE,BUCKET_END_DATE,CASE_STATUS_ID)
              values 
	            (@v_case_id,@v_case_status_effective_dt,convert(date,@v_case_status_effective_dt),@MAX_DATE,@v_case_status_id);

			end;

        end;
		
	  fetch next from c_inserted into @v_case_id,@v_case_status_effective_dt,@v_case_status_end_dt,@v_case_status_id;

    end;

  close c_inserted;
  deallocate c_inserted;

end;
go