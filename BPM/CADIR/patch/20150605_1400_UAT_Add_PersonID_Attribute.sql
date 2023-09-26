alter table corp_etl_manage_work_tmp drop column updated;
alter table corp_etl_manage_work_tmp drop column person_id;
alter table corp_etl_manage_work_tmp add person_id number;
alter table corp_etl_manage_work_tmp add updated varchar2(1);
