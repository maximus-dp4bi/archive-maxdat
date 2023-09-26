--------------------------------------------------------------------------
-- Run this script in MAXDAT@NHX1DORUHXDP.CLDMGFTTY3FU.US-EAST-1.RDS.AMAZONAWS.COM:1557/NYHXDPMU to make it look like MAXDAT@NHX1DORD1HXDP.CLDMGFTTY3FU.US-EAST-1.RDS.AMAZONAWS.COM:1557/NYHXDPMD.
--
-- Please review the script before using it to make sure it won't cause any unacceptable data loss.
--
-- MAXDAT@NHX1DORUHXDP.CLDMGFTTY3FU.US-EAST-1.RDS.AMAZONAWS.COM:1557/NYHXDPMU schema extracted by user WL134672
-- MAXDAT@NHX1DORD1HXDP.CLDMGFTTY3FU.US-EAST-1.RDS.AMAZONAWS.COM:1557/NYHXDPMD schema extracted by user MAXDAT
--  
--  Note: Difference limit has been reached.
--       Only the first 1000 differences are shown.
--  
--------------------------------------------------------------------------
-- "Set define off" turns off substitution variables.
Set define off;

COMMENT ON COLUMN MAXDAT.CORP_ETL_MFB_ECN_STG.ENV_CREATION_DATE IS 'The Envelope Creation Date is the date that the envelope is scanned in KOFAX.';

CREATE TABLE MAXDAT.F_MFB_V2_BY_DAY
(
  BATCH_GUID             VARCHAR2(38 CHAR),
  D_DATE                 DATE,
  MFB_V2_BI_ID           NUMBER,
  MFB_V2_CREATE_DATE     DATE,
  MFB_V2_UPDATE_DATE     DATE,
  CREATE_DT              DATE,
  FAX_BATCH_SOURCE       VARCHAR2(100 CHAR),
  BATCH_CLASS            VARCHAR2(50 CHAR),
  CANCEL_DT              DATE,
  REPROCESSED_DT         DATE,
  BATCH_COMPLETE_DT      DATE,
  AGE_IN_BUSINESS_HOURS  NUMBER,
  AGE_IN_BUSINESS_DAYS   INTEGER,
  CREATION_COUNT         NUMBER(1),
  INVENTORY_COUNT        NUMBER(1),
  COMPLETION_COUNT       NUMBER(1),
  CANCELATION_COUNT      NUMBER(1),
  REPROCESSED_COUNT      NUMBER(1),
  WEEKEND_FLAG           CHAR(1 BYTE),
  BUSINESS_DAY_FLAG      CHAR(1 BYTE),
  BATCH_GROUP            VARCHAR2(50 CHAR),
  BATCH_PROGRAM          VARCHAR2(50 CHAR)
)
TABLESPACE MAXDAT_DATA
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOLOGGING 
NOCOMPRESS 
NO INMEMORY
NOCACHE
RESULT_CACHE (MODE DEFAULT)
NOPARALLEL;

CREATE INDEX MAXDAT.F_MFB_V2_BD_IX3 ON MAXDAT.F_MFB_V2_BY_DAY
(D_DATE)
LOGGING
TABLESPACE MAXDAT_INDX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;

CREATE UNIQUE INDEX MAXDAT.F_MFB_V2_BD_UIX1 ON MAXDAT.F_MFB_V2_BY_DAY
(BATCH_GUID, D_DATE)
LOGGING
TABLESPACE MAXDAT_INDX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;

CREATE UNIQUE INDEX MAXDAT.F_MFB_V2_BD_UIX2 ON MAXDAT.F_MFB_V2_BY_DAY
(MFB_V2_BI_ID, D_DATE)
LOGGING
TABLESPACE MAXDAT_INDX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;

CREATE OR REPLACE TRIGGER MAXDAT.TRG_BIU_F_MFB_V2_BY_DAY 
BEFORE INSERT OR UPDATE ON MAXDAT.F_MFB_V2_BY_DAY
FOR EACH ROW
BEGIN
	IF INSERTING THEN
		:NEW.MFB_V2_CREATE_DATE := SYSDATE;
		:NEW.MFB_V2_UPDATE_DATE := NULL;
	END IF;

	IF UPDATING THEN
		:NEW.MFB_V2_CREATE_DATE := :OLD.MFB_V2_CREATE_DATE;
		:NEW.MFB_V2_UPDATE_DATE := SYSDATE;
	END IF;	

