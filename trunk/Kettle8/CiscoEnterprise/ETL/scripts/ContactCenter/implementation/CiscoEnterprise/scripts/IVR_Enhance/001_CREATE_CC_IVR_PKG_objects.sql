alter session set plsql_code_type = native;

CREATE OR REPLACE PACKAGE CISCO_ENTERPRISE_CC.IVR_CALC_PKG AS
--PROCEDURE IVR_CALC_CLASSIFICATION(P_RUNTYPE IN VARCHAR2);
--PROCEDURE IVR_CALC_CLASSIFICATION(P_RUNTYPE IN VARCHAR2, P_IVR_SOURCE IN VARCHAR2 DEFAULT 'ALL');
PROCEDURE IVR_CALC_CLASSIFICATION(P_RUNTYPE IN VARCHAR2
          , P_IVR_SOURCE IN VARCHAR2 DEFAULT 'ALL'
          , P_PROJECT_NAME IN VARCHAR2 DEFAULT 'ALL'
          , P_PROGRAM_NAME IN VARCHAR2 DEFAULT 'ALL'
          , P_APP_NAME IN VARCHAR2 DEFAULT 'ALL'
          , P_INST_ID_FROM IN NUMBER DEFAULT 0
          , P_INST_ID_TO IN NUMBER DEFAULT 0);
END ;
/

CREATE OR REPLACE PACKAGE BODY IVR_CALC_PKG AS

/*PROCEDURE IVR_CALC_CLASSIFICATION(P_RUNTYPE IN VARCHAR2) IS
  BEGIN
    IVR_CALC_CLASSIFICATION(P_RUNTYPE,NULL, 0,0, NULL,0,0);
  END;

 
PROCEDURE IVR_CALC_CLASSIFICATION(P_RUNTYPE IN VARCHAR2, P_IVR_SOURCE IN VARCHAR2, P_PROJECT_NAME IN NUMBER, P_PROGRAM_NAME IN NUMBER, P_APP_NAME IN VARCHAR2, P_INST_ID_FROM IN NUMBER, P_INST_ID_TO IN NUMBER) IS
V_PROJECT_ID NUMBER;
V_PROGRAM_ID NUMBER;
  BEGIN
    BEGIN
      SELECT PROJECT_ID INTO V_PROJECT_ID FROM CC_D_PROJECT WHERE PROJECT_NAME = P_PROJECT_NAME;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      NULL;
    END;
    BEGIN
      SELECT PROGRAM_ID INTO V_PROGRAM_ID FROM CC_D_PROGRAM WHERE PROGRAM_NAME = P_PROGRAM_NAME;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      NULL;
    END;
    
    IVR_CALC_CLASSIFICATION(P_RUNTYPE, P_IVR_SOURCE, V_PROJECT_ID,V_PROGRAM_ID,NULL,P_INST_ID_FROM, P_INST_ID_TO);
  END;
*/

PROCEDURE IVR_CALC_CLASSIFICATION(P_RUNTYPE IN VARCHAR2
          , P_IVR_SOURCE IN VARCHAR2 DEFAULT 'ALL'
          , P_PROJECT_NAME IN VARCHAR2 DEFAULT 'ALL'
          , P_PROGRAM_NAME IN VARCHAR2 DEFAULT 'ALL'
          , P_APP_NAME IN VARCHAR2 DEFAULT 'ALL'
          , P_INST_ID_FROM IN NUMBER DEFAULT 0
          , P_INST_ID_TO IN NUMBER DEFAULT 0) IS
