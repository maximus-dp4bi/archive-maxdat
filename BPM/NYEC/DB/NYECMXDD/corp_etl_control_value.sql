INSERT INTO corp_etl_control
( name , value_type , value , description , create_ts , updated_ts )
VALUES ( 'IR_LAST_APPLICATION_ID' , 'N' , 0 , 'Used to fetch Applications from OLTP for Initiate Renewal process'
       , SYSDATE , SYSDATE );