END;
/
SHOW ERRORS;


CREATE INDEX MAXDAT.NYHIX_MFB_V2_BATCH_EVENT_PARENT_JOB_ID ON MAXDAT.NYHIX_MFB_V2_BATCH_EVENT
(MFB_V2_PARENT_JOB_ID)
LOGGING
TABLESPACE MAXDAT_INDX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;

CREATE INDEX MAXDAT.NYHIX_MFB_V2_DOCUMENT_PARENT_JOB_ID ON MAXDAT.NYHIX_MFB_V2_DOCUMENT
(MFB_V2_PARENT_JOB_ID)
LOGGING
TABLESPACE MAXDAT_INDX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;

CREATE INDEX MAXDAT.NYHIX_MFB_V2_ENVELOPE_PARENT_JOB_ID ON MAXDAT.NYHIX_MFB_V2_ENVELOPE
(MFB_V2_PARENT_JOB_ID)
LOGGING
TABLESPACE MAXDAT_INDX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;

CREATE INDEX MAXDAT.NYHIX_MFB_V2_MAXDAT_REPORTING_PARENT_JOB_ID ON MAXDAT.NYHIX_MFB_V2_MAXDAT_REPORTING
(MFB_V2_PARENT_JOB_ID)
LOGGING
TABLESPACE MAXDAT_INDX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;

CREATE INDEX MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH_PARENT_JOB_ID ON MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_LAUNCH
(MFB_V2_PARENT_JOB_ID)
LOGGING
TABLESPACE MAXDAT_INDX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;

CREATE INDEX MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE_PARENT_JOB_ID ON MAXDAT.NYHIX_MFB_V2_STATS_BATCH_MODULE
(MFB_V2_PARENT_JOB_ID)
LOGGING
TABLESPACE MAXDAT_INDX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;

CREATE INDEX MAXDAT.NYHIX_MFB_V2_STATS_BATCH_PARENT_JOB_ID ON MAXDAT.NYHIX_MFB_V2_STATS_BATCH
(MFB_V2_PARENT_JOB_ID)
LOGGING
TABLESPACE MAXDAT_INDX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;

CREATE INDEX MAXDAT.NYHIX_MFB_V2_STATS_FORM_TYPE_PARENT_JOB_ID ON MAXDAT.NYHIX_MFB_V2_STATS_FORM_TYPE
(MFB_V2_PARENT_JOB_ID)
LOGGING
TABLESPACE MAXDAT_INDX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL;

CREATE OR REPLACE function MAXDAT.bus_day_count 
    ( p_start_date  in date,
      p_end_date    in date
    )
    return number
 as

    lv_start_date date;
    lv_end_date date;
    lv_num_days number := 0;    
    

begin

lv_start_date := trunc(p_start_date);
lv_end_date := trunc(p_end_date); 

if lv_start_date > lv_end_date
then
    return 0;
end if;
    
with h_days
as
(
select sum(1) as h_cnt 
	FROM HOLIDAYS
	where HOLIDAY_DATE between lv_start_date and lv_end_date
),
b_days 
as
( select
    (  trunc(lv_end_date, 'IW' ) - TRUNC( lv_start_date, 'IW' ) ) * 5 / 7
       + LEAST( lv_end_date - TRUNC( lv_end_date, 'IW' ) + 1, 5 )
       - LEAST( lv_start_date - TRUNC( lv_start_date, 'IW' ) + 1, 5 ) as b_cnt 
from dual
)
select nvl(b_days.b_cnt,0) - nvl(h_days.h_cnt,0)
	into lv_num_days
from b_days, h_days;

if  nvl(lv_num_days,0) >= 0
then
    return lv_num_days+1;
else 
    return 0;
end if;    

end;
/

SHOW ERRORS;

