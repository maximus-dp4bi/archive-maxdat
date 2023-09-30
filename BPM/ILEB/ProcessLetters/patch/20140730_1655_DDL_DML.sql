/*
Created on 30-Jul-2014 by Raj A.
NYHIX has some error reasons for letters greater the existing size of 100. So, changed to 4000 to match the Letter_STG.error_codes
Same is the reason for County_Code.
To keep NYHIX and ILEB in sync changing in IL too.

NYHIX & ILEB have a bug in fetching new instances. Currently, the code is fetching new instances since the last successful run date. 
I changed to fetch new instances going back by few days or few hours. This global control can be changed to go back 180 days or 0.25 day i.e., 6 hours.
To insert all the missing instances since many months, I will use global control value=180 days; After the first run after this deployment, 
I will change to 4/24, i.e., 4 hours.
*/
alter table corp_etl_proc_letters modify error_reason varchar2(4000);
alter table corp_etl_proc_letters_oltp modify error_reason varchar2(4000);
alter table corp_etl_proc_letters_wip_bpm modify error_reason varchar2(4000);
alter table d_pl_current modify REQUEST_ERROR_REASON varchar2(4000);

alter table corp_etl_proc_letters modify COUNTY_CODE varchar2(64);
alter table corp_etl_proc_letters_oltp modify COUNTY_CODE varchar2(64);
alter table corp_etl_proc_letters_wip_bpm modify COUNTY_CODE varchar2(64);
alter table d_pl_current modify COUNTY_CODE varchar2(64);

insert into CORP_ETL_CONTROL
values ('PL_SCHEDULE_START','V','02:00:00','Process Letters ETL to run once daily on NYHIX. Represents the hour & minute value on 24-hour format.', sysdate, sysdate);
insert into CORP_ETL_CONTROL
values ('PL_SCHEDULE_END','V','21:00:00','Process Letters ETL to run once daily on NYHIX. Represents the hour & minute value on 24-hour format.', sysdate, sysdate);

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('PL_SUCCESSFUL_RUN_LOOK_BACK_DAYS','N',600,'Last Successful ETL run date minus these many days. Ex: use 180 to go back 6 months. 0.25 to go back 6 hours.',sysdate,sysdate);

commit;