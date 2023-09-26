-- Update PP_BO_Event_target_lkup NYHIX-23560

Insert into PP_BO_EVENT_TARGET_LKUP (EVENT_ID,NAME,TARGET,SCORECARD_FLAG,START_DATE,END_DATE,CREATE_BY,CREATE_DATETIME,SCORECARD_GROUP) values (1317,'Retro Verification Document',4,'Y',to_date('01/01/2016 00:00:00','mm/dd/yyyy hh24:mi:ss'),to_date('01-Aug-16 00:00:00','dd-Mon-yy hh24:mi:ss'),'script',to_date('06/13/2016 10:08:13','mm/dd/yyyy hh24:mi:ss'),'Retro Verification Document');

commit;
