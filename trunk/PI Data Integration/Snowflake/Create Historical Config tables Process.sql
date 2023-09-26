--drop start and end date columns from tables table
alter table public.d_pi_tables drop column start_date, end_date;
--add update_timestamp column
alter table public.d_pi_tables add column update_timestamp timestamp_ntz;

--create history table for tables table
create table public.D_PI_TABLES_HISTORY (
table_name varchar(255)
,s3_sourced boolean  
,active boolean   
,start_time timestamp_ntz
,end_time timestamp_ntz
,current_flag int);

grant all on table public.d_pi_tables_history to pi_data_ingest_UAT_alert_user;
alter table public.d_pi_tables set change_tracking=true;


--create stream on tables table
create or replace stream raw.pi_tables_stream on table public.d_pi_tables;

create or replace view raw.pi_tables_change_data as
select table_name, s3_sourced, active, start_time, end_time, current_flag, 'I' as dml_type
from (select table_name, s3_sourced, active, update_timestamp as start_time,
      lag(update_timestamp) over (partition by table_name order by update_timestamp desc) as end_time_raw,
      case when end_time_raw is null then 
'9999-12-31'::timestamp_ntz else end_time_raw end as end_time,
      case when end_time_raw is null then 1 else 0 end as current_flag
      from (select table_name, s3_sourced, active, update_timestamp
            from pi_tables_stream
            where metadata$action = 'INSERT'
            and metadata$isupdate = 'FALSE'))
union
select table_name, s3_sourced, active, start_time, end_time, current_flag, dml_type
from (select table_name, s3_sourced, active, update_timestamp as start_time,
      lag(update_timestamp) over (partition by table_name order by update_timestamp desc) as end_time_raw,
      case when end_time_raw is null then 
'9999-12-31'::timestamp_ntz else end_time_raw end as end_time,
      case when end_time_raw is null then 1 else 0 end as current_flag,dml_type
      from (-- Identify data to insert into nation_history table
        select table_name, s3_sourced, active, update_timestamp, 'I' as dml_type
        from pi_tables_stream
        where metadata$action = 'INSERT'
        and metadata$isupdate = 'TRUE'
union
select table_name, null, null, start_time, 'U' as dml_type
from public.d_pi_tables_history
where table_name in (select distinct table_name 
                             from pi_tables_stream
                             where metadata$action = 'INSERT'
                             and metadata$isupdate = 'TRUE')
        and current_flag = 1))
union
select str.table_name, null, null, hist.start_time, current_timestamp()::timestamp_ntz, null, 'D'
from public.d_pi_tables_history hist
inner join pi_tables_stream str
on hist.table_name = str.table_name
where str.metadata$action = 'DELETE'
and str.metadata$isupdate = 'FALSE'
and hist.current_flag = 1;

--create sp and task
CREATE or replace PROCEDURE update_tables_history ()
  RETURNS VARCHAR
  LANGUAGE javascript
  EXECUTE AS CALLER
  AS
  
  $$
  
var sqlCommand = `merge into public.d_pi_tables_history nh
using pi_tables_change_data m 
   on  nh.table_name = m.table_name 
   and nh.start_time = m.start_time
when matched and m.dml_type = 'U' then update
    set nh.end_time = m.end_time,
        nh.current_flag = 0
when matched and m.dml_type = 'D' then update 
    set nh.end_time = m.end_time,
        nh.current_flag = 0
when not matched and m.dml_type = 'I' then insert
           (table_name, s3_sourced, active, start_time, end_time, current_flag)
    values (m.table_name, m.s3_sourced, m.active, m.start_time, m.end_time, m.current_flag);`;

snowflake.execute ({sqlText: sqlCommand});

sqlCommand = `update public.d_pi_tables_history hist
set hist.end_time = temp.real_end_time
from 
(select table_name, start_time, end_time ,
    lead (start_time) over (partition by table_name order by start_time asc) as proposed_end_time,
    case when proposed_end_time is not null and timestampdiff(seconds,end_time, proposed_end_time) <=60 then proposed_end_time else end_time end as real_end_time
from public.d_pi_tables_history) as temp
where hist.table_name = temp.table_name
and hist.start_time = temp.start_time
and hist.end_time != temp.real_end_time;
--and some time within 1 minute of now`;

