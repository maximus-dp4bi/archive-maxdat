select count(*) as Number_of_Nulls  from D_MFB_CURRENT 
where reprocessed_flag is null;

update d_mfb_current
set reprocessed_flag = 'N' 
where reprocessed_flag is null;

select count(*) as Number_of_Nulls  from D_MFB_CURRENT 
where reprocessed_flag is null;
