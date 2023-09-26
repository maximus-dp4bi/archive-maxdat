CREATE OR REPLACE sequence coverva_mio.seq_cfg_prodst_id;

CREATE TABLE coverva_mio.cfg_productivity_standard
(cfg_prodst_id number not null default coverva_mio.seq_cfg_prodst_id.nextval,
 case_type VARCHAR,
 case_type_abbreviation VARCHAR,
 training_status VARCHAR, 
 standard_in_minutes number(5,2),
 standard_percent number(5,2),
 start_date timestamp_ntz(9),
 end_date timestamp_ntz(9),
 updated_on timestamp_ntz(9) default current_timestamp());
 
ALTER TABLE coverva_mio.cfg_productivity_standard ADD PRIMARY KEY(cfg_prodst_id);

grant select on coverva_mio.cfg_productivity_standard to role mars_dp4bi_prod_read;


INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Application','A','Production',64,100,cast('01/01/2021' as date),cast('07/07/7777' as date));

INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Application','A','Week1',256,25,cast('01/01/2021' as date),cast('07/07/7777' as date));

INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Application','A','Week2',128,50,cast('01/01/2021' as date),cast('07/07/7777' as date));

INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Application','A','Week3',85.34,75,cast('01/01/2021' as date),cast('07/07/7777' as date));

INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Application','A','Week4',85.34,75,cast('01/01/2021' as date),cast('07/07/7777' as date));

INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Application','A','Training',256,25,cast('01/01/2021' as date),cast('07/07/7777' as date));

INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Application','A','Nesting',256,25,cast('01/01/2021' as date),cast('07/07/7777' as date));

----
INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Renewal','R','Production',42.60,100,cast('01/01/2021' as date),cast('07/07/7777' as date));

INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Renewal','R','Week1',170.40,25,cast('01/01/2021' as date),cast('07/07/7777' as date));

INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Renewal','R','Week2',85.20,50,cast('01/01/2021' as date),cast('07/07/7777' as date));

INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Renewal','R','Week3',85.20,50,cast('01/01/2021' as date),cast('07/07/7777' as date));

INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Renewal','R','Week4',56.80,75,cast('01/01/2021' as date),cast('07/07/7777' as date));

INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Renewal','R','Training',170.40,25,cast('01/01/2021' as date),cast('07/07/7777' as date));

INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Renewal','R','Nesting',170.40,25,cast('01/01/2021' as date),cast('07/07/7777' as date));

----
INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Intake','I','Production',21.30,100,cast('01/01/2021' as date),cast('07/07/7777' as date));

INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Intake','I','Week1',85.20,25,cast('01/01/2021' as date),cast('07/07/7777' as date));

INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Intake','I','Week2',42.60,50,cast('01/01/2021' as date),cast('07/07/7777' as date));

INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Intake','I','Week3',42.60,50,cast('01/01/2021' as date),cast('07/07/7777' as date));

INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Intake','I','Week4',28.40,75,cast('01/01/2021' as date),cast('07/07/7777' as date));

INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Intake','I','Training',85.20,25,cast('01/01/2021' as date),cast('07/07/7777' as date));

INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Intake','I','Nesting',85.20,25,cast('01/01/2021' as date),cast('07/07/7777' as date));

-----
INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Validation','V','Production',7.5,100,cast('01/01/2021' as date),cast('07/07/7777' as date));

INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Validation','V','Week1',30,25,cast('01/01/2021' as date),cast('07/07/7777' as date));

INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Validation','V','Week2',15,50,cast('01/01/2021' as date),cast('07/07/7777' as date));

INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Validation','V','Week3',10,75,cast('01/01/2021' as date),cast('07/07/7777' as date));

INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Validation','V','Week4',10,75,cast('01/01/2021' as date),cast('07/07/7777' as date));

INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Validation','V','Training',30,25,cast('01/01/2021' as date),cast('07/07/7777' as date));

INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Validation','V','Nesting',30,25,cast('01/01/2021' as date),cast('07/07/7777' as date));