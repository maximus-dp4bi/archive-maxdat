

update cc_d_agent a set a.site_name='11CW FL-6  Z-1' where a.login_id in (            
with eff as(
select login_id,site_name from (
select  d_agent_id, login_id,site_name, 
rank() over (partition by login_id order by record_eff_dt desc)rnk
from cc_d_agent)
where rnk=1 and site_name='11CW FL-6  Z-1')
select a.login_id from cc_d_agent a
inner join eff  on eff.login_id =a.login_id);

update cc_d_agent a set a.site_name='11CW FL-6  Z-2' where a.login_id in (            
with eff as(
select login_id,site_name from (
select  d_agent_id, login_id,site_name, 
rank() over (partition by login_id order by record_eff_dt desc)rnk
from cc_d_agent)
where rnk=1 and site_name='11CW FL-6  Z-2')
select a.login_id from cc_d_agent a
inner join eff  on eff.login_id =a.login_id);

update cc_d_agent a set a.site_name='11CW FL-6  Z-3' where a.login_id in (            
with eff as(
select login_id,site_name from (
select  d_agent_id, login_id,site_name, 
rank() over (partition by login_id order by record_eff_dt desc)rnk
from cc_d_agent)
where rnk=1 and site_name='11CW FL-6  Z-3')
select a.login_id from cc_d_agent a
inner join eff  on eff.login_id =a.login_id);


update cc_d_agent a set a.site_name='22CW FL-2  Z-1' where a.login_id in (            
with eff as(
select login_id,site_name from (
select  d_agent_id, login_id,site_name, 
rank() over (partition by login_id order by record_eff_dt desc)rnk
from cc_d_agent)
where rnk=1 and site_name='22CW FL-2  Z-1')
select a.login_id from cc_d_agent a
inner join eff  on eff.login_id =a.login_id);

update cc_d_agent a set a.site_name='22CW FL-2  Z-2' where a.login_id in (            
with eff as(
select login_id,site_name from (
select  d_agent_id, login_id,site_name, 
rank() over (partition by login_id order by record_eff_dt desc)rnk
from cc_d_agent)
where rnk=1 and site_name='22CW FL-2  Z-2')
select a.login_id from cc_d_agent a
inner join eff  on eff.login_id =a.login_id);

update cc_d_agent a set a.site_name='22CW FL-4  Z-1' where a.login_id in (            
with eff as(
select login_id,site_name from (
select  d_agent_id, login_id,site_name, 
rank() over (partition by login_id order by record_eff_dt desc)rnk
from cc_d_agent)
where rnk=1 and site_name='22CW FL-4  Z-1')
select a.login_id from cc_d_agent a
inner join eff  on eff.login_id =a.login_id);


update cc_d_agent a set a.site_name='22CW FL-4  Z-2' where a.login_id in (            
with eff as(
select login_id,site_name from (
select  d_agent_id, login_id,site_name, 
rank() over (partition by login_id order by record_eff_dt desc)rnk
from cc_d_agent)
where rnk=1 and site_name='22CW FL-4  Z-2')
select a.login_id from cc_d_agent a
inner join eff  on eff.login_id =a.login_id);

update cc_d_agent a set a.site_name='30 Broad' where a.login_id in (            
with eff as(
select login_id,site_name from (
select  d_agent_id, login_id,site_name, 
rank() over (partition by login_id order by record_eff_dt desc)rnk
from cc_d_agent)
where rnk=1 and site_name='30 Broad')
select a.login_id from cc_d_agent a
inner join eff  on eff.login_id =a.login_id);


update cc_d_agent a set a.site_name='NYC FL-16' where a.login_id in (            
with eff as(
select login_id,site_name from (
select  d_agent_id, login_id,site_name, 
rank() over (partition by login_id order by record_eff_dt desc)rnk
from cc_d_agent)
where rnk=1 and site_name='NYC FL-16')
select a.login_id from cc_d_agent a
inner join eff  on eff.login_id =a.login_id);

update cc_d_agent a set a.site_name='NYC FL-17' where a.login_id in (            
with eff as(
select login_id,site_name from (
select  d_agent_id, login_id,site_name, 
rank() over (partition by login_id order by record_eff_dt desc)rnk
from cc_d_agent)
where rnk=1 and site_name='NYC FL-17')
select a.login_id from cc_d_agent a
inner join eff  on eff.login_id =a.login_id);

update cc_d_agent a set a.site_name='NYC FL-5' where a.login_id in (            
with eff as(
select login_id,site_name from (
select  d_agent_id, login_id,site_name, 
rank() over (partition by login_id order by record_eff_dt desc)rnk
from cc_d_agent)
where rnk=1 and site_name='NYC FL-5')
select a.login_id from cc_d_agent a
inner join eff  on eff.login_id =a.login_id);


update cc_f_agent_by_date set d_site_id=(select d_site_id from cc_d_site where site_name ='22CW FL-2  Z-2')
where d_agent_id in (select d_agent_id from 
cc_d_agent where login_id in ('75671'));

commit;
