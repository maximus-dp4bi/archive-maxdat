-- Generate test data for UK HWS Assessments MAXDat tables.

-- Truncate all MAXDat Assessments data:
-- Tables truncated are listed in Review Results section below.
-- USE WITH CAUTION!   Download this script from SVN and execute it.
--   svn://rcmxapp1d.maximus.com/maxdat/BPM/UK_HWS/Assessments/createdb/mssql/truncate_data_model_Assessments.sql
--
-- Generate Test Data:
-- Parameter is number of CASES to create.
-- Approx. 50K cases can be created per hour.
--   execute MAXDAT.ASSESSMENTS_TEST_GENERATE_DATA 1000;
--
-- Review Results:
-- 
--  Inserted/updated by test generator:
--    select * from MAXDAT.RESOURCES order by RESOURCE_ID asc;
--    select * from MAXDAT.CASES order by CASE_ID asc;
--    select * from MAXDAT.ASSESSMENTS order by CASE_ID asc, ASSESSMENT_SEQUENCE asc;
--    select * from MAXDAT.DWP_SIGNPOSTING order by ASSESSMENT_ID asc, DWP_SIGNPOSTING_EFFECTIVE_DT asc;
--    select * from MAXDAT.DWP_INTERVENTIONS order by ASSESSMENT_ID asc, DWP_INTERVENTION_EFFECTIVE_DT asc;
--    select * from MAXDAT.ASSESSMENT_OUTCOMES order by ASSESSMENT_ID asc, ASSESSMENT_OUTCOME_EFFECTIVE_DT asc;
--    select * from MAXDAT.OBSTACLES order by ASSESSMENT_ID asc, OBSTACLE_ID asc;
--    select * from MAXDAT.RECOM_SIGNPOSTING_ADJUST order by OBSTACLE_ID asc, RSA_ID asc;
--    select * from MAXDAT.APPOINTMENTS order by CASE_ID asc,ASSESSMENT_ID asc,APPOINTMENT_ID asc;
--    select * from MAXDAT.APPOINTMENT_DATE_HISTORY order by APPOINTMENT_ID asc, APPOINTMENT_DATE_EFFECTIVE_DT asc;
--
--  Inserted/updated by triggers:
--    select * from MAXDAT.APPOINTMENT_STATUS_HISTORY order by APPOINTMENT_ID asc, APPOINTMENT_STATUS_EFFECTIVE_DT asc;
--    select * from MAXDAT.ASSESSMENT_STATUS_HISTORY order by ASSESSMENT_ID asc, ASSESSMENT_STATUS_EFFECTIVE_DT asc;
--    select * from MAXDAT.CASE_STATUS_HISTORY order by CASE_ID asc, CASE_STATUS_EFFECTIVE_DT asc;
--
--    select * from MAXDAT.D_APPOINTMENT_STATUS_HISTORY order by APPOINTMENT_ID asc, BUCKET_START_DATE asc;
--    select * from MAXDAT.D_ASSESSMENT_STATUS_HISTORY order by ASSESSMENT_ID asc, BUCKET_START_DATE asc;
--    select * from MAXDAT.D_CASE_STATUS_HISTORY order by CASE_ID asc, BUCKET_START_DATE asc;
--
--  Selected by views:
--    select * from MAXDAT.D_APPOINTMENT_STATUS_HISTORY_SV order by APPOINTMENT_ID asc, D_DATE asc;
--    select * from MAXDAT.D_ASSESSMENT_STATUS_HISTORY_SV order by ASSESSMENT_ID asc, D_DATE asc;
--    select * from MAXDAT.D_CASE_STATUS_HISTORY_SV order by CASE_ID asc, D_DATE asc;
--
--    select * from MAXDAT.F_APPOINTMENT_STATUS_HISTORY_BY_DATE_SV order by APPOINTMENT_ID asc, D_DATE asc;
--    select * from MAXDAT.F_ASSESSMENT_STATUS_HISTORY_BY_DATE_SV order by ASSESSMENT_ID asc, D_DATE asc;
--    select * from MAXDAT.F_CASE_STATUS_HISTORY_BY_DATE_SV order by CASE_ID asc, D_DATE asc


if OBJECT_ID ('MAXDAT.ASSESSMENTS_TEST_GENERATE_DATA','P') is not null
begin
  drop procedure MAXDAT.ASSESSMENTS_TEST_GENERATE_DATA;
end;
go

create procedure MAXDAT.ASSESSMENTS_TEST_GENERATE_DATA
  (@p_number_cases int)
as
begin

  -- Generate RESOURCES test data.
  execute MAXDAT.ASSESSMENTS_TEST_GENERATE_RESOURCES @p_number_cases;

  -- Generate CASES test data.
  execute MAXDAT.ASSESSMENTS_TEST_GENERATE_CASES @p_number_cases;

end;
go

-- Generate APPOINTMENTS test data.
if OBJECT_ID ('MAXDAT.ASSESSMENTS_TEST_GENERATE_APPOINTMENTS','P') is not null
begin
  drop procedure MAXDAT.ASSESSMENTS_TEST_GENERATE_APPOINTMENTS;
end;
go

create procedure MAXDAT.ASSESSMENTS_TEST_GENERATE_APPOINTMENTS
  (@p_case_id int,
   @p_assessment_id int,
   @p_assessment_start_dt datetime,
   @p_appointment_id int output)
