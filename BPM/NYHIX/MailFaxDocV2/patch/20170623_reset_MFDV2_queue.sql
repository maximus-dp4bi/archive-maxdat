execute MAXDAT_ADMIN.SHUTDOWN_JOBS;
/

begin FOR cur IN (SELECT OBJECT_NAME, OBJECT_TYPE, owner FROM all_objects WHERE object_type in ('PACKAGE','PACKAGE BODY') and owner = :OBJECT_OWNER AND status = 'INVALID' ) LOOP 
BEGIN
  if cur.OBJECT_TYPE = 'PACKAGE BODY' then 
    EXECUTE IMMEDIATE 'alter package "' || cur.owner || '"."' || cur.OBJECT_NAME || '" compile body'; 
  else 
    EXECUTE IMMEDIATE 'alter ' || cur.OBJECT_TYPE || ' "' || cur.owner || '"."' || cur.OBJECT_NAME || '" compile'; 
  end if; 
EXCEPTION
  WHEN OTHERS THEN NULL; 
END;
end loop; end;
/
execute MAXDAT_ADMIN.RESET_BPM_QUEUE_ROWS_BY_BSL_ID(24);

execute MAXDAT_ADMIN.STARTUP_JOBS;

