--Drop tables
 declare  c int;
 begin
    select count(*) into c from user_tables where table_name ='HCO_F_PORTAL_ASSIST_BY_DATE';
    if c = 1 then
       execute immediate 'drop table HCO_F_PORTAL_ASSIST_BY_DATE cascade constraints';
    end if;
 end;
 /
 declare  c int;
 begin
    select count(*) into c from user_tables where table_name ='HCO_F_PORTAL_DOWNTIME_BY_DATE';
    if c = 1 then
       execute immediate 'drop table HCO_F_PORTAL_DOWNTIME_BY_DATE cascade constraints';
    end if;
 end;
 /
 declare  c int;
 begin
    select count(*) into c from user_tables where table_name ='HCO_D_PORTAL_PROVIDERS';
    if c = 1 then
       execute immediate 'drop table HCO_D_PORTAL_PROVIDERS cascade constraints';
    end if;
 end;
 /
 declare  c int;
 begin
    select count(*) into c from user_tables where table_name ='HCO_F_PORTAL_DLDS_BY_DATE';
    if c = 1 then
       execute immediate 'drop table HCO_F_PORTAL_DLDS_BY_DATE cascade constraints';
    end if;
 end;
 /
 declare  c int;
 begin
    select count(*) into c from user_tables where table_name ='HCO_F_PORTAL_SEARCHES_BY_DATE';
    if c = 1 then
       execute immediate 'drop table HCO_F_PORTAL_SEARCHES_BY_DATE cascade constraints';
    end if;
 end;
 /
 declare  c int;
 begin
    select count(*) into c from user_tables where table_name ='HCO_F_SYSTEM_TESTS';
    if c = 1 then
       execute immediate 'drop table HCO_F_SYSTEM_TESTS cascade constraints';
    end if;
 end;
 /
 declare  c int;
 begin
    select count(*) into c from user_tables where table_name ='HCO_D_DEPARTMENT_TRANS';
    if c = 1 then
       execute immediate 'drop table HCO_D_DEPARTMENT_TRANS cascade constraints';
    end if;
 end;
 /
 declare  c int;
 begin
    select count(*) into c from user_tables where table_name ='HCO_D_DEPARTMENT';
    if c = 1 then
       execute immediate 'drop table HCO_D_DEPARTMENT cascade constraints';
    end if;
 end;
 /
 declare  c int;
 begin
    select count(*) into c from user_tables where table_name ='HCO_F_NETWORK_USAGE';
    if c = 1 then
       execute immediate 'drop table HCO_F_NETWORK_USAGE cascade constraints';
    end if;
 end;
 /
 declare  c int;
 begin
    select count(*) into c from user_tables where table_name ='HCO_F_SYSTEM_AVAILABILITY';
    if c = 1 then
       execute immediate 'drop table HCO_F_SYSTEM_AVAILABILITY cascade constraints';
    end if;
 end;
 /
 declare  c int;
 begin
    select count(*) into c from user_tables where table_name ='HCO_D_SYSTEM';
    if c = 1 then
       execute immediate 'drop table HCO_D_SYSTEM cascade constraints';
    end if;
 end;
 /
 declare  c int;
 begin
    select count(*) into c from user_tables where table_name ='HCO_D_SYSTEM_TYPE';
    if c = 1 then
       execute immediate 'drop table HCO_D_SYSTEM_TYPE cascade constraints';
    end if;
 end;
 /

