create or replace PACKAGE CAHCO_ETL_MW_UTIL_PKG AS

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL$';
  SVN_REVISION varchar2(20) := '$Revision$';
  SVN_REVISION_DATE varchar2(60) := '$Date$';
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

    FUNCTION    is_true
    RETURN                                                                      PLS_INTEGER;

    FUNCTION    is_false
    RETURN                                                                      PLS_INTEGER;

    FUNCTION    is_yes
    RETURN                                                                      VARCHAR2;

    FUNCTION    is_no
    RETURN                                                                      VARCHAR2;

    FUNCTION    get_unknown_staff_id
    RETURN                                                                      PLS_INTEGER;

    FUNCTION    get_system_process_staff_id
    RETURN                                                                      PLS_INTEGER;

    FUNCTION    get_unknown_business_unit_id
    RETURN                                                                      PLS_INTEGER;

    FUNCTION    get_unknown_team_id
    RETURN                                                                      PLS_INTEGER;

    FUNCTION    get_unknown_dcn
    RETURN                                                                      VARCHAR2;

    FUNCTION    get_unknown_client_number
    RETURN                                                                      PLS_INTEGER;

    FUNCTION    get_unknown_case_number
    RETURN                                                                      PLS_INTEGER;

    FUNCTION    get_unknown_ref_type
    RETURN                                                                      VARCHAR2;

    FUNCTION    get_unknown_ref_id
    RETURN                                                                      PLS_INTEGER;

    FUNCTION    get_action_stop
    RETURN                                                                      VARCHAR2;
    
    FUNCTION    get_action_start
    RETURN                                                                      VARCHAR2;    

    FUNCTION    get_queue_status_pending
    RETURN                                                                      VARCHAR2;

    FUNCTION    get_queue_status_in_progress
    RETURN                                                                      VARCHAR2;

    FUNCTION    get_queue_status_complete
    RETURN                                                                      VARCHAR2;
    
    FUNCTION    automatically_claimed
    RETURN                                                                      VARCHAR2;

    FUNCTION    claimed_on_ownership_change
    RETURN                                                                      VARCHAR2;

    FUNCTION    get_mw_status_unclaimed
    RETURN                                                                      VARCHAR2;

    FUNCTION    get_mw_status_claimed
    RETURN                                                                      VARCHAR2;

    FUNCTION    get_mw_status_completed
    RETURN                                                                      VARCHAR2;
    
    FUNCTION    get_log_message_type_info
    RETURN                                                                      VARCHAR2;

    FUNCTION    get_log_message_type_warning
    RETURN                                                                      VARCHAR2;

    FUNCTION    get_log_message_type_error
    RETURN                                                                      VARCHAR2;

    FUNCTION    get_corp_etl_control_date
                (
                    p_NAME                              IN                      CORP_ETL_CONTROL.name%TYPE
                )
    RETURN                                                                      DATE;    

    FUNCTION    get_corp_etl_control_number
                (
                    p_NAME                              IN                      CORP_ETL_CONTROL.name%TYPE
                )
    RETURN                                                                      NUMBER;

    FUNCTION    get_corp_etl_control_string
                (
                    p_NAME                              IN                      CORP_ETL_CONTROL.name%TYPE
                )
    RETURN                                                                      VARCHAR2;                

    PROCEDURE   set_corp_etl_control_string
                (
                    p_NAME                              IN                      CORP_ETL_CONTROL.name%TYPE,
                    p_STRING                            IN                      VARCHAR2
                );

    PROCEDURE   set_corp_etl_control_date
                (
                    p_NAME                              IN                      CORP_ETL_CONTROL.name%TYPE,
                    p_DATE                              IN                      DATE
                );


    FUNCTION    get_team_biz_unit_id
                (
                    p_TEAM_ID                           IN                      GROUPS_STG.group_id%TYPE,
                    p_LEVEL                             IN                      VARCHAR2
                )
    RETURN                                                                      GROUPS_STG.group_id%TYPE;

    PROCEDURE   get_staff_team_biz_unit_ids
                (
                    p_STAFF_KEY                         IN                      STAFF_KEY_LKUP.staff_key%TYPE,
                    p_TEAM_ID                                       OUT         D_TEAMS.team_id%TYPE,
                    p_BUSINESS_UNIT_ID                              OUT         D_BUSINESS_UNITS.business_unit_id%TYPE
                );                

    FUNCTION    get_staff_id
                (
                    p_EXT_STAFF_NUMBER                  IN                      D_STAFF.ext_staff_number%TYPE,
                    p_STAFF_FIRST_NAME                  IN                      D_STAFF.first_name%TYPE                             DEFAULT NULL,
                    p_STAFF_LAST_NAME                   IN                      D_STAFF.last_name%TYPE                              DEFAULT NULL,
                    p_FUZZY_MATCH                       IN                      PLS_INTEGER                                         DEFAULT is_true
                )
    RETURN                                                                      D_STAFF.staff_id%TYPE;

    FUNCTION    get_staff_key_lkup_staff_id
                (
                    p_STAFF_KEY                         IN                      STAFF_KEY_LKUP.staff_key%TYPE
                )
    RETURN                                                                      STAFF_KEY_LKUP.staff_id%TYPE;

    FUNCTION    return_query_date
                (
                    p_SQL                               IN                      VARCHAR2
                )
    RETURN                                                                      DATE;

    FUNCTION    return_query_string
                (
                    p_SQL                               IN                      VARCHAR2
                )
    RETURN                                                                      VARCHAR2;

    PROCEDURE   truncate_table
                (
                    p_TABLE_NAME                        IN                      VARCHAR2
                );

    FUNCTION    get_string_digits       
                (
                    p_string                            IN                      VARCHAR2,
                    p_must_be_consecutive               IN                      PLS_INTEGER                                         DEFAULT is_true
                )
    RETURN                                                                      VARCHAR2;

    FUNCTION    format_staff_string
                (
                    p_staff_string                      IN                      VARCHAR2
                )
    RETURN                                                                      VARCHAR2;

    PROCEDURE   populate_corp_etl_list_lkup;
    
    PROCEDURE   sync_task_type_entity_cfg;    

    FUNCTION    is_valid_enrollment
                (
                    p_enrollment_trans_type_code        IN                      EMRS_F_ENROLLMENT.enrollment_trans_type_code%TYPE,
                    p_dcn                               IN                      EMRS_F_ENROLLMENT.dcn%TYPE,                    
                    p_client_number                     IN                      EMRS_F_ENROLLMENT.client_number%TYPE,                    
                    p_channel_id                        IN                      EMRS_F_ENROLLMENT.channel_id%TYPE,                    
                    p_record_name                       IN                      EMRS_F_ENROLLMENT.record_name%TYPE,
                    p_date_of_validity_start            IN                      EMRS_F_ENROLLMENT.date_of_validity_start%TYPE,
                    p_date_of_validity_end              IN                      EMRS_F_ENROLLMENT.date_of_validity_end%TYPE                                        
                )
    RETURN                                                                      PLS_INTEGER;

    PROCEDURE   log_message
                (
                    p_CONTEXT                           IN                      CAHCO_ETL_MW_LOG.context%TYPE,
                    p_MESSAGE                           IN                      CAHCO_ETL_MW_LOG.message%TYPE,
                    p_MESSAGE_TYPE                      IN                      CAHCO_ETL_MW_LOG.message_type%TYPE                  DEFAULT get_log_message_type_info
                );                

