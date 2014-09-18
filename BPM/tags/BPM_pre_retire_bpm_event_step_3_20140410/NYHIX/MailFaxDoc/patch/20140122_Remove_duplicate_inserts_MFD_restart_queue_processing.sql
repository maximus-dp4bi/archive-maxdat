--Remove duplicates

declare 
cursor s1 is select identifier 
             from BPM_INSTANCE where bsl_id = 18;
begin
  for c1 in s1 
   loop
    delete from BPM_UPDATE_EVENT_QUEUE 
    where identifier = c1.identifier and BSL_ID = 18 and OLD_DATA is NULL;
    commit;
   end loop;
end;
/

--Reset queue rows
execute MAXDAT_ADMIN.RESET_BPM_QUEUE_ROWS_BY_BSL_ID(18);

--Enable processing
execute MAXDAT_ADMIN.CONFIG_QUEUE_JOB(18,1,'ENABLED','Y');
execute MAXDAT_ADMIN.CONFIG_QUEUE_JOB(18,2,'ENABLED','Y');