--Drop views
 declare  c int;
 begin
    select count(*) into c from user_views where view_name ='HCO_D_SYSTEM_TYPE_SV';
    if c = 1 then
       execute immediate 'drop view HCO_D_SYSTEM_TYPE_SV cascade constraints';
    end if;
 end;
 /
 declare  c int;
 begin
    select count(*) into c from user_views where view_name ='HCO_D_SYSTEM_SV';
    if c = 1 then
       execute immediate 'drop view HCO_D_SYSTEM_SV cascade constraints';
    end if;
 end;
 /
 declare  c int;
 begin
    select count(*) into c from user_views where view_name ='HCO_F_SYSTEM_AVAILABILITY_SV';
    if c = 1 then
       execute immediate 'drop view HCO_F_SYSTEM_AVAILABILITY_SV cascade constraints';
    end if;
 end;
 /
 declare  c int;
 begin
    select count(*) into c from user_views where view_name ='HCO_F_NETWORK_USAGE_SV';
    if c = 1 then
       execute immediate 'drop view HCO_F_NETWORK_USAGE_SV cascade constraints';
    end if;
 end;
 /
 declare  c int;
 begin
    select count(*) into c from user_views where view_name ='HCO_D_DEPARTMENT_SV';
    if c = 1 then
       execute immediate 'drop view HCO_D_DEPARTMENT_SV cascade constraints';
    end if;
 end;
 /
 declare  c int;
 begin
    select count(*) into c from user_views where view_name ='HCO_D_DEPARTMENT_TRANS_SV';
    if c = 1 then
       execute immediate 'drop view HCO_D_DEPARTMENT_TRANS_SV cascade constraints';
    end if;
 end;
 /
 declare  c int;
 begin
    select count(*) into c from user_views where view_name ='HCO_F_SYSTEM_TESTS_SV';
    if c = 1 then
       execute immediate 'drop view HCO_F_SYSTEM_TESTS_SV cascade constraints';
    end if;
 end;
 /
 declare  c int;
 begin
    select count(*) into c from user_views where view_name ='HCO_F_PORTAL_SEARCHES_BY_DATE_SV';
    if c = 1 then
       execute immediate 'drop view HCO_F_PORTAL_SEARCHES_BY_DATE_SV cascade constraints';
    end if;
 end;
 /
 declare  c int;
 begin
    select count(*) into c from user_views where view_name ='HCO_F_PORTAL_DLDS_BY_DATE_SV';
    if c = 1 then
       execute immediate 'drop view HCO_F_PORTAL_DLDS_BY_DATE_SV cascade constraints';
    end if;
 end;
 /
 declare  c int;
 begin
    select count(*) into c from user_views where view_name ='HCO_D_PORTAL_PROVIDERS_SV';
    if c = 1 then
       execute immediate 'drop view HCO_D_PORTAL_PROVIDERS_SV cascade constraints';
    end if;
 end;
 /
 declare  c int;
 begin
    select count(*) into c from user_views where view_name ='HCO_F_PORTAL_DOWNTIME_BY_DATE_SV';
    if c = 1 then
       execute immediate 'drop view HCO_F_PORTAL_DOWNTIME_BY_DATE_SV cascade constraints';
    end if;
 end;
 /

-- COMMENTED TABLES AND VIEWS HAVE BEEN PREVIOUSLY DEVELOPED BY MarquesBQuiller@maximus.com
/* create table HCO_D_SYSTEM_TYPE 
    (
      SYSTEM_TYPE_ID                NUMBER(18)
    , SYSTEM_TYPE_NAME              VARCHAR2(40)
    , CREATE_BY                     VARCHAR2(50)
    , CREATE_DATE                   DATE
    , LAST_UPDATE_BY                VARCHAR2(50)
    , LAST_UPDATE_DATE              DATE
    )
    TABLESPACE MAXDAT_DATA
    STORAGE (BUFFER_POOL DEFAULT);
    
    alter table HCO_D_SYSTEM_TYPE add constraint PK_HCO_D_SYSTEM_TYPE PRIMARY KEY (SYSTEM_TYPE_ID);

    GRANT SELECT ON MAXDAT.HCO_D_SYSTEM_TYPE TO MAXDAT_READ_ONLY;
    

create table HCO_D_SYSTEM 
    (
      SYSTEM_ID                     NUMBER(18)
    , SYSTEM_TYPE_ID                NUMBER(18)
    , SYSTEM_NAME                   VARCHAR2(40)
    , CREATE_BY                     VARCHAR2(50)
    , CREATE_DATE                   DATE
    , LAST_UPDATE_BY                VARCHAR2(50)
    , LAST_UPDATE_DATE              DATE
    )
    TABLESPACE MAXDAT_DATA
    STORAGE (BUFFER_POOL DEFAULT);
    
    alter table HCO_D_SYSTEM add constraint PK_HCO_D_SYSTEM PRIMARY KEY (SYSTEM_ID);

    GRANT SELECT ON MAXDAT.HCO_D_SYSTEM TO MAXDAT_READ_ONLY;
    
 */        
