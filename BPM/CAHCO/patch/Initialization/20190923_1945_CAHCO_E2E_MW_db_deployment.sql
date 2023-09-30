ALTER SESSION SET CURRENT_SCHEMA=MAXDAT;

-- D_STAFF

Insert into D_STAFF (STAFF_ID,EXT_STAFF_NUMBER,DOB,SSN,FIRST_NAME,FIRST_NAME_CANON,FIRST_NAME_SOUND_LIKE,GENDER_CD,START_DATE,END_DATE,PHONE_NUMBER,LAST_NAME,LAST_NAME_CANON,LAST_NAME_SOUND_LIKE,CREATED_BY,CREATE_TS,UPDATED_BY,UPDATE_TS,MIDDLE_NAME,MIDDLE_NAME_CANON,MIDDLE_NAME_SOUND_LIKE,EMAIL,FAX_NUMBER,NOTE_REFID,DEPLOYMENT_STAFF_NUM,DEFAULT_GROUP_ID,STAFF_TYPE_CD,UNIQUE_STAFF_ID,VOID_IND,EXEMPT_FLAG,SOURCE_REFERENCE_TYPE,SOURCE_REFERENCE_ID) values (-1,'SYSTEM_PROCESS',null,null,'System',null,null,null,null,null,null,'Process',null,null,'MAXDAT',SYSDATE,'MAXDAT',SYSDATE,null,null,null,null,null,null,null,-2,null,null,0,'N',null,null);

-- Insert GROUPS_STG

DELETE
  FROM  GROUPS_STG
 WHERE  group_id < 0;

INSERT 
  INTO  GROUPS_STG (   GROUP_ID,    GROUP_NAME,                     DESCRIPTION,                    PARENT_GROUP_ID,    DEPLOYMENT_NAME,        START_DATE,                                                     END_DATE,                                               TYPE_CD,        SUPERVISOR_STAFF_ID,        CREATED_BY,     CREATE_TS,  UPDATED_BY, UPDATE_TS   ) 
VALUES             (   -1,          'System Process',               'System Process',               NULL,               NULL,                   to_date('1900-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'),         to_date('3077-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'), 'BIZUNIT',      NULL,                       USER,           SYSDATE,    USER,       SYSDATE     );

INSERT 
  INTO  GROUPS_STG (   GROUP_ID,    GROUP_NAME,                     DESCRIPTION,                    PARENT_GROUP_ID,    DEPLOYMENT_NAME,        START_DATE,                                                     END_DATE,                                               TYPE_CD,        SUPERVISOR_STAFF_ID,        CREATED_BY,     CREATE_TS,  UPDATED_BY, UPDATE_TS   ) 
VALUES             (   -2,          'System Process',               'System Process',               -1,                 NULL,                   to_date('1900-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'),         to_date('3077-01-01 00:00:00','YYYY-MM-DD HH24:MI:SS'), 'TEAM',         0,                          USER,           SYSDATE,    USER,       SYSDATE     );


-- Insert D_TEAMS

INSERT
  INTO  D_TEAMS     (TEAM_ID,   TEAM_NAME,          TEAM_DESCRIPTION,   TEAM_SUPERVISOR_STAFF_ID)
VALUES              (-2,        'System Process',   'System Process',   -1);

UPDATE  D_TEAMS
   SET  team_supervisor_staff_id    =   -1
 WHERE  team_id                     =   -2;

-- Insert D_BUSINESS_UNITS

INSERT
  INTO  D_BUSINESS_UNITS    (BUSINESS_UNIT_ID,      BUSINESS_UNIT_NAME,      BUSINESS_UNIT_DESCRIPTION)
VALUES                      (-1,                    'System Process',       'System Process');


-- STAFF_KEY_LKUP

