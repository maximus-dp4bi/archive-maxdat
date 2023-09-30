TRUNCATE TABLE MAXDAT.PP_BO_EVENT_TARGET_LKUP;
COMMIT;

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1
    , 'Beginning of Attendance'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    2
    , 'End of Attendance'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    3
    , 'Slack Time'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    4
    , 'Break'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'NON-PRODUCTIVE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    5
    , 'Lunch'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'NON-PRODUCTIVE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    6
    , 'Vacation'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    7
    , 'Sick'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    8
    , 'Holiday'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    9
    , 'Off'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    10
    , '(  )'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    11
    , 'Unknown'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    12
    , 'Clock In'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    13
    , 'Clock Out'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    14
    , 'Personal Day'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    15
    , 'Late Start'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    16
    , 'Invalid Agent State'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    17
    , 'Unknown Work'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    18
    , '(none)'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    19
    , 'Split Time'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    20
    , '(no actuals)'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    21
    , '(no schedule)'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    22
    , 'Split Work Event'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    23
    , 'Idle Time'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'NON-PRODUCTIVE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    24
    , 'QuickPick Withdrawn'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1000
    , 'CSS III'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1003
    , 'CSS I - SHOP'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1006
    , 'CSS II - SHOP'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1007
    , 'Non Existing Test group'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1008
    , 'SWCC-CSR'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1009
    , 'SWCC-CSR Bilingual'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1010
    , 'SWCC-CSR II'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1011
    , 'SWCC-CSR II Bilingual'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1018
    , 'CSS IV'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1019
    , 'CSS III Bilingual'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1020
    , 'CSS IV Bilingual'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1021
    , 'Team Lead (SHOP)'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1022
    , 'Team Lead (SHOP) - Bilingual'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1023
    , 'Team Lead (Individual)'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1024
    , 'Team Lead (Individual) - Bilingual'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1044
    , 'Eligibility Specialist A'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1045
    , 'HSDE'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1046
    , 'Eligibility Specialist B'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1047
    , 'FM Specialists'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1052
    , 'Eligibility Specialist C'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1057
    , 'Quality Control'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1060
    , 'NY HBE Pilot - Individual'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1061
    , 'NY HBE Pilot - SHOP'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1065
    , 'Staff Meeting'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'NON-PRODUCTIVE'
    , 'Y'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1066
    , 'Training'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'NON-PRODUCTIVE'
    , 'Y'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1067
    , 'Outbound Calls'
    , 4
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Outbound Calls'
    , 'Y'
    , 'Account Review'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1068
    , 'Special Project'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'NON-PRODUCTIVE'
    , 'Y'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1069
    , 'One-on-One'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'NON-PRODUCTIVE'
    , 'Y'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1070
    , 'E-Chat'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1071
    , 'Time Off'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1077
    , 'Mail Room Specialist'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1080
    , 'Navigator'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1081
    , 'Eligibility Specialist C - Appeals'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'NON-PRODUCTIVE'
    , 'Y'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1082
    , 'Financial Management Specialist'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1083
    , 'Supervisor Help'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'NON-PRODUCTIVE'
    , 'Y'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1084
    , 'System Problems'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'NON-PRODUCTIVE'
    , 'Y'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1085
    , 'Phone Problems'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'NON-PRODUCTIVE'
    , 'Y'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1087
    , 'Early Departure'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1088
    , 'Weather Related Late Arrival'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1090
    , 'Unplanned Team Meeting'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1091
    , 'Special Floor Meeting'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1092
    , 'Unplanned Absence'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1093
    , 'IDR incident'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1095
    , 'Employer Application'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1096
    , 'Employee Application'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1098
    , 'Existing Appeal'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1099
    , 'Complaint'
    , 10
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Complaint'
    , 'Y'
    , 'Account Review'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1099
    , 'Complaint'
    , 20
    , 'Y'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:54', 'YYYY-MM-DD HH24:MI:SS')
    , 'Complaint'
    , 'Y'
    , 'Account Review'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1099
    , 'Complaint'
    , 20
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:48:56', 'YYYY-MM-DD HH24:MI:SS')
    , 'Complaint'
    , 'Y'
    , 'Account Review'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1101
    , 'Incident Open'
    , 2
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Incident Open'
    , 'Y'
    , 'Account Review'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1101
    , 'Incident Open'
    , 3.5
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:48:56', 'YYYY-MM-DD HH24:MI:SS')
    , 'Incident Open'
    , 'Y'
    , 'Account Review'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1102
    , 'Refer to ES-C'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'NON-PRODUCTIVE'
    , 'Y'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1103
    , 'Schedule Hearing'
    , 0.65
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:48:57', 'YYYY-MM-DD HH24:MI:SS')
    , 'Schedule Hearing'
    , 'Y'
    , 'Account Review'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1103
    , 'Schedule Hearing'
    , 0.75
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Schedule Hearing'
    , 'Y'
    , 'Account Review'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1104
    , 'Verification Document'
    , 8
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Verification Document'
    , 'Y'
    , 'Verification Document'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1104
    , 'Verification Document'
    , 8.5
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:48:57', 'YYYY-MM-DD HH24:MI:SS')
    , 'Verification Document'
    , 'Y'
    , 'Verification Document'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1105
    , 'Application in Process'
    , 10
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Application in Process'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1105
    , 'Application in Process'
    , 9
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:48:57', 'YYYY-MM-DD HH24:MI:SS')
    , 'Application in Process'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1106
    , 'Free Form Text'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1107
    , 'Returned Mail Application'
    , 15
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Returned Mail'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1107
    , 'Returned Mail Application'
    , 0
    , 'N'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:05', 'YYYY-MM-DD HH24:MI:SS')
    , 'Returned Mail'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1107
    , 'Returned Mail Application'
    , 18
    , 'Y'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:54', 'YYYY-MM-DD HH24:MI:SS')
    , 'Returned Mail'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1109
    , 'Wrong Program'
    , 20
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:48:57', 'YYYY-MM-DD HH24:MI:SS')
    , 'Wrong Program'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1109
    , 'Wrong Program'
    , 15
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Wrong Program'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1110
    , 'FM Returned Mail'
    , 10
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Other Research'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1110
    , 'FM Returned Mail'
    , 20
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:48:57', 'YYYY-MM-DD HH24:MI:SS')
    , 'Other Research'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1110
    , 'FM Returned Mail'
    , 20
    , 'Y'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:54', 'YYYY-MM-DD HH24:MI:SS')
    , 'Other Research'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1111
    , 'Other'
    , 10
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Other Research'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1111
    , 'Other'
    , 20
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:48:57', 'YYYY-MM-DD HH24:MI:SS')
    , 'Other Research'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1111
    , 'Other'
    , 20
    , 'Y'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:54', 'YYYY-MM-DD HH24:MI:SS')
    , 'Other Research'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1112
    , 'IDR Incident Open'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1118
    , 'CC Supervisor'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1119
    , 'Team Meeting'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1120
    , 'Problem Case'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'NON-PRODUCTIVE'
    , 'Y'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1121
    , 'CSS III - Spec Lang'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1122
    , 'CSS I - SHOP Bilingual'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1123
    , 'CSS II - SHOP Bilingual'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1124
    , 'Missing Data'
    , 7
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Application - Missing Data'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1124
    , 'Missing Data'
    , 0
    , 'N'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:04', 'YYYY-MM-DD HH24:MI:SS')
    , 'Application - Missing Data'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1126
    , 'NYEC - Renewals'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1127
    , 'NYEC - Renewals Bilingual'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1128
    , 'NYEC - PAP'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1129
    , 'NYEC - FPBP'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1130
    , 'NYEC - Agency Conference'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1131
    , 'Document Problem Resolution'
    , 10
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Other Research'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1131
    , 'Document Problem Resolution'
    , 20
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:48:57', 'YYYY-MM-DD HH24:MI:SS')
    , 'Other Research'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1131
    , 'Document Problem Resolution'
    , 20
    , 'Y'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:54', 'YYYY-MM-DD HH24:MI:SS')
    , 'Other Research'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1132
    , 'Doc/Form Type Mismatch Task'
    , 10
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Other Research'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1132
    , 'Doc/Form Type Mismatch Task'
    , 20
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:48:57', 'YYYY-MM-DD HH24:MI:SS')
    , 'Other Research'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1132
    , 'Doc/Form Type Mismatch Task'
    , 20
    , 'Y'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:54', 'YYYY-MM-DD HH24:MI:SS')
    , 'Other Research'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1133
    , 'Financial Management'
    , 10
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Other Research'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1133
    , 'Financial Management'
    , 20
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:48:57', 'YYYY-MM-DD HH24:MI:SS')
    , 'Other Research'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1133
    , 'Financial Management'
    , 20
    , 'Y'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:54', 'YYYY-MM-DD HH24:MI:SS')
    , 'Other Research'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1134
    , 'Free Form Follow-Up'
    , 10
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Other Research'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1134
    , 'Free Form Follow-up'
    , 20
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:48:57', 'YYYY-MM-DD HH24:MI:SS')
    , 'Other Research'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1134
    , 'Free Form Follow-Up'
    , 20
    , 'Y'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:55', 'YYYY-MM-DD HH24:MI:SS')
    , 'Other Research'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1137
    , 'HSDE-QC VHT'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1138
    , 'Link Document Set - App'
    , 24
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Link Document Set - App'
    , 'Y'
    , 'Linking'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1138
    , 'Link Document Set - App'
    , 30
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:48:58', 'YYYY-MM-DD HH24:MI:SS')
    , 'Link Document Set - App'
    , 'Y'
    , 'Linking'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1138
    , 'Link Document Set - App'
    , 28
    , 'Y'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:55', 'YYYY-MM-DD HH24:MI:SS')
    , 'Link Document Set - App'
    , 'Y'
    , 'Linking'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1139
    , 'Data Entry - Verification Document'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1140
    , 'NYHBE Verification Doc Research'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1141
    , 'Data Entry-SHOP Employee Task'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1142
    , 'Data Entry Research Task'
    , 4
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Data Entry Research'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1143
    , 'Awaiting Documentation'
    , 3
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Awaiting Documentation'
    , 'Y'
    , 'Account Review'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1144
    , 'Awaiting Written Withdrawal'
    , 4
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Awaiting Written Withdrawal'
    , 'Y'
    , 'Account Review'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1144
    , 'Awaiting Written Withdrawal'
    , 7
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:48:58', 'YYYY-MM-DD HH24:MI:SS')
    , 'Awaiting Written Withdrawal'
    , 'Y'
    , 'Account Review'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1145
    , 'Appeals TBD'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1147
    , 'HSDE QC - Verification'
    , 32
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'HSDE QC - Verification'
    , 'Y'
    , 'Linking'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1147
    , 'HSDE QC - Verification'
    , 40
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:48:58', 'YYYY-MM-DD HH24:MI:SS')
    , 'HSDE QC - Verification'
    , 'Y'
    , 'Linking'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1150
    , 'NYHBE Complaints'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1151
    , 'NYHBE Verification Doc Research Task'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1152
    , 'Refer to ES-C Supervisor'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1153
    , 'Supervisor Complaint Task'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1154
    , 'Supervisor Referral Task'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1155
    , 'Emergency Personal Call'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'NON-PRODUCTIVE'
    , 'Y'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1156
    , 'Link Doc Set QC - App'
    , 24
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Link Doc Set QC - App'
    , 'Y'
    , 'QC'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1156
    , 'Link Doc Set QC - App'
    , 27
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:48:58', 'YYYY-MM-DD HH24:MI:SS')
    , 'Link Doc Set QC - App'
    , 'Y'
    , 'QC'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1156
    , 'Link Doc Set QC - App'
    , 25
    , 'Y'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:55', 'YYYY-MM-DD HH24:MI:SS')
    , 'Link Doc Set QC - App'
    , 'Y'
    , 'QC'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1157
    , 'Multiple Applications'
    , 30
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Linking Issues'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1157
    , 'Multiple Applications'
    , 19
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:48:58', 'YYYY-MM-DD HH24:MI:SS')
    , 'Linking Issues'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1157
    , 'Multiple Applications'
    , 25
    , 'Y'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:55', 'YYYY-MM-DD HH24:MI:SS')
    , 'Linking Issues'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1158
    , 'NYHBE MAXIMUS QC Task'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1159
    , 'Orphan Document'
    , 30
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Orphan Document'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1159
    , 'Orphan Document'
    , 21
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:48:58', 'YYYY-MM-DD HH24:MI:SS')
    , 'Orphan Document'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1159
    , 'Orphan Document'
    , 26
    , 'Y'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:55', 'YYYY-MM-DD HH24:MI:SS')
    , 'Orphan Document'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1160
    , 'Irate Client'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'NON-PRODUCTIVE'
    , 'Y'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1161
    , 'Account Correction'
    , 30
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Linking Issues'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1161
    , 'Account Correction'
    , 19
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:48:58', 'YYYY-MM-DD HH24:MI:SS')
    , 'Linking Issues'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1161
    , 'Account Correction'
    , 25
    , 'Y'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:55', 'YYYY-MM-DD HH24:MI:SS')
    , 'Linking Issues'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1162
    , 'TESTING'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1166
    , 'Inbound/Outbound Call'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'NON-PRODUCTIVE'
    , 'Y'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1167
    , 'Processing'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1168
    , 'Wrap Up'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1169
    , 'HSDE Verification'
    , 19
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'HSDE Verification'
    , 'Y'
    , 'HSDE'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1169
    , 'HSDE Verification'
    , 24.5
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:48:58', 'YYYY-MM-DD HH24:MI:SS')
    , 'HSDE Verification'
    , 'Y'
    , 'HSDE'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1170
    , 'Data Entry - SHOP Employer'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1171
    , 'HSDE NYSOH Application'
    , 3.75
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:48:58', 'YYYY-MM-DD HH24:MI:SS')
    , 'HSDE NYSOH Application'
    , 'Y'
    , 'HSDE'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1171
    , 'HSDE NYSOH Application'
    , 3.25
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'HSDE NYSOH Application'
    , 'Y'
    , 'HSDE'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1172
    , 'Authorized Rep'
    , 10
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Authorized Rep'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1172
    , 'Authorized Rep'
    , 10
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:48:58', 'YYYY-MM-DD HH24:MI:SS')
    , 'Authorized Rep'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1173
    , 'Reschedule Hearing'
    , 4
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Reschedule Hearing'
    , 'Y'
    , 'Account Review'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1173
    , 'Reschedule Hearing'
    , 6
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:48:58', 'YYYY-MM-DD HH24:MI:SS')
    , 'Reschedule Hearing'
    , 'Y'
    , 'Account Review'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1174
    , 'MAXIMUS QC Task'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'NON-PRODUCTIVE'
    , 'Y'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1175
    , 'Document Management QC'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1176
    , 'VLP - G845'
    , 10
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'VLP'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1176
    , 'VLP - G845'
    , 12
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:48:59', 'YYYY-MM-DD HH24:MI:SS')
    , 'VLP'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1176
    , 'VLP - G845'
    , 11
    , 'Y'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:55', 'YYYY-MM-DD HH24:MI:SS')
    , 'VLP'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1177
    , 'TPHI'
    , 10
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Other Research'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1177
    , 'TPHI'
    , 20
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:48:59', 'YYYY-MM-DD HH24:MI:SS')
    , 'Other Research'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1177
    , 'TPHI'
    , 20
    , 'Y'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:55', 'YYYY-MM-DD HH24:MI:SS')
    , 'Other Research'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1178
    , 'KOFAX Fax QC'
    , 70
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'KOFAX FAX QC'
    , 'Y'
    , 'HSDE'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1178
    , 'KOFAX Fax QC'
    , 100
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:48:59', 'YYYY-MM-DD HH24:MI:SS')
    , 'KOFAX FAX QC'
    , 'Y'
    , 'HSDE'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1179
    , 'KOFAX Mail QC'
    , 70
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'KOFAX FAX QC'
    , 'Y'
    , 'HSDE'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1179
    , 'KOFAX Mail QC'
    , 0
    , 'N'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:04', 'YYYY-MM-DD HH24:MI:SS')
    , 'KOFAX FAX QC'
    , 'Y'
    , 'HSDE'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1180
    , 'Mailroom'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'NON-PRODUCTIVE'
    , 'Y'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1181
    , 'Inbound Calls'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1182
    , 'Complaints/NYSOH Support - Outbound Calls'
    , 4
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Complaints/NYSOH Support - Outbound Calls'
    , 'Y'
    , 'Account Review'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1183
    , 'ES C - Gen Info'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1184
    , 'Orientation'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1185
    , 'Agent Self Study Online'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1186
    , 'Agent Classroom'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1187
    , 'Compliance'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1189
    , 'NYEC - Renewal Processing'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1190
    , 'NYEC - Renewals Processing'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1192
    , 'NYEC Renewal Processing'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1193
    , 'Refresher Training'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1194
    , 'WFM Chat'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1195
    , 'Safety Training'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1196
    , 'Research Specialist'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1197
    , 'Application Missing Information'
    , 7
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Application - Missing Data'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1197
    , 'Application Missing Information'
    , 6
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:48:59', 'YYYY-MM-DD HH24:MI:SS')
    , 'Application - Missing Data'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1197
    , 'Application Missing Information'
    , 6
    , 'Y'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:55', 'YYYY-MM-DD HH24:MI:SS')
    , 'Application - Missing Data'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1198
    , 'Identity Proofing'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1199
    , 'Incomplete Fax'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1200
    , 'Returned Mail'
    , 15
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Returned Mail'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1200
    , 'Returned Mail'
    , 19
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:48:59', 'YYYY-MM-DD HH24:MI:SS')
    , 'Returned Mail'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1200
    , 'Returned Mail'
    , 18
    , 'Y'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:56', 'YYYY-MM-DD HH24:MI:SS')
    , 'Returned Mail'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1201
    , 'Appeals'
    , 10
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Appeals'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1201
    , 'Appeals'
    , 20
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:48:59', 'YYYY-MM-DD HH24:MI:SS')
    , 'Appeals'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1201
    , 'Appeals'
    , 20
    , 'Y'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:56', 'YYYY-MM-DD HH24:MI:SS')
    , 'Appeals'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1202
    , 'Quality Training'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1203
    , 'Account Review Unit / Non-Task'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'NON-PRODUCTIVE'
    , 'Y'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1204
    , 'Awaiting Validity Check'
    , 3
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Awaiting Validity Check'
    , 'Y'
    , 'Account Review'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1204
    , 'Awaiting Validity Check'
    , 5
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:48:59', 'YYYY-MM-DD HH24:MI:SS')
    , 'Awaiting Validity Check'
    , 'Y'
    , 'Account Review'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1205
    , 'Evidence Packet Correction - Task'
    , 0.75
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Evidence Packet Correction - Task'
    , 'Y'
    , 'Account Review'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1206
    , 'Un-Scheduled Break'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'NON-PRODUCTIVE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1207
    , 'Appeal - Task'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1208
    , 'Fire Drill/ Evacuation'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1209
    , 'Complaint Training'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1210
    , 'Cobrowse Training'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1211
    , 'Seibel Updates Training'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1212
    , 'UPK Training'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1213
    , 'Flex Time'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1214
    , 'Pipkins Modification UPK'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1215
    , 'NYEC Agency Conference Processing'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1216
    , 'Newborn - UPK'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1217
    , 'CSS 1'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1218
    , 'Gap'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1219
    , 'zOT-CSS I'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1220
    , 'zOT-CSS II'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1221
    , 'zOT-CSS III'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1222
    , 'zOT-CSS IV'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1223
    , 'Test 1'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1224
    , 'Test 2'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1225
    , 'Renewals training'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1226
    , 'NYEC Quality Control'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1227
    , 'NYEC Research'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1228
    , 'CBT UPK'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1229
    , 'eMedNY UPK'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1230
    , 'Incarceration Proof'
    , 10
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Other Research'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1230
    , 'Incarceration Proof'
    , 20
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:48:59', 'YYYY-MM-DD HH24:MI:SS')
    , 'Other Research'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1230
    , 'Incarceration Proof'
    , 20
    , 'Y'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:56', 'YYYY-MM-DD HH24:MI:SS')
    , 'Other Research'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1231
    , 'zOT-Eligibility Specialist C-Appeals'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1232
    , 'zOT-NAV2'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1233
    , 'zOT-Research Specialist'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1234
    , 'zOT-SWCC-CSR'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1235
    , 'zOT-SWCC-CSR 2'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1236
    , 'Etiquette Training'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1237
    , 'Benefits Webinar'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1238
    , 'Defects UPK Training'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1239
    , 'NYEC - HSDE - Renewals'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1240
    , 'NYEC - HSDE - FPBP'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1241
    , 'SDE Application Registration'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1242
    , 'SDE FPBP'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1243
    , 'SDE FPPB MI'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1244
    , 'SDE WMS'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1245
    , 'Report QA'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1246
    , 'Bucket Cases'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1247
    , 'DOH Project'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1248
    , 'Coaching/Side by Side'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1249
    , 'Batching'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1250
    , 'Document Management'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1251
    , 'QC Application Registration'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1252
    , 'QC FPBP'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1253
    , 'QC FPPB MI'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1254
    , 'QC WMS'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1255
    , 'Data Corrections'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1256
    , 'eMedNY Tasks'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1257
    , 'WINR Report'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1258
    , 'DPR'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1259
    , 'APR'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1260
    , 'Manual Notice'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1261
    , 'Fair Hearing Packets'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1262
    , 'Fair Hearing Calls'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1263
    , 'Agency Conference'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1264
    , 'Provider Reports'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1265
    , 'State Data Entry'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1266
    , 'Undeliverable/Returned Mail'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1267
    , 'Premium Assistance Program - TPHI'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1268
    , 'Clockdown I /II'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1269
    , 'Document Printing'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1270
    , 'SME'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1271
    , 'Notifications'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1272
    , 'QC Coaching'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1273
    , 'MAXIMUS - QC'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1274
    , 'MAXIMUS - QC - New Case Member'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1275
    , 'SDE Reactivation'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1276
    , 'MI Reprocessing'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1277
    , 'Agency Conference Incident'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1278
    , 'LDSS Call'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1279
    , 'LDSS Email'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1280
    , 'Bonus Plan UPK'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1281
    , 'Hot Docs UPK'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1282
    , 'ID Proof - Task'
    , 35
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'ID Proof - Task'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1282
    , 'ID Proof - Task'
    , 27
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:48:59', 'YYYY-MM-DD HH24:MI:SS')
    , 'ID Proof - Task'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1283
    , 'ID Proof - Calls'
    , 12
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'ID Proof - Calls'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1283
    , 'ID Proof - Calls'
    , 12
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:48:59', 'YYYY-MM-DD HH24:MI:SS')
    , 'ID Proof - Calls'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1284
    , 'Manual Notice QC'
    , 45
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Manual Notice QC'
    , 'Y'
    , 'QC'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1284
    , 'Manual Notice QC'
    , 65
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'Manual Notice QC'
    , 'Y'
    , 'QC'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1284
    , 'Manual Notice QC'
    , 55
    , 'Y'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:56', 'YYYY-MM-DD HH24:MI:SS')
    , 'Manual Notice QC'
    , 'Y'
    , 'QC'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1285
    , 'Evidence Packet QC'
    , 3
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Evidence Packet QC'
    , 'Y'
    , 'QC'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1285
    , 'Evidence Packet QC'
    , 3.5
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'Evidence Packet QC'
    , 'Y'
    , 'QC'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1286
    , 'HSDE QC - App'
    , 6
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'HSDE QC - App'
    , 'Y'
    , 'Linking'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1286
    , 'HSDE QC - App'
    , 10
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'HSDE QC - App'
    , 'Y'
    , 'Linking'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1287
    , 'HSDE QC - V Doc w/Engage'
    , 0
    , 'N'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:04', 'YYYY-MM-DD HH24:MI:SS')
    , 'HSDE QC - Verification'
    , 'Y'
    , 'Linking'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1287
    , 'HSDE QC - V Doc w/Engage'
    , 32
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'HSDE QC - Verification'
    , 'Y'
    , 'Linking'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1289
    , 'Data Entry Research - Other'
    , 10
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Other Research'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1289
    , 'Data Entry Research - Other'
    , 20
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'Other Research'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1289
    , 'Data Entry Research - Other'
    , 20
    , 'Y'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:56', 'YYYY-MM-DD HH24:MI:SS')
    , 'Other Research'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1290
    , 'Application - Missing Data'
    , 7
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Application - Missing Data'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1290
    , 'Application - Missing Data'
    , 6
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'Application - Missing Data'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1290
    , 'Application - Missing Data'
    , 6
    , 'Y'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:56', 'YYYY-MM-DD HH24:MI:SS')
    , 'Application - Missing Data'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1291
    , 'Queue Empty'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'NON-PRODUCTIVE'
    , 'Y'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1292
    , 'zOT-Team Leads'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1293
    , '1095 UPK'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1294
    , 'Letter Resend'
    , 10
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Other Research'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1294
    , 'Letter Resend'
    , 20
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'Other Research'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1294
    , 'Letter Resend'
    , 20
    , 'Y'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:56', 'YYYY-MM-DD HH24:MI:SS')
    , 'Other Research'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1295
    , 'OVT UPK'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1296
    , 'CR 150'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1297
    , 'Auth Rep UPK'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1298
    , 'Assistor Classroom Training'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1299
    , 'Link Document Set QC - VDoc'
    , 32
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Link Document Set QC - Vdoc'
    , 'Y'
    , 'QC'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1299
    , 'Link Document Set QC - VDOC'
    , 36
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'Link Document Set QC - Vdoc'
    , 'Y'
    , 'QC'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1299
    , 'Link Document Set QC - VDoc'
    , 34
    , 'Y'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:56', 'YYYY-MM-DD HH24:MI:SS')
    , 'Link Document Set QC - Vdoc'
    , 'Y'
    , 'QC'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1300
    , 'Link Document Set - Verification'
    , 32
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Link Document Set - Verification'
    , 'Y'
    , 'Linking'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1300
    , 'Link Document Set - Verification'
    , 38
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'Link Document Set - Verification'
    , 'Y'
    , 'Linking'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1300
    , 'Link Document Set - Verification'
    , 34
    , 'Y'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:56', 'YYYY-MM-DD HH24:MI:SS')
    , 'Link Document Set - Verification'
    , 'Y'
    , 'Linking'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1301
    , 'HSDE Access Application'
    , 8
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'HSDE Access Application'
    , 'Y'
    , 'HSDE'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1301
    , 'HSDE Access Application'
    , 8
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'HSDE Access Application'
    , 'Y'
    , 'HSDE'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1302
    , 'HSDE Nav/CAC Batches'
    , 30
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'HSDE Nav/CAC Batches'
    , 'Y'
    , 'HSDE'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1302
    , 'HSDE Nav/CAC Batches'
    , 40
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'HSDE Nav/CAC Batches'
    , 'Y'
    , 'HSDE'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1303
    , 'Health and Safety Audit'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1304
    , 'I/EDR Case Note'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1305
    , 'Employee Survey'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1306
    , 'ABSORB DSIRP training'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1307
    , 'Classroom DSIRP training'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1308
    , 'Return Mail Refresher Classroom Training'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1309
    , '30 Day Check In'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1310
    , 'Focus Group'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1311
    , 'MPSD Training'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1312
    , 'Returned Mail Training'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1313
    , 'DMATCH Training'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1314
    , 'Retro Processing Training'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1315
    , 'SBA'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1316
    , 'NYEC Approved Task'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1317
    , 'Retro Verification Document'
    , 7
    , 'Y'
    , to_date ('2016-08-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Retro Verification Document'
    , 'Y'
    , 'Verification Document'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1317
    , 'Retro Verification Document'
    , 4
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-07-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Retro Verification Document'
    , 'Y'
    , 'Verification Document'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1317
    , 'Retro Verification Document'
    , 8.5
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:01', 'YYYY-MM-DD HH24:MI:SS')
    , 'Retro Verification Document'
    , 'Y'
    , 'Verification Document'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1318
    , 'Fair Hearing Case Maintenance'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1319
    , 'Fair Hearing incidents'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1320
    , 'Hold For WMS'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1321
    , 'Approved'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1322
    , 'Reactivation DPR'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1323
    , 'Reactivation APR'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1324
    , 'Reactivation Reports'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1325
    , 'July 2015 Holiday'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1326
    , 'Upstate SDE Application Registration'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1327
    , 'Upstate SDE FPBP'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1328
    , 'Upstate SDE FPBP MI'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1329
    , 'Upstate SDE WMS'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1330
    , 'Downstate SDE Application Registration'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1331
    , 'Downstate SDE FPBP'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1332
    , 'Downstate SDE FPPB MI'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1333
    , 'Downstate SDE WMS'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1334
    , 'Upstate QC Application Registration'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1335
    , 'Upstate QC FPBP'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1336
    , 'Upstate QC FPBP MI'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1337
    , 'Upstate QC WMS'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1338
    , 'Downstate QC Application Registration'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1339
    , 'Downstate QC FPBP'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1340
    , 'Downstate QC FPPB MI'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1341
    , 'Downstate QC WMS'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1342
    , 'VLP - Override'
    , 10
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'VLP'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1342
    , 'VLP - Override'
    , 12
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:01', 'YYYY-MM-DD HH24:MI:SS')
    , 'VLP'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1342
    , 'VLP - Override'
    , 11
    , 'Y'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:57', 'YYYY-MM-DD HH24:MI:SS')
    , 'VLP'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1343
    , 'VLP - PRUCOL'
    , 10
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'VLP'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1343
    , 'VLP - PRUCOL'
    , 12
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:01', 'YYYY-MM-DD HH24:MI:SS')
    , 'VLP'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1343
    , 'VLP - PRUCOL'
    , 11
    , 'Y'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:57', 'YYYY-MM-DD HH24:MI:SS')
    , 'VLP'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1344
    , 'VLP - Follow Up'
    , 10
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'VLP'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1344
    , 'VLP - Follow Up'
    , 12
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:01', 'YYYY-MM-DD HH24:MI:SS')
    , 'VLP'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1344
    , 'VLP - Follow Up'
    , 11
    , 'Y'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:57', 'YYYY-MM-DD HH24:MI:SS')
    , 'VLP'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1345
    , 'Data Entry Research - Immigration Docs'
    , 10
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'VLP'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1345
    , 'Data Entry Research - Immigration Docs'
    , 12
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:01', 'YYYY-MM-DD HH24:MI:SS')
    , 'VLP'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1345
    , 'Data Entry Research - Immigration Docs'
    , 11
    , 'Y'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:57', 'YYYY-MM-DD HH24:MI:SS')
    , 'VLP'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1346
    , 'Ren Kofax QC Fax'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1347
    , 'Ren Kofax QC Mail'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1348
    , 'Ren Kofax VAL Fax'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1349
    , 'Ren Kofax VAL Mail'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1350
    , 'FPBP Kofax QC Fax'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1351
    , 'FPBP Kofax QC Mail'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1352
    , 'FPBP Kofax VAL Fax'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1353
    , 'FPBP Kofax VAL Mail'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1354
    , 'FPBP HSDE QC'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1355
    , 'Image Assembly'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1356
    , 'HSDE QC'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1357
    , 'Siebel CBT'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1358
    , 'Lang CBT'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1359
    , 'Siebel UI CBT'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1360
    , 'Account Creation CBT'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1361
    , 'Downstate APR'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1362
    , 'Upstate APR'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1363
    , 'Essential Plan & DISRP Classroom'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1364
    , 'PE Segments'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1365
    , 'SP Break'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1366
    , 'Voter Reg CBT'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1367
    , 'Unapproved'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1368
    , 'zOT-CSS III Spec Lang'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1369
    , 'Agents must select event from list'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1370
    , 'CSS IV - Task Team (DEMAND)'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1371
    , 'CSS IV - Task Team'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1372
    , 'Task Team - Activities'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1373
    , 'Task Team - Defect'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1374
    , 'Task Team - Complaints'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1375
    , 'Task Team - Referrals'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1376
    , 'Task Team - Referrals Follow-up'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1377
    , 'Task Team - Complaints Follow-up'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1378
    , 'Task Team - Complaint Sent In Error'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1379
    , 'Task Team - Referral Sent In Error'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1380
    , 'Task Team - Outbound Call'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1381
    , 'Training - Adirondack'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1382
    , 'Training - Taconic'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1383
    , 'Training - Catskills'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1384
    , 'Training - Helderberg'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1385
    , 'Training - Shawangunk'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1386
    , 'Training - Hudson'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1387
    , 'Training - Genesee'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1388
    , 'Training - Mohawk'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1389
    , 'Training - Niagara'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1390
    , 'Training - Lark'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1391
    , 'Training - Madison'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1392
    , 'Training - The Egg'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1393
    , 'Training - The Plaza'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1394
    , 'Training - Empire'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1395
    , 'Training - Liberty'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1396
    , 'Training - Emerald'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1397
    , 'Training - Colorado'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1398
    , 'Training - Executive'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1399
    , 'Training - Garnet'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1400
    , 'Linking Issues'
    , 30
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Linking Issues'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1400
    , 'Linking Issues'
    , 19
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:01', 'YYYY-MM-DD HH24:MI:SS')
    , 'Linking Issues'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1400
    , 'Linking Issues'
    , 25
    , 'Y'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:57', 'YYYY-MM-DD HH24:MI:SS')
    , 'Linking Issues'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1401
    , 'NYEC Mailroom'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1402
    , 'Training -Cayuga'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1403
    , 'Rescan'
    , 6.5
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Rescan'
    , 'Y'
    , 'HSDE'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1403
    , 'Rescan'
    , 4.5
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:01', 'YYYY-MM-DD HH24:MI:SS')
    , 'Rescan'
    , 'Y'
    , 'HSDE'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1404
    , 'G845'
    , 50
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'G845'
    , 'Y'
    , 'Mailroom'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1404
    , 'G845'
    , 0
    , 'N'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:01', 'YYYY-MM-DD HH24:MI:SS')
    , 'G845'
    , 'Y'
    , 'Mailroom'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1405
    , 'Appeal Letters'
    , 12.25
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Appeal Letters'
    , 'Y'
    , 'Mailroom'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1405
    , 'Appeal Letters'
    , 100
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:01', 'YYYY-MM-DD HH24:MI:SS')
    , 'Appeal Letters'
    , 'Y'
    , 'Mailroom'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1406
    , 'Evidence Packets'
    , 2
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Evidence Packets'
    , 'Y'
    , 'Mailroom'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1406
    , 'Evidence Packets'
    , 0
    , 'N'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:04', 'YYYY-MM-DD HH24:MI:SS')
    , 'Evidence Packets'
    , 'Y'
    , 'Mailroom'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1407
    , 'Printing Return Mail'
    , 300
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:01', 'YYYY-MM-DD HH24:MI:SS')
    , 'Purge'
    , 'Y'
    , 'Mailroom'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1407
    , 'Printing Return Mail'
    , 8.25
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Purge'
    , 'Y'
    , 'Mailroom'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1408
    , 'Printing Rescans'
    , 20.5
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Printing Rescans'
    , 'Y'
    , 'Mailroom'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1408
    , 'Printing Rescans'
    , 100
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:02', 'YYYY-MM-DD HH24:MI:SS')
    , 'Printing Rescans'
    , 'Y'
    , 'Mailroom'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1409
    , 'Scanning'
    , 19
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Scanning'
    , 'Y'
    , 'Mailroom'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1409
    , 'Scanning'
    , 19
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:02', 'YYYY-MM-DD HH24:MI:SS')
    , 'Scanning'
    , 'Y'
    , 'Mailroom'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1410
    , 'Logging Live Checks'
    , 35
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Logging Task'
    , 'Y'
    , 'Mailroom'
    , 'Y'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1410
    , 'Logging Live Checks'
    , 0
    , 'N'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:04', 'YYYY-MM-DD HH24:MI:SS')
    , 'Logging Task'
    , 'Y'
    , 'Mailroom'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1411
    , 'Logging Voter Registration'
    , 0
    , 'N'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:04', 'YYYY-MM-DD HH24:MI:SS')
    , 'Logging Task'
    , 'Y'
    , 'Mailroom'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1411
    , 'Logging Voter Registration'
    , 35
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Logging Task'
    , 'Y'
    , 'Mailroom'
    , 'Y'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1412
    , 'Logging NYSOH Apps'
    , 0
    , 'N'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:04', 'YYYY-MM-DD HH24:MI:SS')
    , 'Logging Task'
    , 'Y'
    , 'Mailroom'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1412
    , 'Logging NYSOH Apps'
    , 35
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Logging Task'
    , 'Y'
    , 'Mailroom'
    , 'Y'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1413
    , 'Logging Good Cause / Med Reimbursments'
    , 35
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Logging Task'
    , 'Y'
    , 'Mailroom'
    , 'Y'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1413
    , 'Logging Good Cause / Med Reimbursments'
    , 0
    , 'N'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:04', 'YYYY-MM-DD HH24:MI:SS')
    , 'Logging Task'
    , 'Y'
    , 'Mailroom'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1414
    , 'Purge'
    , 65
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Returned Mail Prepping'
    , 'Y'
    , 'MULTIPLE'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1414
    , 'Purge'
    , 0
    , 'N'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:05', 'YYYY-MM-DD HH24:MI:SS')
    , 'Returned Mail Prepping'
    , 'Y'
    , 'MULTIPLE'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1415
    , 'Storage'
    , 100
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:02', 'YYYY-MM-DD HH24:MI:SS')
    , 'Storage'
    , 'Y'
    , 'Mailroom'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1415
    , 'Storage'
    , 100
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Storage'
    , 'Y'
    , 'Mailroom'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1416
    , 'Training - Washington Park'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1417
    , 'Training - Room E'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1418
    , 'Training - Sacandaga'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1419
    , 'Training - Pearl'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1420
    , 'Training - Amethyst'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1421
    , 'Training - Ontario'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1422
    , 'Team Lead - QC'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1423
    , 'Training  -Tupper'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1424
    , 'ARU Wrap Up'
    , 2
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'ARU Wrap Up'
    , 'Y'
    , 'Account Review'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1425
    , 'Schedule Hearing Task'
    , 0.65
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:02', 'YYYY-MM-DD HH24:MI:SS')
    , 'Schedule Hearing'
    , 'Y'
    , 'Account Review'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1425
    , 'Schedule Hearing Task'
    , 0.75
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Schedule Hearing'
    , 'Y'
    , 'Account Review'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1426
    , 'Appeal Task Team'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'NON-PRODUCTIVE'
    , 'Y'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1427
    , 'NYSOH Support Inbox'
    , 2
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'NYSOH Support Inbox'
    , 'Y'
    , 'Account Review'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1428
    , 'Backdating Call Backs'
    , 5
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Backdating Call Backs'
    , 'Y'
    , 'Account Review'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1429
    , 'Defect Task'
    , 4
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Defect Task'
    , 'Y'
    , 'Account Review'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1430
    , 'Complaint - Follow Up'
    , 4
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Complaint - Follow Up'
    , 'Y'
    , 'Account Review'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1431
    , 'Training - Texas'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1432
    , 'Absence - NCNS'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1433
    , 'Absence - Sup Notified'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1434
    , 'ARU Task Team'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1435
    , 'ARU Team Lead'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1436
    , 'ARU Team Lead - QC'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'NON-PRODUCTIVE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1437
    , 'CSS III - Mandarin'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1438
    , 'CSS III - Mandarin/Cantonese'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1439
    , 'CSS III - Haitian Creole'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1440
    , 'CSS III - Russian'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1441
    , 'CSS III - Cantonese'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1442
    , 'Dismissal Failed to Attend Hearing'
    , 4
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Dismissal Failed to Attend Hearing'
    , 'Y'
    , 'Account Review'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1442
    , 'Dismissal Failed to Attend Hearing'
    , 6
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:02', 'YYYY-MM-DD HH24:MI:SS')
    , 'Dismissal Failed to Attend Hearing'
    , 'Y'
    , 'Account Review'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1443
    , 'Document Account Review'
    , 2.5
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Document Account Review'
    , 'Y'
    , 'Account Review'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1443
    , 'Document Account Review'
    , 8
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:02', 'YYYY-MM-DD HH24:MI:SS')
    , 'Document Account Review'
    , 'Y'
    , 'Account Review'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1443
    , 'Document Account Review'
    , 4
    , 'Y'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:57', 'YYYY-MM-DD HH24:MI:SS')
    , 'Document Account Review'
    , 'Y'
    , 'Account Review'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1444
    , 'Data Entry Research'
    , 4
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Data Entry Research'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1445
    , 'Expired Clock Document'
    , 4
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Expired Clock Document'
    , 'Y'
    , 'Account Review'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1446
    , 'HX Cases'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'NON-PRODUCTIVE'
    , 'Y'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1447
    , 'Defects'
    , 4
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Defect Task'
    , 'Y'
    , 'Account Review'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1448
    , 'Returned Mail Data Entry'
    , 7.25
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:02', 'YYYY-MM-DD HH24:MI:SS')
    , 'Returned Mail Data Entry'
    , 'Y'
    , 'HSDE'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1448
    , 'Returned Mail Data Entry'
    , 6.5
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Returned Mail Data Entry'
    , 'Y'
    , 'HSDE'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1452
    , 'Agent Training'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1453
    , 'Training - Topaz'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1454
    , 'Returned Mail Prepping'
    , 65
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Returned Mail Prepping'
    , 'Y'
    , 'MULTIPLE'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1454
    , 'Returned Mail Prepping'
    , 0
    , 'N'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:05', 'YYYY-MM-DD HH24:MI:SS')
    , 'Returned Mail Prepping'
    , 'Y'
    , 'MULTIPLE'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1455
    , 'Envelope Sorting'
    , 650
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Envelope Sorting'
    , 'Y'
    , 'Mailroom'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1455
    , 'Envelope Sorting'
    , 0
    , 'N'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:02', 'YYYY-MM-DD HH24:MI:SS')
    , 'Envelope Sorting'
    , 'Y'
    , 'Mailroom'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1456
    , 'Envelopes Prepped'
    , 29
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Envelopes Prepped'
    , 'Y'
    , 'Mailroom'
    , 'Y'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1456
    , 'Envelopes Prepped'
    , 30
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:02', 'YYYY-MM-DD HH24:MI:SS')
    , 'Envelopes Prepped'
    , 'Y'
    , 'Mailroom'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1457
    , 'Account Correction (VDOCS)'
    , 8
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Account Correction (VDOCS)'
    , 'Y'
    , 'Verification Document'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1457
    , 'Account Correction (VDOCS)'
    , 0
    , 'N'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:05', 'YYYY-MM-DD HH24:MI:SS')
    , 'Account Correction (VDOCS)'
    , 'Y'
    , 'Verification Document'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1458
    , 'Complaint (DPR)'
    , 10
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Other Research'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1458
    , 'Complaint (DPR)'
    , 20
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:02', 'YYYY-MM-DD HH24:MI:SS')
    , 'Other Research'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1458
    , 'Complaint (DPR)'
    , 20
    , 'Y'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:57', 'YYYY-MM-DD HH24:MI:SS')
    , 'Other Research'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1459
    , 'Escalations'
    , 8
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Escalations'
    , 'Y'
    , 'Verification Document'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1459
    , 'Escalations'
    , 0
    , 'N'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:05', 'YYYY-MM-DD HH24:MI:SS')
    , 'Escalations'
    , 'Y'
    , 'Verification Document'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1460
    , 'Refer To Account Review'
    , 4
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Refer to Account Review'
    , 'Y'
    , 'Account Review'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1461
    , 'Team Lead (VDOCS)'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'NON-PRODUCTIVE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1462
    , 'VLP 3 - G845'
    , 10
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'VLP'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1462
    , 'VLP 3 - G845'
    , 12
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:03', 'YYYY-MM-DD HH24:MI:SS')
    , 'VLP'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1462
    , 'VLP 3 - G845'
    , 11
    , 'Y'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:57', 'YYYY-MM-DD HH24:MI:SS')
    , 'VLP'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1463
    , 'VLP 4 - Override'
    , 10
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'VLP'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1463
    , 'VLP 4 - Override'
    , 12
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:03', 'YYYY-MM-DD HH24:MI:SS')
    , 'VLP'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1463
    , 'VLP 4 - Override'
    , 11
    , 'Y'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:57', 'YYYY-MM-DD HH24:MI:SS')
    , 'VLP'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1464
    , 'VLP 5 - PRUCOL'
    , 12
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:03', 'YYYY-MM-DD HH24:MI:SS')
    , 'VLP'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1464
    , 'VLP 5 - PRUCOL'
    , 11
    , 'Y'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:58', 'YYYY-MM-DD HH24:MI:SS')
    , 'VLP'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1464
    , 'VLP 5 - PRUCOL'
    , 10
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'VLP'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1465
    , 'VLP 6 - Follow Up'
    , 10
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'VLP'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1465
    , 'VLP 6 - Follow up'
    , 12
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:03', 'YYYY-MM-DD HH24:MI:SS')
    , 'VLP'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1465
    , 'VLP 6 - Follow Up'
    , 11
    , 'Y'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:58', 'YYYY-MM-DD HH24:MI:SS')
    , 'VLP'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1466
    , 'VLP Holding'
    , 10
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'VLP'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1466
    , 'VLP Holding'
    , 12
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:03', 'YYYY-MM-DD HH24:MI:SS')
    , 'VLP'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1466
    , 'VLP Holding'
    , 11
    , 'Y'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:58', 'YYYY-MM-DD HH24:MI:SS')
    , 'VLP'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1467
    , 'Application In Process'
    , 10
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Application in Process'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1467
    , 'Application In Process'
    , 9
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:03', 'YYYY-MM-DD HH24:MI:SS')
    , 'Application in Process'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1468
    , 'Application Missing Data'
    , 7
    , 'Y'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'Application - Missing Data'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1468
    , 'Application Missing Data'
    , 6
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:03', 'YYYY-MM-DD HH24:MI:SS')
    , 'Application - Missing Data'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1468
    , 'Application Missing Data'
    , 6
    , 'Y'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:58', 'YYYY-MM-DD HH24:MI:SS')
    , 'Application - Missing Data'
    , 'Y'
    , 'Research'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1469
    , 'Training - City Hall'
    , 0
    , 'N'
    , to_date ('2016-01-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-06-13 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1470
    , 'CSS_BROKER_TEST'
    , 0
    , 'N'
    , to_date ('2016-08-25', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-08-08 14:40:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1471
    , 'Training - Utah'
    , 0
    , 'N'
    , to_date ('2016-08-25', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-08-08 14:40:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'NON-PRODUCTIVE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1472
    , 'Return Mail Folding'
    , 80
    , 'Y'
    , to_date ('2016-08-25', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-08-08 14:40:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'Return Mail Folding'
    , 'Y'
    , 'MULTIPLE'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1472
    , 'Return Mail Folding'
    , 0
    , 'N'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:05', 'YYYY-MM-DD HH24:MI:SS')
    , 'Return Mail Folding'
    , 'Y'
    , 'MULTIPLE'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1473
    , 'Return Mail Printing'
    , 120
    , 'Y'
    , to_date ('2016-08-25', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-08-08 14:40:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'Return Mail Printing'
    , 'Y'
    , 'MULTIPLE'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1473
    , 'Return Mail Printing'
    , 0
    , 'N'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:05', 'YYYY-MM-DD HH24:MI:SS')
    , 'Return Mail Printing'
    , 'Y'
    , 'MULTIPLE'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1474
    , 'Bereavement'
    , 0
    , 'N'
    , to_date ('2016-08-25', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-08-08 14:40:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'NON-PRODUCTIVE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1475
    , 'Training - Penn Station'
    , 0
    , 'N'
    , to_date ('2016-08-25', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-08-08 14:40:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'NON-PRODUCTIVE'
    , 'Y'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1476
    , 'Training - Room A'
    , 0
    , 'N'
    , to_date ('2016-08-25', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-08-08 14:40:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'NON-PRODUCTIVE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1477
    , 'Team Lead - Floor Support'
    , 0
    , 'N'
    , to_date ('2016-07-25', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-07-22 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'NON-PRODUCTIVE'
    , 'Y'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1478
    , 'Building Evacuation'
    , 0
    , 'N'
    , to_date ('2016-07-25', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-07-22 10:08:13', 'YYYY-MM-DD HH24:MI:SS')
    , 'NON-PRODUCTIVE'
    , 'Y'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1479
    , 'Training - Room D'
    , 0
    , 'N'
    , to_date ('2016-08-25', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-08-08 14:40:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'NON-PRODUCTIVE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1480
    , 'Training  -Saratoga'
    , 0
    , 'N'
    , to_date ('2016-08-25', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-08-08 14:40:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'NON-PRODUCTIVE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1481
    , 'Operations Quality Control'
    , 0
    , 'N'
    , to_date ('2016-08-25', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-08-08 14:40:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'N'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1482
    , 'Survey'
    , 0
    , 'N'
    , to_date ('2016-08-25', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-08-08 14:40:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'NON-PRODUCTIVE'
    , 'Y'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1483
    , 'DSRIP Opt Out Survey'
    , 65
    , 'Y'
    , to_date ('2016-08-25', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-08-08 14:40:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'DSRIP Opt Out Survey'
    , 'Y'
    , 'Mailroom'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1483
    , 'DSRIP Opt Out Survey'
    , 65
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:03', 'YYYY-MM-DD HH24:MI:SS')
    , 'DSRIP Opt Out Survey'
    , 'Y'
    , 'Mailroom'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1484
    , 'DSRIP Incident'
    , 0
    , 'N'
    , to_date ('2016-08-25', 'YYYY-MM-DD')
    , to_date ('2016-10-08', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-08-08 14:40:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'NON-PRODUCTIVE'
    , 'Y'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1484
    , 'DSRIP Incident'
    , 35
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:03', 'YYYY-MM-DD HH24:MI:SS')
    , 'DSRIP Incident'
    , 'Y'
    , 'Mailroom'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1484
    , 'DSRIP Incident'
    , 35
    , 'Y'
    , to_date ('2016-10-09', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:58', 'YYYY-MM-DD HH24:MI:SS')
    , 'DSRIP Incident'
    , 'Y'
    , 'Mailroom'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1485
    , 'Sorting/Cutting Incoming Mail'
    , 650
    , 'Y'
    , to_date ('2016-08-25', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-08-08 14:40:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'Sorting/Cutting Incoming Mail'
    , 'Y'
    , 'Mailroom'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1485
    , 'Sorting/Cutting Incoming Mail'
    , 0
    , 'N'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:03', 'YYYY-MM-DD HH24:MI:SS')
    , 'Sorting/Cutting Incoming Mail'
    , 'Y'
    , 'Mailroom'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1486
    , 'Making Copies'
    , 0
    , 'N'
    , to_date ('2016-08-25', 'YYYY-MM-DD')
    , to_date ('2016-10-08', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-08-08 14:40:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'NON-PRODUCTIVE'
    , 'Y'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1486
    , 'Making Copies'
    , 100
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:03', 'YYYY-MM-DD HH24:MI:SS')
    , 'Making Copies'
    , 'Y'
    , 'Mailroom'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1486
    , 'Making Copies'
    , 45
    , 'Y'
    , to_date ('2016-10-09', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:58', 'YYYY-MM-DD HH24:MI:SS')
    , 'Making Copies'
    , 'Y'
    , 'Mailroom'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1487
    , 'Logging Certified Mail'
    , 35
    , 'Y'
    , to_date ('2016-08-25', 'YYYY-MM-DD')
    , to_date ('2016-10-31', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-08-08 14:40:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'Logging Certified Mail'
    , 'Y'
    , 'Mailroom'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1487
    , 'Logging Certified Mail'
    , 0
    , 'N'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:05', 'YYYY-MM-DD HH24:MI:SS')
    , 'Logging Certified Mail'
    , 'Y'
    , 'Mailroom'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1487
    , 'Logging Certified Mail'
    , 65
    , 'Y'
    , to_date ('2016-11-01', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:59', 'YYYY-MM-DD HH24:MI:SS')
    , 'Logging Certified Mail'
    , 'Y'
    , 'Mailroom'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1488
    , 'Posting Mail'
    , 0
    , 'N'
    , to_date ('2016-08-25', 'YYYY-MM-DD')
    , to_date ('2016-10-08', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-08-08 14:40:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'NON-PRODUCTIVE'
    , 'Y'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1488
    , 'Posting Mail'
    , 1000
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:04', 'YYYY-MM-DD HH24:MI:SS')
    , 'Posting Mail'
    , 'Y'
    , 'Mailroom'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1488
    , 'Posting Mail'
    , 650
    , 'Y'
    , to_date ('2016-10-09', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:59', 'YYYY-MM-DD HH24:MI:SS')
    , 'Posting Mail'
    , 'Y'
    , 'Mailroom'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1489
    , 'K Drive Appeal QC'
    , 0
    , 'N'
    , to_date ('2016-08-25', 'YYYY-MM-DD')
    , to_date ('2016-10-08', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-08-08 14:40:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'UNUSED_BY_EE'
    , 'Y'
    , 'NOT IN SCORECARD'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1489
    , 'K Drive Appeal QC'
    , 60
    , 'Y'
    , to_date ('2017-05-01', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2017-05-19 13:49:04', 'YYYY-MM-DD HH24:MI:SS')
    , 'Appeals Letters'
    , 'Y'
    , 'Mailroom'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1489
    , 'K Drive Appeal QC'
    , 60
    , 'Y'
    , to_date ('2016-10-09', 'YYYY-MM-DD')
    , to_date ('2017-04-30', 'YYYY-MM-DD')
    , 'script'
    , to_date ('2016-10-21 12:55:59', 'YYYY-MM-DD HH24:MI:SS')
    , 'Appeals Letters'
    , 'Y'
    , 'Mailroom'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1490
    , 'QC - SWCC'
    , 8
    , 'Y'
    , to_date ('2016-09-14', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-09-15 08:40:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'CALL - SWCC'
    , 'Y'
    , 'QC Team'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1491
    , 'QC - SBM'
    , 8
    , 'Y'
    , to_date ('2016-09-15', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-09-15 08:40:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'CALL - SBM'
    , 'Y'
    , 'QC Team'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1492
    , 'QC - Individual Marketplace'
    , 3
    , 'Y'
    , to_date ('2016-09-16', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-09-15 08:40:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'CALL - Individual'
    , 'Y'
    , 'QC Team'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1493
    , 'QC - ARU Call'
    , 3
    , 'Y'
    , to_date ('2016-09-17', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-09-15 08:40:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'CALL - ARU'
    , 'Y'
    , 'QC Team'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1494
    , 'QC - ARU Backdating Call'
    , 2
    , 'Y'
    , to_date ('2016-09-18', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-09-15 08:40:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'CALL - ARU Backdating'
    , 'Y'
    , 'QC Team'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1495
    , 'QC - Research'
    , 5
    , 'Y'
    , to_date ('2016-09-19', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-09-15 08:40:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'TASK - Research'
    , 'Y'
    , 'QC Team'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1496
    , 'QC - VDoc'
    , 5
    , 'Y'
    , to_date ('2016-09-20', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-09-15 08:40:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'TASK - VDoc'
    , 'Y'
    , 'QC Team'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1497
    , 'QC - Mailroom'
    , 14
    , 'Y'
    , to_date ('2016-09-21', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-09-15 08:40:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'TASK - Mailroom'
    , 'Y'
    , 'QC Team'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1498
    , 'QC - Link Doc Set'
    , 5
    , 'Y'
    , to_date ('2016-09-22', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-09-15 08:40:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'TASK - Link Doc Set'
    , 'Y'
    , 'QC Team'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1499
    , 'QC - Link Doc Set QC'
    , 5
    , 'Y'
    , to_date ('2016-09-23', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-09-15 08:40:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'TASK - Link Doc Set QC'
    , 'Y'
    , 'QC Team'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1500
    , 'QC - HSDE'
    , 5
    , 'Y'
    , to_date ('2016-09-24', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-09-15 08:40:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'TASK - HSDE'
    , 'Y'
    , 'QC Team'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1501
    , 'QC - HSDE QC'
    , 5
    , 'Y'
    , to_date ('2016-09-25', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-09-15 08:40:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'TASK - HSDE QC'
    , 'Y'
    , 'QC Team'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1502
    , 'QC - ARU Task'
    , 5
    , 'Y'
    , to_date ('2016-09-26', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-09-15 08:40:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'TASK - ARU'
    , 'Y'
    , 'QC Team'
    , 'N'
    );

INSERT INTO MAXDAT.PP_BO_EVENT_TARGET_LKUP
    (
    EVENT_ID
    , NAME
    , TARGET
    , SCORECARD_FLAG
    , START_DATE
    , END_DATE
    , CREATE_BY
    , CREATE_DATETIME
    , SCORECARD_GROUP
    , EE_ADHERENCE
    , OPS_GROUP
    , WORKSUBACTIVITY_FLAG
    )
VALUES
    (
    1503
    , 'QC - Tasks (Incidents, Defects, Activities)'
    , 5
    , 'Y'
    , to_date ('2016-09-27', 'YYYY-MM-DD')
    , NULL
    , 'script'
    , to_date ('2016-09-15 08:40:00', 'YYYY-MM-DD HH24:MI:SS')
    , 'TASK - Task Team'
    , 'Y'
    , 'QC Team'
    , 'N'
    );

COMMIT;

