CREATE TABLE D_REPORT_DEFINITION
(redef_id   NUMBER(18,0)
 ,Report_Prefix varchar2(15)
 ,Report_number varchar2(15)
 ,Report_name VARCHAR2(100) not null
 ,Report_description varchar2(1000)
 ,Report_location  VARCHAR2(4000)
 ,kpr varchar2(20)
 ,Business_process  VARCHAR2(32)
 ,Report_type  VARCHAR2(128)      
 ,Report_display varchar2(128)
 ,report_created_by varchar2(40)
 ,is_Subscription varchar2(1) not null
 , Rep_Freq_type varchar2(50) not null
 , Rep_Freq_day1 varchar2(25)
 , Rep_Freq_day2 varchar2(25)
 , Rep_Freq_day3 varchar2(25)
 , Rep_Freq_day4 varchar2(25)
 , Rep_freq_day5 varchar2(25)
 , Rep_freq_day6 varchar2(25)
 , Rep_freq_day7 varchar2(25)
 , Rep_Freq_mltptimesaday varchar2(1)
 , Rep_Freq_hour1 varchar2(8)
 , Rep_Freq_hour2 varchar2(8)
 , Rep_Freq_hour3 varchar2(8)
 , Rep_Freq_hour4 varchar2(8)
 , Rep_Freq_hour5 varchar2(8)
 , Rep_Freq_hour6 varchar2(8)
 , Rep_Freq_hour7 varchar2(8)
 , Rep_Freq_hour8 varchar2(8)
 , Rep_Freq_hour9 varchar2(8)
 , Rep_Freq_hour10 varchar2(8)
 , Rep_Freq_hour11 varchar2(8)
 , Rep_Freq_hour12 varchar2(8)
 , Rep_login varchar2(25)
 , Report_subscribers varchar2(1000)
 , effective_from_date DATE not null
 ,effective_thru_date DATE not null
 , excel_linenos varchar2(50)
) TABLESPACE MAXDAT_DATA;

/*
Report_Freq_Type values
	Daily
	Daily Monday - Friday
	Specific Calenday date
	Specific Days of Week

Report_Freq_day values
	Monday to Sunday
	Day number of month 
	
Rep_Freq_mltptimesaday
	Whether report can be sent multiple times a day Y/N
	
Rep_Freq_hour
	Hour number HH:MI AM/PM format
*/	

create public synonym d_report_definition for maxdat.d_report_definition;

create sequence seq_redef_id start with 1 increment by 1;

alter table d_report_definition add constraint dredef_unique unique(report_name);

alter table d_report_definition add constraint dredef_chk_freq_type check (rep_freq_type in ('DAILY','DAILY MONDAY-FRIDAY','CALENDAR DATE','DAYS OF WEEK','UNKNOWN'));

alter table d_report_definition add constraint dredef_chk_freq_mtaday check (rep_freq_mltptimesaday in ('Y','N'));

alter table d_report_definition add constraint dredef_chk_issubscription check (rep_freq_mltptimesaday in ('Y','N'));

GRANT SELECT ON D_REPORT_DEFINITION TO MAXDAT_READ_ONLY;

alter table D_REPORT_DEFINITION add constraint D_REPORT_DEFINITION_PK primary key (REDEF_ID) using index tablespace MAXDAT_INDX;

create or replace view D_REPORT_DEFINITION_SV as
select * 
from D_REPORT_DEFINITION
with read only;


grant select on D_REPORT_DEFINITION_SV to MAXDAT_READ_ONLY;
