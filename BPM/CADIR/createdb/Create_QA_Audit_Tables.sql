CREATE TABLE D_QA_CHECKSHEETS
  (
    Checksheet_ID NUMBER NOT NULL,
    Title VARCHAR2(100),
    Description VARCHAR2(100),
    Collect_Outcomes NUMBER,
    Checksheet_Group_ID NUMBER,
    Active NUMBER,
    Report NUMBER,
    Header_ID NUMBER,
    Reporting_Title VARCHAR2(100),
    Reporting_Footer VARCHAR2(100),
    MQMPR_Report NUMBER,
    Sharepoint NUMBER,
    Program NUMBER,
    NoDupCase_ID VARCHAR2(1)
)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

alter table D_QA_CHECKSHEETS
  add primary key (Checksheet_ID)
  using index 
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );



CREATE TABLE D_QA_CATEGORIES
 (
	Category_ID NUMBER NOT NULL,
	Description VARCHAR2(100),
	Severity NUMBER,
	Active NUMBER
)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
  
alter table D_QA_CATEGORIES
  add primary key (Category_ID)
  using index 
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );  

  
CREATE TABLE D_QA_SUBCATEGORIES 
(
	SubCategory_ID NUMBER NOT NULL,
	Description VARCHAR2(100),
	Active NUMBER
)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

alter table D_QA_SUBCATEGORIES
  add primary key (SubCategory_ID)
  using index 
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  ); 


CREATE TABLE D_QA_OUTCOMES
(
	Outcome_ID NUMBER,
	Description VARCHAR2(100),
	Active NUMBER
)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
  
CREATE TABLE D_QA_ERROR_REASONS
(
	Error_Reason_ID NUMBER,
	Error_Reason_Text VARCHAR2(100),
	Active NUMBER
)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

alter table D_QA_ERROR_REASONS
  add primary key (Error_Reason_ID)
  using index 
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  ); 


CREATE TABLE D_QA_CHECKSHEET_GROUPS
(
	Checksheet_Group_ID NUMBER,
	Description VARCHAR2(100),
	Active NUMBER
)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

alter table D_QA_CHECKSHEET_GROUPS
  add primary key (Checksheet_Group_ID)
  using index 
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  ); 


CREATE TABLE D_QA_QUESTIONS
(
	Question_ID NUMBER,
	Category_ID NUMBER,
	Historical_ID VARCHAR2(50),
	Question_Code VARCHAR2(50),
	Question_Text VARCHAR2(1000),
	Question_Alert NUMBER,
	SubCategory_ID NUMBER,
	Error_Reason_Options_ID NUMBER,
	Active NUMBER
)  
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

alter table D_QA_QUESTIONS
  add primary key (Question_ID)
  using index 
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  ); 


CREATE TABLE D_QA_STAFF
(
	Employee_ID NUMBER,
	Maximus_Emp_ID VARCHAR2(10),
	First_Name VARCHAR2(50),
	Middle_Initial VARCHAR2(50),
	Last_Name VARCHAR2(50),
	AD_Intranet_Group VARCHAR2(50),
	Active NUMBER,
	Maximus_user_ID VARCHAR2(50),
	Display_Name VARCHAR2(250),
	Test_User NUMBER
)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

alter table D_QA_STAFF
  add primary key (Employee_ID)
  using index 
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );


CREATE TABLE D_QA_STAFF_ROLES
(
	Employee_Role_ID NUMBER,
	Role_Description VARCHAR2(100),
	Rank NUMBER,
	Sharepoint_Group VARCHAR2(50),
	AD_Group VARCHAR2(50),
	Active NUMBER
)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

alter table D_QA_STAFF_ROLES
  add primary key (Employee_Role_ID)
  using index 
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );


CREATE TABLE S_QA_STAFF_ORGANIZATION
(
	Employee_ID NUMBER,
	Start_Date DATE,
	Employee_Role_ID NUMBER,
	Reports_To NUMBER,
	Team_Lead_Emp_ID NUMBER,
	Supervisor_Emp_ID NUMBER,
	Manager_Emp_ID NUMBER,
	SrManager_Emp_ID NUMBER,
	Director_Emp_ID NUMBER,
	End_Date DATE
)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );


CREATE TABLE S_QA_AUDIT_RESULTS
(
	QC_Results_ID NUMBER,
	Ops_Specialist_Emp_ID NUMBER,
	QC_Specialist_Emp_ID NUMBER,
	Start_Time DATE,
	End_Time DATE,
	Session_ID VARCHAR2(100),
	Checksheet_ID NUMBER,
	Case_Number VARCHAR2(50),
	Outcome_ID NUMBER,
	Checksheet_Receipt_Date DATE,
	Task_Process_Date DATE,
	Checksheet_Last_Edit_Date DATE,
	Void NUMBER,
	Void_Reason NUMBER,
	Batch_Type NUMBER,
	Batch_Number VARCHAR2(10),
	Transaction_Number VARCHAR2(100),
	RATask_Type NUMBER,
	Transaction_Type NUMBER,
	Plan_Code NUMBER,
	CIN VARCHAR2(50)
)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

alter table S_QA_AUDIT_RESULTS
  add primary key (QC_Results_ID)
  using index 
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

CREATE TABLE S_QA_AUDIT_RESULT_DETAILS
(
	QC_Results_Details_ID NUMBER,
	QC_Results_ID NUMBER,
	Question_ID NUMBER,
	Error_Score NUMBER,
	Error_comment VARCHAR2(2000),
	Sequence NUMBER,
	Error_Reason_ID NUMBER,
	Escalate NUMBER,
	Resolved NUMBER
)
tablespace MAXDAT_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

alter table S_QA_AUDIT_RESULT_DETAILS
  add primary key (QC_Results_Details_ID)
  using index 
  tablespace MAXDAT_INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('QA_AUDIT_ETL_LAST_RUN_DATE','D',20140101,'Last date the QA Audit Job ran.',sysdate,sysdate);

commit;