/* CREATE TABLE HCO_F_SYSTEM_AVAILABILITY
    (
      D_MONTH                       VARCHAR2(3)
    , SYSTEM_ID                     NUMBER(18)
    , REQUIRED_AVAILABLE_MINS       NUMBER(18)
    , SCHEDULED_DOWNTIME_MINS       NUMBER(18)
    , UPTIME_MINS                   NUMBER(18)
    , AVAILABILITY_MINS             NUMBER(18)
    , MAX_UNSCHEDULED_DOWNTIME_MINS NUMBER(18)
    , UNSCHEDULED_DOWNTIME_MINS     NUMBER(18)
    , SLA_FLAG                      VARCHAR2(1)
    , CREATE_BY                     VARCHAR2(50)
    , CREATE_DATE                   DATE
    , LAST_UPDATE_BY                VARCHAR2(50)
    , LAST_UPDATE_DATE              DATE
    )
    TABLESPACE MAXDAT_DATA
    STORAGE (BUFFER_POOL DEFAULT);

    alter table HCO_F_SYSTEM_AVAILABILITY add constraint PK_HCO_F_SYSTEM_AVAILABILITY PRIMARY KEY (D_MONTH);

    GRANT SELECT ON MAXDAT.HCO_F_SYSTEM_AVAILABILITY TO MAXDAT_READ_ONLY;
    */ 
    
/* CREATE TABLE HCO_F_NETWORK_USAGE
    (
      D_DATE                        DATE
    , HOUR                          NUMBER(9)
    , USAGE                         NUMBER(9)
    , CREATE_BY                     VARCHAR2(50)
    , CREATE_DATE                   DATE
    , LAST_UPDATE_BY                VARCHAR2(50)
    , LAST_UPDATE_DATE              DATE
    )
    TABLESPACE MAXDAT_DATA
    STORAGE (BUFFER_POOL DEFAULT);

    alter table HCO_F_NETWORK_USAGE add constraint PK_HCO_F_NETWORK_USAGE PRIMARY KEY (D_DATE,HOUR);

    GRANT SELECT ON MAXDAT.HCO_F_NETWORK_USAGE TO MAXDAT_READ_ONLY;
    
 */
/* CREATE TABLE HCO_D_DEPARTMENT
    (
      DEPARTMENT_ID                 NUMBER(18)
    , DEPARTMENT_NAME               VARCHAR2(100)
    , CREATE_BY                     VARCHAR2(50)
    , CREATE_DATE                   DATE
    , LAST_UPDATE_BY                VARCHAR2(50)
    , LAST_UPDATE_DATE              DATE
    )
    TABLESPACE MAXDAT_DATA
    STORAGE (BUFFER_POOL DEFAULT);

    alter table HCO_D_DEPARTMENT add constraint PK_HCO_D_DEPARTMENT PRIMARY KEY (DEPARTMENT_ID);

    GRANT SELECT ON MAXDAT.HCO_D_DEPARTMENT TO MAXDAT_READ_ONLY;
 */    

/* CREATE TABLE HCO_D_DEPARTMENT_TRANS
    (
      DEPARTMENT_TRANSACTION_ID     NUMBER(18)
    , DEPARTMENT_ID                 NUMBER(18)
    , TRANSACTION_NUMBER            NUMBER(3)
    , TRANSACTION_DESCRIPTION       VARCHAR2(240)
    , CREATE_BY                     VARCHAR2(50)
    , CREATE_DATE                   DATE
    , LAST_UPDATE_BY                VARCHAR2(50)
    , LAST_UPDATE_DATE              DATE
    )
    TABLESPACE MAXDAT_DATA
    STORAGE (BUFFER_POOL DEFAULT);

    alter table HCO_D_DEPARTMENT_TRANS add constraint PK_HCO_D_DEPARTMENT_TRANS PRIMARY KEY (DEPARTMENT_TRANSACTION_ID);

    GRANT SELECT ON MAXDAT.HCO_D_DEPARTMENT_TRANS TO MAXDAT_READ_ONLY;
    
    
CREATE TABLE HCO_F_SYSTEM_TESTS
    (
      SYSTEM_TEST_ID                NUMBER(18)
    , DEPARTMENT_TRANSACTION_ID     NUMBER(18)
    , DEPARTMENT_ID                 NUMBER(18)
    , D_DATE                        DATE
    , TIME                          NUMBER(18,2)
    , CUBE                          VARCHAR2(100)
    , RESPONSE_TIME                 NUMBER(18,2)
    , CREATE_BY                     VARCHAR2(50)
    , CREATE_DATE                   DATE
    , LAST_UPDATE_BY                VARCHAR2(50)
    , LAST_UPDATE_DATE              DATE
    )
    TABLESPACE MAXDAT_DATA
    STORAGE (BUFFER_POOL DEFAULT);

    alter table HCO_F_SYSTEM_TESTS add constraint PK_HCO_F_SYSTEM_TESTS PRIMARY KEY (SYSTEM_TEST_ID);

    GRANT SELECT ON MAXDAT.HCO_F_SYSTEM_TESTS TO MAXDAT_READ_ONLY;
 */    
    
