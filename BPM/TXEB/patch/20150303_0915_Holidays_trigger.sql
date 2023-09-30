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