***** MODIFICATION HISTORY ****************************************************************************
Instructions to install TXEB  Promotions week of 02/20/2014
----------------
Date       Developer           PHONE         Reason/Description
---------- ------------------- ------------- ------------------------------------------------------
2014/02/18 B. Thai             210-722-3895  MailFaxDoc: prevent hard abort, and more job statistic counts.
***** MODIFICATION HISTORY ****************************************************************************

-----------------------
0. Turn off Cron
-----------------------
Disable cron - cron_tx_run_bpm.sh


-----------------------
2. KETTLE FILES SECTION
-----------------------


       *******************************************************************************************	
        Brian Thai (Mail Fax Doc)
	--------------------------------------------------------------------
	Download AS_MailFaxDoc_20140213_Brian_1.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ProcessMailFaxDoc
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ProcessMailFaxDoc 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ProcessMailFaxDoc

	ProcessMailFax_CaptureNewDoc_create.ktr
	ProcessMailFax_Cleanup.ktr
	ProcessMailFax_copy_to_tmp.ktr
	ProcessMailFax_Get_gwf_work_identified.ktr
	ProcessMailFax_Get_MAXe_classify_tsk_Dtl.ktr
	ProcessMailFax_Get_MAXe_IA_tsk_Dtl.ktr
	ProcessMailFax_Get_MAXe_manual_tsk_Dtl.ktr
	ProcessMailFax_Get_MAXe_work_tsk_Dtl.ktr
	ProcessMailFax_Job_Completes.ktr
	ProcessMailFax_set_MAX_DCN.ktr
	ProcessMailFax_Tmp_to_BPM_Update.ktr
	ProcessMailFaxUpdates_update1.ktr
	ProcessMailFaxUpdates_update2.ktr
	ProcessMailFaxUpdates_update3.ktr
	ProcessMailFaxUpdates_update4.ktr
	ProcessMailFaxUpdates_update5.ktr
	ProcessMailFaxUpdates_update6.ktr
	ProcessMailFaxUpdates_update7.ktr
	ProcessMailFaxUpdates_update8.ktr
	--------------------------------------------------------------------
       *******************************************************************************************

----------------------------
3. Enable Cron Jobs 
----------------------------

Enable cron - cron_tx_run_bpm.sh
