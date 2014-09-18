alter table D_MFDOC_CURRENT drop column "Stage Done Date";

alter table D_MFDOC_CURRENT add "Cancel By" varchar2(50);
alter table D_MFDOC_CURRENT add "Cancel Reason" varchar2(256);
alter table D_MFDOC_CURRENT add "Cancel Method" varchar2(50);

