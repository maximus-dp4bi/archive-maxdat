/*
Created on 31-Jul-2014 by Raj A.
NYHIX & ILEB have a bug in fetching new instances. Currently, the code is fetching new instances since the last successful run date. 
I changed to fetch new instances going back by few days or few hours. This global control can be changed to go back 180 days or 0.25 day i.e., 6 hours.
To insert all the missing instances since many months, I will use global control value=180 days; After the first run after this deployment, 
I will change to 4/24, i.e., 4 hours.
*/
insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('PL_SUCCESSFUL_RUN_LOOK_BACK_DAYS','N',30,'Last Successful ETL run date minus these many days. Ex: use 180 to go back 6 months. 0.25 to go back 6 hours.',sysdate,sysdate);

commit;