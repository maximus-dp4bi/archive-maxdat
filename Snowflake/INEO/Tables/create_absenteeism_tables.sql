create table ineo_jan_absenteeism
as
select cast(date as date) date,cast(approved_time_off as number) approved_time_off, cast(checked_in as number) checked_in,cast(ncns as number) ncns,cast(not_checked_in as number) not_checked_in,
cast(unsch_abs as number) unscheduled_absence,cast(unsch_abs_full_day as number) unscheduled_absence_full_day,
cast(unsch_abs_part_day as number) unscheduled_absence_part_day,cast(total_staff as number) total_staff,
cast(absent as number) absent,cast(headcount as number) headcount,cast(abs_rate as float) abs_rate
from jan_absenteeism;

create table ineo_jan_absenteeism_region
as
select cast(date as date) date,cast(approved_time_off as number) approved_time_off, cast(checked_in as number) checked_in,cast(ncns as number) ncns,cast(not_checked_in as number) not_checked_in,
cast(unsch_abs as number) unscheduled_absence,cast(unsch_abs_full_day as number) unscheduled_absence_full_day,
cast(unsch_abs_part_day as number) unscheduled_absence_part_day,cast(total_staff as number) total_staff,
cast(absent as number) absent,cast(headcount as number) headcount,cast(regexp_replace(abs_rate,'%') as float) abs_rate,
region
from jan_absenteeism_region;

CREATE TABLE INEO.INEO_JAN_ABSENTEEISM_REGION(DATE DATE,
APPROVED_TIME_OFF NUMBER,
CHECKED_IN NUMBER,
NCNS NUMBER,
NOT_CHECKED_IN NUMBER,
UNSCHEDULED_ABSENCE NUMBER,
UNSCHEDULED_ABSENCE_FULL_DAY NUMBER,
UNSCHEDULED_ABSENCE_PART_DAY NUMBER,
TOTAL_STAFF NUMBER,
ABSENT NUMBER,
HEADCOUNT NUMBER,
ABS_RATE FLOAT,
REGION VARCHAR);

CREATE TABLE INEO.INEO_JAN_ABSENTEEISM(DATE DATE,
APPROVED_TIME_OFF NUMBER,
CHECKED_IN NUMBER,
NCNS NUMBER,
NOT_CHECKED_IN NUMBER,
UNSCHEDULED_ABSENCE NUMBER,
UNSCHEDULED_ABSENCE_FULL_DAY NUMBER,
UNSCHEDULED_ABSENCE_PART_DAY NUMBER,
TOTAL_STAFF NUMBER,
ABSENT NUMBER,
HEADCOUNT NUMBER,
ABS_RATE FLOAT);