snowflake.execute ({sqlText: sqlCommand});

return 0;

$$;


drop task UPDATE_D_PI_TABLES_HISTORY_DEV;
CREATE TASK UPDATE_D_PI_TABLES_HISTORY_DEV
  WAREHOUSE = 'PUREINSIGHTS_DEV_LOAD_WH'
  SCHEDULE = '1 minute' when system$stream_has_data('pi_tables_stream')
AS
 call update_tables_history ();
 
 alter task UPDATE_D_PI_TABLES_HISTORY_DEV resume;
--------------------------------------------------------
---project unavailable tables history

alter table public.d_pi_project_unavailable_tables set change_tracking=true;
alter table public.d_pi_project_unavailable_tables add column update_timestamp timestamp_ntz;

--create history table for unavalable tables table
create table public.D_PI_PROJECT_UNAVAILABLE_TABLES_HISTORY (
project_id varchar(255),
project_name varchar(255),  
table_name varchar(255),
end_unavailable_date date,
start_time timestamp_ntz,
end_time timestamp_ntz,
current_flag int);

grant all on table public.d_pi_project_unavailable_tables_history to pi_data_ingest_UAT_alert_user;

--create stream on unavailable tables table
create or replace stream raw.pi_unavailable_tables_stream on table public.d_pi_project_unavailable_tables;


--create view
create or replace view raw.pi_unavailable_tables_change_data as
select project_id, project_name, table_name,end_unavailable_date, start_time, end_time, current_flag, 'I' as dml_type
from (select project_id, project_name, table_name,end_unavailable_date, update_timestamp as start_time,
      lag(update_timestamp) over (partition by project_id,table_name order by update_timestamp desc) as end_time_raw,
      case when end_time_raw is null then 
'9999-12-31'::timestamp_ntz else end_time_raw end as end_time,
      case when end_time_raw is null then 1 else 0 end as current_flag
      from (select project_id, project_name, table_name,end_unavailable_date, update_timestamp
            from pi_unavailable_tables_stream
            where metadata$action = 'INSERT'
            and metadata$isupdate = 'FALSE'))
union
select project_id, project_name, table_name,end_unavailable_date, start_time, end_time, current_flag, dml_type
from (select project_id, project_name, table_name,end_unavailable_date, update_timestamp as start_time,
      lag(update_timestamp) over (partition by project_id,table_name order by update_timestamp desc) as end_time_raw,
      case when end_time_raw is null then 
'9999-12-31'::timestamp_ntz else end_time_raw end as end_time,
      case when end_time_raw is null then 1 else 0 end as current_flag,dml_type
      from (-- Identify data to insert into nation_history table
        select project_id, project_name, table_name,end_unavailable_date, update_timestamp, 'I' as dml_type
        from pi_unavailable_tables_stream
        where metadata$action = 'INSERT'
        and metadata$isupdate = 'TRUE'
union
select project_id, null, table_name, null, start_time, 'U' as dml_type
from public.d_pi_project_unavailable_tables_history
where project_id || table_name in (select distinct (project_id || table_name) 
                             from pi_unavailable_tables_stream
                             where metadata$action = 'INSERT'
                             and metadata$isupdate = 'TRUE')
        and current_flag = 1))
union
select str.project_id, null, str.table_name, null, hist.start_time, current_timestamp()::timestamp_ntz, null, 'D'
from public.d_pi_project_unavailable_tables_history hist
inner join pi_unavailable_tables_stream str
on hist.project_id = str.project_id
and hist.table_name = str.table_name
where str.metadata$action = 'DELETE'
and str.metadata$isupdate = 'FALSE'
and hist.current_flag = 1;

--create sp and task
CREATE or replace PROCEDURE update_unavailable_tables_history ()
  RETURNS VARCHAR
  LANGUAGE javascript
  EXECUTE AS CALLER
  AS
  
  $$
  
