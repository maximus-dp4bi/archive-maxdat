UPDATE coverva_mio.cfg_productivity_standard
SET end_date = cast('08/31/2022' as date)
WHERE case_type IN('Application','Validation','Intake','Research')
AND training_status in('Production','Week1','Week2','Week3','Week4');

INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Application','A','Production',48,100,cast('09/01/2022' as date),cast('07/07/7777' as date));

INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Application','A','Week1',192,25,cast('09/01/2022' as date),cast('07/07/7777' as date));

INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Application','A','Week2',96,50,cast('09/01/2022' as date),cast('07/07/7777' as date));

INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Application','A','Week3',64,75,cast('09/01/2022' as date),cast('07/07/7777' as date));

INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Application','A','Week4',64,75,cast('09/01/2022' as date),cast('07/07/7777' as date));

INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Validation','V','Production',7.53,100,cast('09/01/2022' as date),cast('07/07/7777' as date));

INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Validation','V','Week1',30.12,25,cast('09/01/2022' as date),cast('07/07/7777' as date));

INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Validation','V','Week2',15.06,50,cast('09/01/2022' as date),cast('07/07/7777' as date));

INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Validation','V','Week3',10.04,75,cast('09/01/2022' as date),cast('07/07/7777' as date));

INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Validation','V','Week4',10.04,75,cast('09/01/2022' as date),cast('07/07/7777' as date));

INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Research','I','Production',10.67,100,cast('09/01/2022' as date),cast('07/07/7777' as date));

INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Research','I','Week1',42.67,25,cast('09/01/2022' as date),cast('07/07/7777' as date));

INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Research','I','Week2',21.33,50,cast('09/01/2022' as date),cast('07/07/7777' as date));

INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Research','I','Week3',14.22,75,cast('09/01/2022' as date),cast('07/07/7777' as date));

INSERT INTO coverva_mio.cfg_productivity_standard(case_type,case_type_abbreviation,training_status,standard_in_minutes,standard_percent,start_date,end_date)
VALUES('Research','I','Week4',14.22,75,cast('09/01/2022' as date),cast('07/07/7777' as date));
