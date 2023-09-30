
delete from corp_etl_manage_work
where create_date < to_date('08/26/2013','mm/dd/yyyy'); 

delete from bpm_instance_attribute
where bi_id in (select bi_id from bpm_instance
where start_date < to_date('08/26/2013','mm/dd/yyyy'));

delete from bpm_update_event
where bi_id in (select bi_id from bpm_instance
where start_date < to_date('08/26/2013','mm/dd/yyyy'));

delete from bpm_instance
where start_date < to_date('08/26/2013','mm/dd/yyyy'); 


delete from f_mw_by_date
where mw_bi_id in (select mw_bi_id from d_mw_current
where "Create Date" < to_date('08/26/2013','mm/dd/yyyy'));

alter table F_MW_BY_DATE drop constraint FMWBD_DMWCUR_FK;

delete from d_mw_current
where "Create Date" < to_date('08/26/2013','mm/dd/yyyy');

alter table F_MW_BY_DATE add constraint FMWBD_DMWCUR_FK foreign key (MW_BI_ID) references D_MW_CURRENT (MW_BI_ID);

commit;