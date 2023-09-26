-- Update BPM_D_DATES.BUSINESS_DAY_FLAG value when a HOLIDAYS row is deleted.
-- Note that if the HOLIDAYS table is truncated, this update must be done manually.
/* Manual sync SQL.
update MAXDAT.BPM_D_DATES 
set BUSINESS_DAY_FLAG = 
   case when D_DAY_OF_WEEK not in ('1','7') and h.HOLIDAY_DATE is null then 'Y' else 'N' end
   from MAXDAT.BPM_D_DATES d_dates
   left outer join MAXDAT.HOLIDAYS h on (d_dates.D_DATE = h.HOLIDAY_DATE);
*/
if OBJECT_ID ('MAXDAT.TRG_AD_HOLIDAYS','TR') is not null
begin
  drop trigger MAXDAT.TRG_AD_HOLIDAYS;
end;
go

create trigger MAXDAT.TRG_AD_HOLIDAYS
on MAXDAT.HOLIDAYS
after delete
as
begin

  declare @v_holiday_date datetime = null;
  declare c_deleted cursor for 
    select HOLIDAY_DATE 
	from DELETED;
  open c_deleted;
  fetch next from c_deleted into @v_holiday_date;
  while @@fetch_status = 0
    begin

      update MAXDAT.BPM_D_DATES
      set BUSINESS_DAY_FLAG = 'Y'
	  where 
	    D_DATE = @v_holiday_date
		and D_DAY_OF_WEEK not in ('1','7');

	  fetch next from c_deleted into @v_holiday_date;

    end;

  close c_deleted;
  deallocate c_deleted;
 
end;
go


-- Update BPM_D_DATES.BUSINESS_DAY_FLAG value when a HOLIDAYS row is inserted.
if OBJECT_ID ('MAXDAT.TRG_AI_HOLIDAYS','TR') is not null
begin
  drop trigger MAXDAT.TRG_AI_HOLIDAYS;
end;
go

create trigger MAXDAT.TRG_AI_HOLIDAYS
on MAXDAT.HOLIDAYS
after insert
as
begin

  declare @v_holiday_date datetime = null;
  declare c_inserted cursor for 
    select HOLIDAY_DATE 
	from INSERTED;
  open c_inserted;
  fetch next from c_inserted into @v_holiday_date;
  while @@fetch_status = 0
    begin

      update MAXDAT.BPM_D_DATES
      set BUSINESS_DAY_FLAG = 'N'
	  where 
	    D_DATE = @v_holiday_date;

	  fetch next from c_inserted into @v_holiday_date;

    end;

  close c_inserted;
  deallocate c_inserted;
 
end;
go

-- Update BPM_D_DATES.BUSINESS_DAY_FLAG value when a HOLIDAYS row is updated.
if OBJECT_ID ('MAXDAT.TRG_AU_HOLIDAYS','TR') is not null
begin
  drop trigger MAXDAT.TRG_AU_HOLIDAYS;
end;
go

create trigger MAXDAT.TRG_AU_HOLIDAYS
on MAXDAT.HOLIDAYS
after update
as
begin

  declare @v_holiday_date datetime = null;

  declare c_deleted cursor for 
    select HOLIDAY_DATE 
	from DELETED;
  open c_deleted;
  fetch next from c_deleted into @v_holiday_date;
  while @@fetch_status = 0
    begin

      update MAXDAT.BPM_D_DATES
      set BUSINESS_DAY_FLAG = 'Y'
	  where 
	    D_DATE = @v_holiday_date
		and D_DAY_OF_WEEK not in ('1','7');

	  fetch next from c_deleted into @v_holiday_date;

    end;

  close c_deleted;
  deallocate c_deleted;

  declare c_inserted cursor for 
    select HOLIDAY_DATE 
	from INSERTED;
  open c_inserted;
  fetch next from c_inserted into @v_holiday_date;
  while @@fetch_status = 0
    begin

      update MAXDAT.BPM_D_DATES
      set BUSINESS_DAY_FLAG = 'N'
	  where 
	    D_DATE = @v_holiday_date;

	  fetch next from c_inserted into @v_holiday_date;

    end;

  close c_inserted;
  deallocate c_inserted;
 
end;
go