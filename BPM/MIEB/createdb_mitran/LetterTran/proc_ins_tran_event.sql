create or replace procedure ins_tran_event(
p_event_date date
, p_event_name varchar2
, p_tablename varchar2
, p_tableid number
, det1 varchar2 default null
, val1 varchar2 default null
, det2 varchar2 default null
, val2 varchar2 default null
, det3 varchar2 default null
, val3 varchar2 default null
) as
begin
if det1 is null then
  insert into d_tran_Events(event_date, event_name, tran_ref_table, tran_ref_pkid) values (p_event_date,   p_event_name, p_tablename, p_tableid);
else
  insert into d_tran_Events(event_date, event_name, tran_ref_table, tran_ref_pkid
  , detail1_name
  , detail2_name
  , detail3_name
  , detail1_value
  , detail2_value
  , detail3_value
  ) values
  (p_event_date,   p_event_name, p_tablename, p_tableid
  , det1
  , val1
  , det2
  , val2
  , det3
  , val3);
end if;

exception when others then
  null;
end;
/
