--UAT
delete from cc_f_agent_by_date
where f_agent_by_date_id in
(
  91051
 ,90922
 ,90923
 ,90924
);

commit;


--PRD
delete from cc_f_agent_by_date
where f_agent_by_date_id in
(
 98107
,97977
,97978
,97979
);

commit;