V_CLASS_RUN_ID    NUMBER;
V_SQL             CLOB;
V_ERR             VARCHAR2(3900);
V_SQL_ADD         VARCHAR2(2000);
V_SQL_ADD_DEFAULT         VARCHAR2(30) := ' AND 1=1';
V_PROJECT_ID NUMBER;
V_PROGRAM_ID NUMBER;
V_RECALC_ALL_ENABLED VARCHAR2(10) := 'N';
BEGIN

   BEGIN
      select UPPER(OUT_VAR) 
      INTO V_RECALC_ALL_ENABLED
      from CC_A_LIST_LKUP 
      where name = 'IVR_ENHANCE_RECALC_ALL_METRICS'
      and list_type = 'IVR_ENHANCE_RECALC'
      and value = 'ENABLED'
      AND SYSDATE BETWEEN START_DATE AND END_DATE;
   EXCEPTION WHEN NO_DATA_FOUND THEN
     NULL;
     WHEN TOO_MANY_ROWS THEN
       NULL;
   END;
   
   IF V_RECALC_ALL_ENABLED NOT IN ('Y','YES') AND P_RUNTYPE IN ('ALL','NEW') THEN
           V_ERR := 'RECALC ALL DISABLED; CANNOT RECALC ALL' ;
           insert into cc_l_error ( MESSAGE , ERROR_DATE, JOB_NAME , TRANSFORM_NAME)
           values (V_ERR, SYSDATE, 'IVR_CALC_PKG', 'CALC_CLASSIFICATION Insert');
           COMMIT;
           RETURN;
   END IF;  
     
IF P_RUNTYPE <> 'NEW' THEN
    IF P_PROJECT_NAME = 'ALL' THEN
       V_PROJECT_ID := 0;
    ELSE
      BEGIN
        SELECT PROJECT_ID INTO V_PROJECT_ID FROM CC_D_PROJECT WHERE PROJECT_NAME = P_PROJECT_NAME;
      EXCEPTION WHEN NO_DATA_FOUND THEN
        NULL;
      END;
    END IF;

    IF P_PROGRAM_NAME = 'ALL' THEN
       V_PROGRAM_ID := 0;
    ELSE
      BEGIN
        SELECT PROGRAM_ID INTO V_PROGRAM_ID FROM CC_D_PROGRAM WHERE PROGRAM_NAME = P_PROGRAM_NAME;
      EXCEPTION WHEN NO_DATA_FOUND THEN
        NULL;
      END;
    END IF;  
