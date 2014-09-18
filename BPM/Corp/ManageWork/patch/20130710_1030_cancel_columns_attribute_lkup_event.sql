--------------------------------------------------------
--  File created - Wednesday-July-10-2013   
--------------------------------------------------------
REM INSERTING into BPM_ATTRIBUTE_LKUP
SET DEFINE OFF;
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (722,2,'Cancel Method','This is the method as per which the instance was cancelled');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (576,2,'Cancel By','The name of the system or performer who cancelled the letter.');
Insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (547,2,'Cancel Reason','The reason that the JOB ID instance is cancelled.');


commit;