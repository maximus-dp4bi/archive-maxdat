/********** TASK-8937 **********/

USE DATABASE DECISIONPOINT_PRD;

CREATE SCHEMA CONFIG;

USE SCHEMA CONFIG;

/********** TASK-8913 **********/

CREATE TABLE C_HOLIDAYS
(
    HOLIDAYID                      NUMBER(38,0),
    HOLIDAYNAME                    VARCHAR(400)
);

ALTER TABLE C_HOLIDAYS ADD PRIMARY KEY (HOLIDAYID);
ALTER TABLE C_HOLIDAYS ADD UNIQUE (HOLIDAYNAME);

CREATE OR REPLACE VIEW C_HOLIDAYS_SV AS
SELECT * FROM C_HOLIDAYS;

INSERT INTO C_HOLIDAYS (HOLIDAYID, HOLIDAYNAME)
VALUES (10, 'New Year''s Day');

INSERT INTO C_HOLIDAYS (HOLIDAYID, HOLIDAYNAME)
VALUES (20, 'Dr. Martin Luther King Jr. Day');

INSERT INTO C_HOLIDAYS (HOLIDAYID, HOLIDAYNAME)
VALUES (30, 'Presidents'' Day');

INSERT INTO C_HOLIDAYS (HOLIDAYID, HOLIDAYNAME)
VALUES (40, 'Memorial Day');

INSERT INTO C_HOLIDAYS (HOLIDAYID, HOLIDAYNAME)
VALUES (50, 'Juneteenth');

INSERT INTO C_HOLIDAYS (HOLIDAYID, HOLIDAYNAME)
VALUES (60, 'Independence Day');

INSERT INTO C_HOLIDAYS (HOLIDAYID, HOLIDAYNAME)
VALUES (70, 'Labor Day');

INSERT INTO C_HOLIDAYS (HOLIDAYID, HOLIDAYNAME)
VALUES (80, 'Columbus Day');

INSERT INTO C_HOLIDAYS (HOLIDAYID, HOLIDAYNAME)
VALUES (90, 'Veterans Day');

INSERT INTO C_HOLIDAYS (HOLIDAYID, HOLIDAYNAME)
VALUES (100, 'Thanksgiving Day');

INSERT INTO C_HOLIDAYS (HOLIDAYID, HOLIDAYNAME)
VALUES (110, 'Day After Thanksgiving');

INSERT INTO C_HOLIDAYS (HOLIDAYID, HOLIDAYNAME)
VALUES (120, 'Christmas Eve');

INSERT INTO C_HOLIDAYS (HOLIDAYID, HOLIDAYNAME)
VALUES (130, 'Christmas Day');

INSERT INTO C_HOLIDAYS (HOLIDAYID, HOLIDAYNAME)
VALUES (140, 'New Year''s Eve');

INSERT INTO C_HOLIDAYS (HOLIDAYID, HOLIDAYNAME)
VALUES (150, 'State Holiday');

/********** TASK-9193 **********/

CREATE TABLE C_PROJECT_HOLIDAYS
(
    PROJECTID                      NUMBER(38,0),
    PROGRAMID                      NUMBER(38,0),
    HOLIDAYID                      NUMBER(38,0),    
    HOLIDAYDATE                    DATE,
    HOLIDAYSTARTDATE               DATE,
    HOLIDAYENDDATE                 DATE
);

ALTER TABLE C_PROJECT_HOLIDAYS ADD PRIMARY KEY (PROJECTID, PROGRAMID, HOLIDAYDATE);

CREATE OR REPLACE VIEW C_PROJECT_HOLIDAYS_SV AS
SELECT * FROM C_PROJECT_HOLIDAYS;

DELETE FROM C_PROJECT_HOLIDAYS;

-- New Year's Day
INSERT INTO C_PROJECT_HOLIDAYS (PROJECTID, HOLIDAYID, HOLIDAYDATE, HOLIDAYSTARTDATE, HOLIDAYENDDATE)
VALUES (44, 10, '2021-01-01', '2021-01-01', '2021-01-01');

-- Dr. Martin Luther King Jr. Day
INSERT INTO C_PROJECT_HOLIDAYS (PROJECTID, HOLIDAYID, HOLIDAYDATE, HOLIDAYSTARTDATE, HOLIDAYENDDATE)
VALUES (44, 20, '2021-01-18', '2021-01-18', '2021-01-18');

-- Presidents' Day
INSERT INTO C_PROJECT_HOLIDAYS (PROJECTID, HOLIDAYID, HOLIDAYDATE, HOLIDAYSTARTDATE, HOLIDAYENDDATE)
VALUES (44, 30, '2021-02-15', '2021-02-15', '2021-02-15');

-- Memorial Day
INSERT INTO C_PROJECT_HOLIDAYS (PROJECTID, HOLIDAYID, HOLIDAYDATE, HOLIDAYSTARTDATE, HOLIDAYENDDATE)
VALUES (44, 40, '2021-05-31', '2021-05-31', '2021-05-31');

