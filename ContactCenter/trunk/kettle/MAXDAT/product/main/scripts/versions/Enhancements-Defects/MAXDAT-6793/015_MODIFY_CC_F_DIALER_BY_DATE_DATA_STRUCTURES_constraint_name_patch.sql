ALTER TABLE CC_S_DIALER_BY_DATE 
  RENAME CONSTRAINT CC_S_DIALER_BY_DATE_AGENT_LOGIN_FK TO CC_S_DIALER_BY_DATE_AGTLGN_FK;
  

ALTER TABLE CC_F_DIALER_BY_DATE 
  RENAME CONSTRAINT CC_F_DIALER_BY_DATE_AGENT_LOGIN_FK TO CC_F_DIALER_BY_DATE_AGTLGN_FK;