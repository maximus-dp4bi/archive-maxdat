/*
Created on 11-Jun-2013 by Raj A.
Team: MAXDAT.
Project: ICEB.
Business Process: Manage Enrollment Activity.

Description:
Sequence used by the TRG_CORP_ETL_MANAGE_ENRL on the corp_etl_Manage_enroll table.

v1 Raj A. 11-Jun-2013 creation.
v2 Raj A. 17-Jun-2013 Updated the script. it was insert. changed to update.
v3 Raj A. 01-Aug-2013 Changed to 5.
*/

/*
After Initial run, set this variable to 5 days. This is to let the ETL self-heal in case it is stopped for a maximum of 4 days
in MAXDAT production.
*/
update corp_etl_control
   set value = '5'
where name = 'MANAGEENROLL_CDC_DAYS_BACK';
commit;