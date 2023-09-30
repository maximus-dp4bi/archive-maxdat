CREATE OR REPLACE function MAXDAT.GET_VALID_DATE( date_string in varchar, pattern_string in varchar2 default 'mm/dd/yyyy' )
return date
is 
    good_date date;
begin
   good_date := to_date(date_string,pattern_string);
   return good_date;
exception
    when others then 
    return to_date(null);
end;
/

grant execute on MAXDAT.get_valid_date to dp_scorecard;
grant execute on MAXDAT.get_valid_date to maxdat_read_only;
