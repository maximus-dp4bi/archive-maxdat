alter session set current_schema = MAXDAT;

ALTER TABLE CC_C_ACTIVITY_TYPE ADD (SCHEDULED_TO_WORK CHAR (1));

ALTER TABLE CC_C_ACTIVITY_TYPE ADD (IS_PRODUCTIVE CHAR (1));

ALTER TABLE CC_D_ACTIVITY_TYPE ADD (SCHEDULED_TO_WORK CHAR (1));

ALTER TABLE CC_D_ACTIVITY_TYPE ADD (IS_PRODUCTIVE CHAR (1));

COMMIT;