CREATE OR REPLACE function MAXDAT.BUS_HRS_BETWEEN
    (--p_run_date 		in date,
	 p_start_date 		in date,
     p_end_date 		in date,
	 p_bus_day_start_hr in varchar default '07:00', 
	 p_bus_day_end_hr 	in varchar default '19:00'
	 )
    return NUMBER
  as
    lv_bus_days                 integer := 0;
    lv_num_hours 				number(10,5) := 0;
    -- lv_start_date               date;
    --lv_end_date                 date;
    --lv_business_start_date_time date 	:= null;
    --lv_business_end_date_time 	date 	:= null;
    lv_end_of_first_day         date := null;
    lv_start_of_last_day        date := null;
    lv_hrs_per_day              number(10,5) := 0;
  --  lv_nls_date_format          varchar(80) := 'alter session set nls_date_format = '||''''||'YYYY/mm/dd hh24:mi:ss'||'''' ;
 --   lv_holiday_count            integer := 0;
  begin
	lv_num_hours        := 0;

	-- set the business_start_date_time
	--lv_business_start_date_time 	:= to_date(to_char(p_start_date,'yyyymmdd')||lv_bus_day_start_hr,'yyyymmddhh24:mi');

	if p_start_date > nvl(p_end_date,sysdate) 
	then 
		return 0;
	end if;

	-- calculate hours for the first day
	if trunc(p_start_date) = trunc(p_end_date)
	then 
        lv_num_hours := p_end_date - p_start_date;
        return round(lv_num_hours * 24,1);
    end if;
    
    -- get the count of business days
    
    lv_bus_days := bus_day_count(trunc(p_start_date), trunc(P_END_DATE));
    --return lv_bus_days;
    
    if nvl(lv_bus_days,0) <= 0
    then
        return 0;
    end if;    
	
    lv_end_of_first_day         := to_date(to_char(p_start_date,'yyyymmdd')||' '||p_bus_day_end_hr,'yyyymmdd hh24:mi');
    lv_start_of_last_day        := to_date(to_char(nvl(p_end_date,sysdate),'yyyymmdd')||' '||p_bus_day_start_hr,'yyyymmdd hh24:mi');
        
    -- calc hours for the first day
    if nvl(lv_bus_days,0) >= 1
    --and to_date(to_char(p_start_date,'hh24:mi'),'hh24:mi') >= to_date(p_bus_day_start_hr,'hh24:mi')
    and to_date(to_char(p_start_date,'hh24:mi'),'hh24:mi') <= to_date(p_bus_day_end_hr,'hh24:mi')
    then 
    	lv_num_hours := (lv_end_of_first_day  - p_start_date) * 24;
    end if;	 
    
    -- add in the hours for the last_day
    if nvl(lv_bus_days,0) >= 2
    and to_date(to_char(p_end_date,'hh24:mi'),'hh24:mi') >= to_date(p_bus_day_start_hr,'hh24:mi')
    and to_date(to_char(p_end_date,'hh24:mi'),'hh24:mi') <= to_date(p_bus_day_end_hr,'hh24:mi')
    then 
        lv_num_hours := lv_num_hours + (( p_end_date - lv_start_of_last_day ) * 24 );
    end if;
    
    -- add hours for days between
    if nvl(lv_bus_days,0)-2 > 0
    then 
        lv_hrs_per_day := (to_date(p_bus_day_end_hr,'hh24:mi') - to_date(p_bus_day_start_hr,'hh24:mi') ) * 24;
        lv_num_hours := lv_num_hours + ((lv_bus_days-2) * lv_hrs_per_day );
    end if;    

    return round(lv_num_hours,1);

  end;
/

SHOW ERRORS;

CREATE OR REPLACE function MAXDAT.wrk_day_cnt 
    ( p_start_date  in date,
      p_end_date    in date
    )
    return number
 as

    lv_start_date date;
    lv_end_date date;
    lv_num_days number := 0;    
    

begin

lv_start_date := trunc(p_start_date);
lv_end_date := trunc(p_end_date); 

with h_days
as
(
select count(*) as h_cnt 
	FROM HOLIDAYS
	where HOLIDAY_DATE between lv_start_date and lv_end_date
),
b_days 
as
( select
    (  trunc(lv_end_date, 'IW' ) - TRUNC( lv_start_date, 'IW' ) ) * 5 / 7
       + LEAST( lv_end_date - TRUNC( lv_end_date, 'IW' ) + 1, 5 )
       - LEAST( lv_start_date - TRUNC( lv_start_date, 'IW' ) + 1, 5 ) as b_cnt 
from dual
)
select b_cnt - h_cnt 
    into lv_num_days
from h_days, b_days;
 
return lv_num_days;

end;

---select wrk_day_cnt(sysdate-3, sysdate+16) from dual
/

SHOW ERRORS;