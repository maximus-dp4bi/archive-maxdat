
ALTER TABLE CC_S_TMP_AVY_IAPPLICATION ADD (
     CALLSGIVENROUTETO NUMBER (10) DEFAULT 0 
);

ALTER TABLE CC_S_ACD_INTERVAL ADD (
     CALLS_GIVEN_FORCE_DISCONNECT NUMBER (7) DEFAULT 0 , 
     CALLS_GIVEN_ROUTE_TO NUMBER (7) DEFAULT 0 
);


ALTER TABLE CC_F_ACTUALS_QUEUE_INTERVAL ADD (
     CALLS_GIVEN_FORCE_DISCONNECT NUMBER (7) DEFAULT 0 , 
     CALLS_GIVEN_ROUTE_TO NUMBER (7) DEFAULT 0 
);


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME)
VALUES ('0.3.1','109','109_ALTER_QUEUE_TABLES_ADD_COUNT_FIELDS');

COMMIT;