-- Calculation functions and procedures for UK HWS Assessments.

-- Get the next assessment sequence number.
if OBJECT_ID ('MAXDAT.ASSESSMENTS_GET_NEXT_ASSESSMENT_SEQUENCE','FN') is not null
begin
  drop function MAXDAT.ASSESSMENTS_GET_NEXT_ASSESSMENT_SEQUENCE;
end;
go

create function MAXDAT.ASSESSMENTS_GET_NEXT_ASSESSMENT_SEQUENCE
  (@p_case_id int)
  returns int
as
begin
  declare @v_next_assessment_sequence int = null;

  select @v_next_assessment_sequence = isnull(max(ASSESSMENT_SEQUENCE),0) + 1
  from MAXDAT.ASSESSMENTS
  where CASE_ID = @p_case_id;

  return @v_next_assessment_sequence;
end;
go

grant execute on MAXDAT.ASSESSMENTS_GET_NEXT_ASSESSMENT_SEQUENCE to MAXDAT_READ_ONLY;
go


-- Get the assessment required date.
if OBJECT_ID ('MAXDAT.ASSESSMENTS_GET_ASSESSMENT_REQUIRED_DT','FN') is not null
begin
  drop function MAXDAT.ASSESSMENTS_GET_ASSESSMENT_REQUIRED_DT;
end;
go

create function MAXDAT.ASSESSMENTS_GET_ASSESSMENT_REQUIRED_DT
  (@p_case_id int,
   @p_assessment_sequence int)
  returns datetime
as
begin
  declare @v_assessment_required_dt datetime = null;

  if @p_assessment_sequence = 1
    begin

	  select @v_assessment_required_dt = REFERRAL_RECEIPT_DT
	  from MAXDAT.CASES
	  where CASE_ID = @p_case_id;

	end;

  else if @p_assessment_sequence > 1 
    begin

	  declare @v_assessment_id int = null;
	  declare @v_next_touch_point varchar = null;
	  declare @v_assessment_end_dt datetime = null;

      select 
	    @v_assessment_id = ASSESSMENT_ID,
	    @v_assessment_end_dt = ASSESSMENT_END_DT,
	    @v_next_touch_point = NEXT_TOUCHPOINT
      from MAXDAT.ASSESSMENTS
      where 
        CASE_ID = @p_case_id
	    and ASSESSMENT_SEQUENCE = @p_assessment_sequence - 1;

	  if @v_next_touch_point in ('Face to Face','Telephone Assessment')
	    begin
		  set @v_assessment_required_dt = @v_assessment_end_dt;
		end;
	  else if @v_next_touch_point = 'On Track'
	    begin

		  declare @v_appt_booked_dt datetime = null;

		  select @v_assessment_required_dt = APPOINTMENT_BOOKED_DT
		  from APPOINTMENTS
		  where ASSESSMENT_ID = @v_assessment_id;

		end;

	end;

  return @v_assessment_required_dt;
end;
go

grant execute on MAXDAT.ASSESSMENTS_GET_ASSESSMENT_REQUIRED_DT to MAXDAT_READ_ONLY;
go