as
begin

  declare @v_id_start int = 1000;
  declare @v_id_increment_limit int = 5;

  declare @v_avg_number_appointments int = 1;
  declare @v_resource_id int = null;

  declare @v_clinic_id uniqueidentifier = null;
  declare @v_clinic_name varchar(200) = null;

  declare @v_clinician_id uniqueidentifier = null;
  declare @v_clinician_name varchar(200) = null;

  declare @v_isfacetoface bit = null;
  declare @v_appointment_dt datetime = null;
  declare @v_appointment_booked_dt datetime = null;
  declare @v_old_appointment_status_id int = null;
  declare @v_appointment_status_id int = null;
  declare @v_appointment_status varchar(50) = null;
  declare @v_appointment_status_dt datetime = null;
  
  declare @v_min_elapsed_time_minutes int =  10;
  declare @v_max_elapsed_time_minutes int = 120;
  declare @v_elapsed_time int = null;

  declare @v_rescheduled_dt datetime = null;

  declare @v_appointment_status_id_number int = 8;
  declare @v_avg_num_appointment_status_changes int = 2;
  declare @v_num_appointment_status_changes int = null;
  declare @v_appointment_status_change int = null;

  declare @v_percent_appointments_rescheduled float = 20.0;
  declare @v_appointment_date_effective_dt datetime = null;
  declare @v_appointment_rescheduled_dt datetime = null;
  declare @v_old_appointment_dt datetime = null;
  declare @v_appointment_reschedule_reason_number int = 9;
  declare @v_appointment_reschedule_reason varchar(200) = null;

  declare @v_number_appointments int = floor(@v_avg_number_appointments * 2 * rand());
  declare @i int = 0;
  while @i < @v_number_appointments
    begin

	  set @p_appointment_id = @p_appointment_id + 1 + floor(@v_id_increment_limit * rand());
	  select @v_resource_id = max(RANDOM_RESOURCE_ID) from MAXDAT.ASSESSMENTS_TEST_GET_RESOURCE_ID;
	  set @v_clinic_id = newid();
	  set @v_clinic_name = 'Clinic_Name_' + convert(varchar(36),@v_clinic_id);
	  set @v_clinician_id = newid();
	  set @v_clinician_name = 'Clinician_Name_' + convert(varchar(36),@v_clinician_id);
	  set @v_isfacetoface = MAXDAT.BPM_TEST_COMMON_GENERATE_BIT();
	  set @v_appointment_dt = @p_assessment_start_dt + (convert(float,30 * rand()));
	  set @v_appointment_booked_dt = @p_assessment_start_dt;
	  set @v_appointment_status_id = 1;
      set @v_appointment_status = 'Appointment_Status_A';
      set @v_appointment_status_dt = @p_assessment_start_dt;
	  set @v_appointment_rescheduled_dt = null;

	  -- Set elapsed time for completed appointments.
	  set @v_elapsed_time = floor(@v_min_elapsed_time_minutes + ((@v_max_elapsed_time_minutes - @v_min_elapsed_time_minutes) * rand()));
	  if @v_appointment_dt > getdate() - convert(float,@v_elapsed_time / 1440.0)
	    begin
	      set @v_elapsed_time = null;
	    end;

	  insert into APPOINTMENTS
	    (APPOINTMENT_ID,CASE_ID,RESOURCE_ID,ASSESSMENT_ID,CLINIC_ID,
		 CLINIC_NAME,CLINICIAN_ID,CLINICIAN_NAME,ISFACETOFACE,APPOINTMENT_DT,
		 APPOINTMENT_BOOKED_DT,APPOINTMENT_STATUS_ID,APPOINTMENT_STATUS,APPOINTMENT_STATUS_DT,ELAPSED_TIME,RESCHEDULED_DT)
   	  values 
	  	(@p_appointment_id,@p_case_id,@v_resource_id,@p_assessment_id,@v_clinic_id,
		 @v_clinic_name,@v_clinician_id,@v_clinician_name,@v_isfacetoface,@v_appointment_dt,
		 @v_appointment_booked_dt,@v_appointment_status_id,@v_appointment_status,@v_appointment_status_dt,@v_elapsed_time,@v_rescheduled_dt)

	  set @v_num_appointment_status_changes = floor(@v_avg_num_appointment_status_changes * 2 * rand());
	  set @v_appointment_status_change = 0;
      while @v_appointment_status_change < @v_num_appointment_status_changes
        begin
	    
		  set @v_old_appointment_status_id = @v_appointment_status_id;
	      set @v_appointment_status_id = ceiling(@v_appointment_status_id_number * rand()) + 1;
		  if @v_appointment_status_id != @v_old_appointment_status_id
		    begin

	          set @v_appointment_status = 'Appointment_Status_' + char(ascii('A') + (@v_appointment_status_id - 1));
		      set @v_appointment_status_dt = @v_appointment_status_dt + 0.00001 + (0.1 * convert(float,(getdate() - @v_appointment_status_dt)) * rand());
		      set @v_appointment_rescheduled_dt = null;

		      -- Reschedule appointment.
		      if rand() < convert(float,(@v_percent_appointments_rescheduled / 100.0))
                begin

			      set @v_appointment_date_effective_dt = @v_appointment_status_dt;
			      set @v_old_appointment_dt = @v_appointment_dt;
			      set @v_appointment_dt = @p_assessment_start_dt + (convert(float,30 * rand()));
			      set @v_appointment_booked_dt = @v_appointment_status_dt;
			      set @v_appointment_rescheduled_dt = @v_appointment_status_dt;
                  set @v_appointment_reschedule_reason = 'Appointment_Reschedule_Reason_' + char(ascii('A') + (@v_appointment_status_id - 1));

		          update MAXDAT.APPOINTMENT_DATE_HISTORY 
	              set RESCHEDULE_END_DT = @v_appointment_date_effective_dt
		          where 
		            APPOINTMENT_ID = @p_appointment_id
			        and RESCHEDULE_END_DT = convert(datetime,'9999-12-31',121);
			  	
			      insert into MAXDAT.APPOINTMENT_DATE_HISTORY
			        (APPOINTMENT_ID,APPOINTMENT_DATE_EFFECTIVE_DT,RESCHEDULE_END_DT,APPOINTMENT_DT,NEW_APPOINTMENT_DT,
                     APPOINTMENT_RESCHEDULED_DT,APPOINTMENT_RESCHEDULE_REASON)
			      values
			        (@p_appointment_id,@v_appointment_date_effective_dt,convert(datetime,'9999-12-31',121),@v_old_appointment_dt,@v_appointment_dt,
                     @v_appointment_rescheduled_dt,@v_appointment_reschedule_reason);

			    end;

		      update MAXDAT.APPOINTMENTS 
	          set 
		        APPOINTMENT_DT = @v_appointment_dt,
			    APPOINTMENT_BOOKED_DT = @v_appointment_booked_dt,
		        APPOINTMENT_STATUS_ID = @v_appointment_status_id,
			    APPOINTMENT_STATUS = @v_appointment_status,
			    APPOINTMENT_STATUS_DT = @v_appointment_status_dt,
			    RESCHEDULED_DT = @v_appointment_rescheduled_dt,
			    RESCHEDULE_REASON = @v_appointment_reschedule_reason
	          where APPOINTMENT_ID = @p_appointment_id;

		      set @v_appointment_status_change = @v_appointment_status_change + 1;

		    end;

	    end;

	  set @i = @i + 1;

   end;

end;
go


