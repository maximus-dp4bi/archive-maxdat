
UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Monthly'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 0
    ,LETTER_MIN_SENT_PER_DAY = 44
    ,LETTER_MAX_SENT_PER_DAY = 69
    ,MIN_ALERT_THRESHOLD =  40
    ,MAX_ALERT_THRESHOLD = 77
    ,MAX_NCOA_THRESHOLD =  null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'Medicaid'
WHERE lmdef_id = 456;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = null
    ,NO_DUPES_DAYS = null
    ,LETTER_MIN_SENT_PER_DAY = 0
    ,LETTER_MAX_SENT_PER_DAY = 1
    ,MIN_ALERT_THRESHOLD =  0
    ,MAX_ALERT_THRESHOLD = 1
    ,MAX_NCOA_THRESHOLD =  null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'CHIP'
WHERE lmdef_id = 716;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = null
    ,NO_DUPES_DAYS = null
    ,LETTER_MIN_SENT_PER_DAY = 0
    ,LETTER_MAX_SENT_PER_DAY = 844
    ,MIN_ALERT_THRESHOLD = 0
    ,MAX_ALERT_THRESHOLD = 250
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'CHIP'
WHERE lmdef_id = 433;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = null
    ,NO_DUPES_DAYS = null
    ,LETTER_MIN_SENT_PER_DAY = 0
    ,LETTER_MAX_SENT_PER_DAY = 1
    ,MIN_ALERT_THRESHOLD = 0
    ,MAX_ALERT_THRESHOLD = 10
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'CHIP'
WHERE lmdef_id = 424;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = null
    ,NO_DUPES_DAYS = null
    ,LETTER_MIN_SENT_PER_DAY = 0
    ,LETTER_MAX_SENT_PER_DAY = 3
    ,MIN_ALERT_THRESHOLD = 0
    ,MAX_ALERT_THRESHOLD = 10
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = 2
    ,MAILHOUSE_PROGRAM = 'CHIP'
WHERE lmdef_id = 425;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Retired'
    ,DUPE_CNT_TRIGGER = null
    ,NO_DUPES_DAYS = null
    ,LETTER_MIN_SENT_PER_DAY = null
    ,LETTER_MAX_SENT_PER_DAY = null
    ,MIN_ALERT_THRESHOLD = null
    ,MAX_ALERT_THRESHOLD = null
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = null
WHERE lmdef_id = 737;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 1
    ,LETTER_MAX_SENT_PER_DAY = 1
    ,MIN_ALERT_THRESHOLD = 0
    ,MAX_ALERT_THRESHOLD = 5
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'Medicaid'
WHERE lmdef_id = 439;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 0
    ,LETTER_MAX_SENT_PER_DAY = 4025
    ,MIN_ALERT_THRESHOLD = 0
    ,MAX_ALERT_THRESHOLD = 600
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = 2
    ,MAILHOUSE_PROGRAM = 'CHIP'
WHERE lmdef_id = 420;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 0
    ,LETTER_MAX_SENT_PER_DAY = 9068
    ,MIN_ALERT_THRESHOLD = 0
    ,MAX_ALERT_THRESHOLD = 2000
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = 75
    ,MAILHOUSE_PROGRAM = 'CHIP'
WHERE lmdef_id = 422;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Monthly'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 60
    ,LETTER_MIN_SENT_PER_DAY = 0
    ,LETTER_MAX_SENT_PER_DAY = 1623
    ,MIN_ALERT_THRESHOLD = 0
    ,MAX_ALERT_THRESHOLD = 1000
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = 90
    ,MAILHOUSE_PROGRAM = 'CHIP'
WHERE lmdef_id = 429;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 5
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 0
    ,LETTER_MAX_SENT_PER_DAY = 17
    ,MIN_ALERT_THRESHOLD = 0
    ,MAX_ALERT_THRESHOLD = 15
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = 8
    ,MAILHOUSE_PROGRAM = 'CHIP'
WHERE lmdef_id = 418;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 0
    ,LETTER_MAX_SENT_PER_DAY = 6541
    ,MIN_ALERT_THRESHOLD = 0
    ,MAX_ALERT_THRESHOLD = 1800
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = 2
    ,MAILHOUSE_PROGRAM = 'CHIP'