DELETE
  FROM  STAFF_KEY_LKUP 
 WHERE  staff_id < 0;

Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'errusr');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'errorusr');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'clsxmp');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'uspmailreturned');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'ocrdisregard');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'hfdefault43');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'mltss_30dayphase03');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'loss_of_cmc_eligibility_manual_disnroll_and_dl_oct');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'mltss_30dayphase01');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'centralvalleydisenrollment');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'loss_of_cmc_eligibility_manual_disnroll_and_dl_feb');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'cci_60dayphase11');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'adhcpassiveenrollmentdd');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'cci_60dayphase17');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'loss_of_cmc_eligibility_manual_disnroll_and_dl_dec');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'loss_of_cmc_eligibility_manual_disnroll_lec_oct');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'espd_30dayphase04');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'loss_of_cmc_eligibility_manual_disnroll_and_dl_jul');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'defaultsb75');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'loss_of_cmc_eligibility_disnroll_and_dl_sep_cancel');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'streamline');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'cci_60dayphase07');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'cci_60dayphase10');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'defaultspd');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'hfphase1cdefault');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'cbas_passiveenrollment');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'espd_30dayphase08');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'mltss_30dayphase06');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'mmaref');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'mltss_30dayphase16');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'sacden');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'cci_60dayphase01');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'cci_60dayphase16');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'hfdefault41');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'loss_of_cmc_eligibility_manual_disnroll_and_dl_jun');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'loss_of_cmc_eligibility_manual_disnroll_and_dl_may');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'mltss_30dayphase05');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'mltss_30dayphase13');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'cbasdefaults');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'centralvalleydefault');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'is-generated');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'hfdefault44');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'wha');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'cci_60dayphase19');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'hf1bdefault');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'cci_60dayphase21');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'loss_of_cmc_eligibility_manual_disnroll_and_dl_sep');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'cci_60dayphase12');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'cci_60dayphase09');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'cci_60dayphase20');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'cci_60dayphase18');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'expansiondefault');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'uhc017-removalprocess-inelig');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'espd_30dayphase07');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'sdn');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'mltss_30dayphase11');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'espd_30dayphase01');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'adhcincomplete2or9');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'cci_60dayphase04');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'westerndentaldefault');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'mltss_30dayphase08');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'dba');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'espd_30dayphase11');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'loss_of_cmc_eligibility_manual_disnroll_lec_sep');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'mltss_30dayphase07');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'default');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'loss_of_cmc_eligibility_manual_disnroll_and_dl_jan');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'loss_of_cmc_eligibility_manual_disnroll_lec_aug');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'loss_of_cmc_eligibility_manual_disnroll_lec_may');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'cmcdisenroll800_phase04');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'penrl');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'cl_ltr');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'ocra');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'wklyplanfiles');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'admin');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'5n8');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'crmeds');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'dl_ltr');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'mltss_30dayphase02');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'spd_expansion_default');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'loss_of_cmc_eligibility_manual_disnroll_lec_mar');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'hfphase3default');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'mltss_30dayphase15');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'loss_of_cmc_eligibility_manual_disenrollmnt_and_dl');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'espd_30dayphase12');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'cci_60dayphase06');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'loss_of_cmc_eligibility_manual_disnroll_lec_apr');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'cci_60dayphase13');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'mltss_30dayphase12');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'cci_60dayphase07_mssp');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'espd_30dayphase09');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'mltss_30dayphase10');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'loss_of_cmc_eligibility_manual_disnroll_lec_jan');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'cci_60dayphase03');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'uhc017-reassignprocess');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'ddlusr');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'lihpdefault');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'newelg-wccphase2');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'loss_of_cmc_eligibility_manual_disnroll_and_dl_nov');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'espd_30dayphase03');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'loss_of_cmc_eligibility_manual_disnroll_and_dl_mar');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'cci_60dayphase08');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'loss_of_cmc_eligibility_manual_disnroll_lec_jun');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'mltss_30dayphase04');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'defaultadjustment');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'loss_of_cmc_eligibility_manual_disnroll_lec_nov');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'espd_30dayphase02');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'loss_of_cmc_eligibility_manual_disnroll_and_dl_apr');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'loss_of_cmc_eligibility_manual_disnroll_lec_dec');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'cci_60dayphase14');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'mltss_30dayphase17');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'mltss_30dayphase09');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'adhcpassiveenrollment');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'espd_30dayphase05');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'espd_30dayphase10');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'loss_of_cmc_eligibility_manual_disnroll_lec_feb');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'cci_60dayphase02');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'westerndentaldisenrollment');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'cci_60dayphase15');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'loss_of_cmc_eligibility_manual_disnroll_and_dl_aug');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'espd_30dayphase06');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'mltss_30dayphase14');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'loss_of_cmc_eligibility_manual_disnroll_lec_jul');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'cci_60dayphase05');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'rcnfix');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'newelig');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'newelg');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'recon');
Insert into STAFF_KEY_LKUP (STAFF_ID,STAFF_KEY) values (-1,'errmed');

update D_MW_TASK_INSTANCE set curr_owner_staff_id = -1 where curr_owner_staff_id < -1;
update D_MW_TASK_INSTANCE set curr_last_upd_by_staff_id = -1 where curr_last_upd_by_staff_id < -1;
update D_MW_TASK_INSTANCE set curr_forwarded_by_staff_id = -1 where curr_forwarded_by_staff_id < -1;
update D_MW_TASK_INSTANCE set curr_escalated_to_staff_id = -1 where curr_escalated_to_staff_id < -1;
update D_MW_TASK_INSTANCE set curr_created_by_staff_id = -1 where curr_created_by_staff_id < -1;
update D_MW_TASK_INSTANCE set cancelled_by_staff_id = -1 where cancelled_by_staff_id < -1;