-- Generate ASSESSMENTS test data.
if OBJECT_ID ('MAXDAT.ASSESSMENTS_TEST_GENERATE_ASSESSMENTS','P') is not null
begin
  drop procedure MAXDAT.ASSESSMENTS_TEST_GENERATE_ASSESSMENTS;
end;
go

create procedure MAXDAT.ASSESSMENTS_TEST_GENERATE_ASSESSMENTS
  (@p_case_id int,
   @p_case_create_dt datetime,
   @p_case_closed_dt datetime,
   @p_assessment_id int output,
   @p_obstacle_id int output,
   @p_appointment_id int output)
as
begin

  declare @v_id_start int = 1000;
  declare @v_id_increment_limit int = 5;

  declare @v_avg_number_assessments int = 2;

  declare @v_assessment_status_id_number int = 8;
  declare @v_old_assessment_status_id int = null;
  declare @v_assessment_status_id int = null;
  declare @v_assessment_status varchar(50) = null;
  declare @v_old_assessment_status_dt datetime = null;
  declare @v_assessment_start_dt datetime = @p_case_create_dt + (convert(float,(isnull(@p_case_closed_dt,getdate()) - @p_case_create_dt)) * 0.01 * rand());
  declare @v_assessment_status_dt datetime = @v_assessment_start_dt;
  declare @v_assessment_consent bit = null;

  declare @v_assessment_call_back_ind bit = null;
  declare @v_assessment_last_update_dt datetime = null;
  declare @v_preassessment_complete_ind bit = null;
  declare @v_employee_review_rtwp bit = null;

  declare @v_avg_num_assessment_status_changes int = 2;
  declare @v_num_assessment_status_changes int = null;
  declare @v_assessment_status_change int = null;

  declare @v_percent_assessments_completed float = 75.0;
  declare @v_avg_num_assessment_outcomes int = 2;

  declare @v_number_assessments int = floor(@v_avg_number_assessments * 2 * rand());
  declare @i int = 0;
  while @i < @v_number_assessments
    begin

	  set @p_assessment_id = @p_assessment_id + 1 + floor(@v_id_increment_limit * rand());
	  set @v_assessment_status_id = 1;
      set @v_assessment_status = 'Assessment_Status_A';
	  set @v_assessment_start_dt = @v_assessment_status_dt + (0.1 * convert(float,(isnull(@p_case_closed_dt,getdate()) - @v_assessment_status_dt)) * rand());
      set @v_assessment_status_dt = @v_assessment_start_dt;
      set @v_assessment_consent = isnull(MAXDAT.BPM_TEST_COMMON_GENERATE_BIT(),1);
      set @v_assessment_call_back_ind = MAXDAT.BPM_TEST_COMMON_GENERATE_BIT();
      set @v_assessment_last_update_dt = @v_assessment_status_dt + floor(rand() * 0.01);
      set @v_preassessment_complete_ind = MAXDAT.BPM_TEST_COMMON_GENERATE_BIT();
      set @v_employee_review_rtwp = MAXDAT.BPM_TEST_COMMON_GENERATE_BIT();

	  insert into ASSESSMENTS 
	    (ASSESSMENT_ID,CASE_ID,ASSESSMENT_STATUS,ASSESSMENT_START_DT,ASSESSMENT_STATUS_DT,ASSESSMENT_CONSENT,
         ASSESSMENT_CALL_BACK_IND,ASSESSMENT_LAST_UPDATE_DT,PREASSESSMENT_COMPLETE_IND,EMPLOYEE_REVIEW_RTWP)
   	  values 
	    (@p_assessment_id,@p_case_id,@v_assessment_status,@v_assessment_start_dt,@v_assessment_status_dt,@v_assessment_consent,
         @v_assessment_call_back_ind,@v_assessment_last_update_dt,@v_preassessment_complete_ind,@v_employee_review_rtwp);

	  -- Generate DWP_INTERVENTIONS test data.
	  execute MAXDAT.ASSESSMENTS_TEST_GENERATE_DWP_INTERVENTIONS @p_assessment_id,@v_assessment_status_dt;

	  -- Generate DWP_SIGNPOSTING test data.
	  execute MAXDAT.ASSESSMENTS_TEST_GENERATE_DWP_SIGNPOSTING @p_assessment_id,@v_assessment_status_dt;

	  -- Generate OBSTACLES test data.
	  execute MAXDAT.ASSESSMENTS_TEST_GENERATE_OBSTACLES @p_assessment_id,@p_obstacle_id = @p_obstacle_id output;

	  -- Generate APPOINTMENTS test data.
	  execute MAXDAT.ASSESSMENTS_TEST_GENERATE_APPOINTMENTS @p_case_id,@p_assessment_id,@v_assessment_start_dt,@p_appointment_id = @p_appointment_id output;

	  set @v_num_assessment_status_changes = floor(@v_avg_num_assessment_status_changes * 2 * rand());
	  set @v_assessment_status_change = 0;
      while @v_assessment_status_change < @v_num_assessment_status_changes
        begin
	    
		  set @v_old_assessment_status_id = @v_assessment_status_id;
	      set @v_assessment_status_id = ceiling(@v_assessment_status_id_number * rand()) + 1;
		  if @v_assessment_status_id != @v_old_assessment_status_id
		    begin

	          set @v_assessment_status = 'Assessment_Status_' + char(ascii('A') + (@v_assessment_status_id - 1));
		      set @v_old_assessment_status_dt = @v_assessment_status_dt;
		      set @v_assessment_status_dt = @v_assessment_status_dt + 0.00001 + (0.1 * convert(float,(isnull(@p_case_closed_dt,getdate()) - @v_assessment_status_dt)) * rand());

		      if @v_assessment_status_dt > @v_old_assessment_status_dt
		        begin

		          update MAXDAT.ASSESSMENTS 
	              set 
		            ASSESSMENT_STATUS_ID = @v_assessment_status_id,
			        ASSESSMENT_STATUS = @v_assessment_status,
			        ASSESSMENT_STATUS_DT = @v_assessment_status_dt,
			        ASSESSMENT_LAST_UPDATE_DT = @v_assessment_status_dt
	              where ASSESSMENT_ID = @p_assessment_id;

			    end;

		    end;

		  set @v_assessment_status_change = @v_assessment_status_change + 1;

	    end;

	  -- End some Assessments.
      if rand() < convert(float,(@v_percent_assessments_completed / 100.0))
		begin

		  update MAXDAT.ASSESSMENTS 
		  set ASSESSMENT_END_DT = @v_assessment_status_dt 
		  where ASSESSMENT_ID = @p_assessment_id;

	      -- Generate ASSESSMENT_OUTCOMES test data.
	      execute MAXDAT.ASSESSMENTS_TEST_GENERATE_ASSESSMENT_OUTCOMES @p_assessment_id,@v_assessment_status_dt;

		end;

	  set @i = @i + 1;

   end;