END CAHCO_ETL_MW_UTIL_PKG;
/
create or replace PACKAGE BODY CAHCO_ETL_MW_UTIL_PKG AS

    c_int_true                                                                  PLS_INTEGER                             :=                  1;
    c_int_false                                                                 PLS_INTEGER                             :=                  0;

    c_char_yes                                                                  VARCHAR2(1)                             :=                  'Y';
    c_char_no                                                                   VARCHAR2(1)                             :=                  'N';

    c_action_stop                                                               VARCHAR2(4)                             :=                  'STOP';
    c_action_start                                                              VARCHAR2(5)                             :=                  'START';    

    c_queue_status_pending                                                      VARCHAR2(1)                             :=                  'P';
    c_queue_status_in_progress                                                  VARCHAR2(2)                             :=                  'IP';
    c_queue_status_complete                                                     VARCHAR2(1)                             :=                  'C';

    c_system_process_staff_id                                                   PLS_INTEGER                             :=                  -1;

    c_unknown_staff_id                                                          PLS_INTEGER                             :=                  0;
    c_unknown_business_unit_id                                                  PLS_INTEGER                             :=                  1;
    c_unknown_team_id                                                           PLS_INTEGER                             :=                  0;

    c_unknown_dcn                                                               VARCHAR2(2)                             :=                  '?';
    c_unknown_client_number                                                     PLS_INTEGER                             :=                  0;
    c_unknown_case_number                                                       PLS_INTEGER                             :=                  0;

    c_unknown_ref_type                                                          VARCHAR2(2)                             :=                  '?';
    c_unknown_ref_id                                                            PLS_INTEGER                             :=                  0;

    c_claimed_on_ownership_change                                               VARCHAR2(100)                           :=                  'CLAIMED ON OWNERSHIP CHANGE';
    c_automatically_claimed                                                     VARCHAR2(100)                           :=                  'AUTOMATICALLY CLAIMED';

    c_mw_status_unclaimed                                                       VARCHAR2(40)                            :=                  'UNCLAIMED';
    c_mw_status_claimed                                                         VARCHAR2(40)                            :=                  'CLAIMED';
    c_mw_status_completed                                                       VARCHAR2(40)                            :=                  'COMPLETED';

    c_log_message_type_info                                                     VARCHAR2(1)                             :=                  'I';
    c_log_message_type_warning                                                  VARCHAR2(1)                             :=                  'W';
    c_log_message_type_error                                                    VARCHAR2(1)                             :=                  'E';    
    /*****************************************************************************************************************************************************************

        NAME:           is_true
        DESCRIPTION:    Return c_int_true.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created function.

    *****************************************************************************************************************************************************************/
    FUNCTION    is_true
    RETURN                                                                      PLS_INTEGER
    IS
    BEGIN

        RETURN  c_int_true;

    END         is_true;        
    /*****************************************************************************************************************************************************************

        NAME:           is_false
        DESCRIPTION:    Return c_int_false.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created function.

    *****************************************************************************************************************************************************************/
    FUNCTION    is_false
    RETURN                                                                      PLS_INTEGER
    IS
    BEGIN

        RETURN  c_int_false;

    END         is_false;            
    /*****************************************************************************************************************************************************************

        NAME:           is_yes
        DESCRIPTION:    Return c_char_yes.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created function.

    *****************************************************************************************************************************************************************/
    FUNCTION    is_yes
    RETURN                                                                      VARCHAR2
    IS
    BEGIN

        RETURN  c_char_yes;

    END         is_yes;        
    /*****************************************************************************************************************************************************************

        NAME:           is_no
        DESCRIPTION:    Return c_char_no.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created function.

    *****************************************************************************************************************************************************************/
    FUNCTION    is_no
    RETURN                                                                      VARCHAR2
    IS
    BEGIN

        RETURN  c_char_no;

    END         is_no;            
    /*****************************************************************************************************************************************************************

        NAME:           claimed_on_ownership_change
        DESCRIPTION:    Return c_claimed_on_ownership_change.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created procedure.

    *****************************************************************************************************************************************************************/
    FUNCTION    claimed_on_ownership_change
    RETURN                                                                      VARCHAR2
    IS
    BEGIN

        RETURN  c_claimed_on_ownership_change;

    END         claimed_on_ownership_change;        
    /*****************************************************************************************************************************************************************

        NAME:           automatically_claimed
        DESCRIPTION:    Return c_automatically_claimed.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created procedure.

    *****************************************************************************************************************************************************************/
    FUNCTION    automatically_claimed
    RETURN                                                                      VARCHAR2
    IS
    BEGIN

        RETURN  c_automatically_claimed;

    END         automatically_claimed;   
    /*****************************************************************************************************************************************************************

        NAME:           get_mw_status_unclaimed
        DESCRIPTION:    Return c_mw_status_unclaimed.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created procedure.

    *****************************************************************************************************************************************************************/
    FUNCTION    get_mw_status_unclaimed
    RETURN                                                                      VARCHAR2
    IS
    BEGIN

        RETURN  c_mw_status_unclaimed;

    END         get_mw_status_unclaimed;        
    /*****************************************************************************************************************************************************************

        NAME:           get_mw_status_claimed
        DESCRIPTION:    Return c_mw_status_claimed.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created procedure.

    *****************************************************************************************************************************************************************/
    FUNCTION    get_mw_status_claimed
    RETURN                                                                      VARCHAR2
    IS
    BEGIN

        RETURN  c_mw_status_claimed;

    END         get_mw_status_claimed;        
    /*****************************************************************************************************************************************************************

        NAME:           get_mw_status_completed
        DESCRIPTION:    Return c_mw_status_completed.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created procedure.

    *****************************************************************************************************************************************************************/
    FUNCTION    get_mw_status_completed
    RETURN                                                                      VARCHAR2
    IS
    BEGIN

        RETURN  c_mw_status_completed;

    END         get_mw_status_completed;            
    /*****************************************************************************************************************************************************************

        NAME:           get_log_message_type_info
        DESCRIPTION:    Return c_log_message_type_info.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     05/21/2019              Created function.

    *****************************************************************************************************************************************************************/
    FUNCTION    get_log_message_type_info
    RETURN                                                                      VARCHAR2
    IS
    BEGIN

        RETURN  c_log_message_type_info;

    END         get_log_message_type_info;            
    /*****************************************************************************************************************************************************************

        NAME:           get_log_message_type_warning
        DESCRIPTION:    Return c_log_message_type_warning.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     05/21/2019              Created function.

    *****************************************************************************************************************************************************************/
    FUNCTION    get_log_message_type_warning
    RETURN                                                                      VARCHAR2
    IS
    BEGIN

        RETURN  c_log_message_type_warning;

    END         get_log_message_type_warning;            
    /*****************************************************************************************************************************************************************

        NAME:           get_log_message_type_error
        DESCRIPTION:    Return c_log_message_type_error.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     05/21/2019              Created function.

    *****************************************************************************************************************************************************************/
    FUNCTION    get_log_message_type_error
    RETURN                                                                      VARCHAR2
    IS
    BEGIN

        RETURN  c_log_message_type_error;

    END         get_log_message_type_error;                
    /*****************************************************************************************************************************************************************

        NAME:           get_corp_etl_control_date
        DESCRIPTION:    Get the corp etl control date associated with p_NAME.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created procedure.

    *****************************************************************************************************************************************************************/
    FUNCTION    get_corp_etl_control_date
                (
                    p_NAME                              IN                      CORP_ETL_CONTROL.name%TYPE
                )
    RETURN                                                                      DATE
    IS
        l_corp_etl_control_date                                                 DATE;
    BEGIN

        BEGIN

            SELECT  TO_DATE(cec.value, 'YYYY/MM/DD HH24:MI:SS')
              INTO  l_corp_etl_control_date
              FROM  CORP_ETL_CONTROL                                cec
             WHERE  cec.name                                    =   p_NAME;

        EXCEPTION

            WHEN    NO_DATA_FOUND
            THEN    l_corp_etl_control_date  :=  NULL;

        END;

        RETURN  l_corp_etl_control_date;

    END         get_corp_etl_control_date;
    /*****************************************************************************************************************************************************************

        NAME:           set_corp_etl_control_date
        DESCRIPTION:    Set the corp etl control date associated with p_NAME.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created procedure.

    *****************************************************************************************************************************************************************/
    PROCEDURE   set_corp_etl_control_date
                (
                    p_NAME                              IN                      CORP_ETL_CONTROL.name%TYPE,
                    p_DATE                              IN                      DATE
                )
    IS
    BEGIN

        IF  p_DATE IS NOT NULL
        THEN

            UPDATE  CORP_ETL_CONTROL        cec
               SET  value               =   TO_CHAR(p_date, 'YYYY/MM/DD HH24:MI:SS')
             WHERE  cec.name            =   p_NAME;

            COMMIT;             

        END IF;

    END         set_corp_etl_control_date;
    /*****************************************************************************************************************************************************************

        NAME:           get_corp_etl_control_number
        DESCRIPTION:    Get the corp etl control number associated with p_NAME.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created procedure.

    *****************************************************************************************************************************************************************/
    FUNCTION    get_corp_etl_control_number
                (
                    p_NAME                              IN                      CORP_ETL_CONTROL.name%TYPE
                )
    RETURN                                                                      NUMBER
    IS
        l_corp_etl_control_number                                               NUMBER;
    BEGIN

        BEGIN

            SELECT  TO_NUMBER(cec.value)
              INTO  l_corp_etl_control_number
              FROM  CORP_ETL_CONTROL                                cec
             WHERE  cec.name                                    =   p_NAME;

        EXCEPTION

            WHEN    NO_DATA_FOUND
            THEN    l_corp_etl_control_number  :=  NULL;

        END;

        RETURN  l_corp_etl_control_number;

    END         get_corp_etl_control_number;  
    /*****************************************************************************************************************************************************************

        NAME:           get_corp_etl_control_string
        DESCRIPTION:    Get the corp etl control string associated with p_NAME.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created procedure.

    *****************************************************************************************************************************************************************/
    FUNCTION    get_corp_etl_control_string
                (
                    p_NAME                              IN                      CORP_ETL_CONTROL.name%TYPE
                )
    RETURN                                                                      VARCHAR2
    IS
        l_corp_etl_control_string                                               VARCHAR2(4000);
    BEGIN

        BEGIN

            SELECT  cec.value
              INTO  l_corp_etl_control_string
              FROM  CORP_ETL_CONTROL                                cec
             WHERE  cec.name                                    =   p_NAME;

        EXCEPTION

            WHEN    NO_DATA_FOUND
            THEN    l_corp_etl_control_string  :=  NULL;

        END;

        RETURN  l_corp_etl_control_string;

    END         get_corp_etl_control_string;  
    /*****************************************************************************************************************************************************************

        NAME:           set_corp_etl_control_string
        DESCRIPTION:    Set the corp etl control string associated with p_NAME.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created procedure.

    *****************************************************************************************************************************************************************/
    PROCEDURE   set_corp_etl_control_string
                (
                    p_NAME                              IN                      CORP_ETL_CONTROL.name%TYPE,
                    p_STRING                            IN                      VARCHAR2
                )
    IS
    BEGIN

        IF  p_STRING IS NOT NULL
        THEN

            UPDATE  CORP_ETL_CONTROL        cec
               SET  value               =   p_STRING
             WHERE  cec.name            =   p_NAME;

            COMMIT;             

        END IF;

    END         set_corp_etl_control_string;    
    /*****************************************************************************************************************************************************************

        NAME:           format_staff_string
        DESCRIPTION:    Format the staff string, p_staff_string

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     04/25/2019              Created function.

    *****************************************************************************************************************************************************************/
    FUNCTION    format_staff_string
                (
                    p_staff_string                      IN                      VARCHAR2
                )
    RETURN                                                                      VARCHAR2
    IS
        l_string_index                                                          NUMBER;
        l_formatted_string                                                      VARCHAR2(32767);
    BEGIN
    
        l_formatted_string   :=  LOWER(p_staff_string);
    
        l_string_index  :=  INSTR(l_formatted_string, ' ');

        IF  l_string_index  >   0
        THEN
            l_formatted_string  :=  TRIM(SUBSTR(l_formatted_string, 1, l_string_index));
        END IF;    
    
        RETURN  l_formatted_string;
    
    END         format_staff_string;
    /*****************************************************************************************************************************************************************

        NAME:           get_unknown_staff_id
        DESCRIPTION:    Get the ID of the unknown staff record.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created function.

    *****************************************************************************************************************************************************************/
    FUNCTION    get_unknown_staff_id
    RETURN                                                                      PLS_INTEGER
    IS
    BEGIN

        RETURN  c_unknown_staff_id; 

    END         get_unknown_staff_id;    
    /*****************************************************************************************************************************************************************

        NAME:           get_system_process_staff_id
        DESCRIPTION:    Get the ID of the system process staff record.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     09/24/2019              Created function.

    *****************************************************************************************************************************************************************/
    FUNCTION    get_system_process_staff_id
    RETURN                                                                      PLS_INTEGER
    IS
    BEGIN

        RETURN  c_system_process_staff_id; 

    END         get_system_process_staff_id;    
    /*****************************************************************************************************************************************************************

        NAME:           get_unknown_business_unit_id
        DESCRIPTION:    Get the ID of the unknown business unit record.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created function.

    *****************************************************************************************************************************************************************/
    FUNCTION    get_unknown_business_unit_id
    RETURN                                                                      PLS_INTEGER
    IS
    BEGIN

        RETURN  c_unknown_business_unit_id; 

    END         get_unknown_business_unit_id;    
    /*****************************************************************************************************************************************************************

        NAME:           get_unknown_team_id
        DESCRIPTION:    Get the ID of the unknown team record.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created function.

    *****************************************************************************************************************************************************************/
    FUNCTION    get_unknown_team_id
    RETURN                                                                      PLS_INTEGER
    IS
    BEGIN

        RETURN  c_unknown_team_id; 

    END         get_unknown_team_id;    
    /*****************************************************************************************************************************************************************

        NAME:           get_unknown_dcn
        DESCRIPTION:    Get the value that corresponds to an unknown DCN.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created function.

    *****************************************************************************************************************************************************************/
    FUNCTION    get_unknown_dcn
    RETURN                                                                      VARCHAR2
    IS
    BEGIN

        RETURN  c_unknown_dcn; 

    END         get_unknown_dcn;    
    /*****************************************************************************************************************************************************************

        NAME:           get_unknown_client_number
        DESCRIPTION:    Get the value that corresponds to an unknown client number.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created function.

    *****************************************************************************************************************************************************************/
    FUNCTION    get_unknown_client_number
    RETURN                                                                      PLS_INTEGER
    IS
    BEGIN

        RETURN  c_unknown_client_number; 

    END         get_unknown_client_number;    
    /*****************************************************************************************************************************************************************

        NAME:           get_unknown_case_number
        DESCRIPTION:    Get the value that corresponds to an unknown case number.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created function.

    *****************************************************************************************************************************************************************/
    FUNCTION    get_unknown_case_number
    RETURN                                                                      PLS_INTEGER
    IS
    BEGIN

        RETURN  c_unknown_case_number; 

    END         get_unknown_case_number;        
    /*****************************************************************************************************************************************************************

        NAME:           get_unknown_ref_type
        DESCRIPTION:    Get the value that corresponds to an unknown Ref Type.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created function.

    *****************************************************************************************************************************************************************/
    FUNCTION    get_unknown_ref_type
    RETURN                                                                      VARCHAR2
    IS
    BEGIN

        RETURN  c_unknown_ref_type; 

    END         get_unknown_ref_type;    
    /*****************************************************************************************************************************************************************

        NAME:           get_unknown_ref_id
        DESCRIPTION:    Get the value that corresponds to an unknown Ref ID.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created function.

    *****************************************************************************************************************************************************************/
    FUNCTION    get_unknown_ref_id
    RETURN                                                                      PLS_INTEGER
    IS
    BEGIN

        RETURN  c_unknown_ref_id; 

    END         get_unknown_ref_id;    
    /*****************************************************************************************************************************************************************

        NAME:           get_action_stop
        DESCRIPTION:    Get the value for c_action_stop.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created function.

    *****************************************************************************************************************************************************************/
    FUNCTION    get_action_stop
    RETURN                                                                      VARCHAR2
    IS
    BEGIN

        RETURN  c_action_stop; 

    END         get_action_stop;    
    /*****************************************************************************************************************************************************************

        NAME:           get_action_start
        DESCRIPTION:    Get the value for c_action_start.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created function.

    *****************************************************************************************************************************************************************/
    FUNCTION    get_action_start
    RETURN                                                                      VARCHAR2
    IS
    BEGIN

        RETURN  c_action_start; 

    END         get_action_start;   
    /*****************************************************************************************************************************************************************

        NAME:           get_queue_status_pending
        DESCRIPTION:    Get the value for c_queue_status_pending.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created function.

    *****************************************************************************************************************************************************************/
    FUNCTION    get_queue_status_pending
    RETURN                                                                      VARCHAR2
    IS
    BEGIN

        RETURN  c_queue_status_pending; 

    END         get_queue_status_pending;    
    /*****************************************************************************************************************************************************************

        NAME:           get_queue_status_in_progress
        DESCRIPTION:    Get the value for c_queue_status_in_progress.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created function.

    *****************************************************************************************************************************************************************/
    FUNCTION    get_queue_status_in_progress
    RETURN                                                                      VARCHAR2
    IS
    BEGIN

        RETURN  c_queue_status_in_progress; 

    END         get_queue_status_in_progress;
    /*****************************************************************************************************************************************************************

        NAME:           get_queue_status_complete
        DESCRIPTION:    Get the value for c_queue_status_complete.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created function.

    *****************************************************************************************************************************************************************/
    FUNCTION    get_queue_status_complete
    RETURN                                                                      VARCHAR2
    IS
    BEGIN

        RETURN  c_queue_status_complete; 

    END         get_queue_status_complete;            
    /*****************************************************************************************************************************************************************

        NAME:           get_staff_id
        DESCRIPTION:    Get the ID of the staff record that corresponds to p_EXT_STAFF_NUMBER.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created function.
        TAM                     01/23/2020              MAXDAT-9942:  Added code to use the STAFF_ID in STAFF_KEY_LKUP, iff. the staff ID resolves to the unknown
                                                        staff ID.  If a record does not exist in STAFF_KEY_LKUP, then the the resolved staff ID reverts back to the
                                                        unknown staff ID.
    *****************************************************************************************************************************************************************/
    FUNCTION    get_staff_id
                (
                    p_EXT_STAFF_NUMBER                  IN                      D_STAFF.ext_staff_number%TYPE,
                    p_STAFF_FIRST_NAME                  IN                      D_STAFF.first_name%TYPE                             DEFAULT NULL,
                    p_STAFF_LAST_NAME                   IN                      D_STAFF.last_name%TYPE                              DEFAULT NULL,
                    p_FUZZY_MATCH                       IN                      PLS_INTEGER                                         DEFAULT is_true
                )
    RETURN                                                                      D_STAFF.staff_id%TYPE
    IS
        l_ext_staff_number                                                      D_STAFF.ext_staff_number%TYPE                       DEFAULT LOWER(TRIM(p_EXT_STAFF_NUMBER));
        l_n_ext_staff_number                                                    NUMBER;
        l_staff_id                                                              D_STAFF.staff_id%TYPE;

        l_string_index                                                          NUMBER;
        l_staff_first_name                                                      D_STAFF.first_name%TYPE                             DEFAULT LOWER(TRIM(p_STAFF_FIRST_NAME));
        l_staff_last_name                                                       D_STAFF.last_name%TYPE                              DEFAULT LOWER(TRIM(p_STAFF_LAST_NAME));

    BEGIN

        IF
        (
            p_FUZZY_MATCH = is_false
        )
        THEN

            l_n_ext_staff_number    :=  COALESCE(get_string_digits(l_ext_staff_number), -9999);

            BEGIN

                SELECT  s.staff_id
                  INTO  l_staff_id
                  FROM  D_STAFF                                 s
                 WHERE  s.source_reference_id               =   l_n_ext_staff_number;

            EXCEPTION

                WHEN    TOO_MANY_ROWS
                THEN    BEGIN

                            SELECT  MAX(s.staff_id)
                              INTO  l_staff_id
                              FROM  D_STAFF                                     s
                             WHERE  s.source_reference_id                   =   l_n_ext_staff_number
                               AND  LOWER(TRIM(s.first_name))               =   l_staff_first_name
                               AND  LOWER(TRIM(s.last_name))                =   l_staff_last_name;

                            IF
                            (
                                l_staff_id IS NULL
                            )
                            THEN
                                RAISE   NO_DATA_FOUND;
                            END IF;

                        EXCEPTION

                            WHEN    NO_DATA_FOUND
                            THEN    BEGIN

                                        SELECT  MAX(s.staff_id)
                                          INTO  l_staff_id
                                          FROM  D_STAFF                                     s
                                         WHERE  s.source_reference_id                   =   l_n_ext_staff_number;

                                    EXCEPTION

                                        WHEN    NO_DATA_FOUND
                                        THEN    l_staff_id  := NULL;

                                    END;                        
                        END;


                WHEN    NO_DATA_FOUND
                THEN    l_staff_id  :=  NULL;

            END;

            l_staff_id  :=  NVL(l_staff_id, get_unknown_staff_id);

        ELSE

            IF  l_ext_staff_number IS NULL
            THEN
                RETURN  get_unknown_staff_id;
            END IF;

            l_string_index  :=  INSTR(l_ext_staff_number, ' ');

            IF  l_string_index  >   0
            THEN
                l_ext_staff_number  :=  TRIM(SUBSTR(l_ext_staff_number, 1, l_string_index));
            END IF;

            BEGIN

                SELECT  NVL(MAX(s.staff_id), get_unknown_staff_id)
                  INTO  l_staff_id
                  FROM  D_STAFF                     s
                 WHERE  s.ext_staff_number                                                      =   l_ext_staff_number
                    OR  s.ext_staff_number                                                      =   'cahco\' || l_ext_staff_number
                    OR  s.ext_staff_number                                                      =   'maxcorp\' || l_ext_staff_number
                    OR  s.ext_staff_number                                                      =   'uat\' || l_ext_staff_number                    
                    OR  s.ext_staff_number                                                      =   'maxdev\' || l_ext_staff_number
                    OR  s.ext_staff_number                                                      =   'hcotraining\' || l_ext_staff_number;

            EXCEPTION

                WHEN    NO_DATA_FOUND
                THEN    l_staff_id  :=  get_unknown_staff_id;  

            END;

        END IF;

        IF
        (
            l_staff_id  =   get_unknown_staff_id
        )
        THEN
            
            l_staff_id  :=
            
            get_staff_key_lkup_staff_id
            (
                p_STAFF_KEY     =>  l_ext_staff_number
            );
            
            l_staff_id  :=  NVL(l_staff_id, get_unknown_staff_id);

        END IF;

        RETURN  l_staff_id; 

    END         get_staff_id;    
    /*****************************************************************************************************************************************************************

        NAME:           get_staff_key_lkup_staff_id
        DESCRIPTION:    Get the ID of the staff record that corresponds to p_STAFF_KEY in STAFF_KEY_LKUP.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     09/24/2019              Created function.

    *****************************************************************************************************************************************************************/
    FUNCTION    get_staff_key_lkup_staff_id
                (
                    p_STAFF_KEY                         IN                      STAFF_KEY_LKUP.staff_key%TYPE
                )
    RETURN                                                                      STAFF_KEY_LKUP.staff_id%TYPE
    IS
        l_staff_id                                                              STAFF_KEY_LKUP.staff_id%TYPE;

    BEGIN

        BEGIN
        
            SELECT  MAX(skl.staff_id)
              INTO  l_staff_id
              FROM  STAFF_KEY_LKUP                          skl
             WHERE  skl.staff_key                       =   p_staff_key;

        EXCEPTION

            WHEN    NO_DATA_FOUND
            THEN    l_staff_id  :=  NULL;

        END;

        RETURN  l_staff_id; 

    END         get_staff_key_lkup_staff_id;        
    /*****************************************************************************************************************************************************************

        NAME:           get_team_biz_unit_id
        DESCRIPTION:    Get the ID of the business unit that is associated with p_TEAM_ID, based on p_LEVEL.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created function.

    *****************************************************************************************************************************************************************/
    FUNCTION    get_team_biz_unit_id
                (
                    p_TEAM_ID                           IN                      GROUPS_STG.group_id%TYPE,
                    p_LEVEL                             IN                      VARCHAR2
                )
    RETURN                                                                      GROUPS_STG.group_id%TYPE                
    IS
        l_group_id                                                              GROUPS_STG.group_id%TYPE                                    DEFAULT p_TEAM_ID;
        l_business_unit_id                                                      GROUPS_STG.group_id%TYPE                                    DEFAULT NULL;
        l_type_cd                                                               GROUPS_STG.type_cd%TYPE;
        l_parent_group_id                                                       GROUPS_STG.parent_group_id%TYPE;
    BEGIN

        WHILE   TRUE 
        LOOP

            BEGIN

                SELECT  gsp.group_id,
                        gsp.type_cd,
                        gsp.parent_group_id
                  INTO  l_group_id,
                        l_type_cd,
                        l_parent_group_id
                  FROM  GROUPS_STG                  gsc,
                        GROUPS_STG                  gsp
                 WHERE  gsc.group_id            =   l_group_id
                   AND  gsp.group_id            =   gsc.parent_group_id;

                IF  l_type_cd   =   'BIZUNIT'
                THEN
                    l_business_unit_id  :=  l_group_id;

                    IF      p_LEVEL =   'NEXT'
                    THEN
                        EXIT;
                    END IF;

                END IF;

                IF  l_group_id  =   l_parent_group_id
                THEN
                    EXIT;
                END IF;

            EXCEPTION

                WHEN    NO_DATA_FOUND
                THEN    l_business_unit_id  :=  get_unknown_business_unit_id;

            END;

        END LOOP;

        RETURN  l_business_unit_id; 

    END         get_team_biz_unit_id;        
    /*****************************************************************************************************************************************************************

        NAME:           get_staff_team_biz_unit_ids
        DESCRIPTION:    Get the IDs of the team and business units that are associated with p_STAFF_KEY.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created procedure.

    *****************************************************************************************************************************************************************/
    PROCEDURE   get_staff_team_biz_unit_ids
                (
                    p_STAFF_KEY                         IN                      STAFF_KEY_LKUP.staff_key%TYPE,
                    p_TEAM_ID                                       OUT         D_TEAMS.team_id%TYPE,
                    p_BUSINESS_UNIT_ID                              OUT         D_BUSINESS_UNITS.business_unit_id%TYPE
                )
    IS
        l_team_id                                                               D_TEAMS.team_id%TYPE;
        l_business_unit_id                                                      D_BUSINESS_UNITS.business_unit_id%TYPE;
    BEGIN

        BEGIN

            SELECT  CASE    WHEN    gs.type_cd  =   'TEAM'
                            THEN    s.default_group_id                  
                    END,
                    CASE    WHEN    gs.type_cd  =   'BIZUNIT'
                            THEN    s.default_group_id                  
                    END                                     
              INTO  l_team_id,
                    l_business_unit_id
              FROM  STAFF_KEY_LKUP              skl,
                    D_STAFF                     s,
                    GROUPS_STG                  gs
             WHERE  skl.staff_key           =   p_STAFF_KEY
               AND  skl.staff_id            =   s.staff_id
               AND  s.default_group_id      =   gs.group_id;

        EXCEPTION

            WHEN    NO_DATA_FOUND
            THEN    l_team_id   :=  NULL;  
                    l_business_unit_id  :=  NULL;

        END;

        IF  l_team_id IS NULL
        THEN
            l_team_id   :=  get_unknown_team_id;
        END IF;

        IF  l_business_unit_id IS NULL
        THEN

            l_business_unit_id  :=  get_team_biz_unit_id
                                    (
                                        p_TEAM_ID                           =>  l_team_id,
                                        p_LEVEL                             =>  'NEXT'
                                    );
        END IF;

        p_TEAM_ID   :=  l_team_id;
        p_BUSINESS_UNIT_ID  :=  NVL(l_business_unit_id, get_unknown_business_unit_id);

    END         get_staff_team_biz_unit_ids;    
    /*****************************************************************************************************************************************************************

        NAME:           return_query_date
        DESCRIPTION:    Return the result of the query, p_sql, as a date.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created function.

    *****************************************************************************************************************************************************************/
    FUNCTION    return_query_date
                (
                    p_SQL                               IN                      VARCHAR2
                )
    RETURN                                                                      DATE
    IS
        l_date                                                                  DATE;
    BEGIN

        EXECUTE IMMEDIATE p_SQL INTO l_date;

        RETURN  l_date; 

    END         return_query_date;        
    /*****************************************************************************************************************************************************************

        NAME:           return_query_string
        DESCRIPTION:    Return the result of the query, p_sql, as a string.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created function.

    *****************************************************************************************************************************************************************/
    FUNCTION    return_query_string
                (
                    p_SQL                               IN                      VARCHAR2
                )
    RETURN                                                                      VARCHAR2
    IS
        l_string                                                                VARCHAR2(32767);
    BEGIN

        EXECUTE IMMEDIATE p_SQL INTO l_string;

        RETURN  l_string; 

    END         return_query_string;       
    /*****************************************************************************************************************************************************************

        NAME:           get_string_digits
        DESCRIPTION:    Get a string of digits from a string, p_string.  If p_must_be_consecutive =

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     10/19/2018              Created function.

    *****************************************************************************************************************************************************************/
    FUNCTION    get_string_digits       
                (
                    p_string                            IN                      VARCHAR2,
                    p_must_be_consecutive               IN                      PLS_INTEGER                                         DEFAULT is_true
                )
    RETURN                                                                      VARCHAR2
    IS
        l_string_length                                                         NUMBER                                              DEFAULT LENGTH(p_string);
        l_string_index                                                          NUMBER                                              DEFAULT 1;

        l_string_char                                                           VARCHAR2(1);
        l_digit_string                                                          VARCHAR2(32767)                                     DEFAULT NULL;
    BEGIN

        FOR i IN 1..l_string_length
        LOOP

            l_string_char   :=  SUBSTR(p_string, i, 1);

            IF
            (
                l_string_char IN ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9')
            )
            THEN
                l_digit_string  :=  l_digit_string || l_string_char;
            ELSIF
            (
                    p_must_be_consecutive   =   is_true
                AND l_digit_string IS NOT NULL
            )
            THEN
                EXIT;
            END IF;

        END LOOP;

        RETURN  l_digit_string;

    END         get_string_digits;
    /*****************************************************************************************************************************************************************

        NAME:           sync_task_type_entity_cfg
        DESCRIPTION:    Populate the table CORP_ETL_LIST_LKUP from D_TASK_TYPES.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     03/20/2019              Created procedure.

    *****************************************************************************************************************************************************************/
    PROCEDURE   sync_task_type_entity_cfg
    IS
    BEGIN

        UPDATE  D_BPM_ENTITY    e
           SET  (timeliness_threshold, timeliness_days_type)    =   (
                                                                        SELECT  sla_days,
                                                                                sla_days_type
                                                                          FROM  D_TASK_TYPES                    tt,
                                                                                D_BPM_TASK_TYPE_ENTITY          tte
                                                                         WHERE  tt.task_type_id             =   tte.task_type_id
                                                                           AND  tte.entity_id               =   e.entity_id
                                                                    )
         WHERE  e.entity_id IN  (
                                    SELECT  tte.entity_id
                                      FROM  D_BPM_TASK_TYPE_ENTITY  tte
                                );
                                
        COMMIT;
    
    END         sync_task_type_entity_cfg;
    /*****************************************************************************************************************************************************************

        NAME:           populate_corp_etl_list_lkup
        DESCRIPTION:    Populate the table CORP_ETL_LIST_LKUP from D_TASK_TYPES.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     03/20/2019              Created procedure.

    *****************************************************************************************************************************************************************/
    PROCEDURE   populate_corp_etl_list_lkup
    IS                
    
        TYPE t_d_task_types_arr IS TABLE OF D_TASK_TYPES%rowtype;

        l_d_task_types_arr                    t_d_task_types_arr;
           
    BEGIN

        SELECT  *
                BULK COLLECT INTO
                l_d_task_types_arr
          FROM  D_TASK_TYPES;
            
        FOR t IN 1..l_d_task_types_arr.COUNT
        LOOP
        
            BEGIN
        
                MERGE
                 INTO   corp_etl_list_lkup                          o
                USING
                (
                    Select  'ManageWork_SLA_Days_Type'                          AS  NAME,
                            'TASK_TYPE'                                         AS  LIST_TYPE,
                            l_d_task_types_arr(t).task_name                     AS  VALUE,
                            l_d_task_types_arr(t).sla_days_type                 AS  OUT_VAR,
                            'STEP_DEFINITION_ID'                                AS  REF_TYPE,
                            to_char(l_d_task_types_arr(t).task_type_id)         AS  REF_ID
                      FROM  dual
                                                    
                )                                                   n        
                ON
                (
                        o.name                                      =   n.name
                    AND o.list_type                                 =   n.list_type
                    AND o.value                                     =   n.value
                )
                WHEN MATCHED THEN
                UPDATE SET
                    o.out_var                                       =   n.out_var,
                    o.ref_type                                      =   n.ref_type,
                    o.ref_id                                        =   n.ref_id
                WHEN NOT MATCHED THEN
                INSERT
                (    
                    NAME,
                    LIST_TYPE,
                    VALUE,
                    OUT_VAR,
                    REF_TYPE,
                    REF_ID
                )
                VALUES
                (    
        
                    n.NAME,
                    n.LIST_TYPE,
                    n.VALUE,
                    n.OUT_VAR,
                    n.REF_TYPE,
                    n.REF_ID
        
                );        
        
        
                MERGE
                 INTO   corp_etl_list_lkup                          o
                USING
                (
                    SELECT  'ManageWork_SLA_Days'                               AS  NAME,
                            'TASK_TYPE'                                         AS  LIST_TYPE,
                            l_d_task_types_arr(t).task_name                     AS  VALUE,
                            l_d_task_types_arr(t).sla_days                      AS  OUT_VAR,
                            'STEP_DEFINITION_ID'                                AS  REF_TYPE,
                            to_char(l_d_task_types_arr(t).task_type_id)         AS  REF_ID
                      FROM  dual
                                                    
                )                                                   n        
                ON
                (
                        o.name                                      =   n.name
                    AND o.list_type                                 =   n.list_type
                    AND o.value                                     =   n.value
                )
                WHEN MATCHED THEN
                UPDATE SET
                    o.out_var                                       =   n.out_var,
                    o.ref_type                                      =   n.ref_type,
                    o.ref_id                                        =   n.ref_id
                WHEN NOT MATCHED THEN
                INSERT
                (    
                    NAME,
                    LIST_TYPE,
                    VALUE,
                    OUT_VAR,
                    REF_TYPE,
                    REF_ID
                )
                VALUES
                (    
        
                    n.NAME,
                    n.LIST_TYPE,
                    n.VALUE,
                    n.OUT_VAR,
                    n.REF_TYPE,
                    n.REF_ID
        
                );        
        
        
                MERGE
                 INTO   corp_etl_list_lkup                          o
                USING
                (
                    SELECT  'ManageWork_SLA_Jeopardy_Days'                      AS  NAME,
                            'TASK_TYPE'                                         AS  LIST_TYPE,
                            l_d_task_types_arr(t).task_name                     AS  VALUE,
                            l_d_task_types_arr(t).sla_jeopardy_days             AS  OUT_VAR,
                            'STEP_DEFINITION_ID'                                AS  REF_TYPE,
                            to_char(l_d_task_types_arr(t).task_type_id)         AS  REF_ID
                      FROM  dual
                                                    
                )                                                   n        
                ON
                (
                        o.name                                      =   n.name
                    AND o.list_type                                 =   n.list_type
                    AND o.value                                     =   n.value
                )
                WHEN MATCHED THEN
                UPDATE SET
                    o.out_var                                       =   n.out_var,
                    o.ref_type                                      =   n.ref_type,
                    o.ref_id                                        =   n.ref_id
                WHEN NOT MATCHED THEN
                INSERT
                (    
                    NAME,
                    LIST_TYPE,
                    VALUE,
                    OUT_VAR,
                    REF_TYPE,
                    REF_ID
                )
                VALUES
                (    
        
                    n.NAME,
                    n.LIST_TYPE,
                    n.VALUE,
                    n.OUT_VAR,
                    n.REF_TYPE,
                    n.REF_ID
        
                );        
        
                MERGE
                 INTO   corp_etl_list_lkup                          o
                USING
                (
                    SELECT  'ManageWork_SLA_Target_Days'                        AS  NAME,
                            'TASK_TYPE'                                         AS  LIST_TYPE,
                            l_d_task_types_arr(t).task_name                     AS  VALUE,
                            l_d_task_types_arr(t).sla_target_days               AS  OUT_VAR,
                            'STEP_DEFINITION_ID'                                AS  REF_TYPE,
                            to_char(l_d_task_types_arr(t).task_type_id)         AS  REF_ID
                      FROM  dual
                                                    
                )                                                   n        
                ON
                (
                        o.name                                      =   n.name
                    AND o.list_type                                 =   n.list_type
                    AND o.value                                     =   n.value
                )
                WHEN MATCHED THEN
                UPDATE SET
                    o.out_var                                       =   n.out_var,
                    o.ref_type                                      =   n.ref_type,
                    o.ref_id                                        =   n.ref_id
                WHEN NOT MATCHED THEN
                INSERT
                (    
                    NAME,
                    LIST_TYPE,
                    VALUE,
                    OUT_VAR,
                    REF_TYPE,
                    REF_ID
                )
                VALUES
                (    
        
                    n.NAME,
                    n.LIST_TYPE,
                    n.VALUE,
                    n.OUT_VAR,
                    n.REF_TYPE,
                    n.REF_ID
        
                );        
        
                COMMIT;
        
            EXCEPTION
            
                WHEN    OTHERS
                THEN    ROLLBACK;
                        RAISE;
        
            END;
            
        END LOOP;

    END         populate_corp_etl_list_lkup;
    /*****************************************************************************************************************************************************************

        NAME:           truncate_table
        DESCRIPTION:    Truncate the table, p_TABLE_NAME.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     05/21/2019              Created procedure.
    *****************************************************************************************************************************************************************/
    PROCEDURE   truncate_table
                (
                    p_TABLE_NAME                        IN                      VARCHAR2
                )                
    IS
    BEGIN
    
        EXECUTE IMMEDIATE 'TRUNCATE TABLE ' || p_TABLE_NAME;
    
    END         truncate_table;
    /*****************************************************************************************************************************************************************

        NAME:           log_message
        DESCRIPTION:    Log a message to the table CAHCO_ETL_MW_LOG.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     05/21/2019              Created procedure.

    *****************************************************************************************************************************************************************/
    PROCEDURE   log_message
                (
                    p_CONTEXT                           IN                      CAHCO_ETL_MW_LOG.context%TYPE,
                    p_MESSAGE                           IN                      CAHCO_ETL_MW_LOG.message%TYPE,
                    p_MESSAGE_TYPE                      IN                      CAHCO_ETL_MW_LOG.message_type%TYPE                  DEFAULT get_log_message_type_info
                )                
    IS
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
    
        INSERT
          INTO  CAHCO_ETL_MW_LOG    (   context,        message,        message_type    )
        VALUES                      (   p_CONTEXT,      p_MESSAGE,      p_MESSAGE_TYPE  );
        
        COMMIT;    
    
    END         log_message;    
    /*****************************************************************************************************************************************************************

        NAME:           is_valid_enrollment
        DESCRIPTION:    Determine whether p_enrollment is a valid enrollment.

        WHO                     WHEN                    WHAT
        ===                     ====                    ====
        TAM                     05/01/2019              Created function.

    *****************************************************************************************************************************************************************/
    FUNCTION    is_valid_enrollment
                (
                    p_enrollment_trans_type_code        IN                      EMRS_F_ENROLLMENT.enrollment_trans_type_code%TYPE,
                    p_dcn                               IN                      EMRS_F_ENROLLMENT.dcn%TYPE,                    
                    p_client_number                     IN                      EMRS_F_ENROLLMENT.client_number%TYPE,                    
                    p_channel_id                        IN                      EMRS_F_ENROLLMENT.channel_id%TYPE,                    
                    p_record_name                       IN                      EMRS_F_ENROLLMENT.record_name%TYPE,
                    p_date_of_validity_start            IN                      EMRS_F_ENROLLMENT.date_of_validity_start%TYPE,
                    p_date_of_validity_end              IN                      EMRS_F_ENROLLMENT.date_of_validity_end%TYPE                    
                )
    RETURN                                                                      PLS_INTEGER
    IS
    BEGIN

        IF      p_dcn                               IS  NOT NULL
            AND UPPER(TRIM(p_dcn))                  != 'NULL'       
            AND p_client_number                     IS  NOT NULL
            AND (
                        p_enrollment_trans_type_code        IN  ('5', '8')
                    OR  (
                                p_enrollment_trans_type_code        IN  ('1', '2')
                            AND p_channel_id in ('2','10') 
                            AND (     	
                                        UPPER(p_record_name) LIKE 'MAXCORP%'
                                    OR  UPPER(p_record_name) ='OCRA'
                                )       
                            AND p_date_of_validity_start <= SYSDATE
                            AND p_date_of_validity_end >= SYSDATE
                        )
                )
        THEN
            RETURN  is_true;
        ELSE
            RETURN  is_false;
        END IF;
    
    END         is_valid_enrollment;
    
END CAHCO_ETL_MW_UTIL_PKG;
/