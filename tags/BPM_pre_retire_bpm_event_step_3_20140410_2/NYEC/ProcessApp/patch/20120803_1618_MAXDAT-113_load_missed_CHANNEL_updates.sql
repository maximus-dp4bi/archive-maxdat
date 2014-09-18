-- Patch for MAXDAT-113
 
update 
  (select 
     bia.BIA_ID,
     bia.VALUE_CHAR,
     nepa.CHANNEL
   from 
     NYEC_ETL_PROCESS_APP nepa,
     BPM_INSTANCE bi,
     BPM_INSTANCE_ATTRIBUTE bia
   where 
     nepa.APP_ID = bi.IDENTIFIER
     and bi.BI_ID = bia.BI_ID 
     and bia.BA_ID = 49
     and bia.END_DATE = to_date('2077-07-07','YYYY-MM-DD')
     and 
       ((bia.VALUE_CHAR is null and nepa.CHANNEL is not null) 
         or bia.VALUE_CHAR != nepa.CHANNEL))
set VALUE_CHAR = CHANNEL;
     
select count(*) from ( 
select 
     bia.BIA_ID,
     bia.VALUE_CHAR,
     nepa.CHANNEL
   from 
     NYEC_ETL_PROCESS_APP nepa,
     BPM_INSTANCE bi,
     BPM_INSTANCE_ATTRIBUTE bia
   where 
     nepa.APP_ID = bi.IDENTIFIER
     and bi.BI_ID = bia.BI_ID 
     and bia.BA_ID = 49
     and bia.END_DATE = to_date('2077-07-07','YYYY-MM-DD')
     and 
       ((bia.VALUE_CHAR is null and nepa.CHANNEL is not null) 
         or bia.VALUE_CHAR != nepa.CHANNEL));