end;
go


-- Generate ASSESSMENT_OUTCOMES test data.
if OBJECT_ID ('MAXDAT.ASSESSMENTS_TEST_GENERATE_ASSESSMENT_OUTCOMES','P') is not null
begin
  drop procedure MAXDAT.ASSESSMENTS_TEST_GENERATE_ASSESSMENT_OUTCOMES;
end;
go

create procedure MAXDAT.ASSESSMENTS_TEST_GENERATE_ASSESSMENT_OUTCOMES
  (@p_assessment_id int,
   @p_assessment_status_dt datetime)
as
begin

  declare @v_avg_number_assessment_outcomes int = 2;
  declare @v_number_assessment_outcomes int = floor(@v_avg_number_assessment_outcomes * 2 * rand()) + 1;
  declare @v_assessment_status_id_number int = 9;

  declare @v_assessment_outcome_id int = null;
  declare @v_assessment_outcome_name varchar(MAX) = null;
  declare @v_assessment_outcome_effective_dt datetime = null;

  declare @i int = 0;
  while @i < @v_number_assessment_outcomes
    begin

	  set @v_assessment_outcome_id = ceiling(@v_assessment_status_id_number * rand());
	  set @v_assessment_outcome_name = 'Assessment_Outcome_Name_' + char(ascii('A') + (@v_assessment_outcome_id - 1));
	  set @v_assessment_outcome_effective_dt = @p_assessment_status_dt + (convert(float,(getdate() - @p_assessment_status_dt)) * rand());

	  begin try
	    insert into MAXDAT.ASSESSMENT_OUTCOMES (ASSESSMENT_ID,ASSESSMENT_OUTCOME_ID,ASSESSMENT_OUTCOME_NAME,ASSESSMENT_OUTCOME_EFFECTIVE_DT)
	    values (@p_assessment_id,@v_assessment_outcome_id,@v_assessment_outcome_name,@v_assessment_outcome_effective_dt);
	  end try

	  begin catch
        -- Ignore failed attempts to insert duplicates.
      end catch

	  set @i = @i + 1;

	end;

end; 
go


-- Generate CASES test data.
if OBJECT_ID ('MAXDAT.ASSESSMENTS_TEST_GENERATE_CASES','P') is not null
begin
  drop procedure MAXDAT.ASSESSMENTS_TEST_GENERATE_CASES;
end;
go

create procedure MAXDAT.ASSESSMENTS_TEST_GENERATE_CASES
  (@p_number_cases int)
