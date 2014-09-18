
create table flhk_etl_documents
(
ACCOUNT_ID	NUMBER,
ACCOUNT_NUM	NUMBER,	
AGE_BUSINESS_DAYS	NUMBER default 0 not null	,
AGE_CALENDAR_DAYS	NUMBER	default 0 not null,
ALREADY_WORKED	VARCHAR2(1 BYTE)	,
ASED_CREATE_DOC_IN_VIDA	DATE,
ASF_CREATE_DOC_IN_VIDA	VARCHAR2(1 BYTE) default 'N' not null	,
ASSD_CREATE_DOC_IN_VIDA	DATE	,
CANCEL_DT	DATE	,
CHANNEL	VARCHAR2(32 BYTE)	,
DCN	VARCHAR2(256 BYTE) not null,
DCN_CREATE_DT	DATE	not null,
DCN_ID	NUMBER	not null,
DOC_TYPE	VARCHAR2(32 BYTE)	,
ECN	VARCHAR2(256 BYTE)	,
FORWARD_ADDRESS	VARCHAR2(1 BYTE)	,
GWF_WORK_REQUIRED	VARCHAR2(1 BYTE),	
IMAGE_LOCATION	VARCHAR2(256 BYTE),	
INSTANCE_COMPLETE_DT	DATE	,
INSTANCE_STATUS	VARCHAR2(32 BYTE)default 'ACTIVE' not null,
INSTANCE_STATUS_DT	DATE	not null,
LETTER_ID	VARCHAR2(32 BYTE)	,
MISSING_PAGES	VARCHAR2(1 BYTE)	,
NEW_APP_FLAG	VARCHAR2(32 BYTE)	,
PAYMENT_AMT	NUMBER	,
PAYMENT_NUM	NUMBER	,
RECEIPT_DT	DATE	not null,
RELEASE_DT	DATE	,
RENEWAL_DOC_FLAG	VARCHAR2(32 BYTE)	,
SCAN_DT	DATE	not null,
STAGE_DONE_DATE	DATE	,
STG_EXTRACT_DATE	DATE,	
STG_LAST_UPDATE_DT	DATE	,
UNREADABLE	VARCHAR2(1 BYTE)	,
VIDA_SOURCE	VARCHAR2(32 BYTE)	,
WEB_CONFIRM_ID	VARCHAR2(32 BYTE)	,
WORK_REQUEST_ID	NUMBER	,
WR_CREATED_DATE	DATE	,
UPDATED	VARCHAR2(1 BYTE)	,
SLA_DAYS	NUMBER(18,0)	,
SLA_DAYS_TYPE	VARCHAR2(1 BYTE)	,
SLA_JEOPARDY_DAYS	NUMBER(18,0) not null	,
SLA_JEOPARDY_DATE	DATE	,
SLA_TARGET_DAYS	NUMBER(18,0)	,
DCN_TIMELINESS_STATUS	VARCHAR2(32 BYTE) default 'Timeliness Not Required' not null,
JEOPARDY_FLAG	VARCHAR2(2 BYTE)	,
AGE_BUSINESS_HOURS	NUMBER(18,0) default 0 not null	,
AGE_CALENDAR_HOURS	NUMBER(18,0) default 0 not null	
);

ALTER TABLE "FLHK_ETL_DOCUMENTS" ADD CONSTRAINT "DCN_PK" PRIMARY KEY
(
  "DCN"
  )
  ENABLE;

--------------------------------------------------------
--  DDL for Trigger FLHK_ETL_DOCUMENTS_TRG
--------------------------------------------------------
CREATE
OR REPLACE TRIGGER "FLHK_ETL_DOCUMENTS_TRG" before
INSERT ON "FLHK_ETL_DOCUMENTS" FOR EACH row BEGIN IF inserting THEN IF :NEW."DCN_ID" IS NULL THEN
SELECT FLHK_ETL_DOCUMENTS_SEQ.nextval INTO :NEW."DCN_ID" FROM dual;
END IF;
END IF;
END;
/

ALTER TRIGGER "FLHK_ETL_DOCUMENTS_TRG" ENABLE;
/

create or replace FUNCTION CALCULATE_BUSINESS_DAYS
(start_date IN DATE, 
end_date IN DATE)
RETURN NUMBER IS
busdays NUMBER := 0;
v_start_date DATE;
v_end_date DATE;

BEGIN

