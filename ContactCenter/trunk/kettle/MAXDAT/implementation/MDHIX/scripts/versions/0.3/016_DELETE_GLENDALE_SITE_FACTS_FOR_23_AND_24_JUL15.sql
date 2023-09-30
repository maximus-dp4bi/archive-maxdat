delete from cc_f_agent_activity_by_date
where f_agent_activity_by_date_id in
(
select f_agent_activity_by_date_id
from maxdat_md.cc_f_agent_activity_by_date f
inner join maxdat_md.cc_d_dates d on f.d_date_id = d.d_date_id
inner join maxdat_md.cc_d_site s on f.d_site_id = s.d_site_id
where s.site_name = 'MD-HIX Glendale'
and d.d_date between '23-jul-2015' and '24-jul-2015'
);

delete from cc_f_agent_by_date
where f_agent_by_date_id in
(
select f_agent_by_date_id
from maxdat_md.cc_f_agent_by_date f2
inner join maxdat_md.cc_d_dates d on f2.d_date_id = d.d_date_id
inner join maxdat_md.cc_d_site s on f2.d_site_id = s.d_site_id
where s.site_name = 'MD-HIX Glendale'
and d.d_date between '23-jul-2015' and '24-jul-2015'
); 

commit;