/*
Created on 16-Jul-2014 by Raj A.
This script will set the Start & End times for the  NYHIX Process Letters ETL.

Raj A. 16-Jul-2014 Initial creation.
Raj A. 28-Jul-2014 Using Maxdat_admin package so the changes can be logged.
*/
begin
  maxdat.maxdat_admin.config_etl(p_name => 'PL_SCHEDULE_START',
                                 p_value => '10:00:00');
end;

begin
  maxdat.maxdat_admin.config_etl(p_name => 'PL_SCHEDULE_END',
                                 p_value => '20:00:00');
end;