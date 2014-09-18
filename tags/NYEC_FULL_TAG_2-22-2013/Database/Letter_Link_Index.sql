--- Create/Recreate indexes 
create index NYHOPT.IDX_LTR_LNK_REF_TYPE_REF_ID on NYHOPT.LETTER_REQUEST_LINK (REFERENCE_TYPE, REFERENCE_ID)
  tablespace NYHOPT_INDEX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    next 1
    minextents 1
  );