CREATE TABLE MAXDAT.HCO_F_PORTAL_SEARCHES_BY_DATE
    (
      CREATE_DATE          DATE NOT NULL
    , HITS				   NUMBER (18)
    , PROVIDER_TYPE        VARCHAR2(25)
    , PROVIDER_SPECIALTY   VARCHAR2(100)
    , COUNTY_CODE          VARCHAR2 (2)
    , COUNTY_NAME          VARCHAR2 (70)
    , LANGUAGE             VARCHAR2 (60)
    , PIN_AVAILABILITY     NUMBER (5,2)
    , STG_CREATE_BY        VARCHAR2 (50)
    , STG_CREATE_DATE      DATE
    , STG_LAST_UPDATE_BY   VARCHAR2 (50)
    , STG_LAST_UPDATE_DATE DATE
    )
    TABLESPACE MAXDAT_DATA
    STORAGE (BUFFER_POOL DEFAULT);

--    alter table HCO_F_PORTAL_SEARCHES_BY_DATE add constraint PK_HCO_F_PORTAL_SEARCHES_BY_DATE PRIMARY KEY (CREATE_DATE);
    create index IDX_Portal_Searches_create_Date on HCO_F_PORTAL_SEARCHES_BY_DATE(CREATE_DATE);

    GRANT SELECT ON MAXDAT.HCO_F_PORTAL_SEARCHES_BY_DATE TO MAXDAT_READ_ONLY;
    
    
CREATE TABLE HCO_F_PORTAL_DLDS_BY_DATE
    (
      DOWNLOAD_PIN                  VARCHAR2(30)
    , DOWNLOAD_DATE                 DATE
    , FORM_TYPE                     VARCHAR2(40)
    , CREATE_BY                     VARCHAR2(50)
    , CREATE_DATE                   DATE
    , LAST_UPDATE_BY                VARCHAR2(50)
    , LAST_UPDATE_DATE              DATE
    )
    TABLESPACE MAXDAT_DATA
    STORAGE (BUFFER_POOL DEFAULT);

    alter table HCO_F_PORTAL_DLDS_BY_DATE add constraint PK_HCO_F_PORTAL_DLDS_BY_DATE PRIMARY KEY (DOWNLOAD_PIN,DOWNLOAD_DATE);

    GRANT SELECT ON MAXDAT.HCO_F_PORTAL_DLDS_BY_DATE TO MAXDAT_READ_ONLY;
    
    
/* CREATE TABLE HCO_D_PORTAL_PROVIDERS
    (
      PIN                           VARCHAR2(30)
    , PROVIDER_TYPE                 VARCHAR2(25)
    , PROVIDER_SPECIALTY            VARCHAR2(25)
    , CREATE_BY                     VARCHAR2(50)
    , CREATE_DATE                   DATE
    , LAST_UPDATE_BY                VARCHAR2(50)
    , LAST_UPDATE_DATE              DATE
    )
    TABLESPACE MAXDAT_DATA
    STORAGE (BUFFER_POOL DEFAULT);

    alter table HCO_D_PORTAL_PROVIDERS add constraint PK_HCO_D_PORTAL_PROVIDERS PRIMARY KEY (PIN);

    GRANT SELECT ON MAXDAT.HCO_D_PORTAL_PROVIDERS TO MAXDAT_READ_ONLY;
 */    
    
/* CREATE TABLE HCO_F_PORTAL_DOWNTIME_BY_DATE
    (
      PIN                           VARCHAR2(30)
    , D_DATE                        DATE
    , DOWNTIME_TYPE                 VARCHAR2(30)
    , DAYS_IN_MONTH                 NUMBER(2)
    , REQ_HOURS_IN_DAY              NUMBER(4,2)
    , REQ_MINS_IN_DAY               NUMBER(6)
    , REQ_SECS_IN_DAY               NUMBER(6)
    , REQ_HOURS_IN_MONTH            NUMBER(4,2)
    , REQ_MINS_IN_MONTH             NUMBER(6)
    , REQ_SECS_IN_MONTH             NUMBER(6)
    , AVAIL_HOURS_IN_MONTH          NUMBER(4,2)
    , AVAIL_MINS_IN_MONTH           NUMBER(6)
    , AVAIL_SECS_IN_MONTH           NUMBER(6)
    , AVAILABILITY                  NUMBER(5,2)
    , CREATE_BY                     VARCHAR2(50)
    , CREATE_DATE                   DATE
    , LAST_UPDATE_BY                VARCHAR2(50)
    , LAST_UPDATE_DATE              DATE
    )
    TABLESPACE MAXDAT_DATA
    STORAGE (BUFFER_POOL DEFAULT);

    alter table HCO_F_PORTAL_DOWNTIME_BY_DATE add constraint PK_HCO_F_PORTAL_DOWNTIME_BY_DATE PRIMARY KEY (PIN);

    GRANT SELECT ON MAXDAT.HCO_F_PORTAL_DOWNTIME_BY_DATE TO MAXDAT_READ_ONLY;
 */    