v_start_date := TRUNC(start_date);
v_end_date := TRUNC(end_date);

if v_end_date >= v_start_date then
SELECT COUNT(*) - 1 into busdays
   FROM ( SELECT ROWNUM-1 RNUM FROM ALL_OBJECTS
          WHERE ROWNUM <= TO_DATE(NVL(NULL,TO_DATE(v_end_date))) - TO_DATE(v_start_date) + 1 )
          WHERE TO_CHAR(TO_DATE(NVL(NULL,TO_DATE(v_start_date)))+RNUM -1 , 'DY' ) NOT IN ( 'SAT', 'SUN' )
          AND NOT EXISTS ( SELECT NULL FROM HOLIDAYS WHERE HOLIDAY_DATE = TRUNC(TO_DATE(NVL(NULL,TO_DATE(start_date)))+RNUM-1) );

else
   busdays := 0;
END IF;
  RETURN(busdays);
END;
/

create or replace FUNCTION CALCULATE_BUSINESS_HOURS
(start_date IN DATE, 
end_date IN DATE)
RETURN NUMBER IS
busdays NUMBER := 0;
v_start_date DATE;
v_end_date DATE;

BEGIN

v_start_date := TRUNC(start_date);
v_end_date := TRUNC(end_date);

if v_end_date >= v_start_date then
SELECT (COUNT(*) - 1)*24 into busdays
   FROM ( SELECT ROWNUM-1 RNUM FROM ALL_OBJECTS
          WHERE ROWNUM <= TO_DATE(NVL(NULL,TO_DATE(v_end_date))) - TO_DATE(v_start_date) + 1 )
          WHERE TO_CHAR(TO_DATE(NVL(NULL,TO_DATE(v_start_date)))+RNUM -1 , 'DY' ) NOT IN ( 'SAT', 'SUN' )
          AND NOT EXISTS ( SELECT NULL FROM HOLIDAYS WHERE HOLIDAY_DATE = TRUNC(TO_DATE(NVL(NULL,TO_DATE(start_date)))+RNUM-1) );

else
   busdays := 0;
END IF;
  RETURN(busdays);
END;
/

create or replace FUNCTION GET_AGE_IN_CALENDAR_DAYS
  (p_create_dt in date,
   p_complete_dt in date)
  return number
as
begin
  return trunc(nvl(p_complete_dt,sysdate)) - trunc(p_create_dt);
end; 
/

create or replace FUNCTION GET_AGE_IN_CALENDAR_HOURS
  (p_create_dt in date,
   p_complete_dt in date)
  return number
as
begin
  return round((nvl(p_complete_dt,sysdate) - (p_create_dt))*24);
end; 
/

create or replace FUNCTION GET_JEOPARDY_DAYS
 return number result_cache
as
 v_jeopardy_days varchar2(2):=null;
begin
  select value 
  into v_jeopardy_days
  from corp_etl_control
  where name='MFD_JEOPARDY_DAYS';
 return to_number(v_jeopardy_days);
end;
/

create or replace FUNCTION GET_JEOPARDY_DAYS_TYPE
 return varchar2 result_cache
as
 v_days_type varchar2(2):=null;
begin
  select value 
  into v_days_type
  from corp_etl_control
  where name='MFD_JEOPARDY_DAYS_TYPE';
 return v_days_type;
end;
/

create or replace FUNCTION GET_JEOPARDY_DT
(p_create_dt in date)
return date
as
v_jeopardy date:=null;
begin
v_jeopardy:=p_create_dt + get_jeopardy_days();
return v_jeopardy;
 end;
 /
 
 create or replace FUNCTION GET_JEOPARDY_FLAG
 (p_create_dt in date, 
  p_complete_dt in date)
return varchar2
as
 days_type varchar2(3):=null;
 jeopardy_days number:=null;
 bus_days number :=null;
 cal_days number :=null;
begin
  days_type:=GET_JEOPARDY_DAYS_TYPE();
  jeopardy_days:=GET_JEOPARDY_DAYS();
  bus_days:=CALCULATE_BUSINESS_DAYS(p_create_dt,nvl(p_complete_dt,sysdate));
  cal_days:=trunc(nvl(p_complete_dt,sysdate)) - trunc(p_create_dt);
