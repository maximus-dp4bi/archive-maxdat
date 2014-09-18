BEGIN
INSERT INTO corp_etl_control
( name , value_type , value , description , created_ts , updated_ts )
VALUES ( 'SITP_LAST_LETTER_ID' , 'N' , '0' , 'Used to fetch Letters from OLTP for Send Info to TP process'
       , SYSDATE , SYSDATE );
INSERT INTO corp_etl_control
( name , value_type , value , description , created_ts , updated_ts )
VALUES ( 'SITP_LAST_EVENT_ID' , 'N' , '0' , 'Used to fetch Events from OLTP for Send Info to TP process'
       , SYSDATE , SYSDATE );
INSERT INTO corp_etl_control
( name , value_type , value , description , created_ts , updated_ts )
VALUES ( 'SITP_LAST_DCN_ID' , 'N' , '0' , 'Used to fetch DCNs from OLTP for Send Info to TP process'
       , SYSDATE , SYSDATE );
INSERT INTO corp_etl_control
( name , value_type , value , description , created_ts , updated_ts )
VALUES ( 'SITP_LAST_IEDR' , 'N' , '0' , 'Used to fetch IEDR from OLTP for Send Info to TP process'
       , SYSDATE , SYSDATE );
INSERT INTO corp_etl_control
( name , value_type , value , description , created_ts , updated_ts )
VALUES ( 'SITP_LAST_CIN' , 'N' , '0' , 'Used to fetch CIN from OLTP for Send Info to TP process'
       , SYSDATE , SYSDATE );
--
INSERT INTO corp_etl_control
( name , value_type , value , description , created_ts , updated_ts )
VALUES ( 'SITP_SLA_DAYS_TYPE' , 'V' , 'B' , 'Used to calculate SLA Days TYPE, N is none, B is Busisness, C is Calendar'
       , SYSDATE , SYSDATE );
INSERT INTO corp_etl_control
( name , value_type , value , description , created_ts , updated_ts )
VALUES ( 'SITP_SLA_JEOPARDY_DAYS' , 'N' , '2' , 'Used to calculate SLA Jeopardy Days for Send Info To TP'
       , SYSDATE , SYSDATE );
INSERT INTO corp_etl_control
( name , value_type , value , description , created_ts , updated_ts )
VALUES ( 'SITP_SLA_TARGET_DAYS' , 'N' , '3' , 'Used to calculate SLA Target Days for Send Info To TP'
       , SYSDATE , SYSDATE );
END;