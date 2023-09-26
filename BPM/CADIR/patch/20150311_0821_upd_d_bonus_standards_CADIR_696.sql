select * from D_BONUS_STANDARDS;

update D_BONUS_STANDARDS
set end_date = to_date('01/28/2015','mm/dd/yyyy')
where task_type in ('Document Review Queue',
                    'Preliminary Reviewer Queue',
                    'Final Determination Letter Escalation Queue',
                    'Final Determination Letter Queue',
                    'Termination Queue');


INSERT INTO D_BONUS_STANDARDS (BID,TASK_TYPE,BONUS_STANDARD,BONUS_POINT_1,BONUS_POINT_2,BONUS_POINT_3,ACTIVE,START_DATE,END_DATE,role_name)
VALUES (11,'Termination Queue',5,110,115,120,'Y',TO_DATE('03012015','mmddyyyy'), TO_DATE('07077777','mmddyyyy'),'Terminator' );

INSERT INTO D_BONUS_STANDARDS (BID,TASK_TYPE,BONUS_STANDARD,BONUS_POINT_1,BONUS_POINT_2,BONUS_POINT_3,ACTIVE,START_DATE,END_DATE,role_name)
VALUES (12,'Preliminary Reviewer Queue',5,110,115,120,'Y',TO_DATE('03012015','mmddyyyy'), TO_DATE('07077777','mmddyyyy'),'Preliminary Reviewer' );

INSERT INTO D_BONUS_STANDARDS (BID,TASK_TYPE,BONUS_STANDARD,BONUS_POINT_1,BONUS_POINT_2,BONUS_POINT_3,ACTIVE,START_DATE,END_DATE,role_name)
VALUES (13,'Document Review Queue',3,110,115,120,'Y',TO_DATE('03012015','mmddyyyy'), TO_DATE('07077777','mmddyyyy'),'Document Review Clerk' );

INSERT INTO D_BONUS_STANDARDS (BID,TASK_TYPE,BONUS_STANDARD,BONUS_POINT_1,BONUS_POINT_2,BONUS_POINT_3,ACTIVE,START_DATE,END_DATE,role_name)
VALUES (14,'Request for Information Queue ',4,110,115,120,'Y',TO_DATE('03012015','mmddyyyy'), TO_DATE('07077777','mmddyyyy'),'' );

COMMIT;
