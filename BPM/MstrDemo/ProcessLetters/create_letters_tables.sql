
create table letters_demo_stg
  (PL_BI_ID                       number,
   letter_request_id              number,
	 letter_type							      varchar2(4000),
   create_date							      date,
	 created_by							        varchar2(50),
	 request_date						        date,
	 language							          varchar2(32),
   letter_status				          varchar2(256) not null,
   rejection_reason					      varchar2(100),
	 request_error_reason				    varchar2(4000),	 
   last_update_date					      date,
	 last_updated_by_name				    varchar2(50),
   COMPLETE_DATE						      date,
   sla_category				            varchar2(4000),
	 sla_days                		    varchar2(20),
	 sla_days_type				          varchar2(1),	 
	 sla_jeopardy_days              number,
	 sla_target_days                number,
   case_cin                       varchar2(100),
   instance_status						    varchar2(10),
	 mailed_date							      date,
   reprint								        varchar2(1),
   outcome_flag						        varchar2(1),
   source_of_request              varchar2(100),
   error_reason_category          varchar2(100),
	 case_id								        number,
	 letter_status_date					    date,
   SEND_TO_MAIL_HOUSE_START_DATE	date,
	 send_to_mail_house_end_date		date,
   RECEIVE_CONFIRM_END_DATE		    date);
   
create table letters_demo_child_stg
(letter_request_id number,
 client_id number,
 clnt_cin varchar2(100),
 subprogram varchar2(100));
 
CREATE TABLE d_pl_current
AS
SELECT pl_bi_id,
   letter_request_id,
	 letter_type,
   create_date,
	 case when s.created_by = '10265' then 12667
when s.created_by = '12680' then 10764 
when s.created_by = '11497' then 12692 
when s.created_by = '10905' then 14982 
when s.created_by = '11852' then  12733
when s.created_by = '12337' then 12761 
when s.created_by = '13885' then  13044
when s.created_by = '13887' then  13504
when s.created_by = '13890' then  14424
when s.created_by = '13909' then  15804
when s.created_by = '14210' then  17905
when s.created_by = '14225' then  17943
when s.created_by = '15910' then  17983
when s.created_by = '16367' then  19313
when s.created_by = '16645' then  19367
when s.created_by = '16760' then  19370
when s.created_by = '16785' then  20388
when s.created_by = '16832' then  22452
when s.created_by in('-425','-112','-11','-2','-1001','-19')
 then -425 else null end created_by	,
	 request_date,
	 language,
   letter_status,
   rejection_reason,
	 request_error_reason,	 
   last_update_date,
	 case when s.last_updated_by_name = '10265' then 12667
when s.last_updated_by_name = '10764' then 12680  
when s.last_updated_by_name = '11497' then 12692 
when s.last_updated_by_name = '10905' then 14982 
when s.last_updated_by_name = '11852' then  12733
when s.last_updated_by_name = '12337' then 12761 
when s.last_updated_by_name = '13885' then  13044
when s.last_updated_by_name = '13887' then  13504
when s.last_updated_by_name = '13890' then  14424
when s.last_updated_by_name = '13909' then  15804
when s.last_updated_by_name = '14210' then  17905
when s.last_updated_by_name = '14225' then  17943
when s.last_updated_by_name = '15910' then  17983
when s.last_updated_by_name = '16367' then  19313
when s.last_updated_by_name = '16645' then  19367
when s.last_updated_by_name = '16760' then  19370
when s.last_updated_by_name = '16785' then  20388
when s.last_updated_by_name = '16832' then  22452
when s.last_updated_by_name in('-425','-112','-11','-2','-1001','-19')
 then -425
else null end last_updated_by,
   complete_date,
   sla_category,
	 sla_days,
	 sla_days_type,	 
	 sla_jeopardy_days,
	 sla_target_days,
   case_cin,
   instance_status,
	 mailed_date,
   reprint,
   outcome_flag,
   source_of_request,
   error_reason_category,
	 case_id,
	 letter_status_date,
   send_to_mail_house_start_date,
	 send_to_mail_house_end_date,
   receive_confirm_end_date
FROM letters_demo_stg s;