WHERE lmdef_id = 417;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 0
    ,LETTER_MAX_SENT_PER_DAY = 1
    ,MIN_ALERT_THRESHOLD = 0
    ,MAX_ALERT_THRESHOLD = 10
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'CHIP'
WHERE lmdef_id = 446;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 0
    ,LETTER_MAX_SENT_PER_DAY = 4
    ,MIN_ALERT_THRESHOLD = 0
    ,MAX_ALERT_THRESHOLD = 10
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = 2
    ,MAILHOUSE_PROGRAM = 'CHIP'
WHERE lmdef_id = 447;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 0
    ,LETTER_MAX_SENT_PER_DAY = 6
    ,MIN_ALERT_THRESHOLD = 0
    ,MAX_ALERT_THRESHOLD = 10
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = 1
    ,MAILHOUSE_PROGRAM = 'CHIP'
WHERE lmdef_id =445;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 0
    ,LETTER_MAX_SENT_PER_DAY = 2
    ,MIN_ALERT_THRESHOLD = 0
    ,MAX_ALERT_THRESHOLD = 10
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = 1
    ,MAILHOUSE_PROGRAM = 'CHIP'
WHERE lmdef_id = 448;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 0
    ,LETTER_MAX_SENT_PER_DAY = 18
    ,MIN_ALERT_THRESHOLD = 0
    ,MAX_ALERT_THRESHOLD = 20
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'CHIP'
WHERE lmdef_id = 419;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 1
    ,LETTER_MAX_SENT_PER_DAY = 11
    ,MIN_ALERT_THRESHOLD = 0
    ,MAX_ALERT_THRESHOLD = 20
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'Medicaid'
WHERE lmdef_id = 452;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 1
    ,LETTER_MAX_SENT_PER_DAY = 39
    ,MIN_ALERT_THRESHOLD = 0
    ,MAX_ALERT_THRESHOLD = 40
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'Medicaid'
WHERE lmdef_id = 450;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 1
    ,LETTER_MAX_SENT_PER_DAY = 2
    ,MIN_ALERT_THRESHOLD = 0
    ,MAX_ALERT_THRESHOLD = 10
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'Medicaid'
WHERE lmdef_id = 451;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Weekly'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 2321
    ,LETTER_MAX_SENT_PER_DAY = 15739
    ,MIN_ALERT_THRESHOLD = 2000
    ,MAX_ALERT_THRESHOLD = 17000
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'THSteps'
WHERE lmdef_id = 101;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Weekly'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 1555
    ,LETTER_MAX_SENT_PER_DAY = 8216
    ,MIN_ALERT_THRESHOLD = 1500
    ,MAX_ALERT_THRESHOLD = 9000
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'THSteps'
WHERE lmdef_id = 441;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Monthly'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 9445
    ,LETTER_MAX_SENT_PER_DAY = 10706
    ,MIN_ALERT_THRESHOLD = 9400
    ,MAX_ALERT_THRESHOLD = 12000
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'THSteps'
WHERE lmdef_id = 414;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Monthly'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 4995
    ,LETTER_MAX_SENT_PER_DAY = 18938
    ,MIN_ALERT_THRESHOLD = 5000
    ,MAX_ALERT_THRESHOLD = 20000
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'THSteps'
WHERE lmdef_id = 401;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Monthly'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 19930
    ,LETTER_MAX_SENT_PER_DAY = 21638
    ,MIN_ALERT_THRESHOLD = 18000
    ,MAX_ALERT_THRESHOLD = 23000
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'THSteps'
WHERE lmdef_id = 402;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Monthly'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 454304
    ,LETTER_MAX_SENT_PER_DAY = 518574
    ,MIN_ALERT_THRESHOLD = 400000
    ,MAX_ALERT_THRESHOLD = 550000
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'THSteps'
WHERE lmdef_id = 760;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Monthly'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 290437
    ,LETTER_MAX_SENT_PER_DAY = 304672
    ,MIN_ALERT_THRESHOLD = 200000
    ,MAX_ALERT_THRESHOLD = 350000
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'THSteps'
WHERE lmdef_id = 415;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Monthly'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 208620
    ,LETTER_MAX_SENT_PER_DAY = 378520
    ,MIN_ALERT_THRESHOLD = 150000
    ,MAX_ALERT_THRESHOLD = 400000
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'THSteps'
WHERE lmdef_id = 761;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Monthly'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 116035
    ,LETTER_MAX_SENT_PER_DAY = 188376
    ,MIN_ALERT_THRESHOLD = 100000
    ,MAX_ALERT_THRESHOLD = 200000
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'THSteps'
WHERE lmdef_id = 453;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 1
    ,LETTER_MAX_SENT_PER_DAY = 300
    ,MIN_ALERT_THRESHOLD = 0
    ,MAX_ALERT_THRESHOLD = 75
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'THSteps'
WHERE lmdef_id = 405;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 3
    ,NO_DUPES_DAYS = 7
    ,LETTER_MIN_SENT_PER_DAY = 1
    ,LETTER_MAX_SENT_PER_DAY = 324
    ,MIN_ALERT_THRESHOLD = 0
    ,MAX_ALERT_THRESHOLD = 150
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'THSteps'
WHERE lmdef_id = 410;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Monthly'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 1
    ,LETTER_MAX_SENT_PER_DAY = 125
    ,MIN_ALERT_THRESHOLD = 0
    ,MAX_ALERT_THRESHOLD = 50
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'THSteps'
WHERE lmdef_id = 413;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Monthly'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 1
    ,LETTER_MAX_SENT_PER_DAY = 407
    ,MIN_ALERT_THRESHOLD = 0
    ,MAX_ALERT_THRESHOLD = 80
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'THSteps'
WHERE lmdef_id = 412;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = null
    ,DUPE_CNT_TRIGGER = 0
    ,NO_DUPES_DAYS = 0
    ,LETTER_MIN_SENT_PER_DAY = null
    ,LETTER_MAX_SENT_PER_DAY = null
    ,MIN_ALERT_THRESHOLD = null
    ,MAX_ALERT_THRESHOLD = null
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'THSteps'
WHERE lmdef_id = 454;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 3
    ,NO_DUPES_DAYS = 7
    ,LETTER_MIN_SENT_PER_DAY = 1
    ,LETTER_MAX_SENT_PER_DAY = 9
    ,MIN_ALERT_THRESHOLD = 0
    ,MAX_ALERT_THRESHOLD = 10
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'THSteps'
WHERE lmdef_id = 403;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 3
    ,NO_DUPES_DAYS = 7
    ,LETTER_MIN_SENT_PER_DAY = 1
    ,LETTER_MAX_SENT_PER_DAY = 5
    ,MIN_ALERT_THRESHOLD = 0
    ,MAX_ALERT_THRESHOLD = 10
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'THSteps'
WHERE lmdef_id = 411;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 1
    ,LETTER_MAX_SENT_PER_DAY = 42
    ,MIN_ALERT_THRESHOLD = 0
    ,MAX_ALERT_THRESHOLD = 40
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'THSteps'
WHERE lmdef_id = 407;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = null
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 1
    ,LETTER_MAX_SENT_PER_DAY = 289
    ,MIN_ALERT_THRESHOLD = 0
    ,MAX_ALERT_THRESHOLD = 80
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'THSteps'
WHERE lmdef_id = 409;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = null
    ,DUPE_CNT_TRIGGER = 0
    ,NO_DUPES_DAYS = 0
    ,LETTER_MIN_SENT_PER_DAY = null
    ,LETTER_MAX_SENT_PER_DAY = null
    ,MIN_ALERT_THRESHOLD = null
    ,MAX_ALERT_THRESHOLD = null
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'THSteps'
WHERE lmdef_id = 776;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 5
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 0
    ,LETTER_MAX_SENT_PER_DAY = 448
    ,MIN_ALERT_THRESHOLD = 0
    ,MAX_ALERT_THRESHOLD = 200
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = 35
    ,MAILHOUSE_PROGRAM = 'CHIP'