update D_MW_TASK_INSTANCE set curr_team_id = -2 where curr_owner_staff_id = -1;

update CORP_ETL_MW_WIP set owner_staff_id = -1 where owner_staff_id < -1;
update CORP_ETL_MW_WIP set last_update_by_staff_id = -1 where last_update_by_staff_id < -1;
update CORP_ETL_MW_WIP set forwarded_by_staff_id = -1 where forwarded_by_staff_id < -1;
update CORP_ETL_MW_WIP set escalated_to_staff_id = -1 where escalated_to_staff_id < -1;
update CORP_ETL_MW_WIP set created_by_staff_id = -1 where created_by_staff_id < -1;
update CORP_ETL_MW_WIP set cancelled_by_staff_id = -1 where cancelled_by_staff_id < -1;

update CORP_ETL_MW_WIP set team_id = -2 where owner_staff_id = -1;

update CORP_ETL_MW set owner_staff_id = -1 where owner_staff_id < -1;
update CORP_ETL_MW set last_update_by_staff_id = -1 where last_update_by_staff_id < -1;
update CORP_ETL_MW set forwarded_by_staff_id = -1 where forwarded_by_staff_id < -1;
update CORP_ETL_MW set escalated_to_staff_id = -1 where escalated_to_staff_id < -1;
update CORP_ETL_MW set created_by_staff_id = -1 where created_by_staff_id < -1;
update CORP_ETL_MW set cancelled_by_staff_id = -1 where cancelled_by_staff_id < -1;

update CORP_ETL_MW set team_id = -2 where owner_staff_id = -1;

DELETE
  FROM  D_STAFF
 WHERE  staff_id    <   -1;
 
 DELETE 
   FROM STAFF_KEY_LKUP      skl
  WHERE staff_id        =   0
    AND EXISTS  (
                    SELECT  1
                      FROM  STAFF_KEY_LKUP          skl1
                     WHERE  skl1.staff_key      =   skl.staff_key
                       AND  staff_id            =   -1
                );

create or replace trigger TRG_BIUR_STEP_INSTANCE
BEFORE INSERT OR UPDATE ON STEP_INSTANCE
FOR EACH ROW
DECLARE
    l_rec_change                                                                PLS_INTEGER;