as
begin

  declare @v_id_start int = 1000;
  declare @v_id_increment_limit int = 5;

  declare @v_case_id_prev int = ceiling(@v_id_start * rand());
  declare @v_case_id int = null;

  declare @v_case_status_id_number int = 8;
  declare @v_old_case_status_id int = null;
  declare @v_case_status_id int = null;
  declare @v_case_status varchar(50) = null;

  declare @v_case_create_oldest_days int = 365;
  declare @v_case_create_dt datetime = null;

  declare @v_current_status_dt datetime = null;

  declare @v_case_manager_id int = null;

  declare @v_case_family_id_prev int = ceiling(@v_id_start * rand());
  declare @v_case_family_id_percent_null float = 20.0;
  declare @v_case_family_id int = null;
  declare @v_case_family_percent_shared float = 10.0;
  declare @v_case_family uniqueidentifier = null;

  declare @v_case_closed_dt datetime = null;
  declare @v_is_marked_for_deletion bit = null;

  declare @v_referral_id_prev int = round(@v_id_start * rand(),0);
  declare @v_referral_id int = null;

  declare @v_referral_employeeconsent bit = null;

  declare @v_referral_receipt_dt_interval_days int = 60;
  declare @v_referral_receipt_dt datetime = null;

  declare @v_referral_fit_note_expiry_date date = null;

  declare @v_referral_source_random_number int = null;
  declare @v_referral_source varchar(10) = null;

  declare @v_referral_channel_random_number int = null;
  declare @v_referral_channel varchar(50) = null;

  declare @v_isgeographicallyeligible bit = null;
  declare @v_isinpaidemployment bit = null;
  declare @v_isabsentfromwork bit = null;
  declare @v_isreferredinlast12months bit = null;
  declare @v_employeeconsented bit = null;
  declare @v_isvalid bit = null;

  declare @v_eligibility_flag bit = null;

  declare @v_employee_id_prev int = round(@v_id_start * rand(),0);
  declare @v_employee_id int = null;

  declare @v_employee_min_age_years int = 16;
  declare @v_employee_max_age_years int = 65;
  declare @v_employee_date_of_birth date = null;

  declare @v_employee_receive_sms bit = null;
  declare @v_employee_receive_email bit = null;
  declare @v_absent_from_work bit = null;
  declare @v_fit_note_ind bit = null;
  declare @v_adviceline_ind bit = null;

  declare @v_employer_id_prev int = round(@v_id_start * rand(),0);
  declare @v_employer_id int = null;

  declare @v_employer_offered_services bit = null;
  declare @v_employer_occ_health_service bit = null;
  declare @v_employer_assistance_programme bit = null;
  declare @v_employer_counselling_service bit = null;
  declare @v_employer_physiotherapy_service bit = null;
  declare @v_employer_other_service bit = null;

  declare @v_gp_id_prev int = round(@v_id_start * rand(),0);
  declare @v_gp_id int = null;

  declare @v_missing_information_ind bit = null;

  declare @v_avg_num_case_status_changes int = 3;
  declare @v_num_case_status_changes int = 0;
  declare @v_case_status_change int = 0;

  declare @v_percent_cases_closed float = 75.0;

  declare @p_assessment_id int = ceiling(@v_id_start * rand());
  declare @p_obstacle_id int = ceiling(@v_id_start * rand());
  declare @p_appointment_id int = ceiling(@v_id_start * rand());

  declare @i int = 0;
  while @i < @p_number_cases
    begin

	  set @v_case_id = @v_case_id_prev + 1 + floor(@v_id_increment_limit * rand());
	  set @v_case_id_prev = @v_case_id;

	  set @v_case_status_id = 1;
	  set @v_case_status = 'Case_Status_A';

	  set @v_case_create_dt = getdate() - (@v_case_create_oldest_days * rand());
	  set @v_current_status_dt = @v_case_create_dt

	  select @v_case_manager_id = max(RANDOM_RESOURCE_ID) from MAXDAT.ASSESSMENTS_TEST_GET_RESOURCE_ID;

	  if rand() > convert(float,(@v_case_family_id_percent_null / 100.0))
	    begin
	
	      if rand() > convert(float,(@v_case_family_percent_shared / 100.0))
		  	begin
			  set @v_case_family_id = @v_case_family_id_prev + 1 + floor(@v_id_increment_limit * rand());
			  set @v_case_family = newid();
			  set @v_case_family_id_prev = @v_case_family_id;
			end;

		  else -- Shared Case Family
	        begin
		      select 
			    @v_case_family_id = RANDOM_CASE_FAMILY_ID,
			    @v_case_family = RANDOM_CASE_FAMILY
		      from MAXDAT.ASSESSMENTS_TEST_GET_CASE_FAMILY;
		    end

		end;

	  else
	    begin
		  set @v_case_family_id = null;
		  set @v_case_family = null;
		end;
	  
	  set @v_case_closed_dt = null;
	  set @v_is_marked_for_deletion = 0;

	  set @v_referral_id = @v_referral_id_prev + 1 + floor(@v_id_increment_limit * rand());
	  set @v_referral_id_prev = @v_referral_id;

	  set @v_referral_employeeconsent = isnull(MAXDAT.BPM_TEST_COMMON_GENERATE_BIT(),0);
	  
	  set @v_referral_receipt_dt = @v_case_create_dt;
	  set @v_referral_fit_note_expiry_date = convert(date,(@v_case_create_dt + @v_referral_receipt_dt_interval_days));
	  
	  set @v_referral_source_random_number = ceiling(2 * rand());
	  if @v_referral_source_random_number = 1
	    begin
		  set @v_referral_source = 'Employer';
		end;
	  else
	    begin
		  set @v_referral_source = 'GP';
		end;

	  set @v_referral_channel_random_number = ceiling(3 * rand());
	  if @v_referral_source_random_number = 1
	    begin
		  set @v_referral_channel = 'Online';
		end;
	  else if @v_referral_channel_random_number = 2
	    begin
		  set @v_referral_channel = 'Phone';
		end;
	  else
	    begin
		  set @v_referral_channel = 'Email';
		end;

	  set @v_isgeographicallyeligible = MAXDAT.BPM_TEST_COMMON_GENERATE_BIT();
      set @v_isinpaidemployment = MAXDAT.BPM_TEST_COMMON_GENERATE_BIT()
      set @v_isabsentfromwork = MAXDAT.BPM_TEST_COMMON_GENERATE_BIT();
      set @v_isreferredinlast12months = MAXDAT.BPM_TEST_COMMON_GENERATE_BIT();
      set @v_employeeconsented = MAXDAT.BPM_TEST_COMMON_GENERATE_BIT();
      set @v_isvalid = MAXDAT.BPM_TEST_COMMON_GENERATE_BIT();

	  set @v_eligibility_flag = isnull(MAXDAT.BPM_TEST_COMMON_GENERATE_BIT(),0);

	  set @v_employee_id = @v_employee_id_prev + 1 + floor(@v_id_increment_limit * rand());
	  set @v_employee_id_prev = @v_employee_id;

	  set @v_employee_date_of_birth = convert(date,getdate() - (rand() * 365.25 * (@v_employee_min_age_years + floor(@v_employee_max_age_years - @v_employee_min_age_years))));

	  set @v_employee_receive_sms = MAXDAT.BPM_TEST_COMMON_GENERATE_BIT();
      set @v_employee_receive_email = MAXDAT.BPM_TEST_COMMON_GENERATE_BIT();
      set @v_absent_from_work = MAXDAT.BPM_TEST_COMMON_GENERATE_BIT();
      set @v_fit_note_ind = MAXDAT.BPM_TEST_COMMON_GENERATE_BIT();
      set @v_adviceline_ind = MAXDAT.BPM_TEST_COMMON_GENERATE_BIT();
		  
	  set @v_employer_id = @v_employer_id_prev + 1 + floor(@v_id_increment_limit * rand());
	  set @v_employer_id_prev = @v_employer_id;

	  set @v_employer_offered_services = MAXDAT.BPM_TEST_COMMON_GENERATE_BIT();
      set @v_employer_occ_health_service = MAXDAT.BPM_TEST_COMMON_GENERATE_BIT();
      set @v_employer_assistance_programme = MAXDAT.BPM_TEST_COMMON_GENERATE_BIT();
      set @v_employer_counselling_service = MAXDAT.BPM_TEST_COMMON_GENERATE_BIT();
      set @v_employer_physiotherapy_service = MAXDAT.BPM_TEST_COMMON_GENERATE_BIT();
	  set @v_employer_other_service = MAXDAT.BPM_TEST_COMMON_GENERATE_BIT();

	  set @v_gp_id = @v_gp_id_prev + 1 + floor(@v_id_increment_limit * rand());
	  set @v_gp_id_prev = @v_gp_id;
	  
	  set @v_missing_information_ind = MAXDAT.BPM_TEST_COMMON_GENERATE_BIT();	

      insert into MAXDAT.CASES 
	    (CASE_ID,CASE_STATUS_ID,CASE_STATUS,CURRENT_STATUS_DT,CASE_CREATE_DT,
		 CASE_MANAGER_ID,CASE_FAMILY_ID,CASE_FAMILY,CASE_CLOSED_DT,IS_MARKED_FOR_DELETION,
		 REFERRAL_ID,REFERRAL_EMPLOYEECONSENT,REFERRAL_RECEIPT_DT,REFERRAL_FIT_NOTE_EXPIRY_DATE,REFERRAL_SOURCE,REFERRAL_CHANNEL,
		 ISGEOGRAPHICALLYELIGIBLE,ISINPAIDEMPLOYMENT,ISABSENTFROMWORK,ISREFERREDINLAST12MONTHS,EMPLOYEECONSENTED,
		 ISVALID,ELIGIBILITY_FLAG,EMPLOYEE_ID,
		 EMPLOYEE_RECEIVE_SMS,EMPLOYEE_RECEIVE_EMAIL,ABSENT_FROM_WORK,FIT_NOTE_IND,ADVICELINE_IND,
		 EMPLOYER_ID,EMPLOYEE_DATE_OF_BIRTH,
		 EMPLOYER_OFFERED_SERVICES,EMPLOYER_OCC_HEALTH_SERVICE,EMPLOYER_ASSISTANCE_PROGRAMME,EMPLOYER_COUNSELLING_SERVICE,EMPLOYER_PHYSIOTHERAPY_SERVICE,
         EMPLOYER_OTHER_SERVICE,GP_ID,MISSING_INFORMATION_IND)
	  values 
	    (@v_case_id,@v_case_status_id,@v_case_status,@v_current_status_dt,@v_case_create_dt,
		 @v_case_manager_id,@v_case_family_id,@v_case_family,@v_case_closed_dt,@v_is_marked_for_deletion,
	     @v_referral_id,@v_referral_employeeconsent,@v_referral_receipt_dt,@v_referral_fit_note_expiry_date,@v_referral_source,@v_referral_channel,
		 @v_isgeographicallyeligible,@v_isinpaidemployment,@v_isabsentfromwork,@v_isreferredinlast12months,@v_employeeconsented,
		 @v_isvalid,@v_eligibility_flag,@v_employee_id,
		 @v_employee_receive_sms,@v_employee_receive_email,@v_absent_from_work,@v_fit_note_ind,@v_adviceline_ind,
		 @v_employer_id,@v_employee_date_of_birth,
		 @v_employer_offered_services,@v_employer_occ_health_service,@v_employer_assistance_programme,@v_employer_counselling_service,@v_employer_physiotherapy_service,
		 @v_employer_other_service,@v_gp_id,@v_missing_information_ind);

	  set @v_num_case_status_changes = floor(@v_avg_num_case_status_changes * 2 * rand());
	  set @v_case_status_change = 0;
      while @v_case_status_change < @v_num_case_status_changes
        begin
	    
		  set @v_old_case_status_id = @v_case_status_id;
		  set @v_case_status_id = ceiling(@v_case_status_id_number * rand()) + 1;
		  if @v_case_status_id != @v_old_case_status_id
		    begin
	      
	          set @v_case_status = 'Case_Status_' + char(ascii('A') + (@v_case_status_id - 1));
		      set @v_current_status_dt = @v_current_status_dt + 0.0001 + (0.1 * (convert(float,(getdate() - @v_current_status_dt)) * rand()));

		      update MAXDAT.CASES 
	          set 
		        CASE_STATUS_ID = @v_case_status_id,
			    CASE_STATUS = @v_case_status,
			    CURRENT_STATUS_DT = @v_current_status_dt
	          where CASE_ID = @v_case_id;

		      set @v_case_status_change = @v_case_status_change + 1;

			end;

	    end;

	  -- End some Cases.
      if rand() < convert(float,(@v_percent_cases_closed / 100.0))
		begin

		  set @v_case_closed_dt = @v_current_status_dt;

		  update MAXDAT.CASES
		  set CASE_CLOSED_DT = @v_current_status_dt
		  where CASE_ID = @v_case_id;

		end;

	  -- Generate ASSESSMENTS test data.
	  execute MAXDAT.ASSESSMENTS_TEST_GENERATE_ASSESSMENTS @v_case_id,@v_case_create_dt,@v_case_closed_dt,@p_assessment_id = @p_assessment_id output,@p_obstacle_id = @p_obstacle_id output,@p_appointment_id = @p_appointment_id output;

	  set @i = @i + 1;

   end;