/* CREATE TABLE HCO_F_PORTAL_ASSIST_BY_DATE
    (
      LANGUAGE_ASSIST               number(6)
    , D_DATE                        DATE
    , TEST_ASSIST                   number(6)
    , FAX_ASSIST                    number(6)
    , ENROLL_ASSIST                 number(6)
    , DISENROLL_ASSIST              number(6)
    , PACKET_ASSIST                 number(6)
    , OTHER_ASSIST                  number(6)
    , CREATE_BY                     VARCHAR2(50)
    , CREATE_DATE                   DATE
    , LAST_UPDATE_BY                VARCHAR2(50)
    , LAST_UPDATE_DATE              DATE
    )
    TABLESPACE MAXDAT_DATA
    STORAGE (BUFFER_POOL DEFAULT);

    alter table HCO_F_PORTAL_ASSIST_BY_DATE add constraint PK_HCO_F_PORTAL_ASSIST_BY_DATE PRIMARY KEY (LANGUAGE_ASSIST,D_DATE);

    GRANT SELECT ON MAXDAT.HCO_F_PORTAL_ASSIST_BY_DATE TO MAXDAT_READ_ONLY;
    
 */    
    
/* CREATE OR REPLACE VIEW HCO_D_SYSTEM_SV AS
SELECT SYSTEM_ID
    , SYSTEM_TYPE_ID
    , SYSTEM_NAME
FROM HCO_D_SYSTEM;

    GRANT SELECT ON MAXDAT.HCO_D_SYSTEM_SV TO MAXDAT_READ_ONLY;
    

CREATE OR REPLACE VIEW HCO_D_SYSTEM_TYPE_SV AS
SELECT SYSTEM_TYPE_ID
    , SYSTEM_TYPE_NAME  
FROM HCO_D_SYSTEM_TYPE; 
    
    GRANT SELECT ON MAXDAT.HCO_D_SYSTEM_TYPE_SV TO MAXDAT_READ_ONLY;


CREATE OR REPLACE VIEW HCO_F_SYSTEM_AVAILABILITY_SV AS
SELECT D_MONTH
    , a.system_id                       
    , REQUIRED_AVAILABLE_MINS       
    , SCHEDULED_DOWNTIME_MINS       
    , UPTIME_MINS                   
    , AVAILABILITY_MINS             
    , MAX_UNSCHEDULED_DOWNTIME_MINS 
    , UNSCHEDULED_DOWNTIME_MINS     
    , SLA_FLAG                      
FROM HCO_F_SYSTEM_AVAILABILITY a
join hco_d_system b on a.system_id =b.system_id;
    
    GRANT SELECT ON MAXDAT.HCO_F_SYSTEM_AVAILABILITY_SV TO MAXDAT_READ_ONLY;


CREATE OR REPLACE VIEW HCO_F_NETWORK_USAGE_SV AS
SELECT D_DATE                       
    , HOUR                          
    , USAGE                         
FROM HCO_F_NETWORK_USAGE;

    GRANT SELECT ON MAXDAT.HCO_F_NETWORK_USAGE_SV TO MAXDAT_READ_ONLY;
    

CREATE OR REPLACE VIEW HCO_D_DEPARTMENT_SV AS
SELECT DEPARTMENT_ID                    
    , DEPARTMENT_NAME               
FROM HCO_D_DEPARTMENT;

    GRANT SELECT ON MAXDAT.HCO_D_DEPARTMENT_SV TO MAXDAT_READ_ONLY;
    

CREATE OR REPLACE VIEW HCO_D_DEPARTMENT_TRANS_SV AS
SELECT DEPARTMENT_TRANSACTION_ID    
    , DEPARTMENT_ID                 
    , TRANSACTION_NUMBER            
    , TRANSACTION_DESCRIPTION       
FROM HCO_D_DEPARTMENT_TRANSACTIONS ;

    GRANT SELECT ON MAXDAT.HCO_D_DEPARTMENT_TRANS_SV TO MAXDAT_READ_ONLY;
    
    
CREATE OR REPLACE VIEW HCO_F_SYSTEM_TESTS_SV AS
SELECT SYSTEM_TEST_ID
    , a.DEPARTMENT_TRANSACTION_ID
    , a.DEPARTMENT_ID   
    , D_DATE                        
    , TIME                          
    , CUBE                          
    , RESPONSE_TIME                 
FROM HCO_F_SYSTEM_TESTS a;
join HCO_D_DEPARTMENT_TRANS b
 on a.DEPARTMENT_TRANSACTION_ID = b.DEPARTMENT_TRANSACTION_ID
join HCO_D_DEPARTMENT c
 on a.DEPARTMENT_ID = c.DEPARTMENT_ID

 GRANT SELECT ON MAXDAT.HCO_F_SYSTEM_TESTS_SV TO MAXDAT_READ_ONLY;
 */    
    