END IF;

 IF P_RUNTYPE = 'NEW' THEN
        BEGIN
              EXECUTE IMMEDIATE 'TRUNCATE TABLE CC_S_IVR_PERFORMANCE_INSTANCE_EXT';
        exception
        when others then
             V_ERR := 'TRUNCATE;' || SQLCODE || ';' || SUBSTR(SQLERRM,1,100);
             insert into cc_l_error ( MESSAGE , ERROR_DATE, JOB_NAME , TRANSFORM_NAME)
             values (V_ERR, SYSDATE, 'IVR_CALC_PKG', 'CALC_CLASSIFICATION');
        END;
 END IF;
        
 SELECT SEQ_CLASS_RUN_ID.NEXTVAL INTO V_CLASS_RUN_ID FROM DUAL;

 FOR CLS_CUR IN (SELECT * FROM CC_C_IVR_CTRLS CIC
   WHERE CTRL_TYPE IN ( 'CLASSIFICATION', 'CLASSIFICATION_ID')
   AND EFFECTIVE_dT <= SYSDATE
   AND END_DT >= SYSDATE)
   LOOP
     IF P_RUNTYPE IN ( 'ALL', 'NEW') THEN
     V_SQL := CLS_CUR.INS_CLASS_RUN_STMT;
     ELSIF P_RUNTYPE = 'MISSING' THEN
       V_SQL := CLS_CUR.INS_CLASS_RUN_MISSING_STMT;
     ELSIF P_RUNTYPE = 'RANGE' THEN
       V_SQL := CLS_CUR.INS_CLASS_RUN_RANGE_STMT;
     ELSE
       V_SQL := 'SELECT :1 FROM DUAL';
     END IF;

     IF P_RUNTYPE <> 'NEW' THEN
       V_SQL_ADD := V_SQL_ADD_DEFAULT;
       IF V_PROJECT_ID IS NOT NULL AND V_PROJECT_ID >0 THEN
         V_SQL_ADD := V_SQL_ADD || CHR(10) || ' AND IVRPI.D_PROJECT_ID = ' || TO_CHAR(V_PROJECT_ID);
       END IF;
       IF V_PROGRAM_ID IS NOT NULL AND V_PROGRAM_ID >0 THEN
         V_SQL_ADD := V_SQL_ADD || CHR(10) || ' AND IVRPI.D_PROGRAM_ID = ' || TO_CHAR(V_PROGRAM_ID);
       END IF;
       IF P_APP_NAME IS NOT NULL AND P_APP_NAME <> 'ALL' THEN
         V_SQL_ADD := V_SQL_ADD || CHR(10) || ' AND IVRPI.IVR_APPLICATION_NAME = ''' || TRIM(P_APP_NAME) || '''';
       END IF;
       IF P_IVR_SOURCE IS NOT NULL AND P_IVR_SOURCE <> 'ALL' THEN
         V_SQL_ADD := V_SQL_ADD || CHR(10) || ' AND CIC.IVR_SOURCE = ''' || TRIM(P_IVR_SOURCE) || '''';
       END IF;
         IF V_SQL_ADD <> V_SQL_ADD_DEFAULT THEN
            V_SQL_ADD := REPLACE(V_SQL_ADD,V_SQL_ADD_DEFAULT);
            V_SQL := REPLACE(V_SQL, V_SQL_ADD_DEFAULT, V_SQL_ADD);
            DBMS_OUTPUT.PUT_LINE(V_SQL);           
         END IF;  
     END IF;

     IF P_RUNTYPE = 'RANGE' THEN
        BEGIN
                EXECUTE IMMEDIATE V_SQL USING V_CLASS_RUN_ID, P_INST_ID_FROM, P_INST_ID_TO;
        exception
        when others then
             V_ERR := 'RUN:' || v_class_run_id || ';RULE: ' || CLS_CUR.IVR_CTRL_ID || SQLCODE || ';' || SUBSTR(SQLERRM,1,100);
             insert into cc_l_error ( MESSAGE , ERROR_DATE, JOB_NAME , TRANSFORM_NAME)
             values (V_ERR, SYSDATE, 'IVR_CALC_PKG', 'CALC_CLASSIFICATION');
        END;
     ELSE
        BEGIN
               EXECUTE IMMEDIATE V_SQL USING V_CLASS_RUN_ID;
        exception
        when others then
             V_ERR := 'RUN:' || v_class_run_id || ';RULE: ' || CLS_CUR.IVR_CTRL_ID || SQLCODE || ';' || SUBSTR(SQLERRM,1,100);
             insert into cc_l_error ( MESSAGE , ERROR_DATE, JOB_NAME , TRANSFORM_NAME)
             values (V_ERR, SYSDATE, 'IVR_CALC_PKG', 'CALC_CLASSIFICATION');
        END;
     END IF;
   END LOOP;
COMMIT;

--dbms_output.put_line(v_class_run_id);

begin
for inst_cur in (        
        select f_ivr_performance_instance_id
        , max(case when ctrl_name = 'INBOUND_DNIS_TYPE' then ctrl_value else null end) INBOUND_DNIS_TYPE
        , max(case when ctrl_name = 'UNIT_OF_WORK' then ctrl_value else null end) UNIT_OF_WORK
        , max(case when ctrl_name = 'D_UNIT_OF_WORK_ID' then ctrl_value else null end) D_UNIT_OF_WORK_ID
        , max(case when ctrl_name = 'AGENT_ROUTING_GROUP_ID' then ctrl_value else null end) AGENT_ROUTING_GROUP_ID
        , max(case when ctrl_name = 'D_CONTACT_QUEUE_ID' then ctrl_value else null end) D_CONTACT_QUEUE_ID
        , nvl(max(case when ctrl_name = 'CALL_CONTAINED_IN_IVR' then to_number(nvl(ctrl_value,0)) else null end),0) CALL_CONTAINED_IN_IVR
        , nvl(max(case when ctrl_name = 'CALL_ROUTED_TO_AGENT' then to_number(nvl(ctrl_value,0)) else null end),0) CALL_ROUTED_TO_AGENT
        , nvl(max(case when ctrl_name = 'CALL_RECEIVED_AFTER_HOURS' then to_number(nvl(ctrl_value,0)) else null end),0) CALL_RECEIVED_AFTER_HOURS
        , max(case when ctrl_name = 'IVR_EXIT_RESULT' then ctrl_value else null end) IVR_EXIT_RESULT
        , max(case when ctrl_name = 'IVR_EXIT_RESULT_DETAIL' then ctrl_value else null end) IVR_EXIT_RESULT_DETAIL
               from (select * from 
              (SELECT SC.*, ROW_NUMBER() OVER (PARTITION BY f_ivr_performance_instance_id, ctrl_name ORDER BY IVR_CTRL_ID ASC) ROWN
              FROM CC_S_TMP_CLASS_RUN SC
              where class_run_id = V_CLASS_RUN_ID
              ) where rown = 1) ctr 
        group by f_ivr_performance_instance_id
) 
loop
  begin
        insert into CC_S_IVR_PERFORMANCE_INSTANCE_EXT (
         F_IVR_PERFORMANCE_INSTANCE_ID 
        , inbound_dnis_type          
        , unit_of_work    
        , D_UNIT_OF_WORK_ID           
        , AGENT_ROUTING_GROUP_ID           
        , D_CONTACT_QUEUE_ID           
        , ivr_exit_result          
        , IVR_EXIT_RESULT_DETAIL    
        , CALL_CONTAINED_IN_IVR   
        , CALL_ROUTED_TO_AGENT      
        , CALL_RECEIVED_AFTER_HOURS 
        , CLASS_RUN_ID   
        )
        values (
         inst_cur.F_IVR_PERFORMANCE_INSTANCE_ID 
        , inst_cur.inbound_dnis_type          
        , inst_cur.unit_of_work  
        , NVL(INST_CUR.D_UNIT_OF_WORK_ID,0)             
        , NVL(INST_CUR.AGENT_ROUTING_GROUP_ID,0)           
        , NVL(INST_CUR.D_CONTACT_QUEUE_ID,0)           
        , inst_cur.ivr_exit_result          
        , inst_cur.IVR_EXIT_RESULT_DETAIL    
        , inst_cur.CALL_CONTAINED_IN_IVR   
        , inst_cur.CALL_ROUTED_TO_AGENT      
        , inst_cur.CALL_RECEIVED_AFTER_HOURS
        , V_CLASS_RUN_ID    
        );
  
  NULL;
       exception
      when others then
           V_ERR := 'RUN:' || v_class_run_id || ';'|| inst_cur.F_IVR_PERFORMANCE_INSTANCE_ID||';'|| inst_cur.unit_of_work|| ' ' || SQLCODE || ';' || SUBSTR(SQLERRM,1,100);
           insert into cc_l_error ( MESSAGE , ERROR_DATE, JOB_NAME , TRANSFORM_NAME)
           values (V_ERR, SYSDATE, 'IVR_CALC_PKG', 'CALC_CLASSIFICATION Insert');
  end;               

end loop;
--dbms_output.put_line('After insert');
commit;        
      exception
      when others then
           V_ERR := 'RUN:' || v_class_run_id || ' ' || SQLCODE || ';' || SUBSTR(SQLERRM,1,100);
           insert into cc_l_error ( MESSAGE , ERROR_DATE, JOB_NAME , TRANSFORM_NAME)
           values (V_ERR, SYSDATE, 'IVR_CALC_PKG', 'CALC_CLASSIFICATION Insert');
end;             


END;

END;
/


alter session set plsql_code_type = interpreted;
