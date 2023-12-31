
CREATE OR REPLACE TRIGGER BIU_CC_C_IVR_CTRLS
    BEFORE INSERT OR UPDATE ON CC_C_IVR_CTRLS 
    FOR EACH ROW 
BEGIN
IF INSERTING AND :NEW.IVR_CTRL_ID IS NULL THEN 
          SELECT SEQ_IVR_CTRL_ID.NEXTVAL INTO :NEW.IVR_CTRL_ID FROM DUAL;
END IF;
IF INSERTING THEN 
          :NEW.CREATE_DT := SYSDATE;
          :NEW.CREATED_BY := USER;
          if :new.effective_dt is null then
             :NEW.EFFECTIVE_DT := trunc(sysdate);
          end if;
          if :new.end_dt is null then   
                    :NEW.END_DT := to_date('7/7/7777','mm/dd/yyyy');
          end if;          
END IF;
--- SND 6/1/2020 - REVERSE POPULATION USING PROJECT_NAME AND PROGRAM_NAME TO POPULATE PROJECT_ID AND PROGRAM_ID WILL BE DONE LATER
IF (INSERTING OR (UPDATING AND :NEW.D_PROJECT_ID <> :OLD.D_PROJECT_ID)) AND :NEW.D_PROJECT_ID IS NOT NULL THEN
  DECLARE
   V_PROJECT_NAME VARCHAR2(55);
   BEGIN
    SELECT PROJECT_NAME INTO V_PROJECT_NAME FROM CC_D_PROJECT PROJ WHERE PROJ.PROJECT_ID = :NEW.D_PROJECT_ID;
    :NEW.IVR_PROJECT_NAME := V_PROJECT_NAME;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      NULL;
      WHEN TOO_MANY_ROWS THEN
        NULL;
    END;
END IF;
IF INSERTING OR (UPDATING AND :NEW.D_PROGRAM_ID <> :OLD.D_PROGRAM_ID) AND :NEW.D_PROGRAM_ID IS NOT NULL THEN
  DECLARE
   V_PROGRAM_NAME VARCHAR2(55);
   BEGIN
    SELECT PROGRAM_NAME INTO V_PROGRAM_NAME FROM CC_D_PROGRAM PROJ WHERE PROJ.PROGRAM_ID = :NEW.D_PROGRAM_ID;
    :NEW.IVR_PROGRAM_NAME := V_PROGRAM_NAME;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      NULL;
      WHEN TOO_MANY_ROWS THEN
        NULL;
    END;
