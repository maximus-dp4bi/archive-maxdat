/*
Created by Raj A on 04/12/2017.
Description: Per MAXDAT-5052 and PAIEB-541, configuring to load PA IEB data.
cc_s_ivr_response.Program_Name was populated with incorrect value; Found this while validating in UAT.
*/
update cc_a_list_lkup
  set ref_type = 'Independent Enrollment Broker'
where   NAME = 'IVR_DATA_FILE_NAMES'
   AND list_type = 'IVR_APP_NAME'
   and VALUE in ('MAXPAIEB', 'MAXPAIEBOCM');
   commit;