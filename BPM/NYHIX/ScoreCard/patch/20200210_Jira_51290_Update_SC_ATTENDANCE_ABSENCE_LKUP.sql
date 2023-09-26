--------------------------------------------------------
--  DML for Table SC_ATTENDANCE_ABSENCE_LKUP
--------------------------------------------------------

--Updates--
Update DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP
set ABSENCE_TYPE = 'Bereavement | Management Approved - Documentation Confirmed (0)'
where SC_ALL_ID = 4;

Update DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP
set ABSENCE_TYPE = 'Critical Absence | Full Day (-6)'
where SC_ALL_ID = 3;

Update DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP
set ABSENCE_TYPE = 'Critical Day Early Departure (5-59 minutes early) (-1)'
where SC_ALL_ID = 7;

Update DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP
set ABSENCE_TYPE = 'Critical Day Late Arrival (5-59 mins late) | Late Arrival (-1)'
where SC_ALL_ID = 11;

Update DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP
set ABSENCE_TYPE = 'Incentive points | Director Approved (1)'
where SC_ALL_ID = 22;

Update DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP
set ABSENCE_TYPE = 'Incentive points | Director Approved (2)'
where SC_ALL_ID = 24;

Update DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP
set ABSENCE_TYPE = 'Incentive points | Director Approved (4)'
where SC_ALL_ID = 26;

Update DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP
set ABSENCE_TYPE = 'Jury Duty | Management Approved - Documentation Confirmed (0)'
where SC_ALL_ID = 28;

Update DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP
set ABSENCE_TYPE = 'Early Departure (5-59 mins early) (-1)'
where SC_ALL_ID = 31;

Update DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP
set ABSENCE_TYPE = 'Military leave | Management Approved - Documentation Confirmed (0)'
where SC_ALL_ID = 32;

Update DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP
set ABSENCE_TYPE = 'Late Arrival (5-59 minutes late) (-1)'
where SC_ALL_ID = 51;

COMMIT;


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

--End Dated--
Update DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP
set END_DATE = sysdate
where SC_ALL_ID in (5,16,17,18,19,20,23,25,27,29,30,33,38) ;

COMMIT;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Inserts--

Insert into DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP (SC_ALL_ID,ABSENCE_TYPE,POINT_VALUE,END_DATE,CREATE_BY,CREATE_DATETIME,INCENTIVE_FLAG,PERFECT_ATTENDANCE_FLAG) 
values (210,'Critical Absence | Partial Day - Greater Than 4 Hours (-6)',-6,to_date('07-JUL-2077 00:00:00','DD-MON-YYYY HH24:MI:SS'),'script',sysdate,null,null);

Insert into DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP (SC_ALL_ID,ABSENCE_TYPE,POINT_VALUE,END_DATE,CREATE_BY,CREATE_DATETIME,INCENTIVE_FLAG,PERFECT_ATTENDANCE_FLAG) 
values (211,'Court - Management Approved-Documentation Confirmed(0)',0,to_date('07-JUL-2077 00:00:00','DD-MON-YYYY HH24:MI:SS'),'script',sysdate,null,null);

Insert into DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP (SC_ALL_ID,ABSENCE_TYPE,POINT_VALUE,END_DATE,CREATE_BY,CREATE_DATETIME,INCENTIVE_FLAG,PERFECT_ATTENDANCE_FLAG) 
values (212,'FMLA Continuous (0)',0,to_date('07-JUL-2077 00:00:00','DD-MON-YYYY HH24:MI:SS'),'script',sysdate,null,null);

Insert into DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP (SC_ALL_ID,ABSENCE_TYPE,POINT_VALUE,END_DATE,CREATE_BY,CREATE_DATETIME,INCENTIVE_FLAG,PERFECT_ATTENDANCE_FLAG) 
values (213,'FMLA Intermittent (0)',0,to_date('07-JUL-2077 00:00:00','DD-MON-YYYY HH24:MI:SS'),'script',sysdate,null,null);

Insert into DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP (SC_ALL_ID,ABSENCE_TYPE,POINT_VALUE,END_DATE,CREATE_BY,CREATE_DATETIME,INCENTIVE_FLAG,PERFECT_ATTENDANCE_FLAG) 
values (214,'LWA Continuous (0)',0,to_date('07-JUL-2077 00:00:00','DD-MON-YYYY HH24:MI:SS'),'script',sysdate,null,null);

Insert into DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP (SC_ALL_ID,ABSENCE_TYPE,POINT_VALUE,END_DATE,CREATE_BY,CREATE_DATETIME,INCENTIVE_FLAG,PERFECT_ATTENDANCE_FLAG) 
values (215,'LWA Intermittent (0)',0,to_date('07-JUL-2077 00:00:00','DD-MON-YYYY HH24:MI:SS'),'script',sysdate,null,null);

Insert into DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP (SC_ALL_ID,ABSENCE_TYPE,POINT_VALUE,END_DATE,CREATE_BY,CREATE_DATETIME,INCENTIVE_FLAG,PERFECT_ATTENDANCE_FLAG) 
values (216,'Mid Shift  (5-59 mins) - Departure/Return Same Day (-1)',-1,to_date('07-JUL-2077 00:00:00','DD-MON-YYYY HH24:MI:SS'),'script',sysdate,null,null);

Insert into DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP (SC_ALL_ID,ABSENCE_TYPE,POINT_VALUE,END_DATE,CREATE_BY,CREATE_DATETIME,INCENTIVE_FLAG,PERFECT_ATTENDANCE_FLAG) 
values (217,'PFL Continuous (0)',0,to_date('07-JUL-2077 00:00:00','DD-MON-YYYY HH24:MI:SS'),'script',sysdate,null,null);

Insert into DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP (SC_ALL_ID,ABSENCE_TYPE,POINT_VALUE,END_DATE,CREATE_BY,CREATE_DATETIME,INCENTIVE_FLAG,PERFECT_ATTENDANCE_FLAG) 
values (218,'PFL Intermittent (0)',0,to_date('07-JUL-2077 00:00:00','DD-MON-YYYY HH24:MI:SS'),'script',sysdate,null,null);

Insert into DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP (SC_ALL_ID,ABSENCE_TYPE,POINT_VALUE,END_DATE,CREATE_BY,CREATE_DATETIME,INCENTIVE_FLAG,PERFECT_ATTENDANCE_FLAG) 
values (219,'PLOA (0)',0,to_date('07-JUL-2077 00:00:00','DD-MON-YYYY HH24:MI:SS'),'script',sysdate,null,null);

Insert into DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP (SC_ALL_ID,ABSENCE_TYPE,POINT_VALUE,END_DATE,CREATE_BY,CREATE_DATETIME,INCENTIVE_FLAG,PERFECT_ATTENDANCE_FLAG) 
values (220,'Return from Continuous Leave (FMLA/PLOA/LWA/PFL) (0)',0,to_date('07-JUL-2077 00:00:00','DD-MON-YYYY HH24:MI:SS'),'script',sysdate,null,null);

COMMIT;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