CREATE OR REPLACE VIEW HCO_F_PORTAL_SEARCHES_BY_DATE_SV AS
SELECT CREATE_DATE
    , HITS                  
    , PROVIDER_TYPE                        
    , PROVIDER_SPECIALTY                   
    , COUNTY_CODE
    , COUNTY_NAME
    , LANGUAGE                      
    , PIN_AVAILABILITY              
FROM MAXDAT.HCO_F_PORTAL_SEARCHES_BY_DATE;

    GRANT SELECT ON MAXDAT.HCO_F_PORTAL_SEARCHES_BY_DATE_SV TO MAXDAT_READ_ONLY;
    
    
CREATE OR REPLACE VIEW HCO_F_PORTAL_DLDS_BY_DATE_SV AS
SELECT DOWNLOAD_PIN                 
    , DOWNLOAD_DATE                 
    , FORM_TYPE                     
FROM maxdat.HCO_F_PORTAL_DLDS_BY_DATE;

    GRANT SELECT ON MAXDAT.HCO_F_PORTAL_DLDS_BY_DATE_SV TO MAXDAT_READ_ONLY;
    
    
/* CREATE OR REPLACE VIEW HCO_D_PORTAL_PROVIDERS_SV AS
SELECT PROVIDER_TYPE                 
    , PROVIDER_SPECIALTY            
FROM maxdat.HCO_D_PORTAL_PROVIDERS;

    GRANT SELECT ON MAXDAT.HCO_D_PORTAL_PROVIDERS_SV TO MAXDAT_READ_ONLY;
 */    
    
/* CREATE OR REPLACE VIEW HCO_F_PORTAL_DOWNTIME_BY_DATE_SV AS
SELECT PIN                          
    , D_DATE                        
    , DOWNTIME_TYPE                 
    , DAYS_IN_MONTH                 
    , REQ_HOURS_IN_DAY              
    , REQ_MINS_IN_DAY               
    , REQ_SECS_IN_DAY               
    , REQ_HOURS_IN_MONTH            
    , REQ_MINS_IN_MONTH             
    , REQ_SECS_IN_MONTH             
    , AVAIL_HOURS_IN_MONTH          
    , AVAIL_MINS_IN_MONTH           
    , AVAIL_SECS_IN_MONTH           
    , AVAILABILITY                  
FROM HCO_F_PORTAL_DOWNTIME_BY_DATE;

    GRANT SELECT ON MAXDAT.HCO_F_PORTAL_DOWNTIME_BY_DATE_SV TO MAXDAT_READ_ONLY;
    

CREATE OR REPLACE VIEW HCO_F_PORTAL_ASSISTANCE_BY_DATE_SV AS
SELECT LANGUAGE_ASSIST              
    , D_DATE                        
    , TEST_ASSIST                   
    , FAX_ASSIST                    
    , ENROLL_ASSIST                 
    , DISENROLL_ASSIST              
    , PACKET_ASSIST                 
    , OTHER_ASSIST                  
FROM HCO_F_PORTAL_ASSISTANCE_BY_DATE;

    GRANT SELECT ON MAXDAT.HCO_F_PORTAL_ASSISTANCE_BY_DATE_SV TO MAXDAT_READ_ONLY;
     */