create or replace PACKAGE CAHCO_ETL_MW_PKG AS

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL$';
  SVN_REVISION varchar2(20) := '$Revision$';
  SVN_REVISION_DATE varchar2(60) := '$Date$';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

    TYPE t_hco_activity_arr IS TABLE OF HCO_ACTIVITY_QUEUE%ROWTYPE;
    
    TYPE t_step_instance_arr IS TABLE OF STEP_INSTANCE%ROWTYPE;

    TYPE step_activity_info_rec IS RECORD (
    	ref_id          NUMBER,
    	status          VARCHAR2(30),
    	create_ts       DATE,
        step_sequence	NUMBER
    );

    --  Batch Info

    CURSOR  c_batch_info
            (   
                cp_DCN                                                          HCO_BATCH_DCN.dcn%TYPE  
            )
    IS
    SELECT  hbs.*
      FROM  HCO_BATCH_DCN               hbd,
            HCO_BATCH_STATS             hbs
     WHERE  hbd.dcn                 =   cp_DCN
       AND  hbd.batch_guid          =   hbs.batch_guid;    

    -- Exemption cursors

    CURSOR  c_emrs_d_exemption_req
    IS
    SELECT  er.*
      FROM  EMRS_D_EXEMPTION_REQ        er
     WHERE  er.record_date   >=         CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_date
                                        (
                                            p_NAME  =>  'MW_ETL_DATA_START_DATE'
                                        )
      AND   er.modified_date   >=       CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_date
                                        (
                                            p_NAME  =>  'MW_EXEMPTION_PROC_DATE'
                                        )
      AND   er.dcn              IS  NOT NULL
      AND   er.client_number    IS  NOT NULL
      order by er.exemption_id;

    CURSOR  c_emrs_d_exempt_status_hist
    IS
    SELECT  esh.*,
            er.record_date               EXEMPTION_RECORD_DATE,
            er.client_number,
            er.dcn,
            es.final_status,
            er.disenrollment_id
      FROM  EMRS_D_EXEMPT_STATUS_HIST   esh,
            EMRS_D_EXEMPTION_REQ        er,
            EMRS_D_EXEMPTION_STATUS     es
     WHERE  er.record_date   >=         CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_date
                                        (
                                            p_NAME  =>  'MW_ETL_DATA_START_DATE'
                                        )
       AND  esh.record_date   >=        CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_date
                                        (
                                            p_NAME      =>  'MW_EXEMPTION_SH_PROC_DATE'
                                        )
       AND  esh.exemption_id            =   er.exemption_id
       AND  er.dcn                       IS  NOT NULL
       AND  upper(trim(er.dcn))          != 'NULL'
       AND  er.client_number             IS  NOT NULL
       AND  esh.exemption_status_code   =   es.exemption_status_code
       order by esh.exemption_hist_id;                                            

    --exemption history activity 6 cursor
	CURSOR c_emrs_d_exempt_status_hist_sixes
	IS
		select * from
		(

		SELECT  eh.exemption_hist_id, eh.exemption_id, eh.exemption_status_code, eh.record_date,  					
                        T.Mail_ID, C.Case_Number as case_id, T.Client_Number,er.dcn,L.MAIL_STATUS, 					
                        L.Date_Requested as mail_start_date , 					
                        L.Modified_Date as mail_end_date, L.date_updated, 
                        rank() over (partition by eh.exemption_hist_id order by L.Date_Requested, L.Modified_Date, dp_letter_mail_id) rnk
                FROM    maxdat.HCO_MAIL_CLIENT_TRANS T					
                        ,maxdat.HCO_D_LETTER_MAILING L					
                        ,maxdat.emrs_d_exempt_status_hist eh					
                        ,maxdat.emrs_d_exemption_req er
                        ,maxdat.emrs_d_exemption_status es
                        ,maxdat.EMRS_D_CASE C
                WHERE   DCIN = MAIL_ID
                AND  C.case_id     = T.Case_ID
                AND     MAIL_STATUS = 'DONE'
                AND     LETTER_TYPE_CODE != 'E6'
                AND     T.exemption_id = eh.exemption_id
                AND     T.client_number = er.client_number
                AND     er.exemption_id = eh.exemption_id
                AND     eh.exemption_status_code = es.exemption_status_code
                AND     er.dcn is not null
                AND  upper(trim(er.dcn))          != 'NULL'
                AND er.client_number is not null
                AND er.record_date >=  CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_date
                                        (
                                            p_NAME  =>  'MW_ETL_DATA_START_DATE'
                                        )

                AND (eh.record_date >=  CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_date
                                        (
                                            p_NAME  =>  'MW_EXEMPTION_SH_PROC_SIX_DATE'
                                        )


		OR L.date_updated >= CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_date
                                        (
                                            p_NAME  =>  'MW_EXEMPTION_SH_PROC_SIX_MAIL_DATE' 
                                        )

		)
                AND     (er.disenrollment_id is null or er.disenrollment_id = 0)
                AND es.final_status = 'Y'
                Order by L.Date_Requested, L.Modified_Date, dp_letter_mail_id
                
                )
                where rnk=1
                order by exemption_hist_id;


    -- EDER cursors

    CURSOR  c_emrs_d_emrgcy_disenroll
    IS
    SELECT  eder.*
      FROM  EMRS_D_EMRGCY_DISENROLL     eder
     WHERE  eder.record_date   >=       CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_date
                                        (
                                            p_NAME  =>  'MW_ETL_DATA_START_DATE'
                                        )
       AND  eder.modified_date   >=     CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_date
                                        (
                                            p_NAME      =>  'MW_EDER_PROC_DATE'
                                        )
       AND  eder.dcn             IS NOT NULL
       order by eder.emrgcy_disenroll_id;

    CURSOR  c_proc_emrs_d_emrgcy_denr_hist
    IS
    SELECT  ederhist.*,
            eder.record_date               EDER_RECORD_DATE,
            eder.client_number,
            eder.dcn,
            es.final_status
      FROM  EMRS_D_EMRGCY_DENR_HIST     ederhist,
            EMRS_D_EMRGCY_DISENROLL     eder,
            EMRS_D_EMRGCY_DENR_STATUS   es
     WHERE  eder.record_date   >=       CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_date
                                        (
                                            p_NAME  =>  'MW_ETL_DATA_START_DATE'
                                        )
       AND  ederhist.record_date   >=   CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_date
                                        (
                                            p_NAME      =>  'MW_EDER_SH_PROC_DATE'
                                        )
       AND  ederhist.emrgcy_denr_id             =   eder.emrgcy_disenroll_id
       AND  eder.dcn                            IS  NOT NULL
       AND  upper(trim(eder.dcn))               != 'NULL'
       AND  eder.client_number                  IS  NOT NULL
       AND  ederhist.emrgcy_denr_status_code    =   es.emrgcy_denr_status_code
       order by ederhist.EMRGCY_DENR_HIST_ID;                                            

    -- Enrollment cursor

    CURSOR  c_emrs_f_enrollment
    IS
    SELECT  e.*,
            ext.export_batch_date,
            ext.research_ind,
            ext.error_reason_action,
            (
                SELECT  sl.process_start_date
                  FROM  HCO_SYSTEM_LOG                  sl
                 WHERE  e.transaction_export_date IS NOT NULL                   
                   AND  sl.system_log_id in (
                                                SELECT  min(system_log_id)
                                                  FROM  HCO_SYSTEM_LOG
                                                 WHERE  sl.process_start_date       >=  e.transaction_export_date
                                                   AND  sl.process_name    IN ('uspMedsUploadWrapUp')
                                                   AND  sl.status                   =   'DONE' 
                                            )                                                

            )                           meds_process_start_date,
            (

                SELECT  sl.process_end_date
                  FROM  HCO_SYSTEM_LOG                  sl
                 WHERE  e.transaction_export_date IS NOT NULL                   
                   AND  sl.system_log_id in (
                                                SELECT  min(system_log_id)
                                                  FROM  HCO_SYSTEM_LOG
                                                 WHERE  sl.process_start_date       >=  e.transaction_export_date
                                                   AND  sl.process_name    IN ('uspMedsUploadWrapUp')
                                                   AND  sl.status                   =   'DONE' 
                                            )

            )                           meds_process_end_date,
            (
                SELECT  dte.record_date
                  FROM  DAILY_TRANSACTION_ENROLLMENT    dte
                 WHERE  dte.enrollment_id               =   e.enrollment_id
                   AND  dte.enrollment_record_id        =   (
                                                                SELECT  MAX(enrollment_record_id)
                                                                  FROM  DAILY_TRANSACTION_ENROLLMENT        dte1
                                                                 WHERE  dte1.enrollment_id              =   e.enrollment_id
                                                            )
            )                           proc_daily_meds_trans_file_start,
            (
                SELECT  dte.modified_date
                  FROM  DAILY_TRANSACTION_ENROLLMENT    dte
                 WHERE  dte.enrollment_id               =   e.enrollment_id
                   AND  dte.modified_date IS NOT NULL
                   AND  dte.modified_date > dte.record_date
                   AND  dte.enrollment_record_id        =   (
                                                                SELECT  MAX(enrollment_record_id)
                                                                  FROM  DAILY_TRANSACTION_ENROLLMENT        dte1
                                                                 WHERE  dte1.enrollment_id              =   e.enrollment_id
                                                            )                   
            )                           proc_daily_meds_trans_file_end
      FROM  EMRS_F_ENROLLMENT           e,
            HCO_ENROLLMENT_EXT          ext
     WHERE  e.record_date          >=   CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_date
                                        (
                                            p_NAME  =>  'MW_ETL_DATA_START_DATE'
                                        )
       AND  e.modified_date        >=   CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_date
                                        (
                                            p_NAME      =>  'MW_ENROLLMENT_PROC_DATE'
                                        )
       AND  CAHCO_ETL_MW_UTIL_PKG.is_valid_enrollment(e.enrollment_trans_type_code, e.dcn, e.client_number, e.channel_id, e.record_name, e.date_of_validity_start, e.date_of_validity_end) = CAHCO_ETL_MW_UTIL_PKG.is_true
       AND  e.enrollment_id         =   ext.enrollment_id
       AND  e.dcn                   =   ext.dcn
     ORDER
        BY  e.enrollment_id,
            e.modified_date;

    -- Return Mail Case cursor

    CURSOR  c_return_mail
    IS
    SELECT  mr.*,
            obt.record_date             obt_record_date,
            obt.modified_date           obt_modified_date,
            obt.disposition_code        obt_disposition_code
      FROM  HCO_D_MAIL_RETURNED     mr
            LEFT JOIN
            HCO_OB_TRANSACTIONS     obt
            ON  
            (
                    mr.case_number                  =   obt.case_number
                AND mr.case_head_client_number      =   obt.client_number
                AND obt.ob_call_type                =   'BA'
            )
     WHERE  (
                    mr.mail_returned_outcome_id =   6
                AND (
                            obt.ob_call_id IS NULL
                        OR  (
                                    obt.record_date >=  mr.modified_date
                                -- Get the first call number that was placed to the beneficiary on the case, as that is considered the point where the generation
                                -- of the outbound campaign started.
                                AND obt.ob_call_id  =   (
                                                            SELECT  MIN(ob_call_id)
                                                              FROM  HCO_OB_TRANSACTIONS         obt1
                                                             WHERE  obt1.case_number        =   obt.case_number
                                                               AND  obt1.client_number      =   obt.client_number
                                                               AND  obt1.ob_call_type       =   'BA'
                                                        )
                            )
                    )
                AND mr.record_date   >=          CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_date
                                                (
                                                    p_NAME  =>  'MW_ETL_DATA_START_DATE'
                                                )
                AND (
                             mr.modified_date       >=   CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_date
                                                        (
                                                            p_NAME      =>  'MW_MAIL_RETURNED_PROC_DATE'
                                                        )
                        OR  obt.modified_date       >=  CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_date
                                                        (
                                                            p_NAME      =>  'MW_RM_OB_TRANS_PROC_DATE'
                                                        )
                        OR  obt.date_updated        >=  CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_date
                                                        (
                                                            p_NAME      =>  'MW_RM_OB_TRANS_PROC_DATE'
                                                        )                                                        
                    )
            );                                                    

    -- Leter Mailing cursor

    CURSOR  c_hco_d_letter_mailing
    IS
    SELECT  lm.dim_letter_mailing_id,
            lm.date_requested,
            lm.vendor_received_date,
            lm.date_mailed,
            lm.modified_date,
            mct.mail_id,
            mct.client_number,
            mct.case_id,
            ec.case_number,
            MAX(mct.mt_modified_date)                                           AS  MAIL_TRANSACTION_DATE,
            MAX(mct.mail_response_letter_date)                                  AS  MAIL_RESPONSE_LETTER_DATE,
            MAX(mct.enrollment_id)                                              AS  ENROLLMENT_ID,
            MAX(mct.exemption_id)                                               AS  EXEMPTION_ID                        
      FROM  HCO_D_LETTER_MAILING        lm,
            HCO_MAIL_CLIENT_TRANS       mct,
            EMRS_D_CASE                 ec
     WHERE  lm.record_date   >=         CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_date
                                        (
                                            p_NAME  =>  'MW_ETL_DATA_START_DATE'
                                        )
       AND  lm.modified_date   >=       CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_date
                                        (
                                            p_NAME  =>  'MW_LETTER_MAILING_PROC_DATE'
                                        )
       AND  lm.mail_status      =       'DONE'
       AND  lm.dcin             =       mct.mail_id
       AND  lm.case_id          =       mct.case_id
       AND  ec.case_id          =       mct.case_id
     GROUP
        BY  lm.dim_letter_mailing_id,
            lm.date_requested,
            lm.vendor_received_date,
            lm.date_mailed,
            lm.modified_date,
            mct.mail_id,
            mct.client_number,
            mct.case_id,
            ec.case_number;

    -- Packet Mailing cursor

    CURSOR  c_hco_d_packet_mailing
    IS
    SELECT  pm.dim_packet_mailing_id,
            pm.date_requested,
            pm.vendor_received_date,
            pm.date_mailed,
            pm.modified_date,
            mct.mail_id,
            mct.client_number,
            mct.case_id,
            ec.case_number,
            MAX(mct.mt_modified_date)                                           AS  MAIL_TRANSACTION_DATE,
            MAX(mct.mail_response_packet_date)                                  AS  MAIL_RESPONSE_PACKET_DATE,
            MAX(mct.enrollment_id)                                              AS  ENROLLMENT_ID,
            MAX(mct.exemption_id)                                               AS  EXEMPTION_ID                                    
      FROM  HCO_D_PACKET_MAILING        pm,
            HCO_MAIL_CLIENT_TRANS       mct,
            EMRS_D_CASE                 ec
     WHERE  pm.record_date   >=         CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_date
                                        (
                                            p_NAME  =>  'MW_ETL_DATA_START_DATE'
                                        )                
       AND  pm.modified_date   >=       CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_date
                                        (
                                            p_NAME  =>  'MW_LETTER_MAILING_PROC_DATE'
                                        )
       AND  pm.mail_status      =       'DONE'
       AND  pm.dcin             =       mct.mail_id
       AND  pm.case_id          =       mct.case_id
       AND  ec.case_id          =       mct.case_id
     GROUP
        BY  pm.dim_packet_mailing_id,
            pm.date_requested,
            pm.vendor_received_date,
            pm.date_mailed,
            pm.modified_date,
            mct.mail_id,
            mct.client_number,
            mct.case_id,
            ec.case_number;    

    PROCEDURE   ins_hco_activity_queue
                (
                    p_ACT_STATUS                        IN                      HCO_ACTIVITY_QUEUE.act_status%TYPE,
                    p_ACT_STATUS_TS                     IN                      HCO_ACTIVITY_QUEUE.act_status_ts%TYPE,
                    p_ACT_OWNER                         IN                      HCO_ACTIVITY_QUEUE.act_owner%TYPE,
                    p_ACT_TEAM_ID                       IN                      HCO_ACTIVITY_QUEUE.act_team_id%TYPE,
                    p_ACT_CASE_ID                       IN                      HCO_ACTIVITY_QUEUE.act_case_id%TYPE,
                    p_ACT_CLIENT_ID                     IN                      HCO_ACTIVITY_QUEUE.act_client_id%TYPE,
                    p_ACT_DCN                           IN                      HCO_ACTIVITY_QUEUE.act_dcn%TYPE,
                    p_ACT_REF_ID                        IN                      HCO_ACTIVITY_QUEUE.act_ref_id%TYPE,
                    p_ACT_REF_TYPE                      IN                      HCO_ACTIVITY_QUEUE.act_ref_type%TYPE,
                    p_ACT_STEP_DEFINITION_ID            IN                      HCO_ACTIVITY_QUEUE.act_step_definition_id%TYPE,
                    p_ACT_PROCESS_ID                    IN                      HCO_ACTIVITY_QUEUE.act_process_id%TYPE,                    
                    p_ACT_CREATED_BY                    IN                      HCO_ACTIVITY_QUEUE.act_created_by%TYPE,
                    p_ACT_CREATE_TS                     IN                      HCO_ACTIVITY_QUEUE.act_create_ts%TYPE,                    
                    p_ACT_COMMENTS                      IN                      HCO_ACTIVITY_QUEUE.act_comments%TYPE,
                    p_ACT_STEP_SEQUENCE			        IN			            HCO_ACTIVITY_QUEUE.step_sequence%TYPE DEFAULT 1
                );

    PROCEDURE   proc_emrs_d_exemption_req;
    PROCEDURE   proc_emrs_d_exempt_status_hist;
    PROCEDURE   proc_emrs_d_exempt_status_hist_activity_six;

    PROCEDURE   proc_emrs_d_emrgcy_disenroll;
    PROCEDURE   proc_emrs_d_emrgcy_denr_hist;

    PROCEDURE   proc_emrs_f_enrollment;

    PROCEDURE   proc_return_mail;

    PROCEDURE   proc_hco_d_letter_mailing;
    PROCEDURE   proc_hco_d_packet_mailing;

    PROCEDURE   ins_step_instance_stg;

    FUNCTION    step_inst_hist_rec_exists
                (
                    p_REF_ID                            IN                      STEP_INSTANCE.ref_id%TYPE,
                    p_REF_TYPE                          IN                      STEP_INSTANCE.ref_type%TYPE,
                    p_STEP_DEFINITION_ID                IN                      STEP_INSTANCE.step_definition_id%TYPE,
                    p_CREATE_TS                         IN                      STEP_INSTANCE.create_ts%TYPE,                    
                    p_STATUS                            IN                      STEP_INSTANCE.status%TYPE,
                    p_STATUS_TS                         IN                      STEP_INSTANCE.status_ts%TYPE,
                    p_STEP_SEQUENCE			            IN			            STEP_INSTANCE.step_sequence%TYPE DEFAULT 1
                )
    RETURN                                                                      PLS_INTEGER;

    FUNCTION    map_hco_process_instance
                (
                    p_HCO_PROCESS_ID                    IN                      D_HCO_PROCESS_INSTANCE.hco_process_id%TYPE,
                    p_DCN                               IN                      D_HCO_PROCESS_INSTANCE.dcn%TYPE,
                    p_CLIENT_NUMBER                     IN                      D_HCO_PROCESS_INSTANCE.client_number%TYPE,
                    p_CASE_NUMBER                       IN                      D_HCO_PROCESS_INSTANCE.case_number%TYPE,
                    p_REF_TYPE                          IN                      D_HCO_PROCESS_INSTANCE.ref_type%TYPE,
                    p_REF_ID                            IN                      D_HCO_PROCESS_INSTANCE.ref_id%TYPE,
                    p_INS_IF_NOT_EXISTS                 IN                      PLS_INTEGER                                                 DEFAULT CAHCO_ETL_MW_UTIL_PKG.is_false

                )                    
    RETURN                                                                      D_HCO_PROCESS_INSTANCE.hco_process_instance_id%TYPE;

    FUNCTION    get_dcn_date
                (
                    p_DCN                               IN                      D_HCO_PROCESS_INSTANCE.dcn%TYPE
                )
    RETURN                                                                      DATE;

    PROCEDURE   proc_hco_activity_queue
                (
                    p_BATCH_SIZE                        IN                      NUMBER,
                    p_DML_OPERATION                     IN                      VARCHAR2
                );

    PROCEDURE   refresh_groups;
    PROCEDURE   generate_step_instances;

    FUNCTION    get_most_recent_step_or_activity
                (
                    p_REF_ID                            IN                      STEP_INSTANCE.ref_id%TYPE,
                    p_REF_TYPE                          IN                      STEP_INSTANCE.ref_type%TYPE,
                    p_STEP_DEFINITION_ID                IN                      STEP_INSTANCE.step_definition_id%TYPE   
                )
    RETURN                                                                      step_activity_info_rec;
    
    FUNCTION    is_exemption_status_code_a_duplicate
                (
                    
                    p_EXEMPTION_HIST_ID                         IN                 emrs_d_exempt_status_hist.exemption_hist_id%TYPE,
                    p_EXEMPTION_ID                         	IN                 emrs_d_exempt_status_hist.exemption_id%TYPE,
                    p_STATUS_CODE                     		IN                 emrs_d_exempt_status_hist.exemption_status_code%TYPE
                      
                )
    RETURN                                                                      PLS_INTEGER;


    FUNCTION    is_eder_status_code_a_duplicate
                (
                    
                    p_EDER_HIST_ID                      	IN                 EMRS_D_EMRGCY_DENR_HIST.emrgcy_denr_hist_id%TYPE,
                    p_EDER_ID                         		IN                 EMRS_D_EMRGCY_DENR_HIST.emrgcy_denr_id%TYPE,
                    p_STATUS_CODE                     		IN                 EMRS_D_EMRGCY_DENR_HIST.emrgcy_denr_status_code%TYPE
                      
                )
    RETURN                                                                      PLS_INTEGER;

    FUNCTION    evaluate_ownership_change
                (
                    p_CURR_OWNER                        IN                      STEP_INSTANCE.owner%TYPE,
                    p_NEW_OWNER                         IN                      STEP_INSTANCE.owner%TYPE
                )
    RETURN                                                                      STEP_INSTANCE.owner%TYPE;
    
    PROCEDURE   analyze_pended_enrollments
                (
                    p_BATCH_SIZE                        IN                      NUMBER
                );

    PROCEDURE   mrg_staff_key_lkup
                (
                    p_STAFF_KEY                         IN                      STAFF_KEY_LKUP.staff_key%TYPE
                );

