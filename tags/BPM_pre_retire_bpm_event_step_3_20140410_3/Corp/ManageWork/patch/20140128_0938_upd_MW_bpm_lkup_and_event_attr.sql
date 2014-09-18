/* MW Staff update to include space between first and last name
1. Update staff dimensional lookup
2. Remove event queues for MW
3. Update instance attributes
*/

-- Where clause to ensure multiple script runs will not continue to concatenate additional space(s)
update D_MW_OWNER set "Owner Name" = replace("Owner Name",',', ', ')
 where instr("Owner Name",', ') = 0;

update D_MW_LAST_UPDATE_BY_NAME set "Last Update By Name" = replace("Last Update By Name",',',', ')
 where instr("Last Update By Name",', ') = 0;

update D_MW_ESCALATED set "Escalated To Name" = replace("Escalated To Name",',',', ')
 where instr("Escalated To Name",', ') = 0;

update D_MW_FORWARDED set "Forwarded By Name" = replace("Forwarded By Name",',',', ')
 where instr("Forwarded By Name",', ') = 0;

commit;

create table BPM_INSTANCE_ATTR_TMP as
select BIA.BIA_ID from BPM_INSTANCE_ATTRIBUTE BIA, BPM_ATTRIBUTE BA, BPM_ATTRIBUTE_LKUP BAL
 where BIA.BA_ID = BA.BA_ID and BA.BAL_ID = BAL.BAL_ID
   and BA.BEM_ID = 1
   and BAL.BAL_ID in (8,10,11,15,17,19,34)
   and instr(VALUE_CHAR,', ') = 0;

-- Event attr details
declare
  V_CNT INTEGER := 0;
begin
  for Q in (select * from BPM_INSTANCE_ATTR_TMP)
  loop
    update BPM_INSTANCE_ATTRIBUTE BIA
       set VALUE_CHAR = replace(BIA.VALUE_CHAR,',', ', ')
     where BIA.BIA_ID = Q.BIA_ID;
    --
    if V_CNT = 10000
    then commit; V_CNT := 0;
    else V_CNT := V_CNT + 1;
    end if;
  end loop;
  commit;
end;
/
drop table BPM_INSTANCE_ATTR_TMP;
