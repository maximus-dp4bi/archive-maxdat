update cc_d_agent set site_name ='Chicago-CES' where site_name ='Chicago - CES';
update cc_d_agent set site_name ='Chicago-EEV' where site_name ='Chicago - EEV';
update cc_d_agent set site_name ='Chicago-MI' where site_name ='Chicago - MI';            
            
update cc_d_agent a set a.site_name='Chicago-CES' where a.login_id in (            
with eff as(
select login_id,site_name from (
select  d_agent_id, login_id,site_name, 
rank() over (partition by login_id order by record_eff_dt desc)rnk
from cc_d_agent)
where rnk=1 and site_name='Chicago-CES')
select a.login_id from cc_d_agent a
inner join eff  on eff.login_id =a.login_id);

update cc_d_agent a set a.site_name='Chicago-EEV' where a.login_id in (            
with eff as(
select login_id,site_name from (
select  d_agent_id, login_id,site_name, 
rank() over (partition by login_id order by record_eff_dt desc)rnk
from cc_d_agent)
where rnk=1 and site_name='Chicago-EEV')
select a.login_id from cc_d_agent a
inner join eff  on eff.login_id =a.login_id);

update cc_d_agent a set a.site_name='Chicago-MI' where a.login_id in (            
with eff as(
select login_id,site_name from (
select  d_agent_id, login_id,site_name, 
rank() over (partition by login_id order by record_eff_dt desc)rnk
from cc_d_agent)
where rnk=1 and site_name='Chicago-MI')
select a.login_id from cc_d_agent a
inner join eff  on eff.login_id =a.login_id);

update cc_f_agent_by_date set d_site_id=(select d_site_id from cc_d_site where site_name ='Chicago-EEV')
where d_agent_id in (select d_agent_id from 
cc_d_agent where login_id in ('76498','76500','76501','76502','76503','76504','76505','76506'));

commit;