-- Juneteenth
INSERT INTO C_PROJECT_HOLIDAYS (PROJECTID, HOLIDAYID, HOLIDAYDATE, HOLIDAYSTARTDATE, HOLIDAYENDDATE)
VALUES (44, 50, '2021-06-19', '2021-06-19', '2021-06-19');

-- Independence Day
INSERT INTO C_PROJECT_HOLIDAYS (PROJECTID, HOLIDAYID, HOLIDAYDATE, HOLIDAYSTARTDATE, HOLIDAYENDDATE)
VALUES (44, 60, '2021-07-04', '2021-07-04', '2021-07-04');

-- Labor Day
INSERT INTO C_PROJECT_HOLIDAYS (PROJECTID, HOLIDAYID, HOLIDAYDATE, HOLIDAYSTARTDATE, HOLIDAYENDDATE)
VALUES (44, 70, '2021-09-06', '2021-09-06', '2021-09-06');

-- Columbus Day
INSERT INTO C_PROJECT_HOLIDAYS (PROJECTID, HOLIDAYID, HOLIDAYDATE, HOLIDAYSTARTDATE, HOLIDAYENDDATE)
VALUES (44, 80, '2021-10-11', '2021-10-11', '2021-10-11');

-- Veterans Day
INSERT INTO C_PROJECT_HOLIDAYS (PROJECTID, HOLIDAYID, HOLIDAYDATE, HOLIDAYSTARTDATE, HOLIDAYENDDATE)
VALUES (44, 90, '2021-11-11', '2021-11-11', '2021-11-11');

-- Thanksgiving Day
INSERT INTO C_PROJECT_HOLIDAYS (PROJECTID, HOLIDAYID, HOLIDAYDATE, HOLIDAYSTARTDATE, HOLIDAYENDDATE)
VALUES (44, 100, '2021-11-25', '2021-11-25', '2021-11-25');

-- Day After Thanksgiving
INSERT INTO C_PROJECT_HOLIDAYS (PROJECTID, HOLIDAYID, HOLIDAYDATE, HOLIDAYSTARTDATE, HOLIDAYENDDATE)
VALUES (44, 110, '2021-11-26', '2021-11-26', '2021-11-26');

-- Christmas Eve
INSERT INTO C_PROJECT_HOLIDAYS (PROJECTID, HOLIDAYID, HOLIDAYDATE, HOLIDAYSTARTDATE, HOLIDAYENDDATE)
VALUES (44, 120, '2021-12-24', '2021-12-24', '2021-12-24');

-- Christmas Day
INSERT INTO C_PROJECT_HOLIDAYS (PROJECTID, HOLIDAYID, HOLIDAYDATE, HOLIDAYSTARTDATE, HOLIDAYENDDATE)
VALUES (44, 130, '2021-12-25', '2021-12-25', '2021-12-25');

USE SCHEMA PUBLIC;

-- Create D_HOLIDAYS_SV

CREATE OR REPLACE VIEW D_HOLIDAYS_SV AS
SELECT * FROM CONFIG.C_HOLIDAYS_SV;

-- Create D_PROJECT_HOLIDAYS_SV

CREATE OR REPLACE VIEW D_PROJECT_HOLIDAYS_SV AS
SELECT  cph.projectid,
        cph.programid,
        cph.holidayid,
        ch.holidayname,
        cph.holidaydate,
        cph.holidaystartdate,
        cph.holidayenddate
  FROM  CONFIG.C_PROJECT_HOLIDAYS_SV       cph
        INNER JOIN
        CONFIG.C_HOLIDAYS_SV               ch
        ON
        (
                cph.holidayid    =   ch.holidayid
        );

/********** TASK-8921 **********/

USE DATABASE PUREINSIGHTS_PRD;
USE SCHEMA PUBLIC;

CREATE OR REPLACE VIEW D_PROJECT_HOLIDAYS_SV AS
SELECT * FROM DECISIONPOINT_PRD.PUBLIC.D_PROJECT_HOLIDAYS_SV;

GRANT SELECT ON D_PROJECT_HOLIDAYS_SV TO PUREINSIGHTS_GEN_DP4BI_PRD;
GRANT SELECT ON D_PROJECT_HOLIDAYS_SV TO PUREINSIGHTS_PROD_READ;

/********** TASK-8924 **********/

USE DATABASE MARS_DP4BI_PROD;
USE SCHEMA PUBLIC;

CREATE OR REPLACE VIEW D_PROJECT_HOLIDAYS_SV AS
SELECT * FROM DECISIONPOINT_PRD.PUBLIC.D_PROJECT_HOLIDAYS_SV;

GRANT SELECT ON D_PROJECT_HOLIDAYS_SV TO MARS_DP4BI_PROD_READ;

