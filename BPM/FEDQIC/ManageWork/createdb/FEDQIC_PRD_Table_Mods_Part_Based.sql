--allow part to be stored in business unit id
alter table maxdat.corp_etl_mw modify business_unit_id number null;
alter table maxdat.corp_etl_mw_wip modify business_unit_id number null;
alter table maxdat.d_mw_task_instance modify curr_business_unit_id number;
alter table "MAXDAT"."D_MW_TASK_HISTORY" disable  constraint "DMWBD_DMW_BUS_UNIT_ID_FK";
alter table maxdat.d_mw_task_history modify business_unit_id number;
alter table "MAXDAT"."D_MW_TASK_HISTORY" enable  constraint "DMWBD_DMW_BUS_UNIT_ID_FK";
--add appeal part id column to fedqic_maxdat_stg;
alter table maxdat.fedqic_maxdat_stg add part_id number;
--expand size of c_status column in fedqic_maxdat_stg so that it can accomodate part based combo id
alter table maxdat.fedqic_maxdat_stg modify c_status number;