end;
go


-- Generate DWP_INTERVENTIONS test data.
if OBJECT_ID ('MAXDAT.ASSESSMENTS_TEST_GENERATE_DWP_INTERVENTIONS','P') is not null
begin
  drop procedure MAXDAT.ASSESSMENTS_TEST_GENERATE_DWP_INTERVENTIONS;
end;
go


create procedure MAXDAT.ASSESSMENTS_TEST_GENERATE_DWP_INTERVENTIONS
  (@p_assessment_id int,
   @p_assessment_status_dt datetime)
as
begin

  declare @v_avg_number_dwp_interventions int = 5;
  declare @v_number_dwp_interventions int = floor(@v_avg_number_dwp_interventions * 2 * rand()) + 1;
  declare @v_assessment_status_id_number int = 9;

  declare @v_dwp_intervention_id int = null;
  declare @v_dwp_intervention_name varchar(MAX) = null;
  declare @v_dwp_intervention_effective_dt datetime = null;

  declare @i int = 0;
  while @i < @v_number_dwp_interventions
    begin

	  set @v_dwp_intervention_id = ceiling(@v_assessment_status_id_number * rand());
	  set @v_dwp_intervention_name = 'DWP_Intervention_Name_' + char(ascii('A') + (@v_dwp_intervention_id - 1));
	  set @v_dwp_intervention_effective_dt = @p_assessment_status_dt + (convert(float,(getdate() - @p_assessment_status_dt)) * rand());

	  begin try
	    insert into MAXDAT.DWP_INTERVENTIONS (ASSESSMENT_ID,DWP_INTERVENTION_ID,DWP_INTERVENTION_NAME,DWP_INTERVENTION_EFFECTIVE_DT)
	    values (@p_assessment_id,@v_dwp_intervention_id,@v_dwp_intervention_name,@v_dwp_intervention_effective_dt);
	  end try

	  begin catch
        -- Ignore failed attempts to insert duplicates.
      end catch

	  set @i = @i + 1;

	end;

end; 
go


-- Generate DWP_SIGNPOSTING test data.
if OBJECT_ID ('MAXDAT.ASSESSMENTS_TEST_GENERATE_DWP_SIGNPOSTING','P') is not null
begin
  drop procedure MAXDAT.ASSESSMENTS_TEST_GENERATE_DWP_SIGNPOSTING;
end;
go

create procedure MAXDAT.ASSESSMENTS_TEST_GENERATE_DWP_SIGNPOSTING
  (@p_assessment_id int,
   @p_assessment_status_dt datetime)