if(p_complete_dt is null) then
 if (days_type='B') then
  if (bus_days>=jeopardy_days) then
   return 'Y';
    else
   return 'N';
  end if;
 elsif (days_type='C') then
  if (cal_days>=jeopardy_days) then
   return 'Y';
    else
     return 'N';
   end if;
  else
  return null;
  end if;
 elsif (p_complete_dt is not null) then
 return 'NA';
 else
 return null;
 end if;
end;
/

create or replace FUNCTION GET_SLA_DAYS
 return number result_cache
as
 v_sla_days varchar2(2):=null;
begin
  select value 
  into v_sla_days
  from corp_etl_control
  where name='MFD_SLA_DAYS';
 return to_number(v_sla_days);
end;
/

create or replace FUNCTION GET_TARGET_DAYS
 return number result_cache
as
 v_target_days varchar2(2):=null;
begin
  select value 
  into v_target_days
  from corp_etl_control
  where name='MFD_TARGET_DAYS';
 return to_number(v_target_days);
end;
/


create or replace FUNCTION GET_TIMELINESS_DAYS
 return number result_cache
as
 v_timeliness_days varchar2(2):=null;
begin
  select value 
  into v_timeliness_days
  from corp_etl_control
  where name='MFD_TIMELINESS_DAYS';
 return to_number(v_timeliness_days);
end;
/

create or replace FUNCTION GET_TIMELINESS_DAYS_TYPE
 return varchar2 result_cache
as
 v_days_type varchar2(2):=null;
begin
  select value 
  into v_days_type
  from corp_etl_control
  where name='MFD_SLA_DAYS_TYPE';
 return v_days_type;
end;
/

create or replace FUNCTION GET_TIMELINESS_DT
 (p_create_dt in date)
 return date
 as
 v_timeliness date:=null;
 begin
  v_timeliness:= p_create_dt + get_timeliness_days();
return v_timeliness;
 end;
 /
 
 create or replace FUNCTION GET_TIMELINESS_STATUS
  (p_create_dt in date, 
   p_complete_dt in date,
   p_cancel_dt in date)
 return varchar2
as
 days_type varchar2(2):=null;
 timeliness_days number:=null;
 bus_days number :=null;
 cal_days number :=null;
begin
  days_type:=GET_TIMELINESS_DAYS_TYPE();
  timeliness_days:=GET_TIMELINESS_DAYS();
  bus_days:=CALCULATE_BUSINESS_DAYS(p_create_dt,nvl(p_complete_dt,sysdate));
  cal_days:=trunc(nvl(p_complete_dt,sysdate)) - trunc(p_create_dt);
if (p_complete_dt is not null) then
 if (days_type='B') then
   if (bus_days<=timeliness_days)
    then return 'Processed Timely';
   elsif (bus_days>=timeliness_days)
    then return 'Processed Untimely';
   else
    return null;
   end if;
 elsif (days_type='C') then
  if (cal_days<timeliness_days)
    then return 'Processed Timely';
  elsif (cal_days>=timeliness_days)
    then return 'Processed Untimely';
    else
      return null;
    end if;
 else
 return null;
 end if;
elsif(p_complete_dt is not null and p_cancel_dt is not null)
then return 'Timeliness Not Required';
elsif (p_complete_dt is null)
then return 'Timeliness Not Required';
else
return null;
end if;
end;
/

create or replace FUNCTION "GET_WEEKDAY" (START_DATE IN DATE, DAYS2ADD IN NUMBER := 0) RETURN DATE IS
  COUNTER      NATURAL := 0;
  CURDATE      DATE := START_DATE;
  DAYNUM       POSITIVE;
  SKIPCNTR     NATURAL := 0;
  DIRECTION    INTEGER := 1; -- days after start_date
  BUSINESSDAYS NUMBER := DAYS2ADD;
BEGIN
  IF DAYS2ADD < 0 THEN
    DIRECTION    := -1; -- days before start_date
    BUSINESSDAYS := (-1) * BUSINESSDAYS;
  END IF;
  WHILE COUNTER < BUSINESSDAYS LOOP
    CURDATE := CURDATE + DIRECTION;
    DAYNUM  := TO_CHAR(CURDATE, 'D');
    IF DAYNUM BETWEEN 2 AND 6 THEN
      COUNTER := COUNTER + 1;
    ELSE
      SKIPCNTR := SKIPCNTR + 1;
    END IF;
  END LOOP;
  RETURN START_DATE +(DIRECTION * (COUNTER + SKIPCNTR));
END Get_WeekDay;
/