END CAHCO_ETL_MW_PKG;
/
create or replace PACKAGE BODY CAHCO_ETL_MW_PKG AS

    c_package_name                                                              VARCHAR2(100)                           :=                  $$plsql_unit;

    c_automated_process                                                         VARCHAR2(40)                            :=                  'AUTOMATED_PROCESS';
    c_letter_mailing                                                            VARCHAR2(40)                            :=                  'Letter Mailing';
    c_packet_mailing                                                            VARCHAR2(40)                            :=                  'Packet Mailing';
    c_eder                                                                      VARCHAR2(40)                            :=                  'EDER';
    c_exemption                                                                 VARCHAR2(40)                            :=                  'Exemption';
    c_enrollment                                                                VARCHAR2(40)                            :=                  'Enrollment';
    c_disenrollment                                                             VARCHAR2(40)                            :=                  'Disenrollment';
    c_case                                                                      VARCHAR2(40)                            :=                  'Case';
    c_mail_returned                                                             VARCHAR2(40)                            :=                  'Mail Returned';    
    /*****************************************************************************************************************************************************************

        NAME:           hco_activity_queue_rec_exists
        DESCRIPTION:    Determine whether the record exists in the HCO activity queue.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     03/19/2019              Created function.

    *****************************************************************************************************************************************************************/
    FUNCTION    hco_activity_queue_rec_exists
                (
                    p_ACT_REF_ID                        IN                      HCO_ACTIVITY_QUEUE.act_ref_id%TYPE,
                    p_ACT_REF_TYPE                      IN                      HCO_ACTIVITY_QUEUE.act_ref_type%TYPE,
                    p_ACT_STEP_DEFINITION_ID            IN                      HCO_ACTIVITY_QUEUE.act_step_definition_id%TYPE,
                    p_ACT_STATUS                        IN                      HCO_ACTIVITY_QUEUE.act_status%TYPE,
                    p_ACT_PROCESS_ID                    IN                      HCO_ACTIVITY_QUEUE.act_process_id%TYPE,
                    p_ACT_STEP_SEQUENCE			        IN			            HCO_ACTIVITY_QUEUE.step_sequence%TYPE	DEFAULT 1	
                )
    RETURN                                                                      PLS_INTEGER
    IS
        l_hco_activity_queue_rec_exists                                         PLS_INTEGER                                                 DEFAULT CAHCO_ETL_MW_UTIL_PKG.is_false;
    BEGIN

        BEGIN

            SELECT  MAX(CAHCO_ETL_MW_UTIL_PKG.is_true)
              INTO  l_hco_activity_queue_rec_exists
              FROM  HCO_ACTIVITY_QUEUE                      haq
             WHERE  haq.act_ref_id                      =   p_ACT_REF_ID
               AND  haq.act_ref_type                    =   p_ACT_REF_TYPE
               AND  haq.act_step_definition_id          =   p_ACT_STEP_DEFINITION_ID
               AND  haq.act_status                      =   p_ACT_STATUS
               AND  haq.act_process_id                  =   p_ACT_PROCESS_ID
	       AND  haq.step_sequence			=   p_ACT_STEP_SEQUENCE;

            l_hco_activity_queue_rec_exists :=  NVL( l_hco_activity_queue_rec_exists, CAHCO_ETL_MW_UTIL_PKG.is_false);

        EXCEPTION

            WHEN    NO_DATA_FOUND
            THEN    l_hco_activity_queue_rec_exists     :=  CAHCO_ETL_MW_UTIL_PKG.is_false;  

        END;

        RETURN  l_hco_activity_queue_rec_exists;  

    END         hco_activity_queue_rec_exists;
    /*****************************************************************************************************************************************************************

        NAME:           ins_hco_activity_queue
        DESCRIPTION:    Insert a record into the table INS_HCO_ACTIVITY_QUEUE.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created procedure.
        TAM                     06/20/2019              Corrected issue with INSERT into HCO_ACTIVITY_QUEUE:  Replaced reference to p_ACT_CREATED_BY with
                                                        l_act_created_by.

    *****************************************************************************************************************************************************************/
    PROCEDURE   ins_hco_activity_queue
                (
                    p_ACT_STATUS                        IN                      HCO_ACTIVITY_QUEUE.act_status%TYPE,
                    p_ACT_STATUS_TS                     IN                      HCO_ACTIVITY_QUEUE.act_status_ts%TYPE,
                    p_ACT_OWNER                         IN                      HCO_ACTIVITY_QUEUE.act_owner%TYPE,
                    p_ACT_TEAM_ID                       IN                      HCO_ACTIVITY_QUEUE.act_team_id%TYPE,
                    p_ACT_CASE_ID                       IN                      HCO_ACTIVITY_QUEUE.act_case_id%TYPE,
                    p_ACT_CLIENT_ID                     IN                      HCO_ACTIVITY_QUEUE.act_client_id%TYPE,
                    p_ACT_DCN                           IN                      HCO_ACTIVITY_QUEUE.act_dcn%TYPE,
                    p_ACT_REF_ID                        IN                      HCO_ACTIVITY_QUEUE.act_ref_id%TYPE,
                    p_ACT_REF_TYPE                      IN                      HCO_ACTIVITY_QUEUE.act_ref_type%TYPE,
                    p_ACT_STEP_DEFINITION_ID            IN                      HCO_ACTIVITY_QUEUE.act_step_definition_id%TYPE,
                    p_ACT_PROCESS_ID                    IN                      HCO_ACTIVITY_QUEUE.act_process_id%TYPE,                    
                    p_ACT_CREATED_BY                    IN                      HCO_ACTIVITY_QUEUE.act_created_by%TYPE,
                    p_ACT_CREATE_TS                     IN                      HCO_ACTIVITY_QUEUE.act_create_ts%TYPE,                    
                    p_ACT_COMMENTS                      IN                      HCO_ACTIVITY_QUEUE.act_comments%TYPE,
                    p_ACT_STEP_SEQUENCE			        IN			            HCO_ACTIVITY_QUEUE.step_sequence%TYPE	DEFAULT 1	
                )
    IS
        l_step_inst_hist_rec_exists                                             PLS_INTEGER                                                 DEFAULT CAHCO_ETL_MW_UTIL_PKG.is_false;
        l_act_owner                                                             HCO_ACTIVITY_QUEUE.act_owner%TYPE;
        l_act_created_by                                                        HCO_ACTIVITY_QUEUE.act_created_by%TYPE;
    BEGIN
    
        IF
        (
                p_ACT_STATUS IS NULL
            OR  p_ACT_STATUS_TS IS NULL
            OR  p_ACT_CREATE_TS IS NULL
        )
        THEN
            CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'ins_hco_activity_queue', 'ERROR --> One or more of the parameters p_ACT_STATUS, P_ACT_STATUS_TS, p_ACT_CREATE_TS was deemed invalid while inserting a record into HCO_ACTIVITY_QUEUE for p_ACT_REF_TYPE = ' || p_ACT_REF_TYPE || ', p_ACT_REF_ID = ' || p_ACT_REF_ID || ', p_ACT_STEP_DEFINITION_ID = ' || p_ACT_STEP_DEFINITION_ID || ', p_ACT_STATUS = ' || p_ACT_STATUS || ', p_ACT_STATUS_TS = ' || TO_CHAR(p_ACT_STATUS_TS, 'YYYY-MM-DD HH24:MI:SS') || ', p_ACT_CREATE_TS = ' || TO_CHAR(p_ACT_CREATE_TS, 'YYYY-MM-DD HH24:MI:SS'), CAHCO_ETL_MW_UTIL_PKG.get_log_message_type_error);
            RETURN;
        END IF;

        l_act_owner  :=     CAHCO_ETL_MW_UTIL_PKG.format_staff_string
                            (
                                p_staff_string      =>  p_ACT_OWNER
                            );

        l_act_created_by    :=  CAHCO_ETL_MW_UTIL_PKG.format_staff_string
                                (
                                    p_staff_string      =>  p_ACT_CREATED_BY
                                );

        IF  p_ACT_STATUS IS NOT NULL
        THEN
            l_step_inst_hist_rec_exists :=  step_inst_hist_rec_exists
                                            (
                                                p_REF_ID                =>  p_ACT_REF_ID, 
                                                p_REF_TYPE              =>  p_ACT_REF_TYPE, 
                                                p_STEP_DEFINITION_ID    =>  p_ACT_STEP_DEFINITION_ID, 
                                                p_CREATE_TS             =>  p_ACT_STATUS_TS,
                                                p_STATUS                =>  p_ACT_STATUS, 
                                                p_STATUS_TS             =>  p_ACT_STATUS_TS,
                                                p_STEP_SEQUENCE		    =>  p_ACT_STEP_SEQUENCE
                                            );

        ELSE

            l_step_inst_hist_rec_exists :=  CAHCO_ETL_MW_UTIL_PKG.is_false;

        END IF;

        IF  l_step_inst_hist_rec_exists = CAHCO_ETL_MW_UTIL_PKG.is_false
        THEN

            INSERT
              INTO  HCO_ACTIVITY_QUEUE          (   act_status,     act_status_ts,      act_owner,      act_team_id,        act_case_id,        act_client_id,      act_dcn,        act_ref_id,     act_ref_type,       act_step_definition_id,     act_process_id,     act_created_by,     act_create_ts,      act_comments,		step_sequence    )
            VALUES                              (   p_ACT_STATUS,   p_ACT_STATUS_TS,    l_act_owner,    p_ACT_TEAM_ID,      p_ACT_CASE_ID,      p_ACT_CLIENT_ID,    p_ACT_DCN,      p_ACT_REF_ID,   p_ACT_REF_TYPE,     p_ACT_STEP_DEFINITION_ID,   p_ACT_PROCESS_ID,   p_act_created_by,   p_ACT_CREATE_TS,    p_ACT_COMMENTS,		case when p_ACT_step_sequence is not null then p_ACT_step_sequence else 1 end );          

        END IF;            

    END         ins_hco_activity_queue;
    /*****************************************************************************************************************************************************************

        NAME:           upd_hco_activity_queue
        DESCRIPTION:    Update date the record in HCO_ACTIVITY_QUEUE that corresponds to p_HCO_ACTIVITY_QUEUE_ID.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created procedure.

    *****************************************************************************************************************************************************************/
    PROCEDURE   upd_hco_activity_queue
                (
                    p_HCO_ACTIVITY_QUEUE_ID             IN                      HCO_ACTIVITY_QUEUE.hco_activity_queue_id%TYPE,
                    p_REC_STATUS                        IN                      HCO_ACTIVITY_QUEUE.rec_status%TYPE
                )
    IS
    BEGIN
    
        UPDATE  HCO_ACTIVITY_QUEUE         
           SET  rec_status                              =   p_REC_STATUS
         WHERE  hco_activity_queue_id                   =   p_HCO_ACTIVITY_QUEUE_ID;

    END         upd_hco_activity_queue;
    /*****************************************************************************************************************************************************************

        NAME:           step_inst_hist_rec_exists
        DESCRIPTION:    Determine whether the step instance record exists in history.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created function.

    *****************************************************************************************************************************************************************/
    FUNCTION    step_inst_hist_rec_exists
                (
                    p_REF_ID                            IN                      STEP_INSTANCE.ref_id%TYPE,
                    p_REF_TYPE                          IN                      STEP_INSTANCE.ref_type%TYPE,
                    p_STEP_DEFINITION_ID                IN                      STEP_INSTANCE.step_definition_id%TYPE,
                    p_CREATE_TS                         IN                      STEP_INSTANCE.create_ts%TYPE,                    
                    p_STATUS                            IN                      STEP_INSTANCE.status%TYPE,
                    p_STATUS_TS                         IN                      STEP_INSTANCE.status_ts%TYPE,
		    p_STEP_SEQUENCE			IN			STEP_INSTANCE.step_sequence%TYPE	DEFAULT 1	
                )
    RETURN                                                                      PLS_INTEGER
    IS
        l_step_inst_hist_rec_exists                                             PLS_INTEGER                                                 DEFAULT CAHCO_ETL_MW_UTIL_PKG.is_false;
    BEGIN

        BEGIN

            SELECT  CAHCO_ETL_MW_UTIL_PKG.is_true
              INTO  l_step_inst_hist_rec_exists 
              FROM  DUAL
             WHERE  EXISTS  (
                                SELECT  1
                                  FROM  STEP_INSTANCE                   si,
                                        STEP_INSTANCE_HISTORY           sih
                                 WHERE  si.ref_type                 =   p_REF_TYPE
                                   AND  si.ref_id                   =   p_REF_ID
                                   AND  si.step_definition_id       =   p_STEP_DEFINITION_ID
                                   AND  si.create_ts                =   p_CREATE_TS
                                   AND  si.status                   !=  p_STATUS
                                   AND  si.step_instance_id         =   sih.step_instance_id
                                   AND  sih.status                  =   p_STATUS
                                   AND  sih.create_ts               =   p_STATUS_TS
				   AND si.step_sequence 	    =   case when p_STEP_SEQUENCE is null then 1 else p_STEP_SEQUENCE end 
                            );

        EXCEPTION

            WHEN    NO_DATA_FOUND
            THEN    l_step_inst_hist_rec_exists :=  CAHCO_ETL_MW_UTIL_PKG.is_false;

        END;

        RETURN  l_step_inst_hist_rec_exists;

    END         step_inst_hist_rec_exists;
    /*****************************************************************************************************************************************************************

        NAME:           get_cur_step_instance_status
        DESCRIPTION:    Get the current step instance status.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created function.

    *****************************************************************************************************************************************************************/
    FUNCTION    get_cur_step_instance_status
                (
                    p_REF_ID                            IN                      STEP_INSTANCE.ref_id%TYPE,
                    p_REF_TYPE                          IN                      STEP_INSTANCE.ref_type%TYPE,
                    p_STEP_DEFINITION_ID                IN                      STEP_INSTANCE.step_definition_id%TYPE,
                    p_PROCESS_ID                        IN                      STEP_INSTANCE.process_id%TYPE,                    
                    p_CREATE_TS                         IN                      STEP_INSTANCE.create_ts%TYPE,
		    p_STEP_SEQUENCE			IN			STEP_INSTANCE.step_sequence%TYPE	DEFAULT 1
                )
    RETURN                                                                      STEP_INSTANCE.status%TYPE
    IS
        l_cur_step_instance_status                                              STEP_INSTANCE.status%TYPE                                   DEFAULT CAHCO_ETL_MW_UTIL_PKG.get_mw_status_unclaimed;
    BEGIN

        BEGIN

            SELECT  si.status
              INTO  l_cur_step_instance_status
              FROM  STEP_INSTANCE                                       si
             WHERE  si.ref_id                                       =   p_REF_ID
               AND  si.ref_type                                     =   p_REF_TYPE
               AND  si.step_definition_id                           =   p_STEP_DEFINITION_ID
               AND  si.process_id                                   =   p_PROCESS_ID
               AND  si.create_ts                                    =   p_CREATE_TS
	       AND  si.step_sequence				    =   p_STEP_SEQUENCE;

        EXCEPTION

            WHEN    NO_DATA_FOUND
            THEN    l_cur_step_instance_status  :=  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_unclaimed;

        END;

        RETURN  l_cur_step_instance_status;

    END         get_cur_step_instance_status;
    /*****************************************************************************************************************************************************************

        NAME:           evaluate_ownership_change
        DESCRIPTION:    Evaluate the proposed ownership change from p_OLD_OWNER to p_NEW_OWNER.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     09/24/2019              Created function.

    *****************************************************************************************************************************************************************/
    FUNCTION    evaluate_ownership_change
                (
                    p_CURR_OWNER                        IN                      STEP_INSTANCE.owner%TYPE,
                    p_NEW_OWNER                         IN                      STEP_INSTANCE.owner%TYPE
                )
    RETURN                                                                      STEP_INSTANCE.owner%TYPE            
    IS
        l_resultant_owner                                                       STEP_INSTANCE.owner%TYPE;
        l_new_owner_staff_id                                                    STAFF_KEY_LKUP.staff_id%TYPE;
        l_curr_owner_staff_id                                                   STAFF_KEY_LKUP.staff_id%TYPE;        
    BEGIN
    
        /*
            
            LOGIC:
            
            If there is no current owner, then automatically set the resultant owner to the new owner.
            
            Otherwise:
            
            If the new owner is a system process user, then set the resultant owner to the current owner, if the user if the current owner is
            not the unknown or system process user.
            Otherwise, set the resulstant owner to the new owner.
            
        */
    
        IF
        (
            p_CURR_OWNER IS NULL
        )
        THEN
            l_resultant_owner   :=  p_NEW_OWNER;
        ELSE

            l_curr_owner_staff_id    :=
            
            CAHCO_ETL_MW_UTIL_PKG.get_staff_key_lkup_staff_id
            (
                p_STAFF_KEY                         =>  p_CURR_OWNER
            );
        
            l_new_owner_staff_id    :=
            
            CAHCO_ETL_MW_UTIL_PKG.get_staff_key_lkup_staff_id
            (
                p_STAFF_KEY                         =>  p_NEW_OWNER
            );
        
            IF
            (
                    l_new_owner_staff_id    =   CAHCO_ETL_MW_UTIL_PKG.get_system_process_staff_id
                AND l_curr_owner_staff_id NOT IN (CAHCO_ETL_MW_UTIL_PKG.get_unknown_staff_id, CAHCO_ETL_MW_UTIL_PKG.get_system_process_staff_id)
            )
            THEN
                l_resultant_owner   :=  p_CURR_OWNER;
            ELSE
                l_resultant_owner   :=  p_NEW_OWNER;
            END IF;
        
        END IF;
    
        RETURN  l_resultant_owner;
    
    END         evaluate_ownership_change;
    /*****************************************************************************************************************************************************************

        NAME:           mrg_staff_key_lkup
        DESCRIPTION:    Upsert a record into the table STAFF_KEY_LKUP.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created procedure.
        TAM                     01/23/2020              MAXDAT-9942:  Separated function call to CAHCO_ETL_MW_UTIL_PKG.get_staff_id from MERGE statement to prevent
                                                        trigger mutation.
    *****************************************************************************************************************************************************************/
    PROCEDURE   mrg_staff_key_lkup
                (
                    p_STAFF_KEY                         IN                      STAFF_KEY_LKUP.staff_key%TYPE
                )
    IS
        l_staff_id                                                              STAFF_KEY_LKUP.staff_id%TYPE;
    BEGIN

        IF  p_STAFF_KEY IS NOT NULL
        THEN

            l_staff_id  :=
            
            CAHCO_ETL_MW_UTIL_PKG.get_staff_id( p_EXT_STAFF_NUMBER  =>  p_STAFF_KEY );

            MERGE 
            INTO        STAFF_KEY_LKUP                                                                                  d
            USING       (
                            SELECT  l_staff_id                                                                      AS  STAFF_ID,
                                    p_STAFF_KEY                                                                     AS  STAFF_KEY
                              FROM  DUAL
                        )                                               s
            ON          (
                                d.staff_key                         =   s.staff_key
                        )                                                   

            WHEN MATCHED THEN UPDATE SET

                d.staff_id                                          =   s.staff_id

            WHEN NOT MATCHED THEN INSERT
                (
                    d.staff_id,
                    d.staff_key    
                )   
            VALUES 
                (
                    s.staff_id,
                    s.staff_key                    
                );

        END IF;

    END         mrg_staff_key_lkup;
    /*****************************************************************************************************************************************************************

        NAME:           map_hco_process_instance
        DESCRIPTION:    Return a value for HCO_PROCESS_INSTANCE_ID from the table D_HCO_PROCESS_INSTANCE.  If p_INS_IF_NOT_EXISTS is TRUE, then a record is
                        inserted.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created function.

    *****************************************************************************************************************************************************************/
    FUNCTION    map_hco_process_instance
                (
                    p_HCO_PROCESS_ID                    IN                      D_HCO_PROCESS_INSTANCE.hco_process_id%TYPE,
                    p_DCN                               IN                      D_HCO_PROCESS_INSTANCE.dcn%TYPE,
                    p_CLIENT_NUMBER                     IN                      D_HCO_PROCESS_INSTANCE.client_number%TYPE,
                    p_CASE_NUMBER                       IN                      D_HCO_PROCESS_INSTANCE.case_number%TYPE,                    
                    p_REF_TYPE                          IN                      D_HCO_PROCESS_INSTANCE.ref_type%TYPE,
                    p_REF_ID                            IN                      D_HCO_PROCESS_INSTANCE.ref_id%TYPE,
                    p_INS_IF_NOT_EXISTS                 IN                      PLS_INTEGER                                                 DEFAULT CAHCO_ETL_MW_UTIL_PKG.is_false

                )                    
    RETURN                                                                      D_HCO_PROCESS_INSTANCE.hco_process_instance_id%TYPE                                                             
    IS

        l_hco_process_id                                                        D_HCO_PROCESS_INSTANCE.hco_process_id%TYPE                  DEFAULT p_HCO_PROCESS_ID;
        l_dcn                                                                   D_HCO_PROCESS_INSTANCE.dcn%TYPE                             DEFAULT NVL(p_DCN, CAHCO_ETL_MW_UTIL_PKG.get_unknown_dcn);
        l_client_number                                                         D_HCO_PROCESS_INSTANCE.client_number%TYPE                   DEFAULT NVL(p_CLIENT_NUMBER, CAHCO_ETL_MW_UTIL_PKG.get_unknown_client_number); 
        l_case_number                                                           D_HCO_PROCESS_INSTANCE.case_number%TYPE                     DEFAULT NVL(p_CASE_NUMBER, CAHCO_ETL_MW_UTIL_PKG.get_unknown_case_number);         
        l_ref_type                                                              D_HCO_PROCESS_INSTANCE.ref_type%TYPE                        DEFAULT NVL(p_REF_TYPE, CAHCO_ETL_MW_UTIL_PKG.get_unknown_ref_type);
        l_ref_id                                                                D_HCO_PROCESS_INSTANCE.ref_id%TYPE                          DEFAULT NVL(p_REF_ID, CAHCO_ETL_MW_UTIL_PKG.get_unknown_ref_id);
        l_hco_process_instance_id                                               D_HCO_PROCESS_INSTANCE.hco_process_instance_id%TYPE;

    BEGIN

        BEGIN

            SELECT  mhpi.hco_process_instance_id
              INTO  l_hco_process_instance_id
              FROM  D_HCO_PROCESS_INSTANCE                      mhpi
             WHERE  mhpi.hco_process_id                     =   l_hco_process_id
               AND  mhpi.dcn                                =   l_dcn
               AND  mhpi.client_number                      =   l_client_number
               AND  mhpi.case_number                        =   l_case_number
               AND  mhpi.ref_type                           =   l_ref_type
               AND  mhpi.ref_id                             =   l_ref_id;

        EXCEPTION

            WHEN    NO_DATA_FOUND
            THEN    l_hco_process_instance_id    :=  NULL;

        END;

        IF      l_hco_process_instance_id IS NULL
            AND p_INS_IF_NOT_EXISTS =   CAHCO_ETL_MW_UTIL_PKG.is_true
        THEN

            INSERT
              INTO  D_HCO_PROCESS_INSTANCE  (   hco_process_instance_id,                hco_process_id,         dcn,        client_number,      case_number,    ref_type,       ref_id      )
            VALUES                          (   SEQ_HCO_PROCESS_INSTANCE_ID.nextval,    l_hco_process_id,       l_dcn,      l_client_number,    l_case_number,  l_ref_type,     l_ref_id    )
            RETURNING   hco_process_instance_id
            INTO        l_hco_process_instance_id;

        END IF;        

        RETURN  l_hco_process_instance_id;

    END         map_hco_process_instance;
    /*****************************************************************************************************************************************************************

        NAME:           mrg_step_instance
        DESCRIPTION:    Upsert a record into the table STEP_INSTANCE.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created procedure.

    *****************************************************************************************************************************************************************/
    PROCEDURE   mrg_step_instance
                (
                    p_STATUS                            IN                      STEP_INSTANCE.status%TYPE,
                    p_STATUS_TS                         IN                      STEP_INSTANCE.status_ts%TYPE,
                    p_ESCALATED_IND                     IN                      STEP_INSTANCE.escalated_ind%TYPE,
                    p_STEP_DUE_TS                       IN                      STEP_INSTANCE.step_due_ts%TYPE,
                    p_FORWARDED_IND                     IN                      STEP_INSTANCE.forwarded_ind%TYPE,
                    p_ESCALATE_TO                       IN                      STEP_INSTANCE.escalate_to%TYPE,
                    p_FORWARDED_BY                      IN                      STEP_INSTANCE.forwarded_by%TYPE,
                    p_OWNER                             IN                      STEP_INSTANCE.owner%TYPE,
                    p_LOCKED_ID                         IN                      STEP_INSTANCE.locked_id%TYPE,
                    p_GROUP_STEP_DEFINITION_ID          IN                      STEP_INSTANCE.group_step_definition_id%TYPE,
                    p_GROUP_ID                          IN                      STEP_INSTANCE.group_id%TYPE,
                    p_TEAM_ID                           IN                      STEP_INSTANCE.team_id%TYPE,
                    p_PROCESS_ID                        IN                      STEP_INSTANCE.process_id%TYPE,
                    p_PRIORITY_CD                       IN                      STEP_INSTANCE.priority_cd%TYPE,
                    p_PROCESS_ROUTER_ID                 IN                      STEP_INSTANCE.process_router_id%TYPE,
                    p_PROCESS_INSTANCE_ID               IN                      STEP_INSTANCE.process_instance_id%TYPE,
                    p_CASE_ID                           IN                      STEP_INSTANCE.case_id%TYPE,
                    p_CLIENT_ID                         IN                      STEP_INSTANCE.client_id%TYPE,
                    p_REF_ID                            IN                      STEP_INSTANCE.ref_id%TYPE,
                    p_REF_TYPE                          IN                      STEP_INSTANCE.ref_type%TYPE,
                    p_STEP_DEFINITION_ID                IN                      STEP_INSTANCE.step_definition_id%TYPE,
                    p_CREATED_BY                        IN                      STEP_INSTANCE.created_by%TYPE,
                    p_CREATE_TS                         IN                      STEP_INSTANCE.create_ts%TYPE,
                    p_SUSPENDED_TS                      IN                      STEP_INSTANCE.suspended_ts%TYPE,
                    p_COMMENTS                          IN                      STEP_INSTANCE.comments%TYPE,
                    p_CREATE_NDT                        IN                      STEP_INSTANCE.create_ndt%TYPE,
                    p_STEP_DUE_NDT                      IN                      STEP_INSTANCE.step_due_ndt%TYPE,
                    p_DCN                               IN                      STEP_INSTANCE.dcn%TYPE,
                    p_DOCUMENT_RECEIVED_DATE            IN                      STEP_INSTANCE.document_received_date%TYPE,
                    p_STEP_SEQUENCE			            IN			            STEP_INSTANCE.step_sequence%TYPE	                DEFAULT 1,
                    p_DML_OPERATION                     IN                      VARCHAR2                                            DEFAULT NULL,
                    p_SUCCESS                                       OUT         VARCHAR2
                )
    IS
    BEGIN

        p_SUCCESS   :=  CAHCO_ETL_MW_UTIL_PKG.is_yes;

        IF      p_DML_OPERATION IS NULL
        THEN

            MERGE 
            INTO        STEP_INSTANCE                                   d
            USING       (
                            SELECT  p_STATUS                        AS  STATUS,
                                    p_STATUS_TS                     AS  STATUS_TS,
                                    p_ESCALATED_IND                 AS  ESCALATED_IND,
                                    p_STEP_DUE_TS                   AS  STEP_DUE_TS,
                                    p_FORWARDED_IND                 AS  FORWARDED_IND,
                                    p_ESCALATE_TO                   AS  ESCALATE_TO,
                                    p_FORWARDED_BY                  AS  FORWARDED_BY,
                                    p_OWNER                         AS  OWNER,
                                    p_LOCKED_ID                     AS  LOCKED_ID,
                                    p_GROUP_STEP_DEFINITION_ID      AS  GROUP_STEP_DEFINITION_ID,    
                                    p_GROUP_ID                      AS  GROUP_ID,
                                    p_TEAM_ID                       AS  TEAM_ID,
                                    p_PROCESS_ID                    AS  PROCESS_ID,
                                    p_PRIORITY_CD                   AS  PRIORITY_CD,
                                    p_PROCESS_ROUTER_ID             AS  PROCESS_ROUTER_ID,
                                    p_PROCESS_INSTANCE_ID           AS  PROCESS_INSTANCE_ID,
                                    p_CASE_ID                       AS  CASE_ID,
                                    p_CLIENT_ID                     AS  CLIENT_ID,
                                    p_REF_ID                        AS  REF_ID,
                                    p_REF_TYPE                      AS  REF_TYPE,
                                    p_STEP_DEFINITION_ID            AS  STEP_DEFINITION_ID,
                                    p_CREATED_BY                    AS  CREATED_BY,
                                    p_CREATE_TS                     AS  CREATE_TS,
                                    p_SUSPENDED_TS                  AS  SUSPENDED_TS,
                                    p_COMMENTS                      AS  COMMENTS,
                                    p_CREATE_NDT                    AS  CREATE_NDT,
                                    p_STEP_DUE_NDT                  AS  STEP_DUE_NDT,
                                    p_DCN                           AS  DCN,
                                    p_DOCUMENT_RECEIVED_DATE        AS  DOCUMENT_RECEIVED_DATE,
                                    p_STEP_SEQUENCE			        AS  STEP_SEQUENCE	
                              FROM  DUAL
                        )                                               s
            ON          (
                                d.ref_type                          =   s.ref_type 
                            AND d.ref_id                            =   s.ref_id
                            AND d.step_definition_id                =   s.step_definition_id   
                            AND d.process_id                        =   s.process_id
                            AND d.process_instance_id               =   s.process_instance_id
                            AND d.create_ts                         =   s.create_ts
                            AND d.step_sequence			            =   s.step_sequence
                        )                                               
            WHEN MATCHED THEN UPDATE SET

                d.status                                            =   s.STATUS,
                d.status_ts                                         =   s.STATUS_TS,
                d.escalated_ind                                     =   s.ESCALATED_IND,
                d.step_due_ts                                       =   s.STEP_DUE_TS,
                d.forwarded_ind                                     =   s.FORWARDED_IND,
                d.escalate_to                                       =   s.ESCALATE_TO,
                d.forwarded_by                                      =   s.FORWARDED_BY,
                d.owner                                             =   s.OWNER,
                d.locked_id                                         =   s.LOCKED_ID,
                d.group_step_definition_id                          =   s.GROUP_STEP_DEFINITION_ID,    
                d.group_id                                          =   s.GROUP_ID,
                d.team_id                                           =   s.TEAM_ID,
                d.priority_cd                                       =   s.PRIORITY_CD,
                d.process_router_id                                 =   s.PROCESS_ROUTER_ID,
                d.case_id                                           =   s.CASE_ID,
                d.client_id                                         =   s.CLIENT_ID,
                d.suspended_ts                                      =   s.SUSPENDED_TS,
                d.comments                                          =   s.COMMENTS,
                d.create_ndt                                        =   s.CREATE_NDT,
                d.dcn                                               =   s.dcn,
                d.document_received_date                            =   s.document_received_date

            WHEN NOT MATCHED THEN INSERT
                (
                    d.step_instance_id,
                    d.status,
                    d.status_ts,
                    d.escalated_ind,
                    d.step_due_ts,
                    d.forwarded_ind,
                    d.escalate_to,
                    d.forwarded_by,
                    d.owner,
                    d.locked_id,
                    d.group_step_definition_id,
                    d.group_id,
                    d.team_id,
                    d.process_id,
                    d.priority_cd,
                    d.process_router_id,
                    d.process_instance_id,
                    d.case_id,
                    d.client_id,
                    d.ref_id,
                    d.ref_type,
                    d.step_definition_id,
                    d.created_by,
                    d.create_ts,                    
                    d.suspended_ts,
                    d.comments,
                    d.create_ndt,
                    d.step_due_ndt,
                    d.dcn,
                    d.document_received_date,
                    d.step_sequence

                )   
            VALUES 
                (

                    SEQ_STEP_INSTANCE_ID.nextval,
                    s.STATUS,
                    s.STATUS_TS,
                    s.ESCALATED_IND,
                    s.STEP_DUE_TS,
                    s.FORWARDED_IND,
                    s.ESCALATE_TO,
                    s.FORWARDED_BY,
                    s.OWNER,
                    s.LOCKED_ID,
                    s.GROUP_STEP_DEFINITION_ID,    
                    s.GROUP_ID,
                    s.TEAM_ID,
                    s.PROCESS_ID,
                    s.PRIORITY_CD,
                    s.PROCESS_ROUTER_ID,
                    s.PROCESS_INSTANCE_ID,
                    s.CASE_ID,
                    s.CLIENT_ID,
                    s.REF_ID,
                    s.REF_TYPE,
                    s.STEP_DEFINITION_ID,
                    s.CREATED_BY,
                    s.CREATE_TS,
                    s.SUSPENDED_TS,
                    s.COMMENTS,
                    s.CREATE_NDT,
                    s.STEP_DUE_NDT,
                    s.dcn,
                    s.document_received_date,
                    s.step_sequence    
                );

        ELSIF   p_DML_OPERATION   = 'I'
        THEN

            MERGE 
            INTO        STEP_INSTANCE                                   d
            USING       (
                            SELECT  p_STATUS                        AS  STATUS,
                                    p_STATUS_TS                     AS  STATUS_TS,
                                    p_ESCALATED_IND                 AS  ESCALATED_IND,
                                    p_STEP_DUE_TS                   AS  STEP_DUE_TS,
                                    p_FORWARDED_IND                 AS  FORWARDED_IND,
                                    p_ESCALATE_TO                   AS  ESCALATE_TO,
                                    p_FORWARDED_BY                  AS  FORWARDED_BY,
                                    p_OWNER                         AS  OWNER,
                                    p_LOCKED_ID                     AS  LOCKED_ID,
                                    p_GROUP_STEP_DEFINITION_ID      AS  GROUP_STEP_DEFINITION_ID,    
                                    p_GROUP_ID                      AS  GROUP_ID,
                                    p_TEAM_ID                       AS  TEAM_ID,
                                    p_PROCESS_ID                    AS  PROCESS_ID,
                                    p_PRIORITY_CD                   AS  PRIORITY_CD,
                                    p_PROCESS_ROUTER_ID             AS  PROCESS_ROUTER_ID,
                                    p_PROCESS_INSTANCE_ID           AS  PROCESS_INSTANCE_ID,
                                    p_CASE_ID                       AS  CASE_ID,
                                    p_CLIENT_ID                     AS  CLIENT_ID,
                                    p_REF_ID                        AS  REF_ID,
                                    p_REF_TYPE                      AS  REF_TYPE,
                                    p_STEP_DEFINITION_ID            AS  STEP_DEFINITION_ID,
                                    p_CREATED_BY                    AS  CREATED_BY,
                                    p_CREATE_TS                     AS  CREATE_TS,
                                    p_SUSPENDED_TS                  AS  SUSPENDED_TS,
                                    p_COMMENTS                      AS  COMMENTS,
                                    p_CREATE_NDT                    AS  CREATE_NDT,
                                    p_STEP_DUE_NDT                  AS  STEP_DUE_NDT,
                                    p_DCN                           AS  DCN,
                                    p_DOCUMENT_RECEIVED_DATE        AS  DOCUMENT_RECEIVED_DATE,
                                    p_STEP_SEQUENCE			        AS  STEP_SEQUENCE	
                              FROM  DUAL
                        )                                               s
            ON          (
                                d.ref_type                          =   s.ref_type 
                            AND d.ref_id                            =   s.ref_id
                            AND d.step_definition_id                =   s.step_definition_id   
                            AND d.process_id                        =   s.process_id
                            AND d.process_instance_id               =   s.process_instance_id
                            AND d.create_ts                         =   s.create_ts
                            AND d.step_sequence			            =   s.step_sequence
                        )                                               

            WHEN NOT MATCHED THEN INSERT
                (
                    d.step_instance_id,
                    d.status,
                    d.status_ts,
                    d.escalated_ind,
                    d.step_due_ts,
                    d.forwarded_ind,
                    d.escalate_to,
                    d.forwarded_by,
                    d.owner,
                    d.locked_id,
                    d.group_step_definition_id,
                    d.group_id,
                    d.team_id,
                    d.process_id,
                    d.priority_cd,
                    d.process_router_id,
                    d.process_instance_id,
                    d.case_id,
                    d.client_id,
                    d.ref_id,
                    d.ref_type,
                    d.step_definition_id,
                    d.created_by,
                    d.create_ts,                    
                    d.suspended_ts,
                    d.comments,
                    d.create_ndt,
                    d.step_due_ndt,
                    d.dcn,
                    d.document_received_date,
                    d.step_sequence

                )   
            VALUES 
                (

                    SEQ_STEP_INSTANCE_ID.nextval,
                    s.STATUS,
                    s.STATUS_TS,
                    s.ESCALATED_IND,
                    s.STEP_DUE_TS,
                    s.FORWARDED_IND,
                    s.ESCALATE_TO,
                    s.FORWARDED_BY,
                    s.OWNER,
                    s.LOCKED_ID,
                    s.GROUP_STEP_DEFINITION_ID,    
                    s.GROUP_ID,
                    s.TEAM_ID,
                    s.PROCESS_ID,
                    s.PRIORITY_CD,
                    s.PROCESS_ROUTER_ID,
                    s.PROCESS_INSTANCE_ID,
                    s.CASE_ID,
                    s.CLIENT_ID,
                    s.REF_ID,
                    s.REF_TYPE,
                    s.STEP_DEFINITION_ID,
                    s.CREATED_BY,
                    s.CREATE_TS,
                    s.SUSPENDED_TS,
                    s.COMMENTS,
                    s.CREATE_NDT,
                    s.STEP_DUE_NDT,
                    s.dcn,
                    s.document_received_date,
                    s.step_sequence    
                );

            IF      SQL%ROWCOUNT = 0
            THEN                        
                p_SUCCESS   :=  CAHCO_ETL_MW_UTIL_PKG.is_no;
            END IF;
            
        ELSE

            MERGE 
            INTO        STEP_INSTANCE                                   d
            USING       (
                            SELECT  p_STATUS                        AS  STATUS,
                                    p_STATUS_TS                     AS  STATUS_TS,
                                    p_ESCALATED_IND                 AS  ESCALATED_IND,
                                    p_STEP_DUE_TS                   AS  STEP_DUE_TS,
                                    p_FORWARDED_IND                 AS  FORWARDED_IND,
                                    p_ESCALATE_TO                   AS  ESCALATE_TO,
                                    p_FORWARDED_BY                  AS  FORWARDED_BY,
                                    p_OWNER                         AS  OWNER,
                                    p_LOCKED_ID                     AS  LOCKED_ID,
                                    p_GROUP_STEP_DEFINITION_ID      AS  GROUP_STEP_DEFINITION_ID,    
                                    p_GROUP_ID                      AS  GROUP_ID,
                                    p_TEAM_ID                       AS  TEAM_ID,
                                    p_PROCESS_ID                    AS  PROCESS_ID,
                                    p_PRIORITY_CD                   AS  PRIORITY_CD,
                                    p_PROCESS_ROUTER_ID             AS  PROCESS_ROUTER_ID,
                                    p_PROCESS_INSTANCE_ID           AS  PROCESS_INSTANCE_ID,
                                    p_CASE_ID                       AS  CASE_ID,
                                    p_CLIENT_ID                     AS  CLIENT_ID,
                                    p_REF_ID                        AS  REF_ID,
                                    p_REF_TYPE                      AS  REF_TYPE,
                                    p_STEP_DEFINITION_ID            AS  STEP_DEFINITION_ID,
                                    p_CREATED_BY                    AS  CREATED_BY,
                                    p_CREATE_TS                     AS  CREATE_TS,
                                    p_SUSPENDED_TS                  AS  SUSPENDED_TS,
                                    p_COMMENTS                      AS  COMMENTS,
                                    p_CREATE_NDT                    AS  CREATE_NDT,
                                    p_STEP_DUE_NDT                  AS  STEP_DUE_NDT,
                                    p_DCN                           AS  DCN,
                                    p_DOCUMENT_RECEIVED_DATE        AS  DOCUMENT_RECEIVED_DATE,
                                    p_STEP_SEQUENCE			        AS  STEP_SEQUENCE	
                              FROM  DUAL
                        )                                               s
            ON          (
                                d.ref_type                          =   s.ref_type 
                            AND d.ref_id                            =   s.ref_id
                            AND d.step_definition_id                =   s.step_definition_id   
                            AND d.process_id                        =   s.process_id
                            AND d.process_instance_id               =   s.process_instance_id
                            AND d.create_ts                         =   s.create_ts
                            AND d.step_sequence			            =   s.step_sequence
                        )                                               
            WHEN MATCHED THEN UPDATE SET

                d.status                                            =   s.STATUS,
                d.status_ts                                         =   s.STATUS_TS,
                d.escalated_ind                                     =   s.ESCALATED_IND,
                d.step_due_ts                                       =   s.STEP_DUE_TS,
                d.forwarded_ind                                     =   s.FORWARDED_IND,
                d.escalate_to                                       =   s.ESCALATE_TO,
                d.forwarded_by                                      =   s.FORWARDED_BY,
                d.owner                                             =   s.OWNER,
                d.locked_id                                         =   s.LOCKED_ID,
                d.group_step_definition_id                          =   s.GROUP_STEP_DEFINITION_ID,    
                d.group_id                                          =   s.GROUP_ID,
                d.team_id                                           =   s.TEAM_ID,
                d.priority_cd                                       =   s.PRIORITY_CD,
                d.process_router_id                                 =   s.PROCESS_ROUTER_ID,
                d.case_id                                           =   s.CASE_ID,
                d.client_id                                         =   s.CLIENT_ID,
                d.suspended_ts                                      =   s.SUSPENDED_TS,
                d.comments                                          =   s.COMMENTS,
                d.create_ndt                                        =   s.CREATE_NDT,
                d.dcn                                               =   s.dcn,
                d.document_received_date                            =   s.document_received_date;    

        END IF;

    END         mrg_step_instance;
    /*****************************************************************************************************************************************************************

        NAME:           proc_hco_activity_queue
        DESCRIPTION:    Process the records in HCO_ACTIVITY_QUEUE that are pending.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created procedure.

    *****************************************************************************************************************************************************************/
    PROCEDURE   proc_hco_activity_queue
                (
                    p_BATCH_SIZE                        IN                      NUMBER,
                    p_DML_OPERATION                     IN                      VARCHAR2
                )
    IS

        l_hco_activity_arr                                                      t_hco_activity_arr;

        l_hco_process_instance_id                                               D_HCO_PROCESS_INSTANCE.hco_process_instance_id%TYPE;        

        l_team_id                                                               STEP_INSTANCE.team_id%TYPE;
        l_group_id                                                              STEP_INSTANCE.group_id%TYPE;

        l_success                                                               VARCHAR2(1);
        l_rec_status                                                            HCO_ACTIVITY_QUEUE.rec_status%TYPE;
        
    BEGIN

        CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'proc_hco_activity_queue', 'Started');

        IF      p_DML_OPERATION = 'I'
            OR  p_DML_OPERATION IS NULL
        THEN    
            l_rec_status    :=  CAHCO_ETL_MW_UTIL_PKG.get_queue_status_pending;
        ELSE    
            l_rec_status    :=  CAHCO_ETL_MW_UTIL_PKG.get_queue_status_in_progress;
        END IF;

        CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'proc_hco_activity_queue', 'Detected p_DML_OPERATION = ' || NVL(p_DML_OPERATION, 'NULL') || ':  Processing records with status ' || l_rec_status);

        LOOP

            IF  
            (
                CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_string(p_NAME  =>  'MW_PROC_CONTROL')  =   CAHCO_ETL_MW_UTIL_PKG.get_action_stop
            )
            THEN
                RETURN;
            END IF;

            CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'proc_hco_activity_queue', 'Fetching next queue batch...');
             
            SELECT  *
                    BULK COLLECT INTO
                    l_hco_activity_arr
              FROM  (
                        SELECT  haq.*
                          FROM  HCO_ACTIVITY_QUEUE                  haq
                         WHERE  haq.rec_status                  =   l_rec_status
                         ORDER
                            BY  haq.act_status_ts asc,
                                haq.hco_activity_queue_id asc
                    )
             WHERE  rownum  <=  p_BATCH_SIZE;
             
            CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'proc_hco_activity_queue', 'Fetched batch with number of records = ' || l_hco_activity_arr.COUNT || '...');
            EXIT WHEN l_hco_activity_arr.COUNT = 0;

            CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'proc_hco_activity_queue', 'Started processing batch...');

            FOR i IN 1..l_hco_activity_arr.COUNT
            LOOP

                UPDATE  HCO_ACTIVITY_QUEUE
                   SET  rec_status                   =   CAHCO_ETL_MW_UTIL_PKG.get_queue_status_in_progress
                 WHERE  hco_activity_queue_id        =   l_hco_activity_arr(i).hco_activity_queue_id;

                mrg_staff_key_lkup
                (
                    p_STAFF_KEY         =>  l_hco_activity_arr(i).act_owner
                );

                mrg_staff_key_lkup
                (
                    p_STAFF_KEY         =>  l_hco_activity_arr(i).act_created_by
                );

                IF      l_hco_activity_arr(i).act_owner IS NOT NULL
                    OR  l_hco_activity_arr(i).act_created_by IS NOT NULL
                THEN

                    CAHCO_ETL_MW_UTIL_PKG.get_staff_team_biz_unit_ids
                    (
                        p_STAFF_KEY                         =>  NVL(l_hco_activity_arr(i).act_owner, l_hco_activity_arr(i).act_created_by),
                        p_TEAM_ID                           =>  l_team_id,
                        p_BUSINESS_UNIT_ID                  =>  l_group_id
                    );

                ELSE

                    l_team_id   :=  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id;
                    l_group_id  :=  CAHCO_ETL_MW_UTIL_PKG.get_unknown_business_unit_id;

                END IF;

                -- NOTE:  In the call to map_hco_process_instance, the values for p_REF_TYPE and p_REF_ID are NULLed out for process #1, because 
                --        those values are not used when mapping to the process instance.

                l_hco_process_instance_id    :=

                map_hco_process_instance
                (
                    p_HCO_PROCESS_ID                    =>  l_hco_activity_arr(i).act_process_id,  
                    p_DCN                               =>  l_hco_activity_arr(i).act_dcn,
                    p_CLIENT_NUMBER                     =>  l_hco_activity_arr(i).act_client_id,
                    p_CASE_NUMBER                       =>  l_hco_activity_arr(i).act_case_id,                    
                    p_REF_TYPE                          =>  CASE WHEN       l_hco_activity_arr(i).act_process_id = 1
                                                                        AND l_hco_activity_arr(i).act_step_definition_id NOT IN (10,11)
                                                                 THEN   NULL
                                                                 ELSE   l_hco_activity_arr(i).act_ref_type
                                                            END,
                    p_REF_ID                            =>  CASE WHEN       l_hco_activity_arr(i).act_process_id = 1
                                                                        AND l_hco_activity_arr(i).act_step_definition_id NOT IN (10,11)
                                                                 THEN   NULL
                                                                 ELSE   l_hco_activity_arr(i).act_ref_id
                                                            END,
                    p_INS_IF_NOT_EXISTS                 =>  CAHCO_ETL_MW_UTIL_PKG.is_true
                );

                mrg_step_instance
                (
                    p_STATUS                            =>  l_hco_activity_arr(i).act_status,  
                    p_STATUS_TS                         =>  l_hco_activity_arr(i).act_status_ts,
                    p_ESCALATED_IND                     =>  NULL,
                    p_STEP_DUE_TS                       =>  NULL,
                    p_FORWARDED_IND                     =>  NULL,
                    p_ESCALATE_TO                       =>  NULL,
                    p_FORWARDED_BY                      =>  NULL,
                    p_OWNER                             =>  l_hco_activity_arr(i).act_owner,
                    p_LOCKED_ID                         =>  NULL,
                    p_GROUP_STEP_DEFINITION_ID          =>  NULL,
                    p_GROUP_ID                          =>  l_group_id,
                    p_TEAM_ID                           =>  l_team_id,
                    p_PROCESS_ID                        =>  l_hco_activity_arr(i).act_process_id,
                    p_PRIORITY_CD                       =>  NULL,
                    p_PROCESS_ROUTER_ID                 =>  NULL,
                    p_PROCESS_INSTANCE_ID               =>  l_hco_process_instance_id,
                    p_CASE_ID                           =>  l_hco_activity_arr(i).act_case_id,
                    p_CLIENT_ID                         =>  l_hco_activity_arr(i).act_client_id,
                    p_REF_ID                            =>  l_hco_activity_arr(i).act_ref_id,
                    p_REF_TYPE                          =>  l_hco_activity_arr(i).act_ref_type,
                    p_STEP_DEFINITION_ID                =>  l_hco_activity_arr(i).act_step_definition_id,
                    p_CREATED_BY                        =>  l_hco_activity_arr(i).act_created_by,
                    p_CREATE_TS                         =>  l_hco_activity_arr(i).act_create_ts,                    
                    p_SUSPENDED_TS                      =>  NULL,
                    p_COMMENTS                          =>  l_hco_activity_arr(i).act_comments,
                    p_CREATE_NDT                        =>  NULL,
                    p_STEP_DUE_NDT                      =>  NULL,
                    p_DCN                               =>  l_hco_activity_arr(i).act_dcn,
                    p_DOCUMENT_RECEIVED_DATE            =>  get_dcn_date(l_hco_activity_arr(i).act_dcn),
                    p_STEP_SEQUENCE			            =>  l_hco_activity_arr(i).step_sequence,
                    p_DML_OPERATION                     =>  p_DML_OPERATION,
                    p_SUCCESS                           =>  l_success
                );

                IF      l_success    =   CAHCO_ETL_MW_UTIL_PKG.is_yes
                THEN

                    UPDATE  HCO_ACTIVITY_QUEUE
                       SET  rec_status                   =   CAHCO_ETL_MW_UTIL_PKG.get_queue_status_complete
                     WHERE  hco_activity_queue_id        =   l_hco_activity_arr(i).hco_activity_queue_id;

                END IF;

            END LOOP;

            COMMIT;

            CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'proc_hco_activity_queue', 'Finished processing batch...');

        END LOOP;
        
        -- Make sure nothing that has a claimed timestamp is unclaimed.

        CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'proc_hco_activity_queue', 'Making sure nothing that has a claimed timestamp is UNCLAIMED...');
        
        UPDATE  STEP_INSTANCE 
           SET  status  =   CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed
         WHERE  status  =   CAHCO_ETL_MW_UTIL_PKG.get_mw_status_unclaimed 
           AND  claimed_ts IS NOT NULL;

        COMMIT;

        maxdat_admin.gather_table_stats(USER, 'step_instance', 8);        
        maxdat_admin.gather_table_stats(USER, 'step_instance_history', 8);        

        CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'proc_hco_activity_queue', 'Completed');

    END         proc_hco_activity_queue;
    /*****************************************************************************************************************************************************************

        NAME:           cr_exemption_req_activities
        DESCRIPTION:    Create Exemption Request activities from the Exemption Request record, p_exemption_req_rec.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created procedure.
        TAM                     06/03/2019              MAXDAT-9691:  Added logic to set task end date to the start date when the end date is less than the start date
                                                        for activity 7.
        
    *****************************************************************************************************************************************************************/
    PROCEDURE   cr_exemption_req_activities
                (
                    p_exemption_req_rec                 IN                      c_emrs_d_exemption_req%ROWTYPE
                )
    IS          
        rec                                                                     c_emrs_d_exemption_req%ROWTYPE;
    BEGIN

        rec :=  p_exemption_req_rec;

        FOR birec IN c_batch_info(  cp_DCN  =>  rec.DCN )
        LOOP

            IF  birec.PERFORM_SCAN_START IS NOT NULL
            THEN

                ins_hco_activity_queue
                (
                    p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                    p_ACT_STATUS_TS                     =>  birec.PERFORM_SCAN_START,
                    p_ACT_OWNER                         =>  birec.CREATION_USER_ID,
                    p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                    p_ACT_CASE_ID                       =>  NULL,
                    p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                    p_ACT_DCN                           =>  rec.DCN,
                    p_ACT_REF_ID                        =>  rec.EXEMPTION_ID,
                    p_ACT_REF_TYPE                      =>  c_exemption,
                    p_ACT_STEP_DEFINITION_ID            =>  1,
                    p_ACT_PROCESS_ID                    =>  1,
                    p_ACT_CREATED_BY                    =>  birec.CREATION_USER_ID,
                    p_ACT_CREATE_TS                     =>  birec.PERFORM_SCAN_START,
                    p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
                );

                IF  birec.PERFORM_SCAN_END IS NOT NULL
                THEN

                    ins_hco_activity_queue
                    (
                        p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
                        p_ACT_STATUS_TS                     =>  birec.PERFORM_SCAN_END,
                        p_ACT_OWNER                         =>  birec.CREATION_USER_ID,
                        p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                        p_ACT_CASE_ID                       =>  NULL,
                        p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                        p_ACT_DCN                           =>  rec.DCN,
                        p_ACT_REF_ID                        =>  rec.EXEMPTION_ID,
                        p_ACT_REF_TYPE                      =>  c_exemption,
                        p_ACT_STEP_DEFINITION_ID            =>  1,
                        p_ACT_PROCESS_ID                    =>  1,
                        p_ACT_CREATED_BY                    =>  birec.CREATION_USER_ID,
                        p_ACT_CREATE_TS                     =>  birec.PERFORM_SCAN_START,
                        p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
                    );

                    ins_hco_activity_queue
                    (
                        p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                        p_ACT_STATUS_TS                     =>  birec.PERFORM_SCAN_END,
                        p_ACT_OWNER                         =>  birec.CREATION_USER_ID,
                        p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                        p_ACT_CASE_ID                       =>  NULL,
                        p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                        p_ACT_DCN                           =>  rec.DCN,
                        p_ACT_REF_ID                        =>  rec.EXEMPTION_ID,
                        p_ACT_REF_TYPE                      =>  c_exemption,
                        p_ACT_STEP_DEFINITION_ID            =>  2,
                        p_ACT_PROCESS_ID                    =>  1,
                        p_ACT_CREATED_BY                    =>  birec.CREATION_USER_ID,
                        p_ACT_CREATE_TS                     =>  birec.PERFORM_SCAN_END,
                        p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
                    );


                END IF;

            END IF;

            IF  birec.RELEASE_TO_DMS_START IS NOT NULL
            THEN

                IF  birec.PERFORM_SCAN_END IS NOT NULL
                THEN

                    ins_hco_activity_queue
                    (
                        p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
                        p_ACT_STATUS_TS                     =>  birec.RELEASE_TO_DMS_START,
                        p_ACT_OWNER                         =>  birec.CREATION_USER_ID,
                        p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                        p_ACT_CASE_ID                       =>  NULL,
                        p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                        p_ACT_DCN                           =>  rec.DCN,
                        p_ACT_REF_ID                        =>  rec.EXEMPTION_ID,
                        p_ACT_REF_TYPE                      =>  c_exemption,
                        p_ACT_STEP_DEFINITION_ID            =>  2,
                        p_ACT_PROCESS_ID                    =>  1,
                        p_ACT_CREATED_BY                    =>  birec.CREATION_USER_ID,
                        p_ACT_CREATE_TS                     =>  birec.PERFORM_SCAN_END,
                        p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
                    );

                END IF;

                ins_hco_activity_queue
                (
                    p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                    p_ACT_STATUS_TS                     =>  birec.RELEASE_TO_DMS_START,
                    p_ACT_OWNER                         =>  birec.CREATION_USER_ID,
                    p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                    p_ACT_CASE_ID                       =>  NULL,
                    p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                    p_ACT_DCN                           =>  rec.DCN,
                    p_ACT_REF_ID                        =>  rec.EXEMPTION_ID,
                    p_ACT_REF_TYPE                      =>  c_exemption,
                    p_ACT_STEP_DEFINITION_ID            =>  12,
                    p_ACT_PROCESS_ID                    =>  1,
                    p_ACT_CREATED_BY                    =>  birec.CREATION_USER_ID,
                    p_ACT_CREATE_TS                     =>  birec.RELEASE_TO_DMS_START,
                    p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
                );

                IF  birec.RELEASE_TO_DMS_END IS NOT NULL
                THEN

                    ins_hco_activity_queue
                    (
                        p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
                        p_ACT_STATUS_TS                     =>  birec.RELEASE_TO_DMS_END,
                        p_ACT_OWNER                         =>  birec.CREATION_USER_ID,
                        p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                        p_ACT_CASE_ID                       =>  NULL,
                        p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                        p_ACT_DCN                           =>  rec.DCN,
                        p_ACT_REF_ID                        =>  rec.EXEMPTION_ID,
                        p_ACT_REF_TYPE                      =>  c_exemption,
                        p_ACT_STEP_DEFINITION_ID            =>  12,
                        p_ACT_PROCESS_ID                    =>  1,
                        p_ACT_CREATED_BY                    =>  birec.CREATION_USER_ID,
                        p_ACT_CREATE_TS                     =>  birec.RELEASE_TO_DMS_START,
                        p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
                    );

                    ins_hco_activity_queue
                    (
                        p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                        p_ACT_STATUS_TS                     =>  birec.RELEASE_TO_DMS_END,
                        p_ACT_OWNER                         =>  rec.RECORD_NAME,
                        p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                        p_ACT_CASE_ID                       =>  NULL,
                        p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                        p_ACT_DCN                           =>  rec.DCN,
                        p_ACT_REF_ID                        =>  rec.EXEMPTION_ID,
                        p_ACT_REF_TYPE                      =>  c_exemption,
                        p_ACT_STEP_DEFINITION_ID            =>  7,
                        p_ACT_PROCESS_ID                    =>  1,
                        p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
                        p_ACT_CREATE_TS                     =>  birec.RELEASE_TO_DMS_END,
                        p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
                    );

                    ins_hco_activity_queue
                    (
                        p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
                        p_ACT_STATUS_TS                     =>  CASE WHEN rec.RECORD_DATE < birec.RELEASE_TO_DMS_END THEN birec.RELEASE_TO_DMS_END ELSE rec.RECORD_DATE END,
                        p_ACT_OWNER                         =>  rec.RECORD_NAME,
                        p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                        p_ACT_CASE_ID                       =>  NULL,
                        p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                        p_ACT_DCN                           =>  rec.DCN,
                        p_ACT_REF_ID                        =>  rec.EXEMPTION_ID,
                        p_ACT_REF_TYPE                      =>  c_exemption,
                        p_ACT_STEP_DEFINITION_ID            =>  7,
                        p_ACT_PROCESS_ID                    =>  1,
                        p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
                        p_ACT_CREATE_TS                     =>  birec.RELEASE_TO_DMS_END,
                        p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
                    );


                END IF;

            END IF;

        END LOOP;

        ins_hco_activity_queue
        (
            p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_unclaimed,
            p_ACT_STATUS_TS                     =>  rec.RECORD_DATE,
            p_ACT_OWNER                         =>  NULL,
            p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
            p_ACT_CASE_ID                       =>  NULL,
            p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
            p_ACT_DCN                           =>  rec.DCN,
            p_ACT_REF_ID                        =>  rec.EXEMPTION_ID,
            p_ACT_REF_TYPE                      =>  c_exemption,
            p_ACT_STEP_DEFINITION_ID            =>  9,
            p_ACT_PROCESS_ID                    =>  1,
            p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
            p_ACT_CREATE_TS                     =>  rec.RECORD_DATE,
            p_ACT_COMMENTS                      =>  'creating from exemption request table',
	    p_ACT_STEP_SEQUENCE			=>  0
        );

    END         cr_exemption_req_activities;
    /*****************************************************************************************************************************************************************

        NAME:           proc_emrs_d_exemption_req
        DESCRIPTION:    Process the records in the table EMRS_D_EXEMPTION_REQ.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created procedure.

    *****************************************************************************************************************************************************************/
    PROCEDURE   proc_emrs_d_exemption_req
    IS

        l_sql                                                                   VARCHAR2(32767);

        l_mw_exemption_proc_dt                                                  DATE;

    BEGIN

        IF  CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_string(p_NAME  =>  'MW_PROC_CONTROL')  =   'STOP'
        THEN
            RETURN;
        END IF;

        FOR rec IN c_emrs_d_exemption_req
        LOOP

            IF  CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_string(p_NAME  =>  'MW_PROC_CONTROL')  =   'STOP'
            THEN
                RETURN;
            END IF;

            cr_exemption_req_activities
            (
                p_exemption_req_rec                 =>  rec
            );

            COMMIT;

        END LOOP;

        l_sql   :=  'SELECT MAX(modified_date) FROM EMRS_D_EXEMPTION_REQ WHERE modified_date <= sysdate';
        l_mw_exemption_proc_dt	:=	cahco_etl_mw_util_pkg.return_query_date
                                    (
                                        p_SQL	=>  l_sql
                                    );

        CAHCO_ETL_MW_UTIL_PKG.set_corp_etl_control_date
        (
            p_NAME                              =>  'MW_EXEMPTION_PROC_DATE',
            p_DATE                              =>  l_mw_exemption_proc_dt
        );

    END         proc_emrs_d_exemption_req;
    /*****************************************************************************************************************************************************************

        NAME:           cr_exemption_sh_activities
        DESCRIPTION:    Create Exemption Status History activities from the Exemption Status History record, p_exemption_sh_rec.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created procedure.
        EB                      04/28/2019              Modified for MAXDAT-9243

    *****************************************************************************************************************************************************************/
    PROCEDURE   cr_exemption_sh_activities
                (
                    p_exemption_sh_rec                 IN                      c_emrs_d_exempt_status_hist%ROWTYPE
                )
    IS          
        rec                                                                     c_emrs_d_exempt_status_hist%ROWTYPE;                  
        l_hco_activity_queue_rec_exists                                         PLS_INTEGER;
        most_recent_info_rec                                                    step_activity_info_rec;
        activity_type_to_close                                                  NUMBER;    
        create_ts_to_close                                                      DATE;
        l_mail_id                                                               VARCHAR2(20 BYTE); 
        l_case_id                                                               VARCHAR2(20 BYTE);
        l_client_num                                                            NUMBER;
        l_dcn                                                                   VARCHAR2(20 BYTE);    
        l_mail_status                                                           VARCHAR2(50 BYTE);
        l_mail_start_date                                                       DATE;
        l_mail_end_date                                                         DATE;

    BEGIN

        rec :=  p_exemption_sh_rec;
    ------------------------------------------------------------------------------------------------------------------
    IF rec.exemption_status_code = 'D' --Pending DHCS Review
    THEN
        --close the most recent open Exemption Process task (9) if one exists
        most_recent_info_rec := get_most_recent_step_or_activity(rec.exemption_id, c_exemption, 9);
        IF (most_recent_info_rec.create_ts is not null and most_recent_info_rec.status != CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed)
        THEN
            IF most_recent_info_rec.status = CAHCO_ETL_MW_UTIL_PKG.get_mw_status_unclaimed
            THEN
                --if latest status is unclaimed, create a claimed record before closing
                ins_hco_activity_queue
                (
                    p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                    p_ACT_STATUS_TS                     =>  rec.RECORD_DATE,
                    p_ACT_OWNER                         =>  rec.RECORD_NAME,
                    p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                    p_ACT_CASE_ID                       =>  NULL,
                    p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                    p_ACT_DCN                           =>  rec.DCN,
                    p_ACT_REF_ID                        =>  rec.EXEMPTION_ID,
                    p_ACT_REF_TYPE                      =>  c_exemption,
                    p_ACT_STEP_DEFINITION_ID            =>  9,
                    p_ACT_PROCESS_ID                    =>  1,
                    p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
                    p_ACT_CREATE_TS                     =>  most_recent_info_rec.create_ts,
                    p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed,
		    p_ACT_STEP_SEQUENCE		    	=>  most_recent_info_rec.step_sequence
                 );
            END If;
            --close
            ins_hco_activity_queue
            (
                p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
                p_ACT_STATUS_TS                     =>  rec.RECORD_DATE,
                p_ACT_OWNER                         =>  rec.RECORD_NAME,
                p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                p_ACT_CASE_ID                       =>  NULL,
                p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                p_ACT_DCN                           =>  rec.DCN,
                p_ACT_REF_ID                        =>  rec.EXEMPTION_ID,
                p_ACT_REF_TYPE                      =>  c_exemption,
                p_ACT_STEP_DEFINITION_ID            =>  9,
                p_ACT_PROCESS_ID                    =>  1,
                p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
                p_ACT_CREATE_TS                     =>  most_recent_info_rec.create_ts,
                p_ACT_COMMENTS                      =>  'closing because status D',
		p_ACT_STEP_SEQUENCE		    =>  most_recent_info_rec.step_sequence
            );
        END IF;

        --create a new task for DHCS Exemption Review (19)
        most_recent_info_rec := get_most_recent_step_or_activity(rec.exemption_id, c_exemption, 19);
        IF (most_recent_info_rec.create_ts is null or most_recent_info_rec.status = CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed)
        THEN
            ins_hco_activity_queue
            (
                p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_unclaimed,
                p_ACT_STATUS_TS                     =>  rec.RECORD_DATE,
                p_ACT_OWNER                         =>  NULL,
                p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                p_ACT_CASE_ID                       =>  NULL,
                p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                p_ACT_DCN                           =>  rec.DCN,
                p_ACT_REF_ID                        =>  rec.EXEMPTION_ID,
                p_ACT_REF_TYPE                      =>  c_exemption,
                p_ACT_STEP_DEFINITION_ID            =>  19,
                p_ACT_PROCESS_ID                    =>  1,
                p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
                p_ACT_CREATE_TS                     =>  rec.RECORD_DATE,
                p_ACT_COMMENTS                      =>  'creating because status D'
            );
        END IF;
    END IF;

    -----------------------------------------------------------------------------------------------------------------
    IF (rec.exemption_status_code in ('A','M') AND is_exemption_status_code_a_duplicate(rec.exemption_hist_id, rec.exemption_id, rec.exemption_status_code) = CAHCO_ETL_MW_UTIL_PKG.is_false)
	--DHCS Approved or Pending Maximus Review
    THEN
        --close the most recent open DHCS Exemption Review task(19) if it exists
        most_recent_info_rec := get_most_recent_step_or_activity(rec.exemption_id, c_exemption, 19);
        IF (most_recent_info_rec.create_ts is not null and most_recent_info_rec.status != CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed)
        THEN
        IF most_recent_info_rec.status = CAHCO_ETL_MW_UTIL_PKG.get_mw_status_unclaimed
            THEN
                --if latest status is unclaimed, create a claimed record before closing
                ins_hco_activity_queue
                (
                    p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                    p_ACT_STATUS_TS                     =>  rec.RECORD_DATE,
                    p_ACT_OWNER                         =>  rec.RECORD_NAME,
                    p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                    p_ACT_CASE_ID                       =>  NULL,
                    p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                    p_ACT_DCN                           =>  rec.DCN,
                    p_ACT_REF_ID                        =>  rec.EXEMPTION_ID,
                    p_ACT_REF_TYPE                      =>  c_exemption,
                    p_ACT_STEP_DEFINITION_ID            =>  19,
                    p_ACT_PROCESS_ID                    =>  1,
                    p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
                    p_ACT_CREATE_TS                     =>  most_recent_info_rec.create_ts,
                    p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
                 );
            END If;
            --close
            ins_hco_activity_queue
            (
                p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
                p_ACT_STATUS_TS                     =>  rec.RECORD_DATE,
                p_ACT_OWNER                         =>  rec.RECORD_NAME,
                p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                p_ACT_CASE_ID                       =>  NULL,
                p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                p_ACT_DCN                           =>  rec.DCN,
                p_ACT_REF_ID                        =>  rec.EXEMPTION_ID,
                p_ACT_REF_TYPE                      =>  c_exemption,
                p_ACT_STEP_DEFINITION_ID            =>  19,
                p_ACT_PROCESS_ID                    =>  1,
                p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
                p_ACT_CREATE_TS                     =>  most_recent_info_rec.create_ts,
                p_ACT_COMMENTS                      =>  'closing because status A or M'
            );
        END IF;        
        --close the most recent open Process Exemption Approval/Denial (24) if it exists 
        most_recent_info_rec := get_most_recent_step_or_activity(rec.exemption_id, c_exemption, 24);
        IF (most_recent_info_rec.create_ts is not null and most_recent_info_rec.status != CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed)
        THEN
        IF most_recent_info_rec.status = CAHCO_ETL_MW_UTIL_PKG.get_mw_status_unclaimed
            THEN
                --if latest status is unclaimed, create a claimed record before closing
                ins_hco_activity_queue
                (
                    p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                    p_ACT_STATUS_TS                     =>  rec.RECORD_DATE,
                    p_ACT_OWNER                         =>  rec.RECORD_NAME,
                    p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                    p_ACT_CASE_ID                       =>  NULL,
                    p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                    p_ACT_DCN                           =>  rec.DCN,
                    p_ACT_REF_ID                        =>  rec.EXEMPTION_ID,
                    p_ACT_REF_TYPE                      =>  c_exemption,
                    p_ACT_STEP_DEFINITION_ID            =>  24,
                    p_ACT_PROCESS_ID                    =>  1,
                    p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
                    p_ACT_CREATE_TS                     =>  most_recent_info_rec.create_ts,
                    p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
                 );
            END If;
            --close
            ins_hco_activity_queue
            (
                p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
                p_ACT_STATUS_TS                     =>  rec.RECORD_DATE,
                p_ACT_OWNER                         =>  rec.RECORD_NAME,
                p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                p_ACT_CASE_ID                       =>  NULL,
                p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                p_ACT_DCN                           =>  rec.DCN,
                p_ACT_REF_ID                        =>  rec.EXEMPTION_ID,
                p_ACT_REF_TYPE                      =>  c_exemption,
                p_ACT_STEP_DEFINITION_ID            =>  24,
                p_ACT_PROCESS_ID                    =>  1,
                p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
                p_ACT_CREATE_TS                     =>  most_recent_info_rec.create_ts,
                p_ACT_COMMENTS                      =>  'closing because status A or M'
            );
        END IF;

        --close the most recent open Exemption Process task (9) if one exists
        most_recent_info_rec := get_most_recent_step_or_activity(rec.exemption_id, c_exemption, 9);
        IF (most_recent_info_rec.create_ts is not null and most_recent_info_rec.status != CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed)
        THEN
            IF most_recent_info_rec.status = CAHCO_ETL_MW_UTIL_PKG.get_mw_status_unclaimed
            THEN
                --if latest status is unclaimed, create a claimed record before closing
                ins_hco_activity_queue
                (
                    p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                    p_ACT_STATUS_TS                     =>  rec.RECORD_DATE,
                    p_ACT_OWNER                         =>  rec.RECORD_NAME,
                    p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                    p_ACT_CASE_ID                       =>  NULL,
                    p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                    p_ACT_DCN                           =>  rec.DCN,
                    p_ACT_REF_ID                        =>  rec.EXEMPTION_ID,
                    p_ACT_REF_TYPE                      =>  c_exemption,
                    p_ACT_STEP_DEFINITION_ID            =>  9,
                    p_ACT_PROCESS_ID                    =>  1,
                    p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
                    p_ACT_CREATE_TS                     =>  most_recent_info_rec.create_ts,
                    p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed,
		    p_ACT_STEP_SEQUENCE		    	=>  most_recent_info_rec.step_sequence
                );
                END If;
            --close
            ins_hco_activity_queue
            (
                p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
                p_ACT_STATUS_TS                     =>  rec.RECORD_DATE,
                p_ACT_OWNER                         =>  rec.RECORD_NAME,
                p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                p_ACT_CASE_ID                       =>  NULL,
                p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                p_ACT_DCN                           =>  rec.DCN,
                p_ACT_REF_ID                        =>  rec.EXEMPTION_ID,
                p_ACT_REF_TYPE                      =>  c_exemption,
                p_ACT_STEP_DEFINITION_ID            =>  9,
                p_ACT_PROCESS_ID                    =>  1,
                p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
                p_ACT_CREATE_TS                     =>  most_recent_info_rec.create_ts,
                p_ACT_COMMENTS                      =>  'closing because status A or M',
		p_ACT_STEP_SEQUENCE		    =>  most_recent_info_rec.step_sequence
            );
        END IF;

        IF (rec.exemption_status_code = 'M')
        THEN
            --create a new task for DHCS Exemption Review (9)
            most_recent_info_rec := get_most_recent_step_or_activity(rec.exemption_id, c_exemption, 9);
            IF (most_recent_info_rec.create_ts is null or most_recent_info_rec.status = CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed)
            THEN
                ins_hco_activity_queue
                (
                    p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_unclaimed,
                    p_ACT_STATUS_TS                     =>  rec.RECORD_DATE,
                    p_ACT_OWNER                         =>  NULL,
                    p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                    p_ACT_CASE_ID                       =>  NULL,
                    p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                    p_ACT_DCN                           =>  rec.DCN,
                    p_ACT_REF_ID                        =>  rec.EXEMPTION_ID,
                    p_ACT_REF_TYPE                      =>  c_exemption,
                    p_ACT_STEP_DEFINITION_ID            =>  9,
                    p_ACT_PROCESS_ID                    =>  1,
                    p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
                    p_ACT_CREATE_TS                     =>  rec.RECORD_DATE,
                    p_ACT_COMMENTS                      =>  'creating because status M' 	
                );
            END IF;
        END IF;

   END IF;

    -------------------------------------------------------------------------------------------------------------------
    IF rec.exemption_status_code = '1' --DHCS Approved - Pending PH40
    THEN
        --create a new task for Process Exemption Approval/Denial (24)
        most_recent_info_rec := get_most_recent_step_or_activity(rec.exemption_id, c_exemption, 24);
        IF (most_recent_info_rec.create_ts is null or most_recent_info_rec.status = CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed)
        THEN
            ins_hco_activity_queue
            (
                p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_unclaimed,
                p_ACT_STATUS_TS                     =>  rec.RECORD_DATE,
                p_ACT_OWNER                         =>  NULL,
                p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                p_ACT_CASE_ID                       =>  NULL,
                p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                p_ACT_DCN                           =>  rec.DCN,
                p_ACT_REF_ID                        =>  rec.EXEMPTION_ID,
                p_ACT_REF_TYPE                      =>  c_exemption,
                p_ACT_STEP_DEFINITION_ID            =>  24,
                p_ACT_PROCESS_ID                    =>  1,
                p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
                p_ACT_CREATE_TS                     =>  rec.RECORD_DATE,
                p_ACT_COMMENTS                      =>  'creating because status 1'
            );
        END IF;
    END IF;

    ---------------------------------------------------------------------------------------------------------------------
    -- At any point, if a history record comes in that is not one of the above, but which has a final status, we CLOSE whatever task is currently open.
    IF (rec.final_status    =   CAHCO_ETL_MW_UTIL_PKG.is_yes and rec.exemption_status_code not in ('D','A','M','1'))
    THEN
        --determine which task is open
        most_recent_info_rec := get_most_recent_step_or_activity(rec.exemption_id, c_exemption, 9);
        IF (most_recent_info_rec.create_ts is not null and most_recent_info_rec.status != CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed)
        THEN
            activity_type_to_close := 9;
            create_ts_to_close := most_recent_info_rec.create_ts;
        ELSE
            most_recent_info_rec := get_most_recent_step_or_activity(rec.exemption_id, c_exemption, 19);
            IF (most_recent_info_rec.create_ts is not null and most_recent_info_rec.status != CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed)
            THEN
                activity_type_to_close := 19;
                create_ts_to_close := most_recent_info_rec.create_ts;
            ELSE
                most_recent_info_rec := get_most_recent_step_or_activity(rec.exemption_id, c_exemption, 24);
                IF (most_recent_info_rec.create_ts is not null and most_recent_info_rec.status != CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed)
                THEN
                    activity_type_to_close := 24;
                    create_ts_to_close := most_recent_info_rec.create_ts;
                ELSE
                    activity_type_to_close := null;
                END IF;
            END IF;
        END IF;

        --close task
        IF activity_type_to_close is not null
        THEN
            IF (most_recent_info_rec.status = CAHCO_ETL_MW_UTIL_PKG.get_mw_status_unclaimed)
            THEN
                --create a claimed record before closing
                ins_hco_activity_queue
                    (
                        p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                        p_ACT_STATUS_TS                     =>  rec.RECORD_DATE,
                        p_ACT_OWNER                         =>  rec.RECORD_NAME,
                        p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                        p_ACT_CASE_ID                       =>  NULL,
                        p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                        p_ACT_DCN                           =>  rec.DCN,
                        p_ACT_REF_ID                        =>  rec.EXEMPTION_ID,
                        p_ACT_REF_TYPE                      =>  c_exemption,
                        p_ACT_STEP_DEFINITION_ID            =>  activity_type_to_close,
                        p_ACT_PROCESS_ID                    =>  1,
                        p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
                        p_ACT_CREATE_TS                     =>  create_ts_to_close,
                        p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed,
			p_ACT_STEP_SEQUENCE		    =>  most_recent_info_rec.step_sequence
                    );
            END IF;
            --close
            ins_hco_activity_queue
            (
                p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
                p_ACT_STATUS_TS                     =>  rec.RECORD_DATE,
                p_ACT_OWNER                         =>  rec.RECORD_NAME,
                p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                p_ACT_CASE_ID                       =>  NULL,
                p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                p_ACT_DCN                           =>  rec.DCN,
                p_ACT_REF_ID                        =>  rec.EXEMPTION_ID,
                p_ACT_REF_TYPE                      =>  c_exemption,
                p_ACT_STEP_DEFINITION_ID            =>  activity_type_to_close,
                p_ACT_PROCESS_ID                    =>  1,
                p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
                p_ACT_CREATE_TS                     =>  create_ts_to_close,
                p_ACT_COMMENTS                      =>  'closing because of some other final status',
		p_ACT_STEP_SEQUENCE		    =>  most_recent_info_rec.step_sequence
            );
        END IF;

    END IF;
    -----------------------------------------------------------------------------------------------------