var sqlCommand = `merge into public.d_pi_project_unavailable_tables_history nh
using pi_unavailable_tables_change_data m 
   on  nh.project_id = m.project_id
   and nh.table_name = m.table_name 
   and nh.start_time = m.start_time
when matched and m.dml_type = 'U' then update
    set nh.end_time = m.end_time,
        nh.current_flag = 0
when matched and m.dml_type = 'D' then update
    set nh.end_time = m.end_time,
        nh.current_flag = 0
when not matched and m.dml_type = 'I' then insert
           (project_id, project_name, table_name,end_unavailable_date, start_time, end_time, current_flag)
    values (m.project_id, m.project_name,m.table_name, m.end_unavailable_date, m.start_time, m.end_time, m.current_flag);`;

snowflake.execute ({sqlText: sqlCommand});

sqlCommand = `update public.d_pi_project_unavailable_tables_history hist
set hist.end_time = temp.real_end_time
from 
(select project_id,table_name, start_time, end_time ,
    lead (start_time) over (partition by project_id,table_name order by start_time asc) as proposed_end_time,
    case when proposed_end_time is not null and timestampdiff(seconds,end_time, proposed_end_time) <=60 then proposed_end_time else end_time end as real_end_time
from public.d_pi_project_unavailable_tables_history) as temp
where hist.project_id = temp.project_id
and hist.table_name = temp.table_name
and hist.start_time = temp.start_time
and hist.end_time != temp.real_end_time;
--and some time within 1 minute of now`;

snowflake.execute ({sqlText: sqlCommand});

return 0;

$$;


drop task UPDATE_D_PI_UNAVAILABLE_TABLES_HISTORY_DEV;
CREATE TASK UPDATE_D_PI_UNAVAILABLE_TABLES_HISTORY_DEV
  WAREHOUSE = 'PUREINSIGHTS_DEV_LOAD_WH'
  SCHEDULE = '1 minute' when system$stream_has_data('pi_unavailable_tables_stream')
AS
 call update_unavailable_tables_history ();
 
 alter task UPDATE_D_PI_UNAVAILABLE_TABLES_HISTORY_DEV resume;
   

-----------------------------------

--projects history table
alter table public.d_pi_projects set change_tracking=true;
alter table public.d_pi_projects add column update_timestamp timestamp_ntz;

create or replace TABLE D_PI_PROJECTS_HISTORY (
	PROJECTID VARCHAR(255),
	PROJECTNAME VARCHAR(255),
	AWSFOLDERNAME VARCHAR(255),
	PROJECTTIMEZONE VARCHAR(255),
    active boolean,   
    start_time timestamp_ntz,
    end_time timestamp_ntz,
    current_flag int);

 grant all on table public.d_pi_projects_history to pi_data_ingest_UAT_alert_user;

--create stream on tables table

create or replace stream raw.pi_projects_stream on table public.d_pi_projects;


--create view to use when updating history table
create or replace view raw.pi_projects_change_data as
select projectid, projectname, awsfoldername, projecttimezone, active, start_time, end_time, current_flag, 'I' as dml_type
from (select projectid, projectname, awsfoldername, projecttimezone, active, update_timestamp as start_time,
      lag(update_timestamp) over (partition by projectid order by update_timestamp desc) as end_time_raw,
      case when end_time_raw is null then 
'9999-12-31'::timestamp_ntz else end_time_raw end as end_time,
      case when end_time_raw is null then 1 else 0 end as current_flag
      from (select projectid, projectname, awsfoldername, projecttimezone, active, update_timestamp
            from pi_projects_stream
            where metadata$action = 'INSERT'
            and metadata$isupdate = 'FALSE'))
union
select projectid, projectname, awsfoldername, projecttimezone, active, start_time, end_time, current_flag, dml_type
from (select projectid, projectname, awsfoldername, projecttimezone, active, update_timestamp as start_time,
      lag(update_timestamp) over (partition by projectid order by update_timestamp desc) as end_time_raw,
      case when end_time_raw is null then 
'9999-12-31'::timestamp_ntz else end_time_raw end as end_time,
      case when end_time_raw is null then 1 else 0 end as current_flag,dml_type
      from (
        select projectid, projectname, awsfoldername, projecttimezone, active, update_timestamp, 'I' as dml_type
        from pi_projects_stream
        where metadata$action = 'INSERT'
        and metadata$isupdate = 'TRUE'
union
select projectid, null, null, null,null,start_time, 'U' as dml_type
from public.d_pi_projects_history
where projectid in (select distinct projectid 
                             from pi_projects_stream
                             where metadata$action = 'INSERT'
                             and metadata$isupdate = 'TRUE')
        and current_flag = 1))
