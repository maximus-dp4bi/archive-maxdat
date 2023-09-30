---   NYHIX-39085

alter session set current_schema = DP_SCORECARD;
alter session set nls_date_format ='DD-MON-YY HH24:MI:SS';

Delete from engage_actuals where LAST_UPDATE_DATE > to_date('16-MAR-2018', 'DD-MON-YYYY');
commit;