WHERE lmdef_id = 430;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 5
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 0
    ,LETTER_MAX_SENT_PER_DAY = 76
    ,MIN_ALERT_THRESHOLD = 0
    ,MAX_ALERT_THRESHOLD = 30
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'CHIP'
WHERE lmdef_id = 421;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 5
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 0
    ,LETTER_MAX_SENT_PER_DAY = 21
    ,MIN_ALERT_THRESHOLD = 0
    ,MAX_ALERT_THRESHOLD = 15
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'CHIP'
WHERE lmdef_id = 423;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 3
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 2
    ,LETTER_MAX_SENT_PER_DAY = 11965
    ,MIN_ALERT_THRESHOLD = 1
    ,MAX_ALERT_THRESHOLD = 4000
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'Medicaid'
WHERE lmdef_id = 436;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 3
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 2
    ,LETTER_MAX_SENT_PER_DAY = 12440
    ,MIN_ALERT_THRESHOLD = 1
    ,MAX_ALERT_THRESHOLD = 7000
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'Medicaid'
WHERE lmdef_id = 435;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 1
    ,NO_DUPES_DAYS = 0
    ,LETTER_MIN_SENT_PER_DAY = null
    ,LETTER_MAX_SENT_PER_DAY = null
    ,MIN_ALERT_THRESHOLD = null
    ,MAX_ALERT_THRESHOLD = null
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'Medicaid'
WHERE lmdef_id = 470;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 1
    ,LETTER_MAX_SENT_PER_DAY = 119
    ,MIN_ALERT_THRESHOLD = 1
    ,MAX_ALERT_THRESHOLD = 50
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'Medicaid'
WHERE lmdef_id = 437;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = null
    ,NO_DUPES_DAYS = null
    ,LETTER_MIN_SENT_PER_DAY = 1
    ,LETTER_MAX_SENT_PER_DAY = 101
    ,MIN_ALERT_THRESHOLD = 1
    ,MAX_ALERT_THRESHOLD = 30
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'Medicaid'
WHERE lmdef_id = 756;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Monthly'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 60
    ,LETTER_MIN_SENT_PER_DAY = 0
    ,LETTER_MAX_SENT_PER_DAY = 2561
    ,MIN_ALERT_THRESHOLD = 0
    ,MAX_ALERT_THRESHOLD = 2500
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = 1
    ,MAILHOUSE_PROGRAM = 'CHIP'
