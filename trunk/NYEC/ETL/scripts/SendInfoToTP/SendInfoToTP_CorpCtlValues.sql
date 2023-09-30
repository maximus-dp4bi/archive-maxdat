-- 01/08/13 Modified from old.
-- 01/31/13 Removed LAST controls; add SITP_IEDR_DAYS.
-- 02/01/13 Moved SLA controls to ETL_LKUP flex fields.
BEGIN
INSERT INTO corp_etl_control
( name , value_type , value , description , created_ts , updated_ts )
VALUES ( 'SITP_LETTER_DAYS' , 'N' , '30' , 'Used to determine how far in the past to look for letters'
       , SYSDATE , SYSDATE );
INSERT INTO corp_etl_control
( name , value_type , value , description , created_ts , updated_ts )
VALUES ( 'SITP_EVENT_DAYS' , 'N' , '30' , 'Used to determine how far in the past to look for events'
       , SYSDATE , SYSDATE );
INSERT INTO corp_etl_control
( name , value_type , value , description , created_ts , updated_ts )
VALUES ( 'SITP_IEDR_DAYS' , 'N' , '30' , 'Used to determine how far in the past to look for IEDR documents'
       , SYSDATE , SYSDATE );
-- 1/25/13
INSERT INTO corp_etl_control
( name , value_type , value , description , created_ts , updated_ts )
VALUES ( 'SITP_CALL_RESPONSE_GRACE' , 'N' , '5' , 'For Send Info To TP, number of give/take minutes between a CSI response and event are created. Initial value is 5 for a 10-minute window.'
       , SYSDATE , SYSDATE );
--
COMMIT;
END;