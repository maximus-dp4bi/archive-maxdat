-- NYHIX-47982
-- Create backup table
SET serveroutput ON;

declare  c int;
begin
   select count(*) into c from user_tables where table_name ='SC_LAG_TIME_48390';
   if c = 1 then
      execute immediate 'drop table DP_SCORECARD.SC_LAG_TIME_48390 cascade constraints';
   end if;
end;
/

create table DP_SCORECARD.SC_LAG_TIME_48390
(
  lag_date                  DATE not null,
  agent_id                  NUMBER(38) not null,
  supervisor_id             NUMBER(38) not null,
  tot_sched_productive_time VARCHAR2(50),
  create_by                 VARCHAR2(100),
  create_date               DATE,
  adherence_flag            NUMBER(1)
)
tablespace MAXDAT_DATA;

GRANT SELECT ON DP_SCORECARD.SC_LAG_TIME_48390 TO DP_SCORECARD_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SC_LAG_TIME_48390 TO MAXDAT_READ_ONLY;

declare

  v_b4_record_count   number := 0;
  v_insert_count      number := 0;
  v_aft_record_count  number := 0;

begin
  SELECT COUNT(*)
  INTO   v_b4_record_count
  FROM   DP_SCORECARD.SC_LAG_TIME;

  dbms_output.put_line('Table DP_SCORECARD.SC_LAG_TIME record count: '||v_b4_record_count);

  INSERT INTO DP_SCORECARD.SC_LAG_TIME_48390
  SELECT lag_date, agent_id, supervisor_id, tot_sched_productive_time, create_by, create_date, adherence_flag
  from   DP_SCORECARD.SC_LAG_TIME;

  v_insert_count := SQL%ROWCOUNT;

  dbms_output.put_line('INSERT INTO Table DP_SCORECARD.SC_LAG_TIME_48390 record count: '||v_insert_count);

  SELECT COUNT(*)
  INTO   v_aft_record_count
  FROM   DP_SCORECARD.SC_LAG_TIME_48390;

  dbms_output.put_line('Table DP_SCORECARD.SC_LAG_TIME_48390 record count: '||v_aft_record_count);

  dbms_output.put_line('If the numbers match then please COMMIT otherwise ROLLBACK');

end;
/
-----------------------------------------------------------
DECLARE  c int;
begin
   select count(*) into c from user_tables where table_name ='SC_AGENT_STAT_48390';
   if c = 1 then
      execute immediate 'drop table DP_SCORECARD.SC_AGENT_STAT_48390 cascade constraints';
   end if;
end;
/

create table DP_SCORECARD.SC_AGENT_STAT_48390
(
  as_date                     DATE not null,
  agent_id                    NUMBER(38) not null,
  supervisor_id               NUMBER(38),
  calls_answered              NUMBER(6),
  short_calls_answered        NUMBER(6),
  average_handle_time         VARCHAR2(50),
  tot_return_to_queue         NUMBER(6),
  tot_sched_productive_time   VARCHAR2(50),
  actual_productive_time      VARCHAR2(50),
  talk_time                   VARCHAR2(50),
  wrap_up_time                VARCHAR2(50),
  logged_in_time              VARCHAR2(50),
  not_ready_time              VARCHAR2(50),
  break_time                  VARCHAR2(50),
  lunch_time                  VARCHAR2(50),
  exclusion_flag              VARCHAR2(1) default 'N',
  create_date                 DATE,
  create_by                   VARCHAR2(50),
  tot_return_to_queue_timeout NUMBER(6),
  calls_offered               NUMBER(6)
)
tablespace MAXDAT_DATA
;

GRANT SELECT ON DP_SCORECARD.SC_AGENT_STAT_48390 TO DP_SCORECARD_READ_ONLY;
GRANT SELECT ON DP_SCORECARD.SC_AGENT_STAT_48390 TO MAXDAT_READ_ONLY;

declare

  v_b4_record_count   number := 0;
  v_insert_count      number := 0;
  v_aft_record_count  number := 0;

begin
  SELECT COUNT(*)
  INTO   v_b4_record_count
  FROM   DP_SCORECARD.SC_AGENT_STAT;

  dbms_output.put_line('Table DP_SCORECARD.SC_AGENT_STAT record count: '||v_b4_record_count);

  INSERT INTO DP_SCORECARD.SC_AGENT_STAT_48390
  SELECT as_date, agent_id, supervisor_id, calls_answered, short_calls_answered, average_handle_time,
         tot_return_to_queue, tot_sched_productive_time, actual_productive_time, talk_time, wrap_up_time,
         logged_in_time, not_ready_time, break_time, lunch_time, exclusion_flag, create_date, create_by,
         tot_return_to_queue_timeout, calls_offered
  from   DP_SCORECARD.SC_AGENT_STAT;

  v_insert_count := SQL%ROWCOUNT;

  dbms_output.put_line('INSERT INTO Table DP_SCORECARD.SC_AGENT_STAT_48390 record count: '||v_insert_count);

  SELECT COUNT(*)
  INTO   v_aft_record_count
  FROM   DP_SCORECARD.SC_AGENT_STAT_48390;

  dbms_output.put_line('Table DP_SCORECARD.SC_AGENT_STAT_48390 record count: '||v_aft_record_count);

  dbms_output.put_line('If the numbers match then please COMMIT otherwise ROLLBACK');

end;
/