union
select str.projectid, null, null, null,null,hist.start_time, current_timestamp()::timestamp_ntz, null, 'D'
from public.d_pi_projects_history hist
inner join pi_projects_stream str
on hist.projectid = str.projectid
where str.metadata$action = 'DELETE'
and str.metadata$isupdate = 'FALSE'
and hist.current_flag = 1;



--create sp and task
CREATE or replace PROCEDURE update_projects_history ()
  RETURNS VARCHAR
  LANGUAGE javascript
  EXECUTE AS CALLER
  AS
  
  $$
  
var sqlCommand = `merge into public.d_pi_projects_history nh 
using pi_projects_change_data m 
   on  nh.projectid = m.projectid
   and nh.start_time = m.start_time
when matched and m.dml_type = 'U' then update
    set nh.end_time = m.end_time,
        nh.current_flag = 0
when matched and m.dml_type = 'D' then update 
    set nh.end_time = m.end_time,
        nh.current_flag = 0
when not matched and m.dml_type = 'I' then insert
           (projectid, projectname, awsfoldername, projecttimezone, active, start_time, end_time, current_flag)
    values (m.projectid, m.projectname, m.awsfoldername, m.projecttimezone, m.active, m.start_time, m.end_time, m.current_flag);`;

snowflake.execute ({sqlText: sqlCommand});

sqlCommand = `update public.d_pi_projects_history hist
set hist.end_time = temp.real_end_time
from 
(select projectid, start_time, end_time ,
    lead (start_time) over (partition by projectid order by start_time asc) as proposed_end_time,
    case when proposed_end_time is not null and timestampdiff(seconds,end_time, proposed_end_time) <=60 then proposed_end_time else end_time end as real_end_time
from public.d_pi_projects_history) as temp
where hist.projectid = temp.projectid
and hist.start_time = temp.start_time
and hist.end_time != temp.real_end_time;
--and some time within 1 minute of now`;

snowflake.execute ({sqlText: sqlCommand});

return 0;

$$;

call update_projects_history();


drop task UPDATE_D_PI_PROJECTS_HISTORY_DEV;
CREATE TASK UPDATE_D_PI_PROJECTS_HISTORY_DEV
  WAREHOUSE = 'PUREINSIGHTS_DEV_LOAD_WH'
  SCHEDULE = '1 minute' when system$stream_has_data('pi_projects_stream')
AS
 call update_projects_history ();
 
 alter task UPDATE_D_PI_PROJECTS_HISTORY_DEV resume;
 


select * from public.d_pi_projects;
select * from public.d_pi_projects_history;

truncate public.d_pi_projects_history;
insert into public.d_pi_projects_history
 select projectid, projectname, awsfoldername, projecttimezone, active, to_timestamp('2021-05-15'), to_timestamp('9999-12-31 00:00:00.000'),1
  from public.d_pi_projects;
  
  select * from public.d_pi_tables;
  select * from public.d_pi_tables_history;
  
truncate public.d_pi_tables_history;  
insert into public.d_pi_tables
 select table_name, s3_sourced,active,  to_timestamp('2021-05-15'), to_timestamp('9999-12-31 00:00:00.000'),1
  from public.d_pi_tables;
  
  select * from public.d_pi_project_unavailable_tables;
  select * from public.d_pi_project_unavailable_tables_history;
  
  truncate public.d_pi_project_unavailable_tables_history;
  insert into public.d_pi_projec_unavailable_tables_history
   select project_id, project_name, table_name, end_unavailable_date, to_timestamp('2021-05-15'), to_timestamp('9999-12-31 00:00:00.000'),1
    from public.d_pi_project_unavailable_tables; 
  
  
  
    

