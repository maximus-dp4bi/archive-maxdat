INSERT INTO CC_C_FILTER(FILTER_TYPE, VALUE) VALUES ('ACD_CALL_TYPE_ID_INC','6971');
INSERT INTO CC_C_FILTER(FILTER_TYPE, VALUE) VALUES ('ACD_CALL_TYPE_ID_INC','6972');
INSERT INTO CC_C_FILTER(FILTER_TYPE, VALUE) VALUES ('ACD_CALL_TYPE_ID_INC','6973');
INSERT INTO CC_C_FILTER(FILTER_TYPE, VALUE) VALUES ('ACD_CALL_TYPE_ID_INC','6974');
INSERT INTO CC_C_FILTER(FILTER_TYPE, VALUE) VALUES ('ACD_CALL_TYPE_ID_INC','6975');
INSERT INTO CC_C_FILTER(FILTER_TYPE, VALUE) VALUES ('ACD_CALL_TYPE_ID_INC','6976');
INSERT INTO CC_C_FILTER(FILTER_TYPE, VALUE) VALUES ('ACD_CALL_TYPE_ID_INC','6964');
INSERT INTO CC_C_FILTER(FILTER_TYPE, VALUE) VALUES ('ACD_CALL_TYPE_ID_INC','6965');
INSERT INTO CC_C_FILTER(FILTER_TYPE, VALUE) VALUES ('ACD_CALL_TYPE_ID_INC','6966');
INSERT INTO CC_C_FILTER(FILTER_TYPE, VALUE) VALUES ('ACD_CALL_TYPE_ID_INC','6967');
INSERT INTO CC_C_FILTER(FILTER_TYPE, VALUE) VALUES ('ACD_CALL_TYPE_ID_INC','6968');
INSERT INTO CC_C_FILTER(FILTER_TYPE, VALUE) VALUES ('ACD_CALL_TYPE_ID_INC','6969');
INSERT INTO CC_C_FILTER(FILTER_TYPE, VALUE) VALUES ('ACD_CALL_TYPE_ID_INC','5105');
INSERT INTO CC_C_FILTER(FILTER_TYPE, VALUE) VALUES ('ACD_CALL_TYPE_ID_INC','5097');

  INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
  VALUES ('0.1.4','101','101_CC_C_FILTER__INSERT_MISSING_QUEUES');
  
  COMMIT;