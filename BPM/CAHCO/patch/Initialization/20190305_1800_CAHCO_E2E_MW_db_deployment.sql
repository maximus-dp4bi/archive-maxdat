alter table step_instance add
(
    DCN                             VARCHAR2(20),
    DOCUMENT_RECEIVED_DATE          DATE
);

/*********************************************

    MODIFY TABLE HCO_D_EMPLOYEES

**********************************************/
DROP TABLE HCO_D_EMPLOYEES;

CREATE TABLE HCO_D_EMPLOYEES
(
    EMPLOYEE_ID                                                                 NUMBER                                              NOT NULL,
    FIRST_NAME                                                                  VARCHAR2(100)                                       NOT NULL,
    LAST_NAME                                                                   VARCHAR2(100)                                       NOT NULL,
    DEPARTMENT_ID                                                               NUMBER                                              NOT NULL,
    DEPARTMENT_NAME                                                             VARCHAR2(100)                                       NOT NULL,
    WORK_LOCATION                                                               VARCHAR2(100)                                       NOT NULL,
    JOB_TITLE                                                                   VARCHAR2(100),
    SUPV_EMPLOYEE_ID                                                            NUMBER,
    SUPV_FIRST_NAME                                                             VARCHAR2(100),
    SUPV_LAST_NAME                                                              VARCHAR2(100),
    CONSTRAINT HCO_D_EMPLOYEES PRIMARY KEY 
    (
        EMPLOYEE_ID
    )    
)
LOGGING 
TABLESPACE MAXDAT_DATA;

GRANT SELECT ON HCO_D_EMPLOYEES TO MAXDAT_READ_ONLY;
GRANT SELECT, INSERT, UPDATE ON HCO_D_EMPLOYEES TO MAXDAT_OLTP_SIU;
GRANT SELECT, INSERT, UPDATE, DELETE ON HCO_D_EMPLOYEES TO MAXDAT_OLTP_SIUD;