CREATE TABLE d_pl_client_sub
AS
SELECT letter_request_id
       ,client_id
       ,clnt_cin client_cin
       ,subprogram
FROM letters_demo_child_stg;

--create views
CREATE OR REPLACE VIEW d_pl_current_sv
AS
SELECT pl.pl_bi_id,
   pl.letter_request_id,
	 pl.letter_type,
   pl.create_date,
	 pl.created_by	,
   cs.first_name||' '||cs.last_name created_by_name,
	 pl.request_date,
	 pl.language,
   pl.letter_status,
   pl.rejection_reason,
	 pl.request_error_reason,	 
   pl.last_update_date,
   pl.last_updated_by,
	 us.first_name||' '||us.last_name last_updated_by_name,
   pl.complete_date,
   pl.sla_category,
	 pl.sla_days,
	 pl.sla_days_type,	 
	 pl.sla_jeopardy_days,
	 pl.sla_target_days,
   pl.case_cin,
   pl.instance_status,
	 pl.mailed_date,
   pl.reprint,
   pl.outcome_flag,
   CASE WHEN TO_NUMBER(pl.created_by) < 0 THEN 'MAXeb' ELSE 'Person' END source_of_request,
   pl.error_reason_category,
	 pl.case_id,
	 pl.letter_status_date,
   pl.send_to_mail_house_start_date,
	 pl.send_to_mail_house_end_date,
   pl.receive_confirm_end_date,
   (SELECT
      CASE
      WHEN (COUNT(*)-1) < 0 THEN 0 ELSE COUNT(*)-1 END
    FROM D_DATES
    WHERE business_day_flag = 'Y'
    AND d_date BETWEEN TRUNC(pl.create_date) AND CASE WHEN TRUNC(pl.complete_date) IS NOT NULL THEN TRUNC(pl.complete_date) ELSE TRUNC(sysdate) END ) age_in_business_days,
    (CASE WHEN pl.complete_date IS NOT NULL THEN TRUNC(pl.complete_date) ELSE TRUNC(sysdate) END ) - TRUNC(pl.create_date) age_in_calendar_days,
    CASE WHEN pl.instance_status = 'Complete' THEN
     CASE WHEN (SELECT
      CASE
      WHEN (COUNT(*)-1) < 0 THEN 0 ELSE COUNT(*)-1 END
    FROM D_DATES
    WHERE business_day_flag = 'Y'
    AND d_date BETWEEN TRUNC(pl.create_date) AND CASE WHEN pl.complete_date IS NOT NULL THEN TRUNC(pl.complete_date) ELSE TRUNC(sysdate) END ) <= sla_days THEN 'Timely' ELSE 'Untimely' END
  ELSE 'Not Processed' END timeliness_status,
  TRUNC(pl.create_date) + pl.sla_jeopardy_days sla_jeopardy_date,
  TO_CHAR(pl.create_date,'MM/YYYY') create_month,
  TO_CHAR(pl.complete_date,'MM/YYYY') complete_month,
  CASE WHEN pl.instance_status = 'Complete' THEN (SELECT
      CASE
      WHEN (COUNT(*)-1) < 0 THEN 0 ELSE COUNT(*)-1 END
    FROM D_DATES
    WHERE business_day_flag = 'Y'
    AND d_date BETWEEN TRUNC(pl.create_date) AND CASE WHEN pl.complete_date IS NOT NULL THEN TRUNC(pl.complete_date) ELSE TRUNC(sysdate) END ) 
  ELSE NULL END cycle_time  
FROM d_pl_current pl
 LEFT JOIN d_staff cs ON pl.created_by = cs.staff_id
 LEFT JOIN d_staff us ON pl.last_updated_by = us.staff_id;

CREATE OR REPLACE VIEW d_pl_client_sub_sv
AS
SELECT letter_request_id
       ,client_id
       ,client_cin
       ,subprogram
FROM d_pl_client_sub;       

--create ProcessLetters system user
insert into d_staff(staff_id,first_name,last_name)
values(-425,'ProcessLettersJob','System');        

--create backup table of original data
CREATE TABLE d_pl_current_orig_data
AS
SELECT * FROM d_pl_current;

CREATE TABLE d_pl_client_sub_orig_data
AS
SELECT * FROM d_pl_client_sub;