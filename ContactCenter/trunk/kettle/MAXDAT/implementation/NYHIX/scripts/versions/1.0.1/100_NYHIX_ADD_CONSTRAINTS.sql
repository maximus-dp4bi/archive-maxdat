ALTER TABLE CC_C_FILTER ADD CONSTRAINT CC_C_FILTER__UN UNIQUE
(
  FILTER_TYPE , VALUE
)
;

ALTER TABLE CC_C_LOOKUP ADD CONSTRAINT CC_C_LOOKUP__UN UNIQUE
(
  LOOKUP_TYPE , LOOKUP_KEY
)
;
INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME)
VALUES ('1.0.1','100','100_NYHIX_ADD_CONSTRAINTS');

COMMIT;