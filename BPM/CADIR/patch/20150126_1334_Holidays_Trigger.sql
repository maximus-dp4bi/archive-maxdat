/*
Created on 01/26/2015 by Raj A. per CADIR-525
*/
alter session set plsql_code_type = native;

-- Update BPM_D_DATES.BUSINESS_DAY_FLAG value when a HOLIDAYS row is deleted.
-- Note that if the HOLIDAYS table is truncated, this update must be done manually.
/* Manual sync SQL.
update BPM_D_DATES set BUSINESS_DAY_FLAG = 'N'
where D_DAY_OF_WEEK in ('1','7');

merge into BPM_D_DATES d
using
  (select 
     HOLIDAY_DATE,
     'N' BUSINESS_DAY_FLAG
   from HOLIDAYS) h on (h.HOLIDAY_DATE = d.D_DATE)
when matched then update
set d.BUSINESS_DAY_FLAG = h.BUSINESS_DAY_FLAG;

commit;
*/
create or replace trigger TRG_ADIU_HOLIDAYS
after delete or insert or update on HOLIDAYS 
for each row
declare
  
begin

  if :old.HOLIDAY_DATE != :new.HOLIDAY_DATE
     or (:old.HOLIDAY_DATE is null and :new.HOLIDAY_DATE is not null)
     or (:old.HOLIDAY_DATE is not null and  :new.HOLIDAY_DATE is null) then

    if deleting then

      update BPM_D_DATES
      set BUSINESS_DAY_FLAG = 'Y'
	    where 
	      D_DATE = :old.HOLIDAY_DATE
		    and D_DAY_OF_WEEK not in ('1','7');
      
    elsif inserting then

      update BPM_D_DATES
      set BUSINESS_DAY_FLAG = 'N'
	    where D_DATE = :new.HOLIDAY_DATE;
    
    elsif updating then

      update BPM_D_DATES
      set BUSINESS_DAY_FLAG = 'Y'
	    where 
	      D_DATE = :old.HOLIDAY_DATE
		    and D_DAY_OF_WEEK not in ('1','7');
      
      update BPM_D_DATES
      set BUSINESS_DAY_FLAG = 'N'
	    where D_DATE = :new.HOLIDAY_DATE;
    
    end if;
    
  end if;
 
end;
/

alter session set plsql_code_type = interpreted;