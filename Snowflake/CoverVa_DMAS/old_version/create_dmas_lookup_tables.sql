--table already created by streamsets load
alter table COVERVA_DMAS.COVERVA_HOLIDAYS add primary key (date);
alter table COVERVA_DMAS.CP_CHANNEL_TO_SOURCE_LKUP add primary key (source,cp_channel);
alter table COVERVA_DMAS.CP_TYPE_LKUP add primary key (type,cp_type);
alter table COVERVA_DMAS.CP_STATUS_LKUP add primary key (status,cp_status);