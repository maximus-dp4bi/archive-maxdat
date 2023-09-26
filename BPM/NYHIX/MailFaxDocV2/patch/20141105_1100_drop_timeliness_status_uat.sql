Alter table D_NYHIX_MFD_HISTORY_V2 add DNMFDDT_ID number(18,0);

alter table D_NYHIX_MFD_HISTORY_V2 drop (DNMFDTS_ID);

/*
--Remove attributes
alter table D_NYHIX_MFD_HISTORY_V2 drop (DNMFDTS_ID, AGE_IN_BUSINESS_DAYS, AGE_IN_CALENDAR_DAYS);
*/