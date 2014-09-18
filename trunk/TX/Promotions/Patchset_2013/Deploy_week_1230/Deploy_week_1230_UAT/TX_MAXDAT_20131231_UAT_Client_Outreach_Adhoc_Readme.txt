***** MODIFICATION HISTORY ****************************************************************************
Instructions for Client Outreach initial deployment and adhoc run
----------------
Date       Developer           PHONE         Reason/Description
---------- ------------------- ------------- ------------------------------------------------------
2013/12/31 Mayuresh Bhalekar   201-328-5695  Load 100k records


***** MODIFICATION HISTORY ****************************************************************************
        
-----------------------
1. KETTLE FILES SECTION
-----------------------

       *******************************************************************************************	
         Mayuresh Bhalekar (Client Outreach)
	--------------------------------------------------------------------
	Download AS_ClientOutreach_20131230_Mayuresh_3.zip
	Deploy the follow files to the appropriate path
	  UAT      DEPLOY TO PATH dtxe4t/ETL_Scripts/scripts/ClientOutreach
	  ProdSupp DEPLOY TO PATH ttxe4t/ETL_Scripts/scripts/ClientOutreach 
	  PROD     DEPLOY TO PATH ptxe4t/ETL_Scripts/scripts/ClientOutreach

	Client_Outreach_ActivityLKUP.ktr
	Client_Outreach_copy_TEMP.ktr
	Client_Outreach_env_var.ktr
	Client_Outreach_fetch_OLTP.kjb
	Client_Outreach_Get_CntrlVariable.ktr
	Client_Outreach_get_OLTP.ktr
	Client_Outreach_get_OLTP_County.ktr
	Client_Outreach_get_OLTP_Human_Task.ktr
	Client_Outreach_get_OLTP_Human_Task_Instance.ktr
	Client_Outreach_get_OLTP_Inc_Header.ktr
	Client_Outreach_get_OLTP_Inst_Head_Stat_Hist.ktr
	Client_Outreach_get_OLTP_Inst_Header_Stat_Hist.ktr
	Client_Outreach_get_OLTP_Proc_Notf_lkup.ktr
	Client_Outreach_get_OLTP_Program.ktr
	Client_Outreach_get_OLTP_Step_Inst.ktr
	Client_Outreach_get_OLTP_Surveys.ktr
	Client_Outreach_get_OLTP_Validation.ktr
	Client_Outreach_GetOLTP_SUBPROG.kjb
	Client_Outreach_GetOLTP_SUBPROG.ktr
	Client_Outreach_GetOLTP_SUBPROG_TMP.ktr
	Client_Outreach_INS1.ktr
	Client_Outreach_INS2.ktr
	Client_Outreach_MainJob_completed.ktr
	Client_Outreach_UPD_BPM_Main.ktr
	Client_Outreach_UPD1.ktr
	Client_Outreach_UPD2.ktr
	Client_Outreach_UPD3.ktr
	Client_Outreach_UPD4.ktr
	Client_Outreach_UPD5.ktr
	Client_Outreach_UPD6.ktr
	Client_Outreach_UPD7.ktr
	Client_Outreach_UPD8.ktr
	Client_Outreach_UPD9.ktr
	Client_Outreach_UPD10.ktr
	Client_Outreach_UPD11.ktr
	Client_Outreach_UPD12.ktr
	Client_Outreach_UPD13.ktr
	Client_Outreach_UPD14.ktr
	Client_Outreach_UPD15.ktr
	Client_Outreach_UPD16.ktr
	Client_Outreach_UPD17.ktr
	Client_Outreach_UPD18.ktr
	Client_Outreach_UPD19.ktr
	Client_Outreach_UPD20.ktr
	Client_Outreach_UPD21.ktr
	Client_Outreach_UPD24.ktr
	Client_Outreach_UPD25.ktr
	Client_Outreach_updMAX_ctrlVariable.ktr
	Client_Outreach_updMAX_Event_id_ctrlVariable.ktr
	ClientOutreach_OLTP_details.kjb
	ClientOutreach_runall.kjb
	ClientOutreach_Updates.kjb
-	--------------------------------------------------------------------
       *******************************************************************************************

----------------------------
2. ADHOC SH SCRIPT SECTION
----------------------------

       *******************************************************************************************	
       
        --Execute tx_run_bpm_ClnO.sh which will populate the Client outreach ETL staging
        UAT             nohup /dtxe4t/ETL_Scripts/scripts/tx_run_bpm_ClnO.sh &
	PROD SUPP       nohup /ttxe4t/ETL_Scripts/scripts/tx_run_bpm_ClnO.sh &
	
	--------------------------------------------------------------------------------------------
       *******************************************************************************************	