BEGIN

    l_rec_change    :=  0;

    IF          UPDATING
            AND (
                    NVL(:OLD.STATUS, '?')   = CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed
                )
    THEN

        :NEW.STATUS                         :=  :OLD.STATUS;
        :NEW.STATUS_TS                      :=  :OLD.STATUS_TS;
        :NEW.CREATE_TS                      :=  :OLD.CREATE_TS;
        :NEW.CLAIMED_TS                     :=  :OLD.CLAIMED_TS;
        :NEW.COMPLETED_TS                   :=  :OLD.COMPLETED_TS;
        :NEW.ESCALATED_IND                  :=  :OLD.ESCALATED_IND;
        :NEW.STEP_DUE_TS                    :=  :OLD.STEP_DUE_TS;
        :NEW.FORWARDED_IND                  :=  :OLD.FORWARDED_IND;
        :NEW.ESCALATE_TO                    :=  :OLD.ESCALATE_TO;
        :NEW.FORWARDED_BY                   :=  :OLD.FORWARDED_BY;
        :NEW.OWNER                          :=  :OLD.OWNER;
        :NEW.LOCKED_ID                      :=  :OLD.LOCKED_ID;
        :NEW.GROUP_STEP_DEFINITION_ID       :=  :OLD.GROUP_STEP_DEFINITION_ID;
        :NEW.GROUP_ID                       :=  :OLD.GROUP_ID;
        :NEW.TEAM_ID                        :=  :OLD.TEAM_ID;
        :NEW.PROCESS_ID                     :=  :OLD.PROCESS_ID;
        :NEW.PRIORITY_CD                    :=  :OLD.PRIORITY_CD;
        :NEW.PROCESS_ROUTER_ID              :=  :OLD.PROCESS_ROUTER_ID;
        :NEW.PROCESS_INSTANCE_ID            :=  :OLD.PROCESS_INSTANCE_ID;
        :NEW.CASE_ID                        :=  :OLD.CASE_ID;
        :NEW.CLIENT_ID                      :=  :OLD.CLIENT_ID;
        :NEW.REF_ID                         :=  :OLD.REF_ID;
        :NEW.REF_TYPE                       :=  :OLD.REF_TYPE;
        :NEW.STEP_DEFINITION_ID             :=  :OLD.STEP_DEFINITION_ID;
        :NEW.CREATED_BY                     :=  :OLD.CREATED_BY;
        :NEW.SUSPENDED_TS                   :=  :OLD.SUSPENDED_TS;
        :NEW.COMMENTS                       :=  :OLD.COMMENTS;
        :NEW.CREATE_NDT                     :=  :OLD.CREATE_NDT;
        :NEW.STEP_DUE_NDT                   :=  :OLD.STEP_DUE_NDT;

        l_rec_change    :=  0;

    ELSE

        IF       INSERTING
                OR  (
                            UPDATING
                        AND (
                                    NVL(:OLD.STATUS, '?')       !=      NVL(:NEW.STATUS, '?')
                                OR  NVL(:OLD.OWNER, '?')        !=      NVL(:NEW.OWNER, '?')
                                OR  NVL(:OLD.ESCALATED_IND, -1) !=     NVL(:NEW.ESCALATED_IND, -1)
                                OR  NVL(:OLD.ESCALATE_TO, '?')  !=     NVL(:NEW.ESCALATE_TO, '?')
                                OR  NVL(:OLD.FORWARDED_IND, -1) !=      NVL(:NEW.FORWARDED_IND, -1)
                                OR  NVL(:OLD.FORWARDED_BY, '?') !=      NVL(:NEW.FORWARDED_BY, '?')
                                OR  NVL(:OLD.GROUP_ID, -1)      !=      NVL(:NEW.GROUP_ID, -1)
                                OR  NVL(:OLD.TEAM_ID, -1)       !=      NVL(:NEW.TEAM_ID, -1)
                            )
                    )
        THEN
            l_rec_change    :=  1;
        END IF;

    END IF;

    IF  l_rec_change    =   1
    THEN

        :NEW.OWNER  :=  
        
        CAHCO_ETL_MW_PKG.evaluate_ownership_change
        (
            p_CURR_OWNER                        =>  :OLD.OWNER,
            p_NEW_OWNER                         =>  :NEW.OWNER
        );

        IF       NVL(:OLD.OWNER, '?')           !=  NVL(:NEW.OWNER, '?')
            AND NVL(:OLD.OWNER, '?')            !=  '?'
            AND NVL(:NEW.OWNER, '?')            !=  '?'
        THEN
            :NEW.FORWARDED_IND  :=  1;
            :NEW.FORWARDED_BY    :=  :OLD.OWNER;
        END IF;

        IF      NVL(:NEW.STATUS, '?')       =      CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed
            AND NVL(:OLD.STATUS, '?')       !=     CAHCO_ETL_MW_UTIL_PKG.get_mw_status_completed
        THEN

            :NEW.COMPLETED_TS := :NEW.STATUS_TS;

        ELSE

            IF  NVL(:NEW.COMMENTS, '?') =   CAHCO_ETL_MW_UTIL_PKG.claimed_on_ownership_change
            THEN

                IF       NVL(:OLD.OWNER, '?')            !=  NVL(:NEW.OWNER, '?')
                    AND NVL(:NEW.OWNER, '?')            !=  '?'
                THEN

                    :NEW.STATUS :=  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed;
                    :NEW.CLAIMED_TS := :NEW.STATUS_TS;

                END IF;

            ELSIF       NVL(:NEW.STATUS, '?') =   CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed
                    AND NVL(:OLD.STATUS, '?') !=  CAHCO_ETL_MW_UTIL_PKG.get_mw_status_claimed
            THEN

                :NEW.CLAIMED_TS := :NEW.STATUS_TS;

            END IF;

        END IF;

        INSERT
          INTO  STEP_INSTANCE_HISTORY       (   STEP_INSTANCE_HISTORY_ID,               STEP_INSTANCE_ID,       STATUS,         OWNER,          ESCALATED_IND,          ESCALATE_TO,            FORWARDED_IND,          FORWARDED_BY,       GROUP_ID,       TEAM_ID,        CREATE_TS,          CREATED_BY                          )
        VALUES                              (   SEQ_STEP_INSTANCE_HISTORY_ID.NEXTVAL,   :NEW.STEP_INSTANCE_ID,  :NEW.STATUS,    :NEW.OWNER,     :NEW.ESCALATED_IND,     :NEW.ESCALATE_TO,       :NEW.FORWARDED_IND,     :NEW.FORWARDED_BY,  :NEW.GROUP_ID,  :NEW.TEAM_ID,   :NEW.STATUS_TS,     NVL(:NEW.OWNER, :NEW.CREATED_BY)    );

    END IF;

    -- If updating the current record, then rollback to the original CREATE_TS and CREATE_BY.

    IF  UPDATING
    THEN
        :NEW.CREATE_TS  :=  :OLD.CREATE_TS;
        :NEW.CREATED_BY  :=  :OLD.CREATED_BY;
    END IF;

    :NEW.COMMENTS   :=  NULL;

END;
/