as
begin

  declare @v_avg_number_dwp_signposting int = 5;
  declare @v_number_dwp_signposting int = floor(@v_avg_number_dwp_signposting * 2 * rand()) + 1;
  declare @v_assessment_status_id_number int = 9;

  declare @v_dwp_signposting_id int = null;
  declare @v_dwp_signposting_name varchar(MAX) = null;
  declare @v_dwp_signposting_effective_dt datetime = null;

  declare @i int = 0;
  while @i < @v_number_dwp_signposting
    begin

	  set @v_dwp_signposting_id = ceiling(@v_assessment_status_id_number * rand());
	  set @v_dwp_signposting_name = 'DWP_Signposting_Name_' + char(ascii('A') + (@v_dwp_signposting_id - 1));
	  set @v_dwp_signposting_effective_dt = @p_assessment_status_dt + (convert(float,(getdate() - @p_assessment_status_dt)) * rand());

	  begin try
	    insert into MAXDAT.DWP_SIGNPOSTING (ASSESSMENT_ID,DWP_SIGNPOSTING_ID,DWP_SIGNPOSTING_NAME,DWP_SIGNPOSTING_EFFECTIVE_DT)
	    values (@p_assessment_id,@v_dwp_signposting_id,@v_dwp_signposting_name,@v_dwp_signposting_effective_dt);
	  end try

	  begin catch
        -- Ignore failed attempts to insert duplicates.
      end catch

	  set @i = @i + 1;

	end;

end; 
go


-- Generate OBSTACLES test data.
if OBJECT_ID ('MAXDAT.ASSESSMENTS_TEST_GENERATE_OBSTACLES','P') is not null
begin
  drop procedure MAXDAT.ASSESSMENTS_TEST_GENERATE_OBSTACLES;
end;
go

create procedure MAXDAT.ASSESSMENTS_TEST_GENERATE_OBSTACLES
  (@p_assessment_id int,
   @p_obstacle_id int output)
as
begin

  declare @v_id_start int = 1000;
  declare @v_id_increment_limit int = 5;

  declare @v_obstacle_type_number int = null;
  declare @v_obstacle_type varchar(100) = null;

  declare @v_obstacle_detail varchar(MAX) = null;
  declare @v_obstacle_detail_max int = 100;
  declare @v_is_primary bit = null;
  declare @v_consent_publish_gp bit = null;
  declare @v_consent_publish_employer bit = null;
  declare @v_consent_publish_3rdparty bit = null;


  declare @v_avg_number_obstacles int = 2;
  declare @v_number_obstacles int = floor(@v_avg_number_obstacles * 2 * rand());
  declare @i int = 0;
  while @i < @v_number_obstacles
    begin

	  set @p_obstacle_id = @p_obstacle_id + 1 + floor(@v_id_increment_limit * rand());

	  set @v_obstacle_type_number = ceiling(4 * rand());
	  if @v_obstacle_type_number = 1
	    begin
		  set @v_obstacle_type = 'Health';
		end;
	  else if @v_obstacle_type_number = 2
	    begin
		  set @v_obstacle_type = 'Mental Health';
		end;
	  else if @v_obstacle_type_number = 3
	    begin
		  set @v_obstacle_type = 'Work Life';
		end;
	  else
	    begin
		  set @v_obstacle_type = 'Home Life';
		end;

	  set @v_obstacle_detail = 'Obstacle_Detail_' + convert(varchar,@p_obstacle_id);
	  set @v_is_primary = isnull(MAXDAT.BPM_TEST_COMMON_GENERATE_BIT(),1);
	  set @v_consent_publish_gp = MAXDAT.BPM_TEST_COMMON_GENERATE_BIT();
      set @v_consent_publish_employer = MAXDAT.BPM_TEST_COMMON_GENERATE_BIT();
	  set @v_consent_publish_3rdparty = MAXDAT.BPM_TEST_COMMON_GENERATE_BIT();

	  insert into MAXDAT.OBSTACLES
	    (OBSTACLE_ID,OBSTACLE_TYPE,OBSTACLE_DETAIL,IS_PRIMARY,CONSENT_PUBLISH_GP,
         CONSENT_PUBLISH_EMPLOYER,CONSENT_PUBLISH_3RDPARTY,ASSESSMENT_ID)
   	  values 
	  	(@p_obstacle_id,@v_obstacle_type,@v_obstacle_detail,@v_is_primary,@v_consent_publish_gp,
         @v_consent_publish_employer,@v_consent_publish_3rdparty,@p_assessment_id);

	  -- Generate RECOM_SIGNPOSTING_ADJUST test data.
	  execute MAXDAT.ASSESSMENTS_TEST_GENERATE_RECOM_SIGNPOSTING_ADJUST @p_obstacle_id;

	  set @i = @i + 1;

   end;

end;
go


-- Generate RECOM_SIGNPOSTING_ADJUST test data.
if OBJECT_ID ('MAXDAT.ASSESSMENTS_TEST_GENERATE_RECOM_SIGNPOSTING_ADJUST','P') is not null
begin
  drop procedure MAXDAT.ASSESSMENTS_TEST_GENERATE_RECOM_SIGNPOSTING_ADJUST;
end;
go

create procedure MAXDAT.ASSESSMENTS_TEST_GENERATE_RECOM_SIGNPOSTING_ADJUST
  (@p_obstacle_id int)