END IF;
IF (INSERTING OR UPDATING) AND :NEW.CTRL_TYPE in ('CLASSIFICATION', 'CLASSIFICATION_ID') THEN
  DECLARE
  V_SQL CLOB;
  V_SQL_MISSING VARCHAR2(3000);
  V_SQL_RANGE VARCHAR2(3000);
  V_FK_VALUE VARCHAR2(200);
  BEGIN

  v_sql := ' INSERT INTO CC_S_TMP_CLASS_RUN (CLASS_RUN_ID, F_IVR_PERFORMANCE_INSTANCE_ID, IVR_CTRL_ID, CTRL_NAME, CTRL_VALUE, CREATE_DT, CREATED_BY)';

  IF :NEW.CTRL_TYPE = 'CLASSIFICATION_ID' AND :NEW.CTRL_NAME = 'D_UNIT_OF_WORK_ID' THEN
     V_SQL := V_SQL || CHR(10) || ' (SELECT :1, IVRPI.F_IVR_PERFORMANCE_INSTANCE_ID, CIC.IVR_CTRL_ID, CIC.CTRL_NAME, NVL(UOW.UOW_ID,0) , SYSDATE, USER';
  ELSIF :NEW.CTRL_TYPE = 'CLASSIFICATION_ID' AND :NEW.CTRL_NAME = 'AGENT_ROUTING_GROUP_ID' THEN
     V_SQL := V_SQL || CHR(10) || ' (SELECT :1, IVRPI.F_IVR_PERFORMANCE_INSTANCE_ID, CIC.IVR_CTRL_ID, CIC.CTRL_NAME, NVL(ARG.C_AGENT_ROUTING_GROUP_ID,0) , SYSDATE, USER';
  ELSIF :NEW.CTRL_TYPE = 'CLASSIFICATION_ID' AND :NEW.CTRL_NAME = 'D_CONTACT_QUEUE_ID' THEN
     V_SQL := V_SQL || CHR(10) || ' (SELECT :1, IVRPI.F_IVR_PERFORMANCE_INSTANCE_ID, CIC.IVR_CTRL_ID, CIC.CTRL_NAME, NVL(CQ.D_CONTACT_QUEUE_ID,0) , SYSDATE, USER';
  ELSE
     V_SQL := V_SQL || CHR(10) || ' (SELECT :1, IVRPI.F_IVR_PERFORMANCE_INSTANCE_ID, CIC.IVR_CTRL_ID, CIC.CTRL_NAME, NVL(CIC.CTRL_VALUE,0) , SYSDATE, USER';
  END IF;
  V_SQL := V_SQL || CHR(10) || ' from ' || dbms_assert.qualified_sql_name('cisco_enterprise_cc.cc_f_ivr_performance_instance') || ' ivrpi';
  V_SQL := V_SQL || CHR(10) || ' join ' || dbms_assert.qualified_sql_name('cisco_enterprise_cc.CC_C_IVR_CTRLS') || ' cic ON';
  V_SQL := V_SQL || CHR(10) || ' CIC.CTRL_TYPE = ''' || TRIM(:NEW.CTRL_TYPE) || '''';
  V_SQL := V_SQL || CHR(10) || ' AND CIC.EFFECTIVE_DT <= SYSDATE';
  V_SQL := V_SQL || CHR(10) || ' AND CIC.END_DT >= SYSDATE';
  V_SQL := V_SQL || CHR(10) || ' AND CIC.IVR_CTRL_ID = '|| :NEW.IVR_CTRL_ID;
  V_SQL := V_SQL || CHR(10) || ' AND CIC.D_PROJECT_ID = IVRPI.D_PROJECT_ID';
  V_SQL := V_SQL || CHR(10) || ' AND CIC.D_PROGRAM_ID = IVRPI.D_PROGRAM_ID';
  V_SQL := V_SQL || CHR(10) || ' AND CIC.IVR_SOURCE = IVRPI.IVR_SOURCE';
  V_SQL := V_SQL || CHR(10) || ' AND CIC.IVR_APPNAME = IVRPI.IVR_APPLICATION_NAME';
  
  --- default behaviour is to get the value from ctrl_value
  --- if "COLUMN" prefix is used, use the column mentioned after that
  
  V_FK_VALUE := 'CIC.CTRL_VALUE';
  IF :NEW.CTRL_TYPE = 'CLASSIFICATION_ID' AND SUBSTR(:NEW.CTRL_VALUE,1,7) = 'COLUMN:' THEN
   V_FK_VALUE := 'IVRPI.' || TRIM(SUBSTR(:NEW.CTRL_VALUE, INSTR(:NEW.CTRL_VALUE,'COLUMN:') + 7)) ;
  END IF;

  IF :NEW.CTRL_TYPE = 'CLASSIFICATION_ID' AND :NEW.CTRL_NAME = 'D_UNIT_OF_WORK_ID' THEN
     V_SQL := V_SQL || CHR(10) || ' LEFT JOIN ' || dbms_assert.qualified_sql_name('cisco_enterprise_cc.CC_D_UNIT_OF_WORK') || ' UOW ON UOW.UNIT_OF_WORK_NAME = ' || V_FK_VALUE || ' AND IVR = 1 AND UOW.PRODUCTION_PLAN_ID = 1';
  ELSIF :NEW.CTRL_TYPE = 'CLASSIFICATION_ID' AND :NEW.CTRL_NAME = 'AGENT_ROUTING_GROUP_ID' THEN
     V_SQL := V_SQL || CHR(10) || ' LEFT JOIN ' || dbms_assert.qualified_sql_name('cisco_enterprise_cc.CC_C_AGENT_RTG_GRP') || ' ARG ON ARG.AGENT_ROUTING_GROUP_NUMBER = ' || V_FK_VALUE || ' AND ARG.AGENT_ROUTING_GROUP_TYPE = ''Precision Queue''';
     V_SQL := V_SQL || CHR(10) || '      AND ARG.PROJECT_NAME = CIC.IVR_PROJECT_NAME AND ARG.PROGRAM_NAME = CIC.IVR_PROGRAM_NAME ';
     V_SQL := V_SQL || CHR(10) || '      AND ARG.RECORD_EFF_DT <= SYSDATE AND ARG.RECORD_END_DT >= SYSDATE';
  ELSIF :NEW.CTRL_TYPE = 'CLASSIFICATION_ID' AND :NEW.CTRL_NAME = 'D_CONTACT_QUEUE_ID' THEN
     V_SQL := V_SQL || CHR(10) || ' LEFT JOIN ' || dbms_assert.qualified_sql_name('cisco_enterprise_cc.CC_D_CONTACT_QUEUE') || ' CQ ON CQ.QUEUE_NUMBER = ' || V_FK_VALUE;
     V_SQL := V_SQL || CHR(10) || '      AND CQ.RECORD_EFF_DT <= SYSDATE AND CQ.RECORD_END_DT >= SYSDATE';
  END IF;

  V_SQL := V_SQL || CHR(10) || ' WHERE NVL(CIC.IVR_DNIS, IVRPI.INBOUND_DNIS) = IVRPI.INBOUND_DNIS';  
  IF :NEW.FACTOR1_COLUMN IS NOT NULL THEN
    V_SQL := V_SQL || chr(10) || ' AND ' || DBMS_ASSERT.qualified_sql_name('IVRPI.' || :NEW.FACTOR1_COLUMN) || ' ' || :NEW.FACTOR1_EXPR;
  END IF;
  IF :NEW.FACTOR2_COLUMN IS NOT NULL THEN
    V_SQL := V_SQL || chr(10) || ' AND ' || DBMS_ASSERT.qualified_sql_name('IVRPI.' || :NEW.FACTOR2_COLUMN) || ' ' || :NEW.FACTOR2_EXPR;
  END IF;
  IF :NEW.FACTOR3_COLUMN IS NOT NULL THEN
    V_SQL := V_SQL || chr(10) || ' AND ' || DBMS_ASSERT.qualified_sql_name('IVRPI.' || :NEW.FACTOR3_COLUMN) || ' ' || :NEW.FACTOR3_EXPR;
  END IF;
  IF :NEW.FACTOR4_COLUMN IS NOT NULL THEN
    V_SQL := V_SQL || chr(10) || ' AND ' || DBMS_ASSERT.qualified_sql_name('IVRPI.' || :NEW.FACTOR4_COLUMN) || ' ' || :NEW.FACTOR4_EXPR;
  END IF;
  IF :NEW.FACTOR5_COLUMN IS NOT NULL THEN
    V_SQL := V_SQL || chr(10) || ' AND ' || DBMS_ASSERT.qualified_sql_name('IVRPI.' || :NEW.FACTOR5_COLUMN) || ' ' || :NEW.FACTOR5_EXPR;
  END IF;
  IF :NEW.FACTOR6_COLUMN IS NOT NULL THEN
    V_SQL := V_SQL || chr(10) || ' AND ' || DBMS_ASSERT.qualified_sql_name('IVRPI.' || :NEW.FACTOR6_COLUMN) || ' ' || :NEW.FACTOR6_EXPR;
  END IF;
  :NEW.INS_CLASS_RUN_STMT := V_SQL || CHR(10) || ' AND 1=1' || CHR(10) || ') ';

  V_SQL_MISSING := 'AND NOT EXISTS (SELECT ''X'' FROM ' || dbms_assert.qualified_sql_name('cisco_enterprise_cc.CC_S_IVR_PERFORMANCE_INSTANCE_EXT') || ' IVRPIE';
  V_SQL_MISSING := V_SQL_MISSING || CHR(10) || ' WHERE IVRPIE.F_IVR_PERFORMANCE_INSTANCE_ID = IVRPI.F_IVR_PERFORMANCE_INSTANCE_ID)';
  :NEW.INS_CLASS_RUN_MISSING_STMT := V_SQL || CHR(10) || V_SQL_MISSING || CHR(10) || ' AND 1=1' || CHR(10) || ') ';
  
  V_SQL_RANGE := 'AND IVRPI.F_IVR_PERFORMANCE_INSTANCE_ID >= :2 AND IVRPI.F_IVR_PERFORMANCE_INSTANCE_ID <= :3';
  :NEW.INS_CLASS_RUN_RANGE_STMT := V_SQL || CHR(10) || V_SQL_RANGE || CHR(10) || ' AND 1=1' || CHR(10) || ') ';
  
  END;
END IF;
:NEW.UPDATE_DT := SYSDATE;
:NEW.UPDATED_BY := USER;
END; 
/

