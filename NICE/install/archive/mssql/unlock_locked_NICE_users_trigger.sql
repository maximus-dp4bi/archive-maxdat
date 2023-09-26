/* Add trigger to NICE platform db to unlock user accounts. */
/* NICE SQL Server db*/


-- Set to database.
use nice_wfm_platform1;


-- Reset all existsing failed login attempts locks and counters .
update dbo.PLATFORM_USER
set 
  FAILED_LOGIN_ATTEMPTS = 0, 
  LOCKED = 0, 
  LOCKED_TIME = null, 
  SYNC_DATE = null
where 
  FAILED_LOGIN_ATTEMPTS > 0 
  or LOCKED != 0
  or LOCKED_TIME is not null;


-- Remove existing trigger,
if OBJECT_ID ('dbo.TRG_AU_PLATFORM_USER','TR') is not null
begin
  drop trigger dbo.TRG_AU_PLATFORM_USER;
end;
go


-- Create a new trigger to reset failed login attempts and locked users anytime a failed login or locked user occurs.
create trigger dbo.TRG_AU_PLATFORM_USER
on dbo.PLATFORM_USER
after update
as
begin

  declare @v_entity_id varchar(255) = null;
  declare @v_failed_login_attempts numeric(19,0)= null;
  declare @v_locked tinyint = null;
  declare @v_locked_time datetime = null;
  
  -- Get new values of rows after any update to the dbo.PLATFORM_USER table.
  declare c_inserted cursor for 
    select 
	  ENTITY_ID,
	  FAILED_LOGIN_ATTEMPTS,
	  LOCKED,
	  LOCKED_TIME
	from INSERTED;
  
  -- Loop through new values of updated rows in the dbo.PLATFORM_USER table.
  open c_inserted;
  fetch next from c_inserted into @v_entity_id, @v_failed_login_attempts, @v_locked, @v_locked_time;
  while @@fetch_status = 0
    begin

	   -- Only reset rows that have a failed login attempt or the user is locked.
	   if @v_failed_login_attempts > 0 or @v_locked != 0 or @v_locked_time is not null
	   begin

		 update dbo.PLATFORM_USER 
		 set 
		   FAILED_LOGIN_ATTEMPTS = 0, 
		   LOCKED = 0, 
		   LOCKED_TIME = null, 
		   SYNC_DATE = null 
         where ENTITY_ID = @v_entity_id and (FAILED_LOGIN_ATTEMPTS > 0 or LOCKED != 0 or LOCKED_TIME is not null);

	   end;

	  fetch next from c_inserted into @v_entity_id, @v_failed_login_attempts, @v_locked, @v_locked_time;

    end;

  close c_inserted;
  deallocate c_inserted;
 
end;
go