as
begin

  declare @v_rsa_id int = null;

  declare @v_rsa_type_number int = null;
  declare @v_rsa_type varchar(50) = null;

  declare @v_rsa_category_number int = null;
  declare @v_rsa_category varchar(200) = null;

  declare @v_rsa_name varchar(500) = null;
  declare @v_rsa_text varchar(500) = null;
  declare @v_rsa_target_date datetime = null;

  declare @v_avg_number_rsa int = 2;
  declare @v_number_rsa int = floor(@v_avg_number_rsa * 2 * rand());
  declare @i int = 0;
  while @i < @v_number_rsa
    begin

	  set @v_rsa_id = next value for MAXDAT.SEQ_RSA_ID;

	  set @v_rsa_type_number = ceiling(3 * rand());
	  if @v_rsa_type_number = 1
	    begin
		  set @v_rsa_type = 'Recommendation';

		  set @v_rsa_category_number = ceiling(6 * rand());
		  if @v_rsa_category_number = 1
	        begin
		      set @v_rsa_category = 'Self Help Materials';
		    end;
	      else if @v_rsa_category_number = 2
	        begin
		      set @v_rsa_category = 'Further Case Management action';
		    end;
		  else if @v_rsa_category_number = 3
	        begin
		      set @v_rsa_category = 'Specialist OT Advisor engaged';
		    end;
		  else if @v_rsa_category_number = 4
	        begin
		      set @v_rsa_category = 'Specialist Physio Advisor engaged';
		    end;
		  else if @v_rsa_category_number = 5
	        begin
		      set @v_rsa_category = 'Specialist OH advisor engaged';
		    end;
	      else
	        begin
		      set @v_rsa_category = 'Specialist OH advisor engaged';
		    end;

		end;

	  else if @v_rsa_type_number = 2
	    begin
		  set @v_rsa_type = 'Signposting';

		  set @v_rsa_category_number = ceiling(14 * rand());
		  if @v_rsa_category_number = 1
	        begin
		      set @v_rsa_category = 'NHS counselling info provided';
		    end;
	      else if @v_rsa_category_number = 2
	        begin
		      set @v_rsa_category = 'NHS physiotherapy info provided';
		    end;
		  else if @v_rsa_category_number = 3
	        begin
		      set @v_rsa_category = 'Employer Services';
		    end;
		  else if @v_rsa_category_number = 4
	        begin
		      set @v_rsa_category = 'Debt Management services';
		    end;
		  else if @v_rsa_category_number = 5
	        begin
		      set @v_rsa_category = 'Advocacy Services';
		    end;
	      else if @v_rsa_category_number = 6
	        begin
		      set @v_rsa_category = 'Addictions Services';
		    end;
	      else if @v_rsa_category_number = 7
	        begin
		      set @v_rsa_category = 'ACAS';
		    end;
		  else if @v_rsa_category_number = 8
	        begin
		      set @v_rsa_category = 'HAWS Website';
		    end;
		  else if @v_rsa_category_number = 9
	        begin
		      set @v_rsa_category = 'HAWS Advice Line';
		    end;
		  else if @v_rsa_category_number = 10
	        begin
		      set @v_rsa_category = 'Trade Union';
		    end;
	      else if @v_rsa_category_number = 11
	        begin
		      set @v_rsa_category = 'Legal Advice';
		    end;
	      else if @v_rsa_category_number = 12
	        begin
		      set @v_rsa_category = 'Tax exemptions for employer';
		    end;
		  else if @v_rsa_category_number = 13
	        begin
		      set @v_rsa_category = 'Access to Work';
		    end;
		  else
	        begin
		      set @v_rsa_category = 'Other';
		    end;

		end;

	  else if @v_rsa_type_number = 3
	    begin
		  set @v_rsa_type = 'Adjustment';
		  set @v_rsa_category = null;
		end;

	  set @v_rsa_name = 'RSA_Name_' + convert(varchar,@v_rsa_id);
	  set @v_rsa_text = 'RSA_Text_' + convert(varchar,@v_rsa_id);
	  set @v_rsa_target_date = null;

	  insert into MAXDAT.RECOM_SIGNPOSTING_ADJUST
	    (RSA_ID,RSA_TYPE,RSA_CATEGORY,RSA_NAME,RSA_TEXT,
         RSA_TARGET_DATE,OBSTACLE_ID)
   	  values 
	  	(@v_rsa_id,@v_rsa_type,@v_rsa_category,@v_rsa_name,@v_rsa_text,
         @v_rsa_target_date,@p_obstacle_id);

	  set @i = @i + 1;

   end;

end;
go


-- Generate RESOURCES test data.
if OBJECT_ID ('MAXDAT.ASSESSMENTS_TEST_GENERATE_RESOURCES','P') is not null
begin
  drop procedure MAXDAT.ASSESSMENTS_TEST_GENERATE_RESOURCES;
end;
go


create procedure MAXDAT.ASSESSMENTS_TEST_GENERATE_RESOURCES
  (@p_number_cases int)
as
begin

  declare @v_id_start int = 1000;
  declare @v_id_increment_limit int = 5;

  declare @v_avg_resources_per_case int = 50;
  declare @v_number_resources int = ceiling((convert(float,@p_number_cases) / (convert(float,@v_avg_resources_per_case) * 2.0)) * rand());

  declare @v_resource_id_prev int = ceiling(@v_id_start * rand());

  declare @v_resource_id int = null;

  declare @v_accountname_length_min int = 10;
  declare @v_accountname_length int = @v_accountname_length_min + ceiling(90 * rand());
  declare @v_accountname varchar(100) = null;

  declare @v_agent_id varchar(30) = null;

  declare @v_resource_is_hp bit = null;

  declare @v_ctateam_id int = null;

  declare @i int = 0;
  while @i < @v_number_resources
    begin

	  set @v_resource_id = @v_resource_id_prev + 1 + floor(@v_id_increment_limit * rand());
	  set @v_resource_id_prev = @v_resource_id;

      set @v_accountname = 'Account_' + convert(varchar,ceiling(5 * rand()));

      set @v_agent_id = MAXDAT.BPM_TEST_COMMON_GENERATE_VARCHAR_ID(30);

      set @v_resource_is_hp = MAXDAT.BPM_TEST_COMMON_GENERATE_BIT();

      set @v_ctateam_id = 200 + floor(3 * rand());

	  insert into MAXDAT.RESOURCES (RESOURCE_ID,ACCOUNTNAME,AGENT_ID,RESOURCE_IS_HP,CTATEAM_ID)
	  values (@v_resource_id,@v_accountname,@v_agent_id,@v_resource_is_hp,@v_ctateam_id);

	  set @i = @i + 1;

	end;

end; 
go


if OBJECT_ID ('MAXDAT.ASSESSMENTS_TEST_GET_CASE_FAMILY','V') is not null
begin
  drop view MAXDAT.ASSESSMENTS_TEST_GET_CASE_FAMILY;
end;
go

create view MAXDAT.ASSESSMENTS_TEST_GET_CASE_FAMILY as
select top 1 
  CASE_FAMILY_ID RANDOM_CASE_FAMILY_ID,
  CASE_FAMILY RANDOM_CASE_FAMILY 
from MAXDAT.CASES 
order by newid();
go


if OBJECT_ID ('MAXDAT.ASSESSMENTS_TEST_GET_RESOURCE_ID','V') is not null
begin
  drop view MAXDAT.ASSESSMENTS_TEST_GET_RESOURCE_ID;
end;
go

create view MAXDAT.ASSESSMENTS_TEST_GET_RESOURCE_ID as
select top 1 
  RESOURCE_ID RANDOM_RESOURCE_ID 
from MAXDAT.RESOURCES 
order by newid();
go
