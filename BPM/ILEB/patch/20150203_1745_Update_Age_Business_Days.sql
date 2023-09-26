/*
Created on 02/04/2015 by Raj A. per ILEB-4363, deployed ETL code and database scripts. Updating instances's age and Timeliness_Status in this script.
*/
 update D_MW_CURRENT
    set 
	    "Age in Business Days" = maxdat.MANAGE_WORK.GET_AGE_IN_BUSINESS_DAYS("Create Date","Complete Date"),
        "Timeliness Status" = maxdat.MANAGE_WORK.GET_TIMELINESS_STATUS("Complete Date","SLA Days Type","Age in Business Days","Age in Calendar Days","SLA Days")
    where trunc("Complete Date") >= '1-JAN-2015';
commit;

update D_MFDOC_CURRENT
    set
      "Age in Business Days" = maxdat.manage_mail_fax_doc.GET_AGE_IN_BUSINESS_DAYS("DCN Create Date","Instance Complete Date"),
      "DCN Timeliness Status" = maxdat.manage_mail_fax_doc.GET_TIMELINESS_STATUS("DCN Create Date","Instance Complete Date","Document Type")
    where trunc("Instance Complete Date") >= '1-JAN-2015';
commit;

update D_PI_CURRENT
    set
      "Age in Business Days" = maxdat.DPY_PROCESS_INCIDENTS.GET_AGE_IN_BUSINESS_DAYS("Receipt Date","Complete Date"),
	  "Timeliness Status" = maxdat.DPY_PROCESS_INCIDENTS.GET_TIMELINESS_STATUS("Receipt Date","Cur Incident Status Date","Cur Instance Status","Cancel Date",PRIORITY)
where trunc("Complete Date") >= '1-JAN-2015';
commit;	  

update D_PL_CURRENT
    set
      AGE_IN_BUSINESS_DAYS = maxdat.PROCESS_LETTERS.GET_AGE_IN_BUSINESS_DAYS(CREATE_DATE,COMPLETE_DATE),
	  TIMELINESS_STATUS = maxdat.PROCESS_LETTERS.GET_TIMELINESS_STATUS(LETTER_TYPE,NEWBORN_FLAG,CREATE_DATE,COMPLETE_DATE)
where trunc(COMPLETE_DATE) >= '1-JAN-2015';
commit;	 

update D_ME_CURRENT
    set
      Age_In_Business_Days = maxdat.MANAGE_ENROLL.GET_AGE_IN_BUSINESS_DAYS(create_dt, COMPLETE_DATE)
where trunc(COMPLETE_DATE) >= '1-JAN-2015';
commit;	

update D_ONL_CURRENT
    set
      AGE_IN_BUSINESS_DAYS= maxdat.PROCESS_ONLINE_INFO.GET_AGE_IN_BUSINESS_DAYS(CREATE_DATE,COMPLETE_DATE), 
	  TIMELINESS_STATUS = maxdat.PROCESS_ONLINE_INFO.GET_POI_TIMELINESS_STAT(TRANSACTION_TYPE,CUR_INSTANCE_STATUS,CREATE_DATE,COMPLETE_DATE)
where trunc(COMPLETE_DATE) >= '1-JAN-2015';
commit;