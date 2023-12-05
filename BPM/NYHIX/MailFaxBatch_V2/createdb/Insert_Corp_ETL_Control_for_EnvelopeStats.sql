-------------------------------------------------------------------
-- Insert corp_etl_control rows for EnveloprStats run 
INSERT INTO maxdat.corp_etl_control (
name,
value_type,
value,
description
) VALUES (
'MFB_V2_ENVELOPESTATS_RUN_FLAG',
'V',
'Y',
'Signal to run EnvelopeStats'
);

insert into maxdat.corp_etl_control (
name,
value_type,
value,
description
) values (
'MFB_V2_ENVELOPESTATS_LAST_UPDATE_DATE',
'D',
'01/01/2023 00:00:00',
'Last insertts for ENVELOPESTATS FORMAT MM/DD/YYYY hh24/mi/ss'
);

commit;
