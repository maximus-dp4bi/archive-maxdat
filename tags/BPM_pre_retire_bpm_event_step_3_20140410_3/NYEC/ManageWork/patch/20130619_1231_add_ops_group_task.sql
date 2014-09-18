declare
  V_GROUP  BPM_D_OPS_GROUP_TASK.OPS_GROUP%type;
  V_TASK   BPM_D_OPS_GROUP_TASK.TASK_TYPE%type;
begin
  for I in 1..28 loop
    case I
    when 1 then V_GROUP := 'PAP State Data Entry'; V_TASK := 'PAP Analysis';
    when 2 then V_GROUP := 'PAP State Data Entry'; V_TASK := 'PAP Analysis-Undeliverable';
    when 3 then V_GROUP := 'PAP State Data Entry'; V_TASK := 'PAP Reactivation';
    when 4 then V_GROUP := 'PAP QC'; V_TASK := 'QC-PAP';
    when 5 then V_GROUP := 'PAP QC'; V_TASK := 'QC-PAP MI';
    when 6 then V_GROUP := 'PAP QC'; V_TASK := 'Data Correction-PAP';
    when 7 then V_GROUP := 'PAP Research'; V_TASK := 'PAP Luberto LDSS Notification';
    when 8 then V_GROUP := 'PAP Research'; V_TASK := 'PAP Out of State Notification';
    when 9 then V_GROUP := 'PAP Research'; V_TASK := 'PAP Courtesy Letter';
    when 10 then V_GROUP := 'PAP Research'; V_TASK := 'PAP Other Notifications';
    when 11 then V_GROUP := 'PAP Research'; V_TASK := 'Application Problem Resolution-PAP';
    when 12 then V_GROUP := 'PAP Research'; V_TASK := 'Application Problem Resolution-PAP Referral';
    when 13 then V_GROUP := 'PAP Research'; V_TASK := 'Application Problem Resolution-PAP Other';
    when 14 then V_GROUP := 'PAP Research'; V_TASK := 'Application Problem Resolution-PAP Reactivated in Error';
    when 15 then V_GROUP := 'PAP Research'; V_TASK := 'Document Problem Resolution-PAP';
    when 16 then V_GROUP := 'PAP Research'; V_TASK := 'Document Problem Resolution-PAP Referral';
    when 17 then V_GROUP := 'PAP Research'; V_TASK := 'Document Problem Resolution-PAP Other';
    when 18 then V_GROUP := 'PAP State Review'; V_TASK := 'PAP Address Update';
    when 19 then V_GROUP := 'PAP State Review'; V_TASK := 'State Review-PAP TPHI';
    when 20 then V_GROUP := 'PAP State Review'; V_TASK := 'State Review-PAP FHP Discontinuance';
    when 21 then V_GROUP := 'PAP State Review'; V_TASK := 'State Review-PAP WMS Enrollment';
    when 22 then V_GROUP := 'PAP State Review'; V_TASK := 'State Review-PAP HIPP Authorize';
    when 23 then V_GROUP := 'PAP State Review'; V_TASK := 'State Review-PAP No TPHI';
    when 24 then V_GROUP := 'PAP State Review'; V_TASK := 'State Review-PAP MI Reprocess';
    when 25 then V_GROUP := 'PAP State Review'; V_TASK := 'State Review-PAP Reactivation';
    when 26 then V_GROUP := 'PAP State Review'; V_TASK := 'State Review-PAP No Response';
    when 27 then V_GROUP := 'PAP State Review'; V_TASK := 'State Review-PAP Discontinuance';
    when 28 then V_GROUP := 'PAP State Review'; V_TASK := 'State Review-PAP Undeliverable';
    else null;
    end case;
    --
    update BPM_D_OPS_GROUP_TASK
       set OPS_GROUP = V_GROUP
     where TASK_TYPE = V_TASK;
    if sql%rowcount = 0
    then insert into BPM_D_OPS_GROUP_TASK (OPS_GROUP,TASK_TYPE) values (V_GROUP,V_TASK);
    end if;
  end loop;
  commit;
end;
/
    