/* 
   --if final status then check whether or not to create 6
    IF rec.final_status    =   CAHCO_ETL_MW_UTIL_PKG.is_yes
    THEN
        IF (rec.disenrollment_id is null or rec.disenrollment_id = 0) -- 6 not being created through (dis)enrollment 
        THEN
        --check mail table
           BEGIN
 		select 	Mail_ID, Case_Number, Client_Number,dcn,MAIL_STATUS, 
                        Activity6_Start_dt , 
                        Activity6_End_dt 
		INTO    l_mail_id, l_case_id, l_client_num, l_dcn, l_mail_status,
                        l_mail_start_date, l_mail_end_date                        
                        from
			(
       			SELECT  T.Mail_ID, C.Case_Number, T.Client_Number,T.dcn,MAIL_STATUS, 
                        	L.Date_Requested as Activity6_Start_dt , 
                        	L.Modified_Date as Activity6_End_dt
                	FROM    maxdat.HCO_MAIL_CLIENT_TRANS T
                        	,maxdat.HCO_D_LETTER_MAILING L
				,maxdat.EMRS_D_CASE C
                	WHERE   DCIN = MAIL_ID
                	AND     EXEMPTION_ID  = rec.exemption_id
                	AND     CLIENT_NUMBER = rec.client_number
			AND     C.case_id     = T.Case_ID
			AND	MAIL_STATUS = 'DONE'
			AND	LETTER_TYPE_CODE != 'E6' 
                	Order by L.Date_Requested, L.Modified_Date, dp_letter_mail_id
			)
		where rownum = 1;                    
                        EXCEPTION
                            WHEN    NO_DATA_FOUND
                            THEN    l_mail_id := null; 
            END;
            IF l_mail_id is not null and l_mail_status in ('DONE')
            THEN
               ins_hco_activity_queue
                (
                    p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                    p_ACT_STATUS_TS                     =>  l_mail_start_date,
                    p_ACT_OWNER                         =>  c_automated_process,
                    p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                    p_ACT_CASE_ID                       =>  l_case_id,
                    p_ACT_CLIENT_ID                     =>  l_client_num,
                    p_ACT_DCN                           =>  rec.DCN,
                    p_ACT_REF_ID                        =>  rec.exemption_id,
                    p_ACT_REF_TYPE                      =>  c_exemption,
                    p_ACT_STEP_DEFINITION_ID            =>  6,
                    p_ACT_PROCESS_ID                    =>  1,
                    p_ACT_CREATED_BY                    =>  c_automated_process,
                    p_ACT_CREATE_TS                     =>  l_mail_start_date,                    
                    p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
                );

              ins_hco_activity_queue
                (
                    p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
                    p_ACT_STATUS_TS                     =>  l_mail_end_date,
                    p_ACT_OWNER                         =>  c_automated_process,
                    p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                    p_ACT_CASE_ID                       =>  l_case_id,
                    p_ACT_CLIENT_ID                     =>  l_client_num,
                    p_ACT_DCN                           =>  rec.DCN,
                    p_ACT_REF_ID                        =>  rec.exemption_id,
                    p_ACT_REF_TYPE                      =>  c_exemption,
                    p_ACT_STEP_DEFINITION_ID            =>  6,
                    p_ACT_PROCESS_ID                    =>  1,
                    p_ACT_CREATED_BY                    =>  c_automated_process,
                    p_ACT_CREATE_TS                     =>  l_mail_start_date,                    
                    p_ACT_COMMENTS                      =>  'creating because final exemption status'
                );

            END IF;
        END IF;

    END IF;
*/

    END         cr_exemption_sh_activities;

    /*****************************************************************************************************************************************************************

        NAME:           proc_emrs_d_exempt_status_hist
        DESCRIPTION:    Process the records in the table EMRS_D_EXEMPT_STATUS_HIST.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created procedure.

    *****************************************************************************************************************************************************************/
    PROCEDURE   proc_emrs_d_exempt_status_hist
    IS

        l_sql                                                                   VARCHAR2(32767);

        l_mw_exemption_sh_proc_dt                                               DATE;

    BEGIN

        IF  CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_string(p_NAME  =>  'MW_PROC_CONTROL')  =   'STOP'
        THEN
            RETURN;
        END IF;

        FOR rec IN c_emrs_d_exempt_status_hist
        LOOP

            IF  CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_string(p_NAME  =>  'MW_PROC_CONTROL')  =   'STOP'
            THEN
                RETURN;
            END IF;

            cr_exemption_sh_activities
            (
                p_exemption_sh_rec                 =>   rec
            );   

            COMMIT;

        END LOOP;

        l_sql   :=  'SELECT MAX(record_date) FROM EMRS_D_EXEMPT_STATUS_HIST WHERE record_date <= sysdate';
        l_mw_exemption_sh_proc_dt	:=	cahco_etl_mw_util_pkg.return_query_date
                                    (
                                        p_SQL	=>  l_sql
                                    );

        CAHCO_ETL_MW_UTIL_PKG.set_corp_etl_control_date
        (
            p_NAME                              =>  'MW_EXEMPTION_SH_PROC_DATE',
            p_DATE                              =>  l_mw_exemption_sh_proc_dt
        );

    END         proc_emrs_d_exempt_status_hist;

   /*****************************************************************************************************************************************************************

        NAME:           cr_exemption_sh_activity_sixes
        DESCRIPTION:    Create activity sixesfrom the Exemption Status History Activity 6 record, p_exemption_sh_six_rec.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        EB                      06/03/2019              Created procedure.
       

    *****************************************************************************************************************************************************************/

    PROCEDURE   cr_exemption_sh_activity_sixes
                (
                    p_exemption_sh_six_rec                 IN                      c_emrs_d_exempt_status_hist_sixes%ROWTYPE
                )
    IS          
        rec                                                                     c_emrs_d_exempt_status_hist_sixes%ROWTYPE;                  
        l_hco_activity_queue_rec_exists                                         PLS_INTEGER;
        most_recent_info_rec                                                    step_activity_info_rec;


    BEGIN

        rec :=  p_exemption_sh_six_rec;

               ins_hco_activity_queue
                (
                    p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                    p_ACT_STATUS_TS                     =>  rec.mail_start_date,
                    p_ACT_OWNER                         =>  c_automated_process,
                    p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                    p_ACT_CASE_ID                       =>  rec.case_id,
                    p_ACT_CLIENT_ID                     =>  rec.client_number,
                    p_ACT_DCN                           =>  rec.DCN,
                    p_ACT_REF_ID                        =>  rec.exemption_id,
                    p_ACT_REF_TYPE                      =>  c_exemption,
                    p_ACT_STEP_DEFINITION_ID            =>  6,
                    p_ACT_PROCESS_ID                    =>  1,
                    p_ACT_CREATED_BY                    =>  c_automated_process,
                    p_ACT_CREATE_TS                     =>  rec.mail_start_date,                    
                    p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
                );

              ins_hco_activity_queue
                (
                    p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
                    p_ACT_STATUS_TS                     =>  rec.mail_end_date,
                    p_ACT_OWNER                         =>  c_automated_process,
                    p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                    p_ACT_CASE_ID                       =>  rec.case_id,
                    p_ACT_CLIENT_ID                     =>  rec.client_number,
                    p_ACT_DCN                           =>  rec.DCN,
                    p_ACT_REF_ID                        =>  rec.exemption_id,
                    p_ACT_REF_TYPE                      =>  c_exemption,
                    p_ACT_STEP_DEFINITION_ID            =>  6,
                    p_ACT_PROCESS_ID                    =>  1,
                    p_ACT_CREATED_BY                    =>  c_automated_process,
                    p_ACT_CREATE_TS                     =>  rec.mail_start_date,                    
                    p_ACT_COMMENTS                      =>  'creating because final exemption status'
                );





    END         cr_exemption_sh_activity_sixes;

    /*****************************************************************************************************************************************************************

        NAME:           proc_emrs_d_exempt_status_hist_activity_six
        DESCRIPTION:    Create activity 6 records from records in the table EMRS_D_EXEMPT_STATUS_HIST.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        EDB                     06/03/2019              Created procedure.

    *****************************************************************************************************************************************************************/

    PROCEDURE   proc_emrs_d_exempt_status_hist_activity_six
    IS

        l_sql                                                                   VARCHAR2(32767);

        l_mw_exemption_sh_proc_six_dt                                               DATE;
        l_mw_exemption_sh_proc_six_mail_dt                                          DATE;

    BEGIN

        IF  CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_string(p_NAME  =>  'MW_PROC_CONTROL')  =   'STOP'
        THEN
            RETURN;
        END IF;

        l_sql   :=  'SELECT MAX(record_date) FROM EMRS_D_EXEMPT_STATUS_HIST WHERE record_date <= sysdate';

        l_mw_exemption_sh_proc_six_dt	:=	cahco_etl_mw_util_pkg.return_query_date
                                    (
                                        p_SQL	=>  l_sql
                                    );



        l_sql   :=  'SELECT MAX(date_updated) from HCO_D_LETTER_MAILING WHERE date_updated <= sysdate';

		l_mw_exemption_sh_proc_six_mail_dt	:=	cahco_etl_mw_util_pkg.return_query_date
                                    (
                                        p_SQL	=>  l_sql
                                    );

        FOR rec IN c_emrs_d_exempt_status_hist_sixes
        LOOP

            IF  CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_string(p_NAME  =>  'MW_PROC_CONTROL')  =   'STOP'
            THEN
                RETURN;
            END IF;

            cr_exemption_sh_activity_sixes
            (
                p_exemption_sh_six_rec                 =>   rec
            );   

            COMMIT;

        END LOOP;


        	CAHCO_ETL_MW_UTIL_PKG.set_corp_etl_control_date
        	(
            		p_NAME                              =>  'MW_EXEMPTION_SH_PROC_SIX_DATE',
            		p_DATE                              =>  l_mw_exemption_sh_proc_six_dt
        	);


	        CAHCO_ETL_MW_UTIL_PKG.set_corp_etl_control_date
        	(
            		p_NAME                              =>  'MW_EXEMPTION_SH_PROC_SIX_MAIL_DATE',
            		p_DATE                              =>  l_mw_exemption_sh_proc_six_mail_dt
        	);


    END         proc_emrs_d_exempt_status_hist_activity_six;


    /*****************************************************************************************************************************************************************

        NAME:           cr_eder_activities
        DESCRIPTION:    Create EDER activities from the EDER record, p_eder_rec.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created procedure.
        TAM                     06/03/2019              MAXDAT-9691:  Added logic to set task end date to the start date when the end date is less than the start date
                                                        for activity 7.
        
    *****************************************************************************************************************************************************************/
    PROCEDURE   cr_eder_activities
                (
                    p_eder_rec                          IN                      c_emrs_d_emrgcy_disenroll%ROWTYPE
                )
    IS          
        rec                                                                     c_emrs_d_emrgcy_disenroll%ROWTYPE;
    BEGIN

        rec :=  p_eder_rec;

        FOR birec IN c_batch_info(  cp_DCN  =>  rec.DCN )
        LOOP

            IF  birec.PERFORM_SCAN_START IS NOT NULL
            THEN

                ins_hco_activity_queue
                (
                    p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                    p_ACT_STATUS_TS                     =>  birec.PERFORM_SCAN_START,
                    p_ACT_OWNER                         =>  birec.CREATION_USER_ID,
                    p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                    p_ACT_CASE_ID                       =>  NULL,
                    p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                    p_ACT_DCN                           =>  rec.DCN,
                    p_ACT_REF_ID                        =>  rec.EMRGCY_DISENROLL_ID,
                    p_ACT_REF_TYPE                      =>  c_eder,
                    p_ACT_STEP_DEFINITION_ID            =>  1,
                    p_ACT_PROCESS_ID                    =>  1,
                    p_ACT_CREATED_BY                    =>  birec.CREATION_USER_ID,
                    p_ACT_CREATE_TS                     =>  birec.PERFORM_SCAN_START,
                    p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
                );

                IF  birec.PERFORM_SCAN_END IS NOT NULL
                THEN

                    ins_hco_activity_queue
                    (
                        p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
                        p_ACT_STATUS_TS                     =>  birec.PERFORM_SCAN_END,
                        p_ACT_OWNER                         =>  birec.CREATION_USER_ID,
                        p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                        p_ACT_CASE_ID                       =>  NULL,
                        p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                        p_ACT_DCN                           =>  rec.DCN,
                        p_ACT_REF_ID                        =>  rec.EMRGCY_DISENROLL_ID,
                        p_ACT_REF_TYPE                      =>  c_eder,
                        p_ACT_STEP_DEFINITION_ID            =>  1,
                        p_ACT_PROCESS_ID                    =>  1,
                        p_ACT_CREATED_BY                    =>  birec.CREATION_USER_ID,
                        p_ACT_CREATE_TS                     =>  birec.PERFORM_SCAN_START,
                        p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
                    );

                    ins_hco_activity_queue
                    (
                        p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                        p_ACT_STATUS_TS                     =>  birec.PERFORM_SCAN_END,
                        p_ACT_OWNER                         =>  birec.CREATION_USER_ID,
                        p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                        p_ACT_CASE_ID                       =>  NULL,
                        p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                        p_ACT_DCN                           =>  rec.DCN,
                        p_ACT_REF_ID                        =>  rec.EMRGCY_DISENROLL_ID,
                        p_ACT_REF_TYPE                      =>  c_eder,
                        p_ACT_STEP_DEFINITION_ID            =>  2,
                        p_ACT_PROCESS_ID                    =>  1,
                        p_ACT_CREATED_BY                    =>  birec.CREATION_USER_ID,
                        p_ACT_CREATE_TS                     =>  birec.PERFORM_SCAN_END,
                        p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
                    );

                END IF;

            END IF;

            IF  birec.RELEASE_TO_DMS_START IS NOT NULL
            THEN

                IF  birec.PERFORM_SCAN_END IS NOT NULL
                THEN
                    ins_hco_activity_queue
                    (
                        p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
                        p_ACT_STATUS_TS                     =>  birec.RELEASE_TO_DMS_START,
                        p_ACT_OWNER                         =>  birec.CREATION_USER_ID,
                        p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                        p_ACT_CASE_ID                       =>  NULL,
                        p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                        p_ACT_DCN                           =>  rec.DCN,
                        p_ACT_REF_ID                        =>  rec.EMRGCY_DISENROLL_ID,
                        p_ACT_REF_TYPE                      =>  c_eder,
                        p_ACT_STEP_DEFINITION_ID            =>  2,
                        p_ACT_PROCESS_ID                    =>  1,
                        p_ACT_CREATED_BY                    =>  birec.CREATION_USER_ID,
                        p_ACT_CREATE_TS                     =>  birec.PERFORM_SCAN_END,
                        p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
                    );
                END IF;

                ins_hco_activity_queue
                (
                    p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                    p_ACT_STATUS_TS                     =>  birec.RELEASE_TO_DMS_START,
                    p_ACT_OWNER                         =>  birec.CREATION_USER_ID,
                    p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                    p_ACT_CASE_ID                       =>  NULL,
                    p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                    p_ACT_DCN                           =>  rec.DCN,
                    p_ACT_REF_ID                        =>  rec.EMRGCY_DISENROLL_ID,
                    p_ACT_REF_TYPE                      =>  c_eder,
                    p_ACT_STEP_DEFINITION_ID            =>  12,
                    p_ACT_PROCESS_ID                    =>  1,
                    p_ACT_CREATED_BY                    =>  birec.CREATION_USER_ID,
                    p_ACT_CREATE_TS                     =>  birec.RELEASE_TO_DMS_START,
                    p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
                );

                IF  birec.RELEASE_TO_DMS_END IS NOT NULL
                THEN

                    ins_hco_activity_queue
                    (
                        p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
                        p_ACT_STATUS_TS                     =>  birec.RELEASE_TO_DMS_END,
                        p_ACT_OWNER                         =>  birec.CREATION_USER_ID,
                        p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                        p_ACT_CASE_ID                       =>  NULL,
                        p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                        p_ACT_DCN                           =>  rec.DCN,
                        p_ACT_REF_ID                        =>  rec.EMRGCY_DISENROLL_ID,
                        p_ACT_REF_TYPE                      =>  c_eder,
                        p_ACT_STEP_DEFINITION_ID            =>  12,
                        p_ACT_PROCESS_ID                    =>  1,
                        p_ACT_CREATED_BY                    =>  birec.CREATION_USER_ID,
                        p_ACT_CREATE_TS                     =>  birec.RELEASE_TO_DMS_START,
                        p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
                    );

                    ins_hco_activity_queue
                    (
                        p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                        p_ACT_STATUS_TS                     =>  birec.RELEASE_TO_DMS_END,
                        p_ACT_OWNER                         =>  rec.RECORD_NAME,
                        p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                        p_ACT_CASE_ID                       =>  NULL,
                        p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                        p_ACT_DCN                           =>  rec.DCN,
                        p_ACT_REF_ID                        =>  rec.EMRGCY_DISENROLL_ID,
                        p_ACT_REF_TYPE                      =>  c_eder,
                        p_ACT_STEP_DEFINITION_ID            =>  7,
                        p_ACT_PROCESS_ID                    =>  1,
                        p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
                        p_ACT_CREATE_TS                     =>  birec.RELEASE_TO_DMS_END,
                        p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
                    );

                    ins_hco_activity_queue
                    (
                        p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
                        p_ACT_STATUS_TS                     =>  CASE WHEN rec.RECORD_DATE < birec.RELEASE_TO_DMS_END THEN birec.RELEASE_TO_DMS_END ELSE rec.RECORD_DATE END,
                        p_ACT_OWNER                         =>  rec.RECORD_NAME,
                        p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                        p_ACT_CASE_ID                       =>  NULL,
                        p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                        p_ACT_DCN                           =>  rec.DCN,
                        p_ACT_REF_ID                        =>  rec.EMRGCY_DISENROLL_ID,
                        p_ACT_REF_TYPE                      =>  c_eder,
                        p_ACT_STEP_DEFINITION_ID            =>  7,
                        p_ACT_PROCESS_ID                    =>  1,
                        p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
                        p_ACT_CREATE_TS                     =>  birec.RELEASE_TO_DMS_END,
                        p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
                    );

                END IF;

            END IF;

        END LOOP;

        ins_hco_activity_queue
        (
            p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_unclaimed,
            p_ACT_STATUS_TS                     =>  rec.RECORD_DATE,
            p_ACT_OWNER                         =>  NULL,
            p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
            p_ACT_CASE_ID                       =>  NULL,
            p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
            p_ACT_DCN                           =>  rec.DCN,
            p_ACT_REF_ID                        =>  rec.EMRGCY_DISENROLL_ID,
            p_ACT_REF_TYPE                      =>  c_eder,
            p_ACT_STEP_DEFINITION_ID            =>  8,
            p_ACT_PROCESS_ID                    =>  1,
            p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
            p_ACT_CREATE_TS                     =>  rec.RECORD_DATE,
            p_ACT_COMMENTS                      =>  'creating from disenroll table',
	    p_ACT_STEP_SEQUENCE			=>  0
        );

    END         cr_eder_activities;
    /*****************************************************************************************************************************************************************

        NAME:           proc_emrs_d_emrgcy_disenroll
        DESCRIPTION:    Process the records in the table EMRS_D_EMRGCY_DISENROLL.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created procedure.

    *****************************************************************************************************************************************************************/
    PROCEDURE   proc_emrs_d_emrgcy_disenroll
    IS

        l_sql                                                                   VARCHAR2(32767);
        l_mw_eder_proc_dt                                                       DATE;

    BEGIN

        IF  CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_string(p_NAME  =>  'MW_PROC_CONTROL')  =   'STOP'
        THEN
            RETURN;
        END IF;

        FOR rec IN c_emrs_d_emrgcy_disenroll
        LOOP

            IF  CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_string(p_NAME  =>  'MW_PROC_CONTROL')  =   'STOP'
            THEN
                RETURN;
            END IF;

            IF  l_mw_eder_proc_dt IS NULL
            THEN
                l_mw_eder_proc_dt    :=  rec.modified_date;
            ELSIF       rec.modified_date   >   l_mw_eder_proc_dt
                    AND rec.modified_date   <=  SYSDATE
            THEN
                l_mw_eder_proc_dt    :=  rec.modified_date;  
            END IF;

            cr_eder_activities
            (
                p_eder_rec                          =>  rec
            );           

            COMMIT;

        END LOOP;

        l_sql   :=  'SELECT MAX(modified_date) FROM EMRS_D_EMRGCY_DISENROLL WHERE modified_date <= sysdate';
        l_mw_eder_proc_dt	:=	cahco_etl_mw_util_pkg.return_query_date
                                (
                                    p_SQL	=>  l_sql
                                );

        CAHCO_ETL_MW_UTIL_PKG.set_corp_etl_control_date
        (
            p_NAME                              =>  'MW_EDER_PROC_DATE',
            p_DATE                              =>  l_mw_eder_proc_dt
        );

    END         proc_emrs_d_emrgcy_disenroll;
    /*****************************************************************************************************************************************************************

        NAME:           cr_eder_hist_activities
        DESCRIPTION:    Create EDER History activities from the EDER History record, p_eder_hist_rec.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created procedure.
        EB                      04/28/2019              Modified for MAXDAT-9243
    *****************************************************************************************************************************************************************/
    PROCEDURE   cr_eder_hist_activities
                (
                    p_eder_hist_rec                     IN                      c_proc_emrs_d_emrgcy_denr_hist%ROWTYPE
                )
    IS          
        rec                                                                     c_proc_emrs_d_emrgcy_denr_hist%ROWTYPE;   
        l_hco_activity_queue_rec_exists                                         PLS_INTEGER;
        most_recent_info_rec                                                    step_activity_info_rec;
        activity_type_to_close                                                  NUMBER;    
        create_ts_to_close                                                      DATE;
	step_sequence_to_use							NUMBER;

    BEGIN

        rec :=  p_eder_hist_rec;
    ---------------------------------------------------------------------------------------------------
    IF rec.emrgcy_denr_status_code = 'P' --Pending DHCS Review
    THEN
        --close the most recent open EDER Process task (8) if one exists
        most_recent_info_rec := get_most_recent_step_or_activity(rec.emrgcy_denr_id, c_eder, 8);
        IF (most_recent_info_rec.create_ts is not null and most_recent_info_rec.status != CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed)
        THEN
            IF most_recent_info_rec.status = CAHCO_ETL_MW_UTIL_PKG.get_mw_status_unclaimed
            THEN
                --if unclaimed create claimed record before closing
                ins_hco_activity_queue
                (
                    p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                    p_ACT_STATUS_TS                     =>  rec.RECORD_DATE,
                    p_ACT_OWNER                         =>  rec.RECORD_NAME,
                    p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                    p_ACT_CASE_ID                       =>  NULL,
                    p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                    p_ACT_DCN                           =>  rec.DCN,
                    p_ACT_REF_ID                        =>  rec.emrgcy_denr_id,
                    p_ACT_REF_TYPE                      =>  c_eder,
                    p_ACT_STEP_DEFINITION_ID            =>  8,
                    p_ACT_PROCESS_ID                    =>  1,
                    p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
                    p_ACT_CREATE_TS                     =>  most_recent_info_rec.create_ts,
                    p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed,
		    p_ACT_STEP_SEQUENCE		        =>  most_recent_info_rec.step_sequence
                );
            END IF;    
        --close
        ins_hco_activity_queue
        (
            p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
            p_ACT_STATUS_TS                     =>  rec.RECORD_DATE,
            p_ACT_OWNER                         =>  rec.RECORD_NAME,
            p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
            p_ACT_CASE_ID                       =>  NULL,
            p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
            p_ACT_DCN                           =>  rec.DCN,
            p_ACT_REF_ID                        =>  rec.EMRGCY_DENR_ID,
            p_ACT_REF_TYPE                      =>  c_eder,
            p_ACT_STEP_DEFINITION_ID            =>  8,
            p_ACT_PROCESS_ID                    =>  1,
            p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
            p_ACT_CREATE_TS                     =>  most_recent_info_rec.create_ts,
            p_ACT_COMMENTS                      =>  'closing because status P',
	    p_ACT_STEP_SEQUENCE		    	=>  most_recent_info_rec.step_sequence
        );
        END IF;
         --close the most recent open Process Retro Disenrollment task (18) if one exists
        most_recent_info_rec := get_most_recent_step_or_activity(rec.emrgcy_denr_id, c_eder, 18);
        IF (most_recent_info_rec.create_ts is not null and most_recent_info_rec.status != CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed)
        THEN
            IF most_recent_info_rec.status = CAHCO_ETL_MW_UTIL_PKG.get_mw_status_unclaimed
            THEN
                --if unclaimed create claimed record before closing
                ins_hco_activity_queue
                (
                    p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                    p_ACT_STATUS_TS                     =>  rec.RECORD_DATE,
                    p_ACT_OWNER                         =>  rec.RECORD_NAME,
                    p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                    p_ACT_CASE_ID                       =>  NULL,
                    p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                    p_ACT_DCN                           =>  rec.DCN,
                    p_ACT_REF_ID                        =>  rec.emrgcy_denr_id,
                    p_ACT_REF_TYPE                      =>  c_eder,
                    p_ACT_STEP_DEFINITION_ID            =>  18,
                    p_ACT_PROCESS_ID                    =>  1,
                    p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
                    p_ACT_CREATE_TS                     =>  most_recent_info_rec.create_ts,
                    p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
                );
            END IF;
        --close
        ins_hco_activity_queue
        (
            p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
            p_ACT_STATUS_TS                     =>  rec.RECORD_DATE,
            p_ACT_OWNER                         =>  rec.RECORD_NAME,
            p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
            p_ACT_CASE_ID                       =>  NULL,
            p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
            p_ACT_DCN                           =>  rec.DCN,
            p_ACT_REF_ID                        =>  rec.EMRGCY_DENR_ID,
            p_ACT_REF_TYPE                      =>  c_eder,
            p_ACT_STEP_DEFINITION_ID            =>  18,
            p_ACT_PROCESS_ID                    =>  1,
            p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
            p_ACT_CREATE_TS                     =>  most_recent_info_rec.create_ts,
            p_ACT_COMMENTS                      =>  'closing because status P'
        );
        END IF;

        --create a new task for DHCS EDER Review (17)
        most_recent_info_rec := get_most_recent_step_or_activity(rec.emrgcy_denr_id, c_eder, 17);
        IF (most_recent_info_rec.create_ts is null or most_recent_info_rec.status = CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed)
        THEN
            ins_hco_activity_queue
            (
                p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_unclaimed,
                p_ACT_STATUS_TS                     =>  rec.RECORD_DATE,
                p_ACT_OWNER                         =>  NULL,
                p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                p_ACT_CASE_ID                       =>  NULL,
                p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                p_ACT_DCN                           =>  rec.DCN,
                p_ACT_REF_ID                        =>  rec.emrgcy_denr_id,
                p_ACT_REF_TYPE                      =>  c_eder,
                p_ACT_STEP_DEFINITION_ID            =>  17,
                p_ACT_PROCESS_ID                    =>  1,
                p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
                p_ACT_CREATE_TS                     =>  rec.RECORD_DATE,
                p_ACT_COMMENTS                      =>  'creating because status P'
            );
        END IF;
    END IF;
    ---------------------------------------------------------------------------------------------------
    IF (rec.emrgcy_denr_status_code in ('R','N') AND is_eder_status_code_a_duplicate(rec.emrgcy_denr_hist_id, rec.emrgcy_denr_id, rec.emrgcy_denr_status_code) = CAHCO_ETL_MW_UTIL_PKG.is_false)
	--DHCS Returned to Maximus or Pendinng Maximus
    THEN
        --close the most recent open DHCS EDER Review task (17) if one exists
        most_recent_info_rec := get_most_recent_step_or_activity(rec.emrgcy_denr_id, c_eder, 17);
        IF (most_recent_info_rec.create_ts is not null and most_recent_info_rec.status != CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed)
        THEN
            IF most_recent_info_rec.status = CAHCO_ETL_MW_UTIL_PKG.get_mw_status_unclaimed
            THEN
                --if unclaimed create claimed record before closing
                ins_hco_activity_queue
                (
                    p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                    p_ACT_STATUS_TS                     =>  rec.RECORD_DATE,
                    p_ACT_OWNER                         =>  rec.RECORD_NAME,
                    p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                    p_ACT_CASE_ID                       =>  NULL,
                    p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                    p_ACT_DCN                           =>  rec.DCN,
                    p_ACT_REF_ID                        =>  rec.emrgcy_denr_id,
                    p_ACT_REF_TYPE                      =>  c_eder,
                    p_ACT_STEP_DEFINITION_ID            =>  17,
                    p_ACT_PROCESS_ID                    =>  1,
                    p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
                    p_ACT_CREATE_TS                     =>  most_recent_info_rec.create_ts,
                    p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
                );
            END IF;            
        --close
        ins_hco_activity_queue
        (
            p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
            p_ACT_STATUS_TS                     =>  rec.RECORD_DATE,
            p_ACT_OWNER                         =>  rec.RECORD_NAME,
            p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
            p_ACT_CASE_ID                       =>  NULL,
            p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
            p_ACT_DCN                           =>  rec.DCN,
            p_ACT_REF_ID                        =>  rec.EMRGCY_DENR_ID,
            p_ACT_REF_TYPE                      =>  c_eder,
            p_ACT_STEP_DEFINITION_ID            =>  17,
            p_ACT_PROCESS_ID                    =>  1,
            p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
            p_ACT_CREATE_TS                     =>  most_recent_info_rec.create_ts,
            p_ACT_COMMENTS                      =>  'closing because status R or N'
        );
        END IF;

         --close the most recent open Process Retro Disenrollment task (18) if one exists
        most_recent_info_rec := get_most_recent_step_or_activity(rec.emrgcy_denr_id, c_eder, 18);
        IF (most_recent_info_rec.create_ts is not null and most_recent_info_rec.status != CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed)
        THEN
            IF most_recent_info_rec.status = CAHCO_ETL_MW_UTIL_PKG.get_mw_status_unclaimed
            THEN
                --if unclaimed create claimed record before closing
                ins_hco_activity_queue
                (
                    p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                    p_ACT_STATUS_TS                     =>  rec.RECORD_DATE,
                    p_ACT_OWNER                         =>  rec.RECORD_NAME,
                    p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                    p_ACT_CASE_ID                       =>  NULL,
                    p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                    p_ACT_DCN                           =>  rec.DCN,
                    p_ACT_REF_ID                        =>  rec.emrgcy_denr_id,
                    p_ACT_REF_TYPE                      =>  c_eder,
                    p_ACT_STEP_DEFINITION_ID            =>  18,
                    p_ACT_PROCESS_ID                    =>  1,
                    p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
                    p_ACT_CREATE_TS                     =>  most_recent_info_rec.create_ts,
                    p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
                );
            END IF;
        --close
        ins_hco_activity_queue
        (
            p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
            p_ACT_STATUS_TS                     =>  rec.RECORD_DATE,
            p_ACT_OWNER                         =>  rec.RECORD_NAME,
            p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
            p_ACT_CASE_ID                       =>  NULL,
            p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
            p_ACT_DCN                           =>  rec.DCN,
            p_ACT_REF_ID                        =>  rec.EMRGCY_DENR_ID,
            p_ACT_REF_TYPE                      =>  c_eder,
            p_ACT_STEP_DEFINITION_ID            =>  18,
            p_ACT_PROCESS_ID                    =>  1,
            p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
            p_ACT_CREATE_TS                     =>  most_recent_info_rec.create_ts,
            p_ACT_COMMENTS                      =>  'closing because status R or N'
        );
        END IF;

        --close the most recent open EDER Process task (8) if one exists
        most_recent_info_rec := get_most_recent_step_or_activity(rec.emrgcy_denr_id, c_eder, 8);
        IF (most_recent_info_rec.create_ts is not null and most_recent_info_rec.status != CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed)
        THEN
            IF most_recent_info_rec.status = CAHCO_ETL_MW_UTIL_PKG.get_mw_status_unclaimed
            THEN
                --if unclaimed create claimed record before closing
                ins_hco_activity_queue
                (
                    p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                    p_ACT_STATUS_TS                     =>  rec.RECORD_DATE,
                    p_ACT_OWNER                         =>  rec.RECORD_NAME,
                    p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                    p_ACT_CASE_ID                       =>  NULL,
                    p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                    p_ACT_DCN                           =>  rec.DCN,
                    p_ACT_REF_ID                        =>  rec.emrgcy_denr_id,
                    p_ACT_REF_TYPE                      =>  c_eder,
                    p_ACT_STEP_DEFINITION_ID            =>  8,
                    p_ACT_PROCESS_ID                    =>  1,
                    p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
                    p_ACT_CREATE_TS                     =>  most_recent_info_rec.create_ts,
                    p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed,
		    p_ACT_STEP_SEQUENCE		    	=>  most_recent_info_rec.step_sequence
                );
            END IF;    
        --close
        ins_hco_activity_queue
        (
            p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
            p_ACT_STATUS_TS                     =>  rec.RECORD_DATE,
            p_ACT_OWNER                         =>  rec.RECORD_NAME,
            p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
            p_ACT_CASE_ID                       =>  NULL,
            p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
            p_ACT_DCN                           =>  rec.DCN,
            p_ACT_REF_ID                        =>  rec.EMRGCY_DENR_ID,
            p_ACT_REF_TYPE                      =>  c_eder,
            p_ACT_STEP_DEFINITION_ID            =>  8,
            p_ACT_PROCESS_ID                    =>  1,
            p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
            p_ACT_CREATE_TS                     =>  most_recent_info_rec.create_ts,
            p_ACT_COMMENTS                      =>  'closing because status R or N',
	    p_ACT_STEP_SEQUENCE		    	=>  most_recent_info_rec.step_sequence
        );
        END IF;        

        --create a new task for EDER Process (8)
        most_recent_info_rec := get_most_recent_step_or_activity(rec.emrgcy_denr_id, c_eder, 8);
        IF (most_recent_info_rec.create_ts is null or most_recent_info_rec.status = CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed)
        THEN
	    step_sequence_to_use := CASE WHEN rec.emrgcy_denr_status_code = 'N' THEN 2 ELSE 1 END;	
            ins_hco_activity_queue
            (
                p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_unclaimed,
                p_ACT_STATUS_TS                     =>  rec.RECORD_DATE,
                p_ACT_OWNER                         =>  NULL,
                p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                p_ACT_CASE_ID                       =>  NULL,
                p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                p_ACT_DCN                           =>  rec.DCN,
                p_ACT_REF_ID                        =>  rec.emrgcy_denr_id,
                p_ACT_REF_TYPE                      =>  c_eder,
                p_ACT_STEP_DEFINITION_ID            =>  8,
                p_ACT_PROCESS_ID                    =>  1,
                p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
                p_ACT_CREATE_TS                     =>  rec.RECORD_DATE,
                p_ACT_COMMENTS                      =>  'creating because status R or N',
	    	p_ACT_STEP_SEQUENCE		    =>  step_sequence_to_use
            );
        END IF;
    END IF;
    --------------------------------------------------------------------------------------------------
    IF rec.emrgcy_denr_status_code in ('1','3') --DHCS Returned to Maximus or Pendinng Maximus
    THEN
        --close the most recent open DHCS EDER Review task (17) if one exists
        most_recent_info_rec := get_most_recent_step_or_activity(rec.emrgcy_denr_id, c_eder, 17);
        IF (most_recent_info_rec.create_ts is not null and most_recent_info_rec.status != CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed)
        THEN
            IF most_recent_info_rec.status = CAHCO_ETL_MW_UTIL_PKG.get_mw_status_unclaimed
            THEN
                --if unclaimed create claimed record before closing
                ins_hco_activity_queue
                (
                    p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                    p_ACT_STATUS_TS                     =>  rec.RECORD_DATE,
                    p_ACT_OWNER                         =>  rec.RECORD_NAME,
                    p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                    p_ACT_CASE_ID                       =>  NULL,
                    p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                    p_ACT_DCN                           =>  rec.DCN,
                    p_ACT_REF_ID                        =>  rec.emrgcy_denr_id,
                    p_ACT_REF_TYPE                      =>  c_eder,
                    p_ACT_STEP_DEFINITION_ID            =>  17,
                    p_ACT_PROCESS_ID                    =>  1,
                    p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
                    p_ACT_CREATE_TS                     =>  most_recent_info_rec.create_ts,
                    p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
                );
            END IF;            
        --close
        ins_hco_activity_queue
        (
            p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
            p_ACT_STATUS_TS                     =>  rec.RECORD_DATE,
            p_ACT_OWNER                         =>  rec.RECORD_NAME,
            p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
            p_ACT_CASE_ID                       =>  NULL,
            p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
            p_ACT_DCN                           =>  rec.DCN,
            p_ACT_REF_ID                        =>  rec.EMRGCY_DENR_ID,
            p_ACT_REF_TYPE                      =>  c_eder,
            p_ACT_STEP_DEFINITION_ID            =>  17,
            p_ACT_PROCESS_ID                    =>  1,
            p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
            p_ACT_CREATE_TS                     =>  most_recent_info_rec.create_ts,
            p_ACT_COMMENTS                      =>  'closing because status 1 or 3'
        );
        END IF;

         --close the most recent open EDER Process task (8) if one exists
        most_recent_info_rec := get_most_recent_step_or_activity(rec.emrgcy_denr_id, c_eder, 8);
        IF (most_recent_info_rec.create_ts is not null and most_recent_info_rec.status != CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed)
        THEN
            IF most_recent_info_rec.status = CAHCO_ETL_MW_UTIL_PKG.get_mw_status_unclaimed
            THEN
                --if unclaimed create claimed record before closing
                ins_hco_activity_queue
                (
                    p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                    p_ACT_STATUS_TS                     =>  rec.RECORD_DATE,
                    p_ACT_OWNER                         =>  rec.RECORD_NAME,
                    p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                    p_ACT_CASE_ID                       =>  NULL,
                    p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                    p_ACT_DCN                           =>  rec.DCN,
                    p_ACT_REF_ID                        =>  rec.emrgcy_denr_id,
                    p_ACT_REF_TYPE                      =>  c_eder,
                    p_ACT_STEP_DEFINITION_ID            =>  8,
                    p_ACT_PROCESS_ID                    =>  1,
                    p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
                    p_ACT_CREATE_TS                     =>  most_recent_info_rec.create_ts,
                    p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed,
		    p_ACT_STEP_SEQUENCE		    	=>  most_recent_info_rec.step_sequence
                );
            END IF;
        --close    
        ins_hco_activity_queue
        (
            p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
            p_ACT_STATUS_TS                     =>  rec.RECORD_DATE,
            p_ACT_OWNER                         =>  rec.RECORD_NAME,
            p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
            p_ACT_CASE_ID                       =>  NULL,
            p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
            p_ACT_DCN                           =>  rec.DCN,
            p_ACT_REF_ID                        =>  rec.EMRGCY_DENR_ID,
            p_ACT_REF_TYPE                      =>  c_eder,
            p_ACT_STEP_DEFINITION_ID            =>  8,
            p_ACT_PROCESS_ID                    =>  1,
            p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
            p_ACT_CREATE_TS                     =>  most_recent_info_rec.create_ts,
            p_ACT_COMMENTS                      =>  'closing because status 1 or 3',
	    p_ACT_STEP_SEQUENCE		    	=>  most_recent_info_rec.step_sequence
        );
        END IF;

        --create a new task for Process Retro Disenrollment (18)
        most_recent_info_rec := get_most_recent_step_or_activity(rec.emrgcy_denr_id, c_eder, 18);
        IF (most_recent_info_rec.create_ts is null or most_recent_info_rec.status = CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed)
        THEN
            ins_hco_activity_queue
            (
                p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_unclaimed,
                p_ACT_STATUS_TS                     =>  rec.RECORD_DATE,
                p_ACT_OWNER                         =>  NULL,
                p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                p_ACT_CASE_ID                       =>  NULL,
                p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                p_ACT_DCN                           =>  rec.DCN,
                p_ACT_REF_ID                        =>  rec.emrgcy_denr_id,
                p_ACT_REF_TYPE                      =>  c_eder,
                p_ACT_STEP_DEFINITION_ID            =>  18,
                p_ACT_PROCESS_ID                    =>  1,
                p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
                p_ACT_CREATE_TS                     =>  rec.RECORD_DATE,
                p_ACT_COMMENTS                      =>  'creating because status 1 or 3'
            );
        END IF;
    END IF;    
    --------------------------------------------------------------------------------------------------
    -- At any point, if a history record comes in that is not one of the above, but which has a final status, we CLOSE whatever task is currently open.
    IF (rec.final_status    =   CAHCO_ETL_MW_UTIL_PKG.is_yes and rec.emrgcy_denr_status_code not in ('P','R','N','1','3'))
    THEN
        --determine which task is open
        most_recent_info_rec := get_most_recent_step_or_activity(rec.emrgcy_denr_id, c_eder, 8);
        IF (most_recent_info_rec.create_ts is not null and most_recent_info_rec.status != CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed)
        THEN
            activity_type_to_close := 8;
            create_ts_to_close := most_recent_info_rec.create_ts;
        ELSE
            most_recent_info_rec := get_most_recent_step_or_activity(rec.emrgcy_denr_id, c_eder, 17);
            IF (most_recent_info_rec.create_ts is not null and most_recent_info_rec.status != CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed)
            THEN
                activity_type_to_close := 17;
                create_ts_to_close := most_recent_info_rec.create_ts;
            ELSE
                most_recent_info_rec := get_most_recent_step_or_activity(rec.emrgcy_denr_id, c_eder, 18);
                IF (most_recent_info_rec.create_ts is not null and most_recent_info_rec.status != CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed)
                THEN
                    activity_type_to_close := 18;
                    create_ts_to_close := most_recent_info_rec.create_ts;
                ELSE
                    activity_type_to_close := null;
                END IF;
            END IF;
        END IF;

        --close task
        IF activity_type_to_close is not null
        THEN
            IF (most_recent_info_rec.status = CAHCO_ETL_MW_UTIL_PKG.get_mw_status_unclaimed)
            THEN
                --if unclaimed create claimed record before closing
                ins_hco_activity_queue
                (
                    p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                    p_ACT_STATUS_TS                     =>  rec.RECORD_DATE,
                    p_ACT_OWNER                         =>  rec.RECORD_NAME,
                    p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                    p_ACT_CASE_ID                       =>  NULL,
                    p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                    p_ACT_DCN                           =>  rec.DCN,
                    p_ACT_REF_ID                        =>  rec.emrgcy_denr_id,
                    p_ACT_REF_TYPE                      =>  c_eder,
                    p_ACT_STEP_DEFINITION_ID            =>  activity_type_to_close,
                    p_ACT_PROCESS_ID                    =>  1,
                    p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
                    p_ACT_CREATE_TS                     =>  create_ts_to_close,
                    p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed,
		    p_ACT_STEP_SEQUENCE		    	=>  most_recent_info_rec.step_sequence
                );
            END IF;
        --close    
        ins_hco_activity_queue
        (
            p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
            p_ACT_STATUS_TS                     =>  rec.RECORD_DATE,
            p_ACT_OWNER                         =>  rec.RECORD_NAME,
            p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
            p_ACT_CASE_ID                       =>  NULL,
            p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
            p_ACT_DCN                           =>  rec.DCN,
            p_ACT_REF_ID                        =>  rec.EMRGCY_DENR_ID,
            p_ACT_REF_TYPE                      =>  c_eder,
            p_ACT_STEP_DEFINITION_ID            =>  activity_type_to_close,
            p_ACT_PROCESS_ID                    =>  1,
            p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
            p_ACT_CREATE_TS                     =>  create_ts_to_close,
            p_ACT_COMMENTS                      =>  'closing because another final status',
	    p_ACT_STEP_SEQUENCE		        =>  most_recent_info_rec.step_sequence
        );
        END IF;

    END IF;

    END         cr_eder_hist_activities;
   /*****************************************************************************************************************************************************************

        NAME:           proc_emrs_d_emrgcy_denr_hist
        DESCRIPTION:    Process the records in the table EMRS_D_EMRGCY_DENR_HIST.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created procedure.

    *****************************************************************************************************************************************************************/
    PROCEDURE   proc_emrs_d_emrgcy_denr_hist
    IS

        l_sql                                                                   VARCHAR2(32767);
        l_mw_eder_sh_proc_dt                                                    DATE;

    BEGIN

        IF  CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_string(p_NAME  =>  'MW_PROC_CONTROL')  =   'STOP'
        THEN
            RETURN;
        END IF;

        FOR rec IN c_proc_emrs_d_emrgcy_denr_hist
        LOOP

            IF  CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_string(p_NAME  =>  'MW_PROC_CONTROL')  =   'STOP'
            THEN
                RETURN;
            END IF;

            cr_eder_hist_activities
            (
                p_eder_hist_rec                     =>  rec
            );

            COMMIT;

        END LOOP;

        l_sql   :=  'SELECT MAX(record_date) FROM EMRS_D_EMRGCY_DENR_HIST WHERE record_date <= sysdate';
        l_mw_eder_sh_proc_dt    :=	cahco_etl_mw_util_pkg.return_query_date
                                    (
                                        p_SQL	=>  l_sql
                                    );

        CAHCO_ETL_MW_UTIL_PKG.set_corp_etl_control_date
        (
            p_NAME                              =>  'MW_EDER_SH_PROC_DATE',
            p_DATE                              =>  l_mw_eder_sh_proc_dt
        );

    END         proc_emrs_d_emrgcy_denr_hist;   
    /*****************************************************************************************************************************************************************

        NAME:           cr_enrollment_activities
        DESCRIPTION:    Create Enrollment activities from the Enrollment record, p_enrollment_rec.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created procedure.
        TAM                     06/03/2019              MAXDAT-9691:  Added logic to set task end date to the start date when the end date is less than the start date
                                                        for activities 2 and 14.

    *****************************************************************************************************************************************************************/
    PROCEDURE   cr_enrollment_activities
                (
                    p_enrollment_rec                    IN                      c_emrs_f_enrollment%ROWTYPE
                )
    IS          
        l_act_ref_type                                                          HCO_ACTIVITY_QUEUE.act_ref_type%TYPE;
        l_export_batch_date                                                     HCO_ENROLLMENT_EXT.export_batch_date%TYPE;

        rec                                                                     c_emrs_f_enrollment%ROWTYPE;            
    BEGIN

        rec :=  p_enrollment_rec;

        IF  rec.enrollment_trans_type_code IN ('1', '5')
        THEN
            l_act_ref_type  :=  c_enrollment;
        ELSE
            l_act_ref_type  :=  c_disenrollment;
        END IF;

        FOR birec IN c_batch_info(  cp_DCN  =>  rec.DCN )
        LOOP

            IF  birec.PERFORM_SCAN_START IS NOT NULL
            THEN

                ins_hco_activity_queue
                (
                    p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                    p_ACT_STATUS_TS                     =>  birec.PERFORM_SCAN_START,
                    p_ACT_OWNER                         =>  birec.CREATION_USER_ID,
                    p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                    p_ACT_CASE_ID                       =>  NULL,
                    p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                    p_ACT_DCN                           =>  rec.DCN,
                    p_ACT_REF_ID                        =>  rec.ENROLLMENT_ID,
                    p_ACT_REF_TYPE                      =>  l_act_ref_type,
                    p_ACT_STEP_DEFINITION_ID            =>  1,
                    p_ACT_PROCESS_ID                    =>  1,
                    p_ACT_CREATED_BY                    =>  birec.CREATION_USER_ID,
                    p_ACT_CREATE_TS                     =>  birec.PERFORM_SCAN_START,
                    p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
                );

                IF  birec.PERFORM_SCAN_END IS NOT NULL
                THEN

                    ins_hco_activity_queue
                    (
                        p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
                        p_ACT_STATUS_TS                     =>  birec.PERFORM_SCAN_END,
                        p_ACT_OWNER                         =>  birec.CREATION_USER_ID,
                        p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                        p_ACT_CASE_ID                       =>  NULL,
                        p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                        p_ACT_DCN                           =>  rec.DCN,
                        p_ACT_REF_ID                        =>  rec.ENROLLMENT_ID,
                        p_ACT_REF_TYPE                      =>  l_act_ref_type,
                        p_ACT_STEP_DEFINITION_ID            =>  1,
                        p_ACT_PROCESS_ID                    =>  1,
                        p_ACT_CREATED_BY                    =>  birec.CREATION_USER_ID,
                        p_ACT_CREATE_TS                     =>  birec.PERFORM_SCAN_START,
                        p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
                    );

                    ins_hco_activity_queue
                    (
                        p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                        p_ACT_STATUS_TS                     =>  birec.PERFORM_SCAN_END,
                        p_ACT_OWNER                         =>  birec.CREATION_USER_ID,
                        p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                        p_ACT_CASE_ID                       =>  NULL,
                        p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                        p_ACT_DCN                           =>  rec.DCN,
                        p_ACT_REF_ID                        =>  rec.ENROLLMENT_ID,
                        p_ACT_REF_TYPE                      =>  l_act_ref_type,
                        p_ACT_STEP_DEFINITION_ID            =>  2,
                        p_ACT_PROCESS_ID                    =>  1,
                        p_ACT_CREATED_BY                    =>  birec.CREATION_USER_ID,
                        p_ACT_CREATE_TS                     =>  birec.PERFORM_SCAN_END,
                        p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
                    );

                END IF;

            END IF;

            IF      rec.channel_id in ('2')
                AND rec.record_name like 'OCR%'
            THEN
                ins_hco_activity_queue
                (
                    p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
                    p_ACT_STATUS_TS                     =>  CASE WHEN rec.record_date < birec.PERFORM_SCAN_END THEN birec.PERFORM_SCAN_END ELSE rec.record_date END,
                    p_ACT_OWNER                         =>  birec.CREATION_USER_ID,
                    p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                    p_ACT_CASE_ID                       =>  NULL,
                    p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                    p_ACT_DCN                           =>  rec.DCN,
                    p_ACT_REF_ID                        =>  rec.ENROLLMENT_ID,
                    p_ACT_REF_TYPE                      =>  l_act_ref_type,
                    p_ACT_STEP_DEFINITION_ID            =>  2,
                    p_ACT_PROCESS_ID                    =>  1,
                    p_ACT_CREATED_BY                    =>  birec.CREATION_USER_ID,
                    p_ACT_CREATE_TS                     =>  birec.PERFORM_SCAN_END,
                    p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
                );
            ELSIF   birec.RELEASE_TO_DMS_START IS NOT NULL
            THEN
                ins_hco_activity_queue
                (
                    p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
                    p_ACT_STATUS_TS                     =>  birec.RELEASE_TO_DMS_START,
                    p_ACT_OWNER                         =>  birec.CREATION_USER_ID,
                    p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                    p_ACT_CASE_ID                       =>  NULL,
                    p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                    p_ACT_DCN                           =>  rec.DCN,
                    p_ACT_REF_ID                        =>  rec.ENROLLMENT_ID,
                    p_ACT_REF_TYPE                      =>  l_act_ref_type,
                    p_ACT_STEP_DEFINITION_ID            =>  2,
                    p_ACT_PROCESS_ID                    =>  1,
                    p_ACT_CREATED_BY                    =>  birec.CREATION_USER_ID,
                    p_ACT_CREATE_TS                     =>  birec.PERFORM_SCAN_END,
                    p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
                );            
            END IF;

            IF  birec.RELEASE_TO_DMS_START IS NOT NULL
            THEN

                ins_hco_activity_queue
                (
                    p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                    p_ACT_STATUS_TS                     =>  birec.RELEASE_TO_DMS_START,
                    p_ACT_OWNER                         =>  birec.CREATION_USER_ID,
                    p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                    p_ACT_CASE_ID                       =>  NULL,
                    p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                    p_ACT_DCN                           =>  rec.DCN,
                    p_ACT_REF_ID                        =>  rec.ENROLLMENT_ID,
                    p_ACT_REF_TYPE                      =>  l_act_ref_type,
                    p_ACT_STEP_DEFINITION_ID            =>  12,
                    p_ACT_PROCESS_ID                    =>  1,
                    p_ACT_CREATED_BY                    =>  birec.CREATION_USER_ID,
                    p_ACT_CREATE_TS                     =>  birec.RELEASE_TO_DMS_START,
                    p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
                );

                IF  birec.RELEASE_TO_DMS_END IS NOT NULL
                THEN

                    ins_hco_activity_queue
                    (
                        p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
                        p_ACT_STATUS_TS                     =>  birec.RELEASE_TO_DMS_END,
                        p_ACT_OWNER                         =>  birec.CREATION_USER_ID,
                        p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                        p_ACT_CASE_ID                       =>  NULL,
                        p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                        p_ACT_DCN                           =>  rec.DCN,
                        p_ACT_REF_ID                        =>  rec.ENROLLMENT_ID,
                        p_ACT_REF_TYPE                      =>  l_act_ref_type,
                        p_ACT_STEP_DEFINITION_ID            =>  12,
                        p_ACT_PROCESS_ID                    =>  1,
                        p_ACT_CREATED_BY                    =>  birec.CREATION_USER_ID,
                        p_ACT_CREATE_TS                     =>  birec.RELEASE_TO_DMS_START,
                        p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
                    );

                    IF      rec.channel_id not in ('2') 
                        AND rec.enrollment_trans_type_code IN ('1', '2')
                    THEN

                        ins_hco_activity_queue
                        (
                            p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                            p_ACT_STATUS_TS                     =>  birec.RELEASE_TO_DMS_END,
                            p_ACT_OWNER                         =>  rec.MODIFIED_NAME,
                            p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                            p_ACT_CASE_ID                       =>  NULL,
                            p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                            p_ACT_DCN                           =>  rec.DCN,
                            p_ACT_REF_ID                        =>  rec.ENROLLMENT_ID,
                            p_ACT_REF_TYPE                      =>  l_act_ref_type,
                            p_ACT_STEP_DEFINITION_ID            =>  14,
                            p_ACT_PROCESS_ID                    =>  1,
                            p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
                            p_ACT_CREATE_TS                     =>  birec.RELEASE_TO_DMS_END,                                            
                            p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
                        );

                        ins_hco_activity_queue
                        (
                            p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
                            p_ACT_STATUS_TS                     =>  CASE WHEN rec.RECORD_DATE < birec.RELEASE_TO_DMS_END THEN birec.RELEASE_TO_DMS_END ELSE rec.RECORD_DATE END,
                            p_ACT_OWNER                         =>  rec.MODIFIED_NAME,
                            p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                            p_ACT_CASE_ID                       =>  NULL,
                            p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                            p_ACT_DCN                           =>  rec.DCN,
                            p_ACT_REF_ID                        =>  rec.ENROLLMENT_ID,
                            p_ACT_REF_TYPE                      =>  l_act_ref_type,
                            p_ACT_STEP_DEFINITION_ID            =>  14,
                            p_ACT_PROCESS_ID                    =>  1,
                            p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
                            p_ACT_CREATE_TS                     =>  birec.RELEASE_TO_DMS_END,                                            
                            p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
                        );

                    END IF;

                END IF;

            END IF;

        END LOOP;

        IF      rec.channel_id in ('2')
            AND rec.enrollment_trans_type_code IN ('1', '2')
        THEN

            ins_hco_activity_queue
            (
                p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                p_ACT_STATUS_TS                     =>  rec.RECORD_DATE,
                p_ACT_OWNER                         =>  rec.RECORD_NAME,
                p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                p_ACT_CASE_ID                       =>  NULL,
                p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                p_ACT_DCN                           =>  rec.DCN,
                p_ACT_REF_ID                        =>  rec.ENROLLMENT_ID,
                p_ACT_REF_TYPE                      =>  l_act_ref_type,
                p_ACT_STEP_DEFINITION_ID            =>  3,
                p_ACT_PROCESS_ID                    =>  1,
                p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
                p_ACT_CREATE_TS                     =>  rec.RECORD_DATE,
                p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
            );

            IF      rec.export_batch_date IS NULL
                OR  rec.export_batch_date < rec.record_date
            THEN
                l_export_batch_date :=  rec.record_date;
            ELSE    
                l_export_batch_date :=  rec.export_batch_date;
            END IF;

            IF      l_export_batch_date IS NOT NULL    
                AND rec.enrollment_trans_type_code IN ('1', '2')
            THEN

                ins_hco_activity_queue
                (
                    p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
                    p_ACT_STATUS_TS                     =>  l_export_batch_date,
                    p_ACT_OWNER                         =>  rec.MODIFIED_NAME,
                    p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                    p_ACT_CASE_ID                       =>  NULL,
                    p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                    p_ACT_DCN                           =>  rec.DCN,
                    p_ACT_REF_ID                        =>  rec.ENROLLMENT_ID,
                    p_ACT_REF_TYPE                      =>  l_act_ref_type,
                    p_ACT_STEP_DEFINITION_ID            =>  3,
                    p_ACT_PROCESS_ID                    =>  1,
                    p_ACT_CREATED_BY                    =>  rec.RECORD_NAME,
                    p_ACT_CREATE_TS                     =>  rec.RECORD_DATE,                    
                    p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
                );

            END IF;     

        END IF;

        IF      rec.meds_process_start_date IS NOT NULL
            AND rec.enrollment_trans_type_code IN ('1', '2')
        THEN

            ins_hco_activity_queue
            (
                p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                p_ACT_STATUS_TS                     =>  rec.meds_process_start_date,
                p_ACT_OWNER                         =>  rec.MODIFIED_NAME,
                p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                p_ACT_CASE_ID                       =>  NULL,
                p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                p_ACT_DCN                           =>  rec.DCN,
                p_ACT_REF_ID                        =>  rec.ENROLLMENT_ID,
                p_ACT_REF_TYPE                      =>  l_act_ref_type,
                p_ACT_STEP_DEFINITION_ID            =>  4,
                p_ACT_PROCESS_ID                    =>  1,
                p_ACT_CREATED_BY                    =>  rec.MODIFIED_NAME,
                p_ACT_CREATE_TS                     =>  rec.meds_process_start_date,                    
                p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
            );

        END IF;            

        IF      rec.meds_process_start_date IS NOT NULL
            AND rec.meds_process_end_date IS NOT NULL
            AND rec.enrollment_trans_type_code IN ('1', '2')
        THEN

            ins_hco_activity_queue
            (
                p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
                p_ACT_STATUS_TS                     =>  rec.meds_process_end_date,
                p_ACT_OWNER                         =>  rec.MODIFIED_NAME,
                p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                p_ACT_CASE_ID                       =>  NULL,
                p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                p_ACT_DCN                           =>  rec.DCN,
                p_ACT_REF_ID                        =>  rec.ENROLLMENT_ID,
                p_ACT_REF_TYPE                      =>  l_act_ref_type,
                p_ACT_STEP_DEFINITION_ID            =>  4,
                p_ACT_PROCESS_ID                    =>  1,
                p_ACT_CREATED_BY                    =>  rec.MODIFIED_NAME,
                p_ACT_CREATE_TS                     =>  rec.meds_process_start_date,                                        
                p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
            );

        END IF;

        IF      rec.proc_daily_meds_trans_file_start IS NOT NULL
            AND rec.enrollment_trans_type_code IN ('1', '2')
        THEN
            ins_hco_activity_queue
            (
                p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                p_ACT_STATUS_TS                     =>  rec.proc_daily_meds_trans_file_start,
                p_ACT_OWNER                         =>  rec.MODIFIED_NAME,
                p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                p_ACT_CASE_ID                       =>  NULL,
                p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                p_ACT_DCN                           =>  rec.DCN,
                p_ACT_REF_ID                        =>  rec.ENROLLMENT_ID,
                p_ACT_REF_TYPE                      =>  l_act_ref_type,
                p_ACT_STEP_DEFINITION_ID            =>  5,
                p_ACT_PROCESS_ID                    =>  1,
                p_ACT_CREATED_BY                    =>  rec.MODIFIED_NAME,
                p_ACT_CREATE_TS                     =>  rec.proc_daily_meds_trans_file_start,                    
                p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
            );

        END IF;

        IF      rec.proc_daily_meds_trans_file_start IS NOT NULL
            AND rec.proc_daily_meds_trans_file_end IS NOT NULL
            AND rec.enrollment_trans_type_code IN ('1', '2')
        THEN
            ins_hco_activity_queue
            (
                p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
                p_ACT_STATUS_TS                     =>  rec.proc_daily_meds_trans_file_end,
                p_ACT_OWNER                         =>  rec.MODIFIED_NAME,
                p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                p_ACT_CASE_ID                       =>  NULL,
                p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                p_ACT_DCN                           =>  rec.DCN,
                p_ACT_REF_ID                        =>  rec.ENROLLMENT_ID,
                p_ACT_REF_TYPE                      =>  l_act_ref_type,
                p_ACT_STEP_DEFINITION_ID            =>  5,
                p_ACT_PROCESS_ID                    =>  1,
                p_ACT_CREATED_BY                    =>  rec.MODIFIED_NAME,
                p_ACT_CREATE_TS                     =>  rec.proc_daily_meds_trans_file_start,                    
                p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
            );

        END IF;

        IF      rec.disregard_trans_ind = CAHCO_ETL_MW_UTIL_PKG.is_yes
            AND rec.transaction_export_date IS NOT NULL
            AND rec.research_ind = CAHCO_ETL_MW_UTIL_PKG.is_yes
            AND rec.error_reason_action = 'REJECT'
            AND rec.proc_daily_meds_trans_file_end IS NOT NULL
            AND rec.enrollment_trans_type_code IN ('1', '2')
        THEN
            ins_hco_activity_queue
            (
                p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                p_ACT_STATUS_TS                     =>  rec.proc_daily_meds_trans_file_end,
                p_ACT_OWNER                         =>  rec.MODIFIED_NAME,
                p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                p_ACT_CASE_ID                       =>  NULL,
                p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                p_ACT_DCN                           =>  rec.DCN,
                p_ACT_REF_ID                        =>  rec.ENROLLMENT_ID,
                p_ACT_REF_TYPE                      =>  l_act_ref_type,
                p_ACT_STEP_DEFINITION_ID            =>  15,
                p_ACT_PROCESS_ID                    =>  1,
                p_ACT_CREATED_BY                    =>  rec.MODIFIED_NAME,
                p_ACT_CREATE_TS                     =>  rec.proc_daily_meds_trans_file_end,                        
                p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
            );

            IF      rec.modified_date   >=   rec.proc_daily_meds_trans_file_end
            THEN

                ins_hco_activity_queue
                (
                    p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
                    p_ACT_STATUS_TS                     =>  rec.MODIFIED_DATE,
                    p_ACT_OWNER                         =>  rec.MODIFIED_NAME,
                    p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                    p_ACT_CASE_ID                       =>  NULL,
                    p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                    p_ACT_DCN                           =>  rec.DCN,
                    p_ACT_REF_ID                        =>  rec.ENROLLMENT_ID,
                    p_ACT_REF_TYPE                      =>  l_act_ref_type,
                    p_ACT_STEP_DEFINITION_ID            =>  15,
                    p_ACT_PROCESS_ID                    =>  1,
                    p_ACT_CREATED_BY                    =>  rec.MODIFIED_NAME,
                    p_ACT_CREATE_TS                     =>  rec.proc_daily_meds_trans_file_end,                        
                    p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
                );

            END IF;

        END IF;

        IF      rec.enrollment_trans_type_code IN ('5', '8')
            AND rec.disregard_trans_ind = CAHCO_ETL_MW_UTIL_PKG.is_yes
        THEN

            ins_hco_activity_queue
            (
                p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                p_ACT_STATUS_TS                     =>  rec.RECORD_DATE,
                p_ACT_OWNER                         =>  rec.MODIFIED_NAME,
                p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                p_ACT_CASE_ID                       =>  NULL,
                p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                p_ACT_DCN                           =>  rec.DCN,
                p_ACT_REF_ID                        =>  rec.ENROLLMENT_ID,
                p_ACT_REF_TYPE                      =>  l_act_ref_type,
                p_ACT_STEP_DEFINITION_ID            =>  16,
                p_ACT_PROCESS_ID                    =>  1,
                p_ACT_CREATED_BY                    =>  rec.MODIFIED_NAME,
                p_ACT_CREATE_TS                     =>  rec.RECORD_DATE,                        
                p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
            );

        END IF;

    END         cr_enrollment_activities;
   /*****************************************************************************************************************************************************************

        NAME:           proc_emrs_f_enrollment
        DESCRIPTION:    Process the records in the table EMRS_F_ENROLLMENT.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created procedure.

    *****************************************************************************************************************************************************************/
    PROCEDURE   proc_emrs_f_enrollment
    IS

        l_sql                                                                   VARCHAR2(32767);

        l_mw_enrollment_proc_dt                                                 DATE;

    BEGIN

        IF  CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_string(p_NAME  =>  'MW_PROC_CONTROL')  =   'STOP'
        THEN
            RETURN;
        END IF;

        FOR rec IN c_emrs_f_enrollment
        LOOP

            IF  CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_string(p_NAME  =>  'MW_PROC_CONTROL')  =   'STOP'
            THEN
                RETURN;
            END IF;

            cr_enrollment_activities
            (
                p_enrollment_rec                    =>  rec
            );

            COMMIT;

        END LOOP;

        l_sql   :=  'SELECT MAX(modified_date) FROM EMRS_F_ENROLLMENT WHERE modified_date <= sysdate';
        l_mw_enrollment_proc_dt    :=	cahco_etl_mw_util_pkg.return_query_date
                                        (
                                            p_SQL	=>  l_sql
                                        );

        CAHCO_ETL_MW_UTIL_PKG.set_corp_etl_control_date
        (
            p_NAME                              =>  'MW_ENROLLMENT_PROC_DATE',
            p_DATE                              =>  l_mw_enrollment_proc_dt
        );

    END         proc_emrs_f_enrollment;    
    /*****************************************************************************************************************************************************************

        NAME:           cr_return_mail_activities
        DESCRIPTION:    Create Return Mail activities from the Return Mail record, p_return_mail_rec.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created procedure.

    *****************************************************************************************************************************************************************/
    PROCEDURE   cr_return_mail_activities
                (
                    p_return_mail_rec                   IN                      c_return_mail%ROWTYPE
                )
    IS          
        rec                                                                     c_return_mail%ROWTYPE;        
    BEGIN

        rec :=  p_return_mail_rec;

        ins_hco_activity_queue
        (
            p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
            p_ACT_STATUS_TS                     =>  rec.record_date,
            p_ACT_OWNER                         =>  rec.record_name,
            p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
            p_ACT_CASE_ID                       =>  rec.case_number,
            p_ACT_CLIENT_ID                     =>  rec.case_head_client_number,
            p_ACT_DCN                           =>  NULL,
            p_ACT_REF_ID                        =>  rec.mail_returned_id,
            p_ACT_REF_TYPE                      =>  c_mail_returned,
            p_ACT_STEP_DEFINITION_ID            =>  10,
            p_ACT_PROCESS_ID                    =>  1,
            p_ACT_CREATED_BY                    =>  rec.record_name,
            p_ACT_CREATE_TS                     =>  rec.record_date,                
            p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
        );

        ins_hco_activity_queue
        (
            p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
            p_ACT_STATUS_TS                     =>  rec.record_date,
            p_ACT_OWNER                         =>  rec.record_name,
            p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
            p_ACT_CASE_ID                       =>  rec.case_number,
            p_ACT_CLIENT_ID                     =>  rec.case_head_client_number,
            p_ACT_DCN                           =>  NULL,
            p_ACT_REF_ID                        =>  rec.mail_returned_id,
            p_ACT_REF_TYPE                      =>  c_mail_returned,
            p_ACT_STEP_DEFINITION_ID            =>  10,
            p_ACT_PROCESS_ID                    =>  1,
            p_ACT_CREATED_BY                    =>  rec.record_name,
            p_ACT_CREATE_TS                     =>  rec.record_date,                
            p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
        );

        IF      rec.obt_record_date IS NOT NULL
        THEN

            ins_hco_activity_queue
            (
                p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                p_ACT_STATUS_TS                     =>  rec.obt_record_date,
                p_ACT_OWNER                         =>  c_automated_process,
                p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                p_ACT_CASE_ID                       =>  rec.case_number,
                p_ACT_CLIENT_ID                     =>  rec.case_head_client_number,
                p_ACT_DCN                           =>  NULL,
                p_ACT_REF_ID                        =>  rec.mail_returned_id,
                p_ACT_REF_TYPE                      =>  c_mail_returned,
                p_ACT_STEP_DEFINITION_ID            =>  11,
                p_ACT_PROCESS_ID                    =>  1,
                p_ACT_CREATED_BY                    =>  c_automated_process,
                p_ACT_CREATE_TS                     =>  rec.obt_record_date,                    
                p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
            );

        END IF;

        IF      rec.obt_record_date IS NOT NULL
            AND rec.obt_disposition_code IS NOT NULL
        THEN

            ins_hco_activity_queue
            (
                p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
                p_ACT_STATUS_TS                     =>  rec.obt_modified_date,
                p_ACT_OWNER                         =>  c_automated_process,
                p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                p_ACT_CASE_ID                       =>  rec.case_number,
                p_ACT_CLIENT_ID                     =>  rec.case_head_client_number,
                p_ACT_DCN                           =>  NULL,
                p_ACT_REF_ID                        =>  rec.mail_returned_id,
                p_ACT_REF_TYPE                      =>  c_mail_returned,
                p_ACT_STEP_DEFINITION_ID            =>  11,
                p_ACT_PROCESS_ID                    =>  1,
                p_ACT_CREATED_BY                    =>  c_automated_process,
                p_ACT_CREATE_TS                     =>  rec.obt_record_date,                    
                p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
            );

        END IF;

        COMMIT;

    END         cr_return_mail_activities;
   /*****************************************************************************************************************************************************************

        NAME:           proc_return_mail
        DESCRIPTION:    Process the records in the table EMRS_D_CASE that indicate addresses were bad.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created procedure.

    *****************************************************************************************************************************************************************/
    PROCEDURE   proc_return_mail
    IS

        l_sql                                                                   VARCHAR2(32767);

        l_mw_return_mail_proc_dt                                                DATE;
        l_mw_rm_ob_trans_proc_dt                                                DATE;

    BEGIN

        IF  CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_string(p_NAME  =>  'MW_PROC_CONTROL')  =   'STOP'
        THEN
            RETURN;
        END IF;

        FOR rec IN c_return_mail
        LOOP

            IF  CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_string(p_NAME  =>  'MW_PROC_CONTROL')  =   'STOP'
            THEN
                RETURN;
            END IF;

            cr_return_mail_activities
            (
                p_return_mail_rec                   =>  rec
            );

        END LOOP;

        l_sql   :=  'SELECT MAX(modified_date) FROM HCO_D_MAIL_RETURNED WHERE modified_date <= sysdate';
        l_mw_return_mail_proc_dt    :=	cahco_etl_mw_util_pkg.return_query_date
                                        (
                                            p_SQL	=>  l_sql
                                        );

        CAHCO_ETL_MW_UTIL_PKG.set_corp_etl_control_date
        (
            p_NAME                              =>  'MW_MAIL_RETURNED_PROC_DATE',
            p_DATE                              =>  l_mw_return_mail_proc_dt
        );


        l_sql   :=  'SELECT MAX(modified_date) FROM HCO_OB_TRANSACTIONS WHERE modified_date <= sysdate';
        l_mw_rm_ob_trans_proc_dt     :=	cahco_etl_mw_util_pkg.return_query_date
                                        (
                                            p_SQL	=>  l_sql
                                        );

        CAHCO_ETL_MW_UTIL_PKG.set_corp_etl_control_date
        (
            p_NAME                              =>  'MW_RM_OB_TRANS_PROC_DATE',
            p_DATE                              =>  l_mw_rm_ob_trans_proc_dt 
        );

    END         proc_return_mail;   
    /*****************************************************************************************************************************************************************

        NAME:           reconcile_enrollment_notification
        DESCRIPTION:    Reconcile the enrollment notification for p_enrollment_id.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     04/27/2019              Created procedure.

    *****************************************************************************************************************************************************************/
    PROCEDURE   reconcile_enrollment_notification
                (
                    p_enrollment_id                     IN                      EMRS_F_ENROLLMENT.enrollment_id%TYPE,
                    p_case_number                       IN                      EMRS_D_CASE.case_number%TYPE,
                    p_client_number                     IN                      EMRS_D_CLIENT.client_number%TYPE,
                    p_dcn                               IN                      STEP_INSTANCE.dcn%TYPE,
                    p_start_date                        IN                      DATE,
                    p_end_date                          IN                      DATE
                )
    IS
        l_ref_type                                                              STEP_INSTANCE.ref_type%TYPE;
        l_ref_id                                                                STEP_INSTANCE.ref_id%TYPE;
    BEGIN

        BEGIN

            SELECT  ref_type,
                    ref_id
              INTO  l_ref_type,
                    l_ref_id
              FROM  (                
                        SELECT  si.ref_type             ref_type,
                                si.ref_id               ref_id
                          FROM  STEP_INSTANCE           si
                         WHERE  (
                                        (

                                                si.ref_type         =   c_enrollment
                                            AND si.ref_id           =   p_enrollment_id
                                        )
                                    OR  (                         
                                                si.ref_type         =   c_disenrollment
                                            AND si.ref_id           =   p_enrollment_id
                                        )
                                )
                            AND rownum  <   2                    
                        UNION ALL
                        SELECT  haq.act_ref_type            ref_type,
                                haq.act_ref_id              ref_id
                          FROM  HCO_ACTIVITY_QUEUE           haq
                         WHERE  (
                                        (

                                                haq.act_ref_type         =   c_enrollment
                                            AND haq.act_ref_id           =   p_enrollment_id
                                        )
                                    OR  (                         
                                                haq.act_ref_type         =   c_disenrollment
                                            AND haq.act_ref_id           =   p_enrollment_id
                                        )
                                )            
                            AND rownum  <   2
                    )
            WHERE   rownum  <   2;

        EXCEPTION

            WHEN    NO_DATA_FOUND
            THEN    l_ref_type  :=  NULL;
                    l_ref_id    :=  NULL;

        END;

        IF      l_ref_type IS NOT NULL
            AND l_ref_id IS NOT NULL
        THEN

            IF      p_start_date IS NOT NULL
            THEN

                ins_hco_activity_queue
                (
                    p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                    p_ACT_STATUS_TS                     =>  p_start_date,
                    p_ACT_OWNER                         =>  c_automated_process,
                    p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                    p_ACT_CASE_ID                       =>  p_case_number,
                    p_ACT_CLIENT_ID                     =>  p_client_number,
                    p_ACT_DCN                           =>  p_dcn,
                    p_ACT_REF_ID                        =>  p_enrollment_id,
                    p_ACT_REF_TYPE                      =>  l_ref_type,
                    p_ACT_STEP_DEFINITION_ID            =>  6,
                    p_ACT_PROCESS_ID                    =>  1,
                    p_ACT_CREATED_BY                    =>  c_automated_process,
                    p_ACT_CREATE_TS                     =>  p_start_date,                    
                    p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
                );

            END IF;

            IF      p_start_date IS NOT NULL
                AND p_end_date IS NOT NULL
            THEN

                ins_hco_activity_queue
                (
                    p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
                    p_ACT_STATUS_TS                     =>  p_end_date,
                    p_ACT_OWNER                         =>  c_automated_process,
                    p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                    p_ACT_CASE_ID                       =>  p_case_number,
                    p_ACT_CLIENT_ID                     =>  p_client_number,
                    p_ACT_DCN                           =>  p_dcn,
                    p_ACT_REF_ID                        =>  p_enrollment_id,
                    p_ACT_REF_TYPE                      =>  l_ref_type,
                    p_ACT_STEP_DEFINITION_ID            =>  6,
                    p_ACT_PROCESS_ID                    =>  1,
                    p_ACT_CREATED_BY                    =>  c_automated_process,
                    p_ACT_CREATE_TS                     =>  p_start_date,                    
                    p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
                );

            END IF;

        END IF;

        COMMIT;

    END         reconcile_enrollment_notification;         
    /*****************************************************************************************************************************************************************

        NAME:           get_dcn
        DESCRIPTION:    Get the DCN that is associated with p_enrollment_id or p_exemption_id.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     04/27/2019              Created function.

    *****************************************************************************************************************************************************************/
    FUNCTION    get_dcn
                (
                    p_enrollment_id                     IN                      EMRS_F_ENROLLMENT.enrollment_id%TYPE,
                    p_exemption_id                      IN                      EMRS_D_EXEMPTION_REQ.dcn%TYPE
                )
    RETURN                                                                      EMRS_F_ENROLLMENT.dcn%TYPE
    IS
        l_dcn                                                                   EMRS_F_ENROLLMENT.dcn%TYPE;
    BEGIN

        IF      p_enrollment_id IS NOT NULL
        THEN

            BEGIN

                SELECT  e.dcn
                  INTO  l_dcn
                  FROM  EMRS_F_ENROLLMENT               e
                 WHERE  e.enrollment_id             =   p_enrollment_id
                   AND  e.date_of_validity_start    <=  SYSDATE
                   AND  e.date_of_validity_end      >=  SYSDATE
                   AND  rownum  <   2;

            EXCEPTION

                WHEN    NO_DATA_FOUND
                THEN    l_dcn   :=  NULL;

            END;

        END IF;

        IF      l_dcn IS NULL
            AND p_exemption_ID IS NOT NULL
        THEN

            BEGIN

                SELECT  e.dcn
                  INTO  l_dcn
                  FROM  EMRS_D_EXEMPTION_REQ            e
                 WHERE  e.exemption_id              =   p_exemption_id;

            EXCEPTION

                WHEN    NO_DATA_FOUND
                THEN    l_dcn   :=  NULL;

            END;

        END IF;

        RETURN  l_dcn;

    END         get_dcn;
    /*****************************************************************************************************************************************************************

        NAME:           cr_letter_mailing_activities
        DESCRIPTION:    Create Letter Mailing activities from the Letter Mailing record, p_letter_mailing_rec.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created procedure.

    *****************************************************************************************************************************************************************/
    PROCEDURE   cr_letter_mailing_activities
                (
                    p_letter_mailing_rec                IN                      c_hco_d_letter_mailing%ROWTYPE
                )
    IS          

        l_mail_transaction_date                                                 HCO_MAIL_CLIENT_TRANS.mt_modified_date%TYPE;
        l_mail_response_letter_date                                             HCO_MAIL_CLIENT_TRANS.mail_response_letter_date%TYPE;
        l_vendor_received_date                                                  HCO_D_LETTER_MAILING.vendor_received_date%TYPE;
        l_date_mailed                                                           HCO_D_LETTER_MAILING.date_mailed%TYPE;

        l_dcn                                                                   STEP_INSTANCE.dcn%TYPE;

        rec                                                                     c_hco_d_letter_mailing%ROWTYPE;        

    BEGIN

        rec :=  p_letter_mailing_rec;

        l_mail_transaction_date             :=  rec.mail_transaction_date;
        l_mail_response_letter_date         :=  rec.mail_response_letter_date;
        l_vendor_received_date              :=  rec.vendor_received_date;
        l_date_mailed                       :=  rec.date_mailed;

        IF      rec.enrollment_id IS NOT NULL
            OR  rec.exemption_id IS NOT NULL
        THEN
            l_dcn   :=  get_dcn
                        (
                            p_enrollment_id     =>  rec.enrollment_id,
                            p_exemption_id      =>  rec.exemption_id
                        );
        END IF;

        IF      rec.enrollment_id IS NOT NULL
        THEN

            reconcile_enrollment_notification
            (
                p_enrollment_id     =>  rec.enrollment_id,
                p_start_date        =>  rec.date_requested,
                p_end_date          =>  rec.modified_date,
                p_client_number     =>  rec.client_number,
                p_case_number       =>  rec.case_number,
                p_dcn               =>  l_dcn
            );

        END IF;

        IF  l_mail_transaction_date IS NOT NULL
        THEN        

            ins_hco_activity_queue
            (
                p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                p_ACT_STATUS_TS                     =>  l_mail_transaction_date,
                p_ACT_OWNER                         =>  c_automated_process,
                p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                p_ACT_CASE_ID                       =>  rec.CASE_NUMBER,
                p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                p_ACT_DCN                           =>  l_dcn,
                p_ACT_REF_ID                        =>  rec.DIM_LETTER_MAILING_ID,
                p_ACT_REF_TYPE                      =>  c_letter_mailing,
                p_ACT_STEP_DEFINITION_ID            =>  20,
                p_ACT_PROCESS_ID                    =>  2,
                p_ACT_CREATED_BY                    =>  c_automated_process,
                p_ACT_CREATE_TS                     =>  l_mail_transaction_date,
                p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
            );

            ins_hco_activity_queue
            (
                p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
                p_ACT_STATUS_TS                     =>  l_mail_transaction_date,
                p_ACT_OWNER                         =>  c_automated_process,
                p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                p_ACT_CASE_ID                       =>  rec.CASE_NUMBER,
                p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                p_ACT_DCN                           =>  l_dcn,
                p_ACT_REF_ID                        =>  rec.DIM_LETTER_MAILING_ID,
                p_ACT_REF_TYPE                      =>  c_letter_mailing,
                p_ACT_STEP_DEFINITION_ID            =>  20,
                p_ACT_PROCESS_ID                    =>  2,
                p_ACT_CREATED_BY                    =>  c_automated_process,
                p_ACT_CREATE_TS                     =>  l_mail_transaction_date,
                p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
            );

            COMMIT;

        END IF;                

        IF  l_mail_response_letter_date IS NOT NULL
        THEN        

            ins_hco_activity_queue
            (
                p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                p_ACT_STATUS_TS                     =>  l_mail_response_letter_date,
                p_ACT_OWNER                         =>  c_automated_process,
                p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                p_ACT_CASE_ID                       =>  rec.CASE_NUMBER,
                p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                p_ACT_DCN                           =>  l_dcn,
                p_ACT_REF_ID                        =>  rec.DIM_LETTER_MAILING_ID,
                p_ACT_REF_TYPE                      =>  c_letter_mailing,
                p_ACT_STEP_DEFINITION_ID            =>  21,
                p_ACT_PROCESS_ID                    =>  2,
                p_ACT_CREATED_BY                    =>  c_automated_process,
                p_ACT_CREATE_TS                     =>  l_mail_response_letter_date,
                p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
            );

            ins_hco_activity_queue
            (
                p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
                p_ACT_STATUS_TS                     =>  l_mail_response_letter_date,
                p_ACT_OWNER                         =>  c_automated_process,
                p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                p_ACT_CASE_ID                       =>  rec.CASE_NUMBER,
                p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                p_ACT_DCN                           =>  l_dcn,
                p_ACT_REF_ID                        =>  rec.DIM_LETTER_MAILING_ID,
                p_ACT_REF_TYPE                      =>  c_letter_mailing,
                p_ACT_STEP_DEFINITION_ID            =>  21,
                p_ACT_PROCESS_ID                    =>  2,
                p_ACT_CREATED_BY                    =>  c_automated_process,
                p_ACT_CREATE_TS                     =>  l_mail_response_letter_date,
                p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
            );

            COMMIT;

        END IF;                

        IF  l_vendor_received_date  IS NOT NULL
        THEN        

            ins_hco_activity_queue
            (
                p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                p_ACT_STATUS_TS                     =>  l_vendor_received_date ,
                p_ACT_OWNER                         =>  c_automated_process,
                p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                p_ACT_CASE_ID                       =>  rec.CASE_NUMBER,
                p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                p_ACT_DCN                           =>  l_dcn,
                p_ACT_REF_ID                        =>  rec.DIM_LETTER_MAILING_ID,
                p_ACT_REF_TYPE                      =>  c_letter_mailing,
                p_ACT_STEP_DEFINITION_ID            =>  22,
                p_ACT_PROCESS_ID                    =>  2,
                p_ACT_CREATED_BY                    =>  c_automated_process,
                p_ACT_CREATE_TS                     =>  l_vendor_received_date ,
                p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
            );

            ins_hco_activity_queue
            (
                p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
                p_ACT_STATUS_TS                     =>  l_vendor_received_date ,
                p_ACT_OWNER                         =>  c_automated_process,
                p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                p_ACT_CASE_ID                       =>  rec.CASE_NUMBER,
                p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                p_ACT_DCN                           =>  l_dcn,
                p_ACT_REF_ID                        =>  rec.DIM_LETTER_MAILING_ID,
                p_ACT_REF_TYPE                      =>  c_letter_mailing,
                p_ACT_STEP_DEFINITION_ID            =>  22,
                p_ACT_PROCESS_ID                    =>  2,
                p_ACT_CREATED_BY                    =>  c_automated_process,
                p_ACT_CREATE_TS                     =>  l_vendor_received_date ,
                p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
            );

            COMMIT;

        END IF;                

        IF  l_date_mailed  IS NOT NULL
        THEN        

            ins_hco_activity_queue
            (
                p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                p_ACT_STATUS_TS                     =>  l_date_mailed,
                p_ACT_OWNER                         =>  c_automated_process,
                p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                p_ACT_CASE_ID                       =>  rec.CASE_NUMBER,
                p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                p_ACT_DCN                           =>  l_dcn,
                p_ACT_REF_ID                        =>  rec.DIM_LETTER_MAILING_ID,
                p_ACT_REF_TYPE                      =>  c_letter_mailing,
                p_ACT_STEP_DEFINITION_ID            =>  23,
                p_ACT_PROCESS_ID                    =>  2,
                p_ACT_CREATED_BY                    =>  c_automated_process,
                p_ACT_CREATE_TS                     =>  l_date_mailed,
                p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
            );

            ins_hco_activity_queue
            (
                p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
                p_ACT_STATUS_TS                     =>  l_date_mailed,
                p_ACT_OWNER                         =>  c_automated_process,
                p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                p_ACT_CASE_ID                       =>  rec.CASE_NUMBER,
                p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                p_ACT_DCN                           =>  l_dcn,
                p_ACT_REF_ID                        =>  rec.DIM_LETTER_MAILING_ID,
                p_ACT_REF_TYPE                      =>  c_letter_mailing,
                p_ACT_STEP_DEFINITION_ID            =>  23,
                p_ACT_PROCESS_ID                    =>  2,
                p_ACT_CREATED_BY                    =>  c_automated_process,
                p_ACT_CREATE_TS                     =>  l_date_mailed,
                p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
            );

            COMMIT;

        END IF;                

    END         cr_letter_mailing_activities;
    /*****************************************************************************************************************************************************************

        NAME:           proc_hco_d_letter_mailing
        DESCRIPTION:    Process the records in the table HCO_D_LETTER_MAILING.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created procedure.

    *****************************************************************************************************************************************************************/
    PROCEDURE   proc_hco_d_letter_mailing
    IS

        l_sql                                                                   VARCHAR2(32767);
        l_mw_letter_mailing_proc_dt                                             DATE;

    BEGIN

        IF  CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_string(p_NAME  =>  'MW_PROC_CONTROL')  =   'STOP'
        THEN
            RETURN;
        END IF;

        FOR rec IN  c_hco_d_letter_mailing   
        LOOP

            IF  CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_string(p_NAME  =>  'MW_PROC_CONTROL')  =   'STOP'
            THEN
                RETURN;
            END IF;

            cr_letter_mailing_activities
            (
                p_letter_mailing_rec                =>  rec
            );

            COMMIT;

        END LOOP;

        l_sql   :=  'SELECT MAX(modified_date) FROM HCO_D_LETTER_MAILING WHERE modified_date <= sysdate';
        l_mw_letter_mailing_proc_dt     :=	cahco_etl_mw_util_pkg.return_query_date
                                            (
                                                p_SQL	=>  l_sql
                                            );

        CAHCO_ETL_MW_UTIL_PKG.set_corp_etl_control_date
        (
            p_NAME                              =>  'MW_LETTER_MAILING_PROC_DATE',
            p_DATE                              =>  l_mw_letter_mailing_proc_dt 
        );

    END         proc_hco_d_letter_mailing;
    /*****************************************************************************************************************************************************************

        NAME:           cr_packet_mailing_activities
        DESCRIPTION:    Create Packet Mailing activities from the Packet Mailing record, p_packet_mailing_rec.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created procedure.

    *****************************************************************************************************************************************************************/
    PROCEDURE   cr_packet_mailing_activities
                (
                    p_packet_mailing_rec                IN                      c_hco_d_packet_mailing%ROWTYPE
                )
    IS          

        l_mail_transaction_date                                                 HCO_MAIL_CLIENT_TRANS.mt_modified_date%TYPE;
        l_mail_response_packet_date                                             HCO_MAIL_CLIENT_TRANS.mail_response_letter_date%TYPE;
        l_vendor_received_date                                                  HCO_D_PACKET_MAILING.vendor_received_date%TYPE;
        l_date_mailed                                                           HCO_D_PACKET_MAILING.date_mailed%TYPE;

        l_dcn                                                                   STEP_INSTANCE.dcn%TYPE;

        rec                                                                     c_hco_d_packet_mailing%ROWTYPE;        

    BEGIN

        rec :=  p_packet_mailing_rec;

        l_mail_transaction_date             :=  rec.mail_transaction_date;
        l_mail_response_packet_date         :=  rec.mail_response_packet_date;
        l_vendor_received_date              :=  rec.vendor_received_date;
        l_date_mailed                       :=  rec.date_mailed;

        IF      rec.enrollment_id IS NOT NULL
            OR  rec.exemption_id IS NOT NULL
        THEN
            l_dcn   :=  get_dcn
                        (
                            p_enrollment_id     =>  rec.enrollment_id,
                            p_exemption_id      =>  rec.exemption_id
                        );
        END IF;

        IF  l_mail_transaction_date IS NOT NULL
        THEN        

            ins_hco_activity_queue
            (
                p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                p_ACT_STATUS_TS                     =>  l_mail_transaction_date,
                p_ACT_OWNER                         =>  c_automated_process,
                p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                p_ACT_CASE_ID                       =>  rec.CASE_NUMBER,
                p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                p_ACT_DCN                           =>  l_dcn,
                p_ACT_REF_ID                        =>  rec.DIM_PACKET_MAILING_ID,
                p_ACT_REF_TYPE                      =>  c_packet_mailing,
                p_ACT_STEP_DEFINITION_ID            =>  20,
                p_ACT_PROCESS_ID                    =>  2,
                p_ACT_CREATED_BY                    =>  c_automated_process,
                p_ACT_CREATE_TS                     =>  l_mail_transaction_date,
                p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
            );

            ins_hco_activity_queue
            (
                p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
                p_ACT_STATUS_TS                     =>  l_mail_transaction_date,
                p_ACT_OWNER                         =>  c_automated_process,
                p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                p_ACT_CASE_ID                       =>  rec.CASE_NUMBER,
                p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                p_ACT_DCN                           =>  l_dcn,
                p_ACT_REF_ID                        =>  rec.DIM_PACKET_MAILING_ID,
                p_ACT_REF_TYPE                      =>  c_packet_mailing,
                p_ACT_STEP_DEFINITION_ID            =>  20,
                p_ACT_PROCESS_ID                    =>  2,
                p_ACT_CREATED_BY                    =>  c_automated_process,
                p_ACT_CREATE_TS                     =>  l_mail_transaction_date,
                p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
            );

            COMMIT;

        END IF;                

        IF  l_mail_response_packet_date IS NOT NULL
        THEN        

            ins_hco_activity_queue
            (
                p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                p_ACT_STATUS_TS                     =>  l_mail_response_packet_date,
                p_ACT_OWNER                         =>  c_automated_process,
                p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                p_ACT_CASE_ID                       =>  rec.CASE_NUMBER,
                p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                p_ACT_DCN                           =>  l_dcn,
                p_ACT_REF_ID                        =>  rec.DIM_PACKET_MAILING_ID,
                p_ACT_REF_TYPE                      =>  c_packet_mailing,
                p_ACT_STEP_DEFINITION_ID            =>  21,
                p_ACT_PROCESS_ID                    =>  2,
                p_ACT_CREATED_BY                    =>  c_automated_process,
                p_ACT_CREATE_TS                     =>  l_mail_response_packet_date,
                p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
            );

            ins_hco_activity_queue
            (
                p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
                p_ACT_STATUS_TS                     =>  l_mail_response_packet_date,
                p_ACT_OWNER                         =>  c_automated_process,
                p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                p_ACT_CASE_ID                       =>  rec.CASE_NUMBER,
                p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                p_ACT_DCN                           =>  l_dcn,
                p_ACT_REF_ID                        =>  rec.DIM_PACKET_MAILING_ID,
                p_ACT_REF_TYPE                      =>  c_packet_mailing,
                p_ACT_STEP_DEFINITION_ID            =>  21,
                p_ACT_PROCESS_ID                    =>  2,
                p_ACT_CREATED_BY                    =>  c_automated_process,
                p_ACT_CREATE_TS                     =>  l_mail_response_packet_date,
                p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
            );

            COMMIT;

        END IF;                

        IF  l_vendor_received_date  IS NOT NULL
        THEN        

            ins_hco_activity_queue
            (
                p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                p_ACT_STATUS_TS                     =>  l_vendor_received_date ,
                p_ACT_OWNER                         =>  c_automated_process,
                p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                p_ACT_CASE_ID                       =>  rec.CASE_NUMBER,
                p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                p_ACT_DCN                           =>  l_dcn,
                p_ACT_REF_ID                        =>  rec.DIM_PACKET_MAILING_ID,
                p_ACT_REF_TYPE                      =>  c_packet_mailing,
                p_ACT_STEP_DEFINITION_ID            =>  22,
                p_ACT_PROCESS_ID                    =>  2,
                p_ACT_CREATED_BY                    =>  c_automated_process,
                p_ACT_CREATE_TS                     =>  l_vendor_received_date ,
                p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
            );

            ins_hco_activity_queue
            (
                p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
                p_ACT_STATUS_TS                     =>  l_vendor_received_date ,
                p_ACT_OWNER                         =>  c_automated_process,
                p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                p_ACT_CASE_ID                       =>  rec.CASE_NUMBER,
                p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                p_ACT_DCN                           =>  l_dcn,
                p_ACT_REF_ID                        =>  rec.DIM_PACKET_MAILING_ID,
                p_ACT_REF_TYPE                      =>  c_packet_mailing,
                p_ACT_STEP_DEFINITION_ID            =>  22,
                p_ACT_PROCESS_ID                    =>  2,
                p_ACT_CREATED_BY                    =>  c_automated_process,
                p_ACT_CREATE_TS                     =>  l_vendor_received_date ,
                p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
            );

            COMMIT;

        END IF;                

        IF  l_date_mailed  IS NOT NULL
        THEN        

            ins_hco_activity_queue
            (
                p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed,
                p_ACT_STATUS_TS                     =>  l_date_mailed,
                p_ACT_OWNER                         =>  c_automated_process,
                p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                p_ACT_CASE_ID                       =>  rec.CASE_NUMBER,
                p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                p_ACT_DCN                           =>  l_dcn,
                p_ACT_REF_ID                        =>  rec.DIM_PACKET_MAILING_ID,
                p_ACT_REF_TYPE                      =>  c_packet_mailing,
                p_ACT_STEP_DEFINITION_ID            =>  23,
                p_ACT_PROCESS_ID                    =>  2,
                p_ACT_CREATED_BY                    =>  c_automated_process,
                p_ACT_CREATE_TS                     =>  l_date_mailed,
                p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
            );

            ins_hco_activity_queue
            (
                p_ACT_STATUS                        =>  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
                p_ACT_STATUS_TS                     =>  l_date_mailed,
                p_ACT_OWNER                         =>  c_automated_process,
                p_ACT_TEAM_ID                       =>  CAHCO_ETL_MW_UTIL_PKG.get_unknown_team_id,
                p_ACT_CASE_ID                       =>  rec.CASE_NUMBER,
                p_ACT_CLIENT_ID                     =>  rec.CLIENT_NUMBER,
                p_ACT_DCN                           =>  l_dcn,
                p_ACT_REF_ID                        =>  rec.DIM_PACKET_MAILING_ID,
                p_ACT_REF_TYPE                      =>  c_packet_mailing,
                p_ACT_STEP_DEFINITION_ID            =>  23,
                p_ACT_PROCESS_ID                    =>  2,
                p_ACT_CREATED_BY                    =>  c_automated_process,
                p_ACT_CREATE_TS                     =>  l_date_mailed,
                p_ACT_COMMENTS                      =>  CAHCO_ETL_MW_UTIL_PKG.automatically_claimed
            );

            COMMIT;

        END IF;                

    END         cr_packet_mailing_activities;
    /*****************************************************************************************************************************************************************

        NAME:           proc_hco_d_packet_mailing
        DESCRIPTION:    Process the records in the table HCO_D_PACKET_MAILING.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created procedure.

    *****************************************************************************************************************************************************************/
    PROCEDURE   proc_hco_d_packet_mailing
    IS

        l_sql                                                                   VARCHAR2(32767);

        l_mw_packet_mailing_proc_dt                                             DATE;

    BEGIN

        IF  CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_string(p_NAME  =>  'MW_PROC_CONTROL')  =   'STOP'
        THEN
            RETURN;
        END IF;

        FOR rec IN  c_hco_d_packet_mailing   
        LOOP

            IF  CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_string(p_NAME  =>  'MW_PROC_CONTROL')  =   'STOP'
            THEN
                RETURN;
            END IF;

            cr_packet_mailing_activities
            (
                p_packet_mailing_rec                =>  rec
            );

            COMMIT;

        END LOOP;

        l_sql   :=  'SELECT MAX(modified_date) FROM HCO_D_PACKET_MAILING WHERE modified_date <= sysdate';
        l_mw_packet_mailing_proc_dt :=	cahco_etl_mw_util_pkg.return_query_date
                                        (
                                            p_SQL	=>  l_sql
                                        );

        CAHCO_ETL_MW_UTIL_PKG.set_corp_etl_control_date
        (
            p_NAME                              =>  'MW_PACKET_MAILING_PROC_DATE',
            p_DATE                              =>  l_mw_packet_mailing_proc_dt 
        );

    END         proc_hco_d_packet_mailing;    
    /*****************************************************************************************************************************************************************

        NAME:           ins_step_instance_stg
        DESCRIPTION:    Insert recprds from STEP_INSTANCE, STEP_INSTANCE_HISTORY into the table STEP_INSTANCE_STG.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created procedure.

    *****************************************************************************************************************************************************************/
    PROCEDURE   ins_step_instance_stg
    IS
        CURSOR  c_step_instance
        IS
        SELECT  si.step_instance_id,
                si.status,
                si.create_ts,
                si.completed_ts, 
                sh.escalated_ind,
                si.step_due_ts,
                sh.forwarded_ind,
                sh.group_id,
                sh.team_id,
                si.ref_id,
                si.ref_type,
                si.step_definition_id,
                si.created_by,
                sh.escalate_to,
                sh.forwarded_by,
                sh.owner,
                si.suspended_ts,
                sh.step_instance_history_id,
                sh.status                        HIST_STATUS,
                sh.create_ts                     HIST_CREATE_TS,
                sh.created_by                    HIST_CREATE_BY,
                CAHCO_ETL_MW_UTIL_PKG.is_no      MW_PROCESSED,
                CAHCO_ETL_MW_UTIL_PKG.is_no      MIB_PROCESSED,
                SYSDATE                          STAGE_CREATE_TS,
                si.case_id,
                si.client_id,
                si.priority_cd                   PRIORITY,
                si.process_id,
                si.process_instance_id,
                si.claimed_ts,
                si.dcn,
                si.document_received_date
        FROM    STEP_INSTANCE                   si,  
                STEP_INSTANCE_HISTORY           sh,  
                STEP_DEFINITION                 sd  
       WHERE    SH.STEP_INSTANCE_ID         =   SI.STEP_INSTANCE_ID
         AND    si.step_definition_id = sd.step_definition_id(+)
         AND    sd.step_type_cd in ('VIRTUAL_HUMAN_TASK','HUMAN_TASK')
         AND    SH.STEP_INSTANCE_HISTORY_ID >   GREATEST
                                                (
                                                    CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_number
                                                    (
                                                        p_NAME      =>  'MW_LAST_STEP_INST_HIST_ID'
                                                    ),
                                                    (
                                                        SELECT  NVL(MAX(step_instance_history_id), 0)
                                                          FROM  STEP_INSTANCE_STG
                                                    )
                                                )
         AND    SH.STEP_INSTANCE_HISTORY_ID <=      CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_number
                                                    (
                                                        p_NAME      =>  'HIGH_LIMIT_TASK_HISTORY_ID'
                                                    );

    BEGIN

        IF  CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_string(p_NAME  =>  'MW_PROC_CONTROL')  =   'STOP'
        THEN
            RETURN;
        END IF;

        FOR rec IN c_step_instance
        LOOP

            IF  CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_string(p_NAME  =>  'MW_PROC_CONTROL')  =   'STOP'
            THEN
                RETURN;
            END IF;

            INSERT
              INTO  STEP_INSTANCE_STG 
                    (
                        step_instance_id,
                        status,
                        create_ts,
                        completed_ts, 
                        escalated_ind,
                        step_due_ts,
                        forwarded_ind,
                        group_id,
                        team_id,
                        ref_id,
                        ref_type,
                        step_definition_id,
                        created_by,
                        escalate_to,
                        forwarded_by,
                        owner,
                        suspended_ts,
                        step_instance_history_id,
                        hist_status,
                        hist_create_ts,
                        hist_create_by,
                        mw_processed,
                        mib_processed,
                        stage_create_ts,
                        case_id,
                        client_id,
                        priority,
                        process_id,
                        process_instance_id,
                        claimed_ts,
                        dcn,
                        document_received_date
                    )
             VALUES (
                        rec.step_instance_id,
                        rec.status,
                        rec.create_ts,
                        rec.completed_ts, 
                        rec.escalated_ind,
                        rec.step_due_ts,
                        rec.forwarded_ind,
                        rec.group_id,
                        rec.team_id,
                        rec.ref_id,
                        rec.ref_type,
                        rec.step_definition_id,
                        rec.created_by,
                        rec.escalate_to,
                        rec.forwarded_by,
                        rec.owner,
                        rec.suspended_ts,
                        rec.step_instance_history_id,
                        rec.hist_status,
                        rec.hist_create_ts,
                        rec.hist_create_by,
                        rec.mw_processed,
                        rec.mib_processed,
                        rec.stage_create_ts,
                        rec.case_id,
                        rec.client_id,
                        rec.priority,
                        rec.process_id,
                        rec.process_instance_id,
                        rec.claimed_ts,
                        rec.dcn,
                        rec.document_received_date
                    );

            COMMIT;

        END LOOP;

    END         ins_step_instance_stg;
    /*****************************************************************************************************************************************************************

        NAME:           get_dcn_date
        DESCRIPTION:    Get the date from the DCN.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     01/29/2019              Created procedure.

    *****************************************************************************************************************************************************************/
    FUNCTION    get_dcn_date
                (
                    p_DCN                               IN                      D_HCO_PROCESS_INSTANCE.dcn%TYPE
                )
    RETURN                                                                      DATE
    IS
        l_dcn_date                                                              DATE;
    BEGIN

        BEGIN

            SELECT  TO_DATE(SUBSTR(p_DCN, 1, 5), 'YYDDD')
              INTO  l_dcn_date
              FROM  DUAL;

        EXCEPTION

            WHEN    OTHERS
            THEN    NULL;

        END;

        RETURN  l_dcn_date;

    END         get_dcn_date;
    /*****************************************************************************************************************************************************************

        NAME:           del_hco_activity_queue
        DESCRIPTION:    Remove records from HCO_ACTIVITY_QUEUE that have REC_STATUS = p_REC_STATUS.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created procedure.

    *****************************************************************************************************************************************************************/
    PROCEDURE   del_hco_activity_queue
                (
                    p_REC_STATUS                        IN                      HCO_ACTIVITY_QUEUE.rec_status%TYPE,
                    p_BATCH_SIZE                        IN                      NUMBER                                                      DEFAULT 5000
                )    
    IS

        l_del_row_count                                                         NUMBER;

    BEGIN

        LOOP

            DELETE
              FROM  HCO_ACTIVITY_QUEUE
             WHERE  rec_status          =   p_REC_STATUS
               AND  rownum              <=  p_BATCH_SIZE;

            l_del_row_count :=  SQL%ROWCOUNT;

            COMMIT;

            EXIT WHEN l_del_row_count = 0;

        END LOOP;

    END         del_hco_activity_queue;    
    /*****************************************************************************************************************************************************************

        NAME:           analyze_pended_enrollments
        DESCRIPTION:    Analyze pended enrollments.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     05/21/2019              Created procedure

    *****************************************************************************************************************************************************************/
    PROCEDURE   analyze_pended_enrollments
                (
                    p_BATCH_SIZE                        IN                      NUMBER
                )
    IS
        l_step_instance_arr                                                     t_step_instance_arr;
        
        l_completed_dt                                                          DATE;
        
        l_pend_enrollment_days                                                  NUMBER;
        l_last_step_instance_id                                                 STEP_INSTANCE.step_instance_id%TYPE;
                
    BEGIN

        CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'analyze_pended_enrollments', 'Started');
 
        l_last_step_instance_id :=  0;

        l_pend_enrollment_days  :=
        
        CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_number
        (
            p_NAME  =>  'MW_PEND_ENROLLMENT_DAYS'
        );
      
        LOOP

            IF  
            (
                CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_string(p_NAME  =>  'MW_PROC_CONTROL')  =   CAHCO_ETL_MW_UTIL_PKG.get_action_stop
            )
            THEN
                RETURN;
            END IF;

            CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'analyze_pended_enrollments', 'Fetching next step instance batch...');          

            SELECT  *
                    BULK COLLECT INTO
                    l_step_instance_arr
              FROM  (
                        SELECT  si.*
                          FROM  STEP_INSTANCE               si
                         WHERE  si.step_definition_id   =   16
                           AND  si.status               =   CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed
                           AND  si.step_instance_id     >   l_last_step_instance_id
                         ORDER
                            BY  si.step_instance_id
                    )
             WHERE  rownum  <=  p_BATCH_SIZE;
 
            CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'analyze_pended_enrollments', 'Fetched batch with number of records = ' || l_step_instance_arr.COUNT || '...');                       
            EXIT WHEN l_step_instance_arr.COUNT = 0;

            CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'analyze_pended_enrollments', 'Started processing batch...');
        
            FOR i IN 1..l_step_instance_arr.COUNT
            LOOP
        
                l_last_step_instance_id :=  l_step_instance_arr(i).step_instance_id;
                
                BEGIN
        
                    SELECT  MIN(COALESCE(e.transaction_export_date, e.modified_date))                
                      INTO  l_completed_dt
                      FROM  EMRS_F_ENROLLMENT           e
                     WHERE  e.enrollment_id         =   l_step_instance_arr(i).ref_id
                       AND  e.enrollment_trans_type_code IN ('1', '2')
                       AND  COALESCE(e.transaction_export_date, e.modified_date)    >=  l_step_instance_arr(i).create_ts;

                EXCEPTION
                
                    WHEN    NO_DATA_FOUND
                    THEN    NULL;

                END;
                
                IF      l_completed_dt IS NULL
                THEN

                    BEGIN
            
                        SELECT  MIN(e.modified_date)                
                          INTO  l_completed_dt
                          FROM  EMRS_F_ENROLLMENT           e
                         WHERE  e.enrollment_id         =   l_step_instance_arr(i).ref_id
                           AND  e.enrollment_trans_type_code IN ('5', '8')
                           AND  e.disregard_trans_ind   =   CAHCO_ETL_MW_UTIL_PKG.is_yes
                           AND  e.record_date           =   l_step_instance_arr(i).create_ts
                           AND  e.modified_date         >=  TRUNC(e.record_date) + l_pend_enrollment_days;
    
                    EXCEPTION
                    
                        WHEN    NO_DATA_FOUND
                        THEN    NULL;
    
                    END;
                
                END IF;
                
                IF      l_completed_dt IS NOT NULL
                THEN
                
                    UPDATE  STEP_INSTANCE               si
                       SET  si.status               =   CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed,
                            si.status_ts            =   l_completed_dt
                     WHERE  si.step_instance_id     =   l_step_instance_arr(i).step_instance_id;
                     
                END IF;
                                                    
            END LOOP;

            COMMIT;

            CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'analyze_pended_enrollments', 'Finished processing batch...');

       END LOOP;
  
        CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'analyze_pended_enrollments', 'Completed');                

    END         analyze_pended_enrollments;
    /*****************************************************************************************************************************************************************

        NAME:           generate_step_instances
        DESCRIPTION:    Generate step instances from DP and HCODB activity data.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     03/15/2019              Created procedure

    *****************************************************************************************************************************************************************/
    PROCEDURE   generate_step_instances
    IS
    BEGIN

        CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'generate_step_instances', 'Started');

        cahco_etl_mw_util_pkg.set_corp_etl_control_string
        (
            p_NAME			=>	'MW_PROC_CONTROL',
            p_STRING		=>	CAHCO_ETL_MW_UTIL_PKG.get_action_start
        );

        CAHCO_ETL_MW_UTIL_PKG.populate_corp_etl_list_lkup;
        CAHCO_ETL_MW_UTIL_PKG.sync_task_type_entity_cfg;

        CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'generate_step_instances', 'Calculating table statistics...');

        CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'generate_step_instances', 'Calculating stats on table D_STAFF...');
        maxdat_admin.gather_table_stats(USER, 'd_staff', 8);

        CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'generate_step_instances', 'Calculating stats on table STAFF_KEY_LKUP...');
        maxdat_admin.gather_table_stats(USER, 'staff_key_lkup', 8);

        CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'generate_step_instances', 'Calculating stats on table HCO_D_EMPLOYEES...');
        maxdat_admin.gather_table_stats(USER, 'hco_d_employees', 8);        

        CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'generate_step_instances', 'Calculating stats on table D_BUSINESS_UNITS...');
        maxdat_admin.gather_table_stats(USER, 'd_business_units', 8);

        CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'generate_step_instances', 'Calculating stats on table D_TEAMS...');
        maxdat_admin.gather_table_stats(USER, 'd_teams', 8);       

        CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'generate_step_instances', 'Calculating stats on table HCO_CASE_DCN...');
        maxdat_admin.gather_table_stats(USER, 'hco_case_dcn', 8);        

        CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'generate_step_instances', 'Calculating stats on table HCO_MAIL_CLIENT_TRANS...');
        maxdat_admin.gather_table_stats(USER, 'hco_mail_client_trans', 8);        

        CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'generate_step_instances', 'Calculating stats on table HCO_D_MAIL_RETURNED...');
        maxdat_admin.gather_table_stats(USER, 'hco_d_mail_returned', 8);        

        CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'generate_step_instances', 'Calculating stats on table DAILY_TRANSACTION_ENROLLMENT...');
        maxdat_admin.gather_table_stats(USER, 'daily_transaction_enrollment', 8);       

        CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'generate_step_instances', 'Calculating stats on table HCO_SYSTEM_LOG...');
        maxdat_admin.gather_table_stats(USER, 'hco_system_log', 8);        

        CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'generate_step_instances', 'Calculating stats on table HCO_ENROLLMENT_EXT...');
        maxdat_admin.gather_table_stats(USER, 'hco_enrollment_ext', 8);   

        CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'generate_step_instances', 'Calculating stats on table HCO_BATCH_STATS...');
        maxdat_admin.gather_table_stats(USER, 'hco_batch_stats', 8);        

        CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'generate_step_instances', 'Calculating stats on table HCO_BATCH_DCN...');
        maxdat_admin.gather_table_stats(USER, 'hco_batch_dcn', 8);        

        CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'generate_step_instances', 'Processing exemption requests...');
        proc_emrs_d_exemption_req;

        CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'generate_step_instances', 'Processing exemption status history...');
        proc_emrs_d_exempt_status_hist;

        CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'generate_step_instances', 'Processing exemption status history activity six...');
        proc_emrs_d_exempt_status_hist_activity_six;

        CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'generate_step_instances', 'Processing EDERs...');
        proc_emrs_d_emrgcy_disenroll;

        CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'generate_step_instances', 'Processing EDER history...');
        proc_emrs_d_emrgcy_denr_hist;

        CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'generate_step_instances', 'Processing enrollments...');
        proc_emrs_f_enrollment;

        CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'generate_step_instances', 'Processing return mail...');
        proc_return_mail;

        CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'generate_step_instances', 'Processing letter mailings...');
        proc_hco_d_letter_mailing;

        CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'generate_step_instances', 'Processing packet mailings...');
        proc_hco_d_packet_mailing;

        CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'generate_step_instances', 'Calculating status on table HCO_ACTIVITY_QUEUE...');
        maxdat_admin.gather_table_stats(USER, 'hco_activity_queue', 8);

        CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'generate_step_instances', 'Processing HCO_ACTIVITY_QUEUE...');
        proc_hco_activity_queue
        (
            p_BATCH_SIZE                 => 2000,
            p_DML_OPERATION              => NULL
        );

        CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'generate_step_instances', 'Deleting HCO_ACTIVITY_QUEUE...');
        del_hco_activity_queue
        (
            p_REC_STATUS    => CAHCO_ETL_MW_UTIL_PKG.get_queue_status_complete,       
            p_BATCH_SIZE    => 2000
        ); 

        CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'generate_step_instances', 'Analyzing pending enrollments...');
        analyze_pended_enrollments
        (
            p_BATCH_SIZE    =>  2000
        );

        CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'generate_step_instances', 'Inserting into STEP_INSTANCE_STG...');
        ins_step_instance_stg;

        CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'generate_step_instances', 'Calculating status on table STEP_INSTANCE_STG...');
        maxdat_admin.gather_table_stats(USER, 'step_instance_stg', 8);        

        cahco_etl_mw_util_pkg.set_corp_etl_control_string
        (
            p_NAME			=>	'MW_PROC_CONTROL',
            p_STRING		=>	'STOP'
        );

        CAHCO_ETL_MW_UTIL_PKG.log_message(c_package_name || '.' || 'generate_step_instances', 'Completed');

    END         generate_step_instances;
    /*****************************************************************************************************************************************************************

        NAME:           upsert_group
        DESCRIPTION:    Update/Insert a group, returning the resulting group ID.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     02/28/2019              Created function.

    *****************************************************************************************************************************************************************/
    FUNCTION    upsert_group
                (
                    p_SOURCE_REFERENCE_TYPE             IN                      GROUPS_STG.source_reference_type%TYPE,
                    p_SOURCE_REFERENCE_ID               IN                      GROUPS_STG.source_reference_id%TYPE,
                    p_GROUP_NAME                        IN                      GROUPS_STG.group_name%TYPE,
                    p_DESCRIPTION                       IN                      GROUPS_STG.description%TYPE,
                    p_PARENT_GROUP_ID                   IN                      GROUPS_STG.parent_group_id%TYPE,
                    p_TYPE_CD                           IN                      GROUPS_STG.type_cd%TYPE,
                    p_SUPERVISOR_STAFF_ID               IN                      GROUPS_STG.supervisor_staff_id%TYPE
                )        
    RETURN                                                                      GROUPS_STG.group_id%TYPE
    IS
        l_group_id                                                              GROUPS_STG.group_id%TYPE;              
    BEGIN

        UPDATE  GROUPS_STG  g
           SET  g.description                           =   p_DESCRIPTION,
                g.parent_group_id                       =   p_PARENT_GROUP_ID,
                g.type_cd                               =   p_TYPE_CD,
                g.supervisor_staff_id                   =   p_SUPERVISOR_STAFF_ID,
                g.updated_by                            =   USER,
                g.update_ts                             =   SYSDATE
         WHERE  g.source_reference_type                 =   p_SOURCE_REFERENCE_TYPE
           AND  g.source_reference_id                   =   p_SOURCE_REFERENCE_ID
        RETURNING   group_id
        INTO        l_group_id;

        IF
        (
            SQL%ROWCOUNT = 0
        )
        THEN

            SELECT  MAX(g.group_id) + 1
              INTO  l_group_id
              FROM  GROUPS_STG  g;            

            INSERT
              INTO  GROUPS_STG  
                    (
                        group_id,
                        source_reference_type,
                        source_reference_id,
                        group_name, 
                        description,
                        parent_group_id,
                        start_date,     
                        end_date,       
                        type_cd,        
                        supervisor_staff_id,
                        created_by,         
                        create_ts,
                        updated_by,
                        update_ts
                    )
            VALUES  (
                        l_group_id,
                        p_SOURCE_REFERENCE_TYPE,
                        p_SOURCE_REFERENCE_ID,
                        p_GROUP_NAME, 
                        p_DESCRIPTION,
                        p_PARENT_GROUP_ID,
                        TO_DATE('1900-01-01 00:00:00', 'yyyy-mm-dd hh24:mi:ss'),
                        TO_DATE('3077-01-01 00:00:00', 'yyyy-mm-dd hh24:mi:ss'),
                        p_TYPE_CD,        
                        p_SUPERVISOR_STAFF_ID,
                        USER,         
                        SYSDATE,
                        USER,
                        SYSDATE
                    );

        END IF;

        COMMIT;

        RETURN  l_group_id;

    END         upsert_group;                    

    /*****************************************************************************************************************************************************************

        NAME:           get_most_recent_step_or_activty
        DESCRIPTION:    get most recent step instance or activty record info.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        EDB                     04/25/2019              Created function.

    *****************************************************************************************************************************************************************/

    FUNCTION    get_most_recent_step_or_activity
                (
                    p_REF_ID                            IN                      STEP_INSTANCE.ref_id%TYPE,
                    p_REF_TYPE                          IN                      STEP_INSTANCE.ref_type%TYPE,
                    p_STEP_DEFINITION_ID                IN                      STEP_INSTANCE.step_definition_id%TYPE
                )
    RETURN                                                                      step_activity_info_rec
    IS
        info_rec                                                                    step_activity_info_rec  default null;

    BEGIN

    BEGIN
    select act_ref_id, act_status, act_create_ts, step_sequence into info_rec.ref_id, info_rec.status, info_rec.create_ts, info_rec.step_sequence
    from 
        (select act_ref_id, act_status, act_create_ts, hco_activity_queue_id, step_sequence, rank() over (partition by act_ref_id order by hco_activity_queue_id desc) rnk
         from hco_activity_queue
         where act_ref_id = p_ref_id
         and act_ref_type= p_ref_type
         and act_step_definition_id = p_step_definition_id)
         where rnk = 1; 
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    info_rec := NULL;
    END;

    IF info_rec.ref_id is null
    THEN

        BEGIN
        select ref_id, status, create_ts, step_sequence into info_rec.ref_id, info_rec.status, info_rec.create_ts, info_rec.step_sequence
        from 
            (select ref_id, status, create_ts, step_instance_id, step_sequence, rank() over (partition by ref_id order by step_instance_id desc) rnk
             from step_instance
             where ref_id = p_ref_id
             and ref_type = p_ref_type
             and step_definition_id = p_step_definition_id)
        where rnk = 1;  
        EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    info_rec := NULL;
    END;    
    END IF;

    return info_rec;

    END         get_most_recent_step_or_activity;

    /*****************************************************************************************************************************************************************

        NAME:           is_exemption_status_code_a_duplicate
        DESCRIPTION:    determine if current exemption history status code is a duplicate of a previous exemption history status code.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        EDB                     06/07/2019              Created function.

    *****************************************************************************************************************************************************************/

    FUNCTION    is_exemption_status_code_a_duplicate
                (
                    
                    p_EXEMPTION_HIST_ID                         IN                 emrs_d_exempt_status_hist.exemption_hist_id%TYPE,
                    p_EXEMPTION_ID                         	IN                 emrs_d_exempt_status_hist.exemption_id%TYPE,
                    p_STATUS_CODE                     		IN                 emrs_d_exempt_status_hist.exemption_status_code%TYPE
                      
                )
    RETURN                                                                      PLS_INTEGER
    IS
		duplicate_count	int;
		duplicate_flag	PLS_INTEGER;
    BEGIN

	select count(*) into duplicate_count
	from maxdat.emrs_d_exempt_status_hist h, maxdat.emrs_d_exemption_req r 
	where h.exemption_id = r.exemption_id
	and r.dcn is not null
	and h.exemption_status_code in (p_status_code)
	and h.exemption_id = p_exemption_id
	and h.exemption_hist_id < p_exemption_hist_id
	and r.record_date >=  CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_date
                                        (
                                            p_NAME  =>  'MW_ETL_DATA_START_DATE'
                                        )
	and h.record_date >= CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_date
                                        (
                                            p_NAME  =>  'MW_ETL_DATA_START_DATE'
                                        )
	and not exists (
			select 1 from maxdat.emrs_d_exempt_status_hist h3
			where h.exemption_id = h3.exemption_id
			and h.exemption_hist_id < h3.exemption_hist_id
			and p_exemption_hist_id > h3.exemption_hist_id
			and h3.exemption_status_code not in (p_status_code,'4','UK','0','I','J','N','O')
			);


	IF (duplicate_count > 0)
	THEN 
		duplicate_flag := CAHCO_ETL_MW_UTIL_PKG.is_true;
	ELSE 
		duplicate_flag := CAHCO_ETL_MW_UTIL_PKG.is_false; 
	END IF;

	return duplicate_flag;
    END         is_exemption_status_code_a_duplicate;


    /*****************************************************************************************************************************************************************

        NAME:           is_eder_status_code_a_duplicate
        DESCRIPTION:    determine if current eder history status code is a duplicate of a previous eder history status code.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        EDB                     06/07/2019              Created function.

    *****************************************************************************************************************************************************************/

    FUNCTION    is_eder_status_code_a_duplicate
                (
                    
                    p_EDER_HIST_ID                      	IN                 EMRS_D_EMRGCY_DENR_HIST.emrgcy_denr_hist_id%TYPE,
                    p_EDER_ID                         		IN                 EMRS_D_EMRGCY_DENR_HIST.emrgcy_denr_id%TYPE,
                    p_STATUS_CODE                     		IN                 EMRS_D_EMRGCY_DENR_HIST.emrgcy_denr_status_code%TYPE
                      
                )
    RETURN                                                                      PLS_INTEGER
    IS
		duplicate_count	int;
		duplicate_flag	PLS_INTEGER;
    BEGIN

	select count(*) into duplicate_count
	from maxdat.emrs_d_emrgcy_denr_hist h, MAXDAT.Emrs_D_emrgcy_disenroll rq 
	where h.emrgcy_denr_id = rq.emrgcy_disenroll_id
	and rq.dcn is not null
	and h.emrgcy_denr_status_code in (p_status_code)
	and h.emrgcy_denr_id = p_eder_id
	and h.emrgcy_denr_hist_id < p_eder_hist_id
	and rq.record_date >=  CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_date
                                        (
                                            p_NAME  =>  'MW_ETL_DATA_START_DATE'
                                        )
	and h.record_date >= CAHCO_ETL_MW_UTIL_PKG.get_corp_etl_control_date
                                        (
                                            p_NAME  =>  'MW_ETL_DATA_START_DATE'
                                        )
	and not exists (
			select 1 from maxdat.emrs_d_emrgcy_denr_hist h3
			where h.emrgcy_denr_id = h3.emrgcy_denr_id
			and h.emrgcy_denr_hist_id < h3.emrgcy_denr_hist_id
			and p_eder_hist_id > h3.emrgcy_denr_hist_id
			and h3.emrgcy_denr_status_code not in (p_status_code,'0','5','A','U')
			);


	IF (duplicate_count > 0)
	THEN 
		duplicate_flag := CAHCO_ETL_MW_UTIL_PKG.is_true;
	ELSE 
		duplicate_flag := CAHCO_ETL_MW_UTIL_PKG.is_false; 
	END IF;

	return duplicate_flag;
    END         is_eder_status_code_a_duplicate;

    /*****************************************************************************************************************************************************************

        NAME:           refresh_bizunits
        DESCRIPTION:    Refresh bizunits in the table GROUPS_STG.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     02/28/2019              Created procedure.

    *****************************************************************************************************************************************************************/
    PROCEDURE   refresh_bizunits
    IS

        CURSOR  c_employees
        IS
        SELECT  DISTINCT
                e.department_name,
                e.department_id
          FROM  HCO_D_EMPLOYEES             e;

        l_group_id                                                              GROUPS_STG.group_id%TYPE;          

    BEGIN

        FOR rec IN c_employees
        LOOP
            l_group_id  :=  upsert_group
                            (
                                p_SOURCE_REFERENCE_TYPE     =>  'Department ID',
                                p_SOURCE_REFERENCE_ID       =>  TO_CHAR(rec.department_id),
                                p_GROUP_NAME                =>  rec.department_name,
                                p_DESCRIPTION               =>  rec.department_name,
                                p_PARENT_GROUP_ID           =>  NULL,
                                p_TYPE_CD                   =>  'BIZUNIT',
                                p_SUPERVISOR_STAFF_ID       =>  NULL
                            );        
        END LOOP;

    END         refresh_bizunits;
    /*****************************************************************************************************************************************************************

        NAME:           refresh_teams
        DESCRIPTION:    Refresh teams in the table GROUPS_STG.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     02/28/2019              Created procedure.

    *****************************************************************************************************************************************************************/
    PROCEDURE   refresh_teams
    IS

        CURSOR  c_employees
        IS
        SELECT  e.employee_id,
                e.department_name,
                e.department_id,
                e.supv_employee_id,
                e.supv_first_name,
                e.supv_last_name
          FROM  HCO_D_EMPLOYEES             e;

        l_group_id                                                              GROUPS_STG.group_id%TYPE;
        l_staff_id                                                              D_STAFF.staff_id%TYPE;

    BEGIN

        -- Make sure any all source reference IDs are populated in D_STAFF.

        UPDATE  D_STAFF     s
           SET  s.source_reference_id   =   CAHCO_ETL_MW_UTIL_PKG.get_string_digits(s.ext_staff_number)
         WHERE  s.source_reference_id   IS NULL;

        UPDATE  D_STAFF     s
           SET  s.source_reference_type =   substr(ext_staff_number, 1, instr(ext_staff_number, '\') - 1)
         WHERE  s.source_reference_type !=  substr(ext_staff_number, 1, instr(ext_staff_number, '\') - 1);

        COMMIT;

        FOR rec IN c_employees
        LOOP
            l_group_id  :=  upsert_group
                            (
                                p_SOURCE_REFERENCE_TYPE     =>  'Department ID',
                                p_SOURCE_REFERENCE_ID       =>  TO_CHAR(rec.department_id),
                                p_GROUP_NAME                =>  rec.department_name,
                                p_DESCRIPTION               =>  rec.department_name,
                                p_PARENT_GROUP_ID           =>  NULL,
                                p_TYPE_CD                   =>  'BIZUNIT',
                                p_SUPERVISOR_STAFF_ID       =>  NULL
                            );        

            l_staff_id  :=  CAHCO_ETL_MW_UTIL_PKG.get_staff_id
                            (
                                p_EXT_STAFF_NUMBER         =>   rec.supv_employee_id,
                                p_FUZZY_MATCH              =>   CAHCO_ETL_MW_UTIL_PKG.is_false
                            );

            IF
            (
                l_staff_id  =   CAHCO_ETL_MW_UTIL_PKG.get_unknown_staff_id
            )
            THEN
                INSERT INTO
                    D_STAFF 
                    (   
                        ext_staff_number,   
                        first_name, 
                        last_name,  
                        created_by,     
                        create_ts,  
                        updated_by, 
                        update_ts,  
                        default_group_id,
                        source_reference_type, 
                        source_reference_id  
                    )
                VALUES      
                    (   
                        'hcotraining\'||TO_CHAR(rec.supv_employee_id),
                        rec.supv_first_name,
                        rec.supv_last_name,
                        USER,
                        SYSDATE,
                        USER,
                        SYSDATE,
                        l_group_id,
                        'hcotraining',
                        rec.supv_employee_id
                    )
                RETURNING
                    staff_id
                INTO
                    l_staff_id;

                COMMIT;

            END IF;

            IF
            (
                l_staff_id IS NOT NULL
            )
            THEN
                l_group_id  :=  upsert_group
                                (
                                    p_SOURCE_REFERENCE_TYPE     =>  'Supervisor Employee ID',
                                    p_SOURCE_REFERENCE_ID       =>  TO_CHAR(rec.supv_employee_id),
                                    p_GROUP_NAME                =>  'Team ' || rec.supv_first_name || ' ' || rec.supv_last_name,
                                    p_DESCRIPTION               =>  'Team ' || rec.supv_first_name || ' ' || rec.supv_last_name,
                                    p_PARENT_GROUP_ID           =>  l_group_id,
                                    p_TYPE_CD                   =>  'TEAM',
                                    p_SUPERVISOR_STAFF_ID       =>  l_staff_id
                                );               

                UPDATE  D_STAFF     s
                   SET  s.default_group_id                                          =   l_group_id
                 WHERE  CAHCO_ETL_MW_UTIL_PKG.get_string_digits(s.ext_staff_number) =   rec.employee_id;

                 COMMIT;

            END IF;

        END LOOP;

        -- Make sure any residual source reference IDs are populated in D_STAFF.

        UPDATE  D_STAFF     s
           SET  s.source_reference_id   =   CAHCO_ETL_MW_UTIL_PKG.get_string_digits(s.ext_staff_number)
         WHERE  s.source_reference_id   IS NULL;

        UPDATE  D_STAFF     s
           SET  s.source_reference_type =   substr(ext_staff_number, 1, instr(ext_staff_number, '\') - 1)
         WHERE  s.source_reference_type !=  substr(ext_staff_number, 1, instr(ext_staff_number, '\') - 1);

        COMMIT;

    END         refresh_teams;
    /*****************************************************************************************************************************************************************

        NAME:           refresh_groups
        DESCRIPTION:    Refresh the table GROUPS_STG.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     02/28/2019              Created procedure.

    *****************************************************************************************************************************************************************/
    PROCEDURE   refresh_groups
    IS
    BEGIN

        refresh_bizunits;
        refresh_teams;

    END         refresh_groups;

END CAHCO_ETL_MW_PKG;
/