WHERE lmdef_id = 20;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 1
    ,LETTER_MAX_SENT_PER_DAY = 87
    ,MIN_ALERT_THRESHOLD = 0
    ,MAX_ALERT_THRESHOLD = 50
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'Medicaid'
WHERE lmdef_id = 408;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Monthly'
    ,DUPE_CNT_TRIGGER = 1
    ,NO_DUPES_DAYS = 0
    ,LETTER_MIN_SENT_PER_DAY = 1
    ,LETTER_MAX_SENT_PER_DAY = 22468
    ,MIN_ALERT_THRESHOLD = 0
    ,MAX_ALERT_THRESHOLD = 0
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'Medicaid'
WHERE lmdef_id = 481;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 7
    ,LETTER_MIN_SENT_PER_DAY = 1
    ,LETTER_MAX_SENT_PER_DAY = 433
    ,MIN_ALERT_THRESHOLD = 1
    ,MAX_ALERT_THRESHOLD = 200
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'Medicaid'
WHERE lmdef_id = 490;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 1
    ,LETTER_MAX_SENT_PER_DAY = 6309
    ,MIN_ALERT_THRESHOLD = 1
    ,MAX_ALERT_THRESHOLD = 1500
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'Medicaid'
WHERE lmdef_id = 491;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 1
    ,LETTER_MAX_SENT_PER_DAY = 498
    ,MIN_ALERT_THRESHOLD = 1
    ,MAX_ALERT_THRESHOLD = 100
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'Medicaid'
WHERE lmdef_id = 492;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 7
    ,LETTER_MIN_SENT_PER_DAY = 1
    ,LETTER_MAX_SENT_PER_DAY = 51
    ,MIN_ALERT_THRESHOLD = 1
    ,MAX_ALERT_THRESHOLD = 25
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'Medicaid'
WHERE lmdef_id = 493;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 1
    ,LETTER_MAX_SENT_PER_DAY = 13
    ,MIN_ALERT_THRESHOLD = 1
    ,MAX_ALERT_THRESHOLD = 15
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'Medicaid'
WHERE lmdef_id = 494;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 7
    ,LETTER_MIN_SENT_PER_DAY = null
    ,LETTER_MAX_SENT_PER_DAY = null
    ,MIN_ALERT_THRESHOLD = null
    ,MAX_ALERT_THRESHOLD = null
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'Medicaid'
WHERE lmdef_id = 497;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Monthly'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 365
    ,LETTER_MIN_SENT_PER_DAY = 1
    ,LETTER_MAX_SENT_PER_DAY = 208555
    ,MIN_ALERT_THRESHOLD = 1
    ,MAX_ALERT_THRESHOLD = 20
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'Medicaid'
WHERE lmdef_id = 482;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Monthly'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 365
    ,LETTER_MIN_SENT_PER_DAY = 1
    ,LETTER_MAX_SENT_PER_DAY = 17038
    ,MIN_ALERT_THRESHOLD = 1
    ,MAX_ALERT_THRESHOLD = 20
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'Medicaid'
WHERE lmdef_id = 483;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 7
    ,LETTER_MIN_SENT_PER_DAY = 1
    ,LETTER_MAX_SENT_PER_DAY = 7
    ,MIN_ALERT_THRESHOLD = 1
    ,MAX_ALERT_THRESHOLD = 10
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'Medicaid'
WHERE lmdef_id = 484;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 7
    ,LETTER_MIN_SENT_PER_DAY = 1
    ,LETTER_MAX_SENT_PER_DAY = 37
    ,MIN_ALERT_THRESHOLD = 1
    ,MAX_ALERT_THRESHOLD = 10
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'Medicaid'
WHERE lmdef_id = 485;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = null
    ,LETTER_MAX_SENT_PER_DAY = null
    ,MIN_ALERT_THRESHOLD = null
    ,MAX_ALERT_THRESHOLD = null
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'Medicaid'
WHERE lmdef_id = 486;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 1
    ,LETTER_MAX_SENT_PER_DAY = 240
    ,MIN_ALERT_THRESHOLD = 1
    ,MAX_ALERT_THRESHOLD = 50
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'Medicaid'
WHERE lmdef_id = 487;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 7
    ,LETTER_MIN_SENT_PER_DAY = 1
    ,LETTER_MAX_SENT_PER_DAY = 7
    ,MIN_ALERT_THRESHOLD = 1
    ,MAX_ALERT_THRESHOLD = 10
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'Medicaid'
WHERE lmdef_id = 488;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 1
    ,LETTER_MAX_SENT_PER_DAY = 6
    ,MIN_ALERT_THRESHOLD = 1
    ,MAX_ALERT_THRESHOLD = 10
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'Medicaid'
WHERE lmdef_id = 489;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 5
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 0
    ,LETTER_MAX_SENT_PER_DAY = 5
    ,MIN_ALERT_THRESHOLD = 0
    ,MAX_ALERT_THRESHOLD = 6
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'CHIP'
WHERE lmdef_id = 717;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Manually Triggered'
    ,DUPE_CNT_TRIGGER = null
    ,NO_DUPES_DAYS = null
    ,LETTER_MIN_SENT_PER_DAY = 0
    ,LETTER_MAX_SENT_PER_DAY = 1
    ,MIN_ALERT_THRESHOLD = 0
    ,MAX_ALERT_THRESHOLD = 2
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'CHIP'
WHERE lmdef_id = 431;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 0
    ,LETTER_MAX_SENT_PER_DAY = 10
    ,MIN_ALERT_THRESHOLD = 0
    ,MAX_ALERT_THRESHOLD = 9
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'CHIP'
WHERE lmdef_id = 758;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Retired'
    ,DUPE_CNT_TRIGGER = null
    ,NO_DUPES_DAYS = null
    ,LETTER_MIN_SENT_PER_DAY = null
    ,LETTER_MAX_SENT_PER_DAY = null
    ,MIN_ALERT_THRESHOLD = null
    ,MAX_ALERT_THRESHOLD = null
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'Medicaid'
WHERE lmdef_id = 460;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 1
    ,NO_DUPES_DAYS = 0
    ,LETTER_MIN_SENT_PER_DAY = null
    ,LETTER_MAX_SENT_PER_DAY = null
    ,MIN_ALERT_THRESHOLD = null
    ,MAX_ALERT_THRESHOLD = 1
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'Medicaid'
WHERE lmdef_id = 449;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 2
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = 1
    ,LETTER_MAX_SENT_PER_DAY = 9439
    ,MIN_ALERT_THRESHOLD = 1
    ,MAX_ALERT_THRESHOLD = 750
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = 'Medicaid'
WHERE lmdef_id = 438;

UPDATE d_letter_definition
SET LETTER_FREQUENCY = 'Daily'
    ,DUPE_CNT_TRIGGER = 5
    ,NO_DUPES_DAYS = 30
    ,LETTER_MIN_SENT_PER_DAY = null
    ,LETTER_MAX_SENT_PER_DAY = null
    ,MIN_ALERT_THRESHOLD = null
    ,MAX_ALERT_THRESHOLD = 10
    ,MAX_NCOA_THRESHOLD = null
    ,MAX_ACS_THRESHOLD = null
    ,MAX_MAILHOUSE_THRESHOLD = null
    ,MAILHOUSE_PROGRAM = null
WHERE lmdef_id = 434;

commit;