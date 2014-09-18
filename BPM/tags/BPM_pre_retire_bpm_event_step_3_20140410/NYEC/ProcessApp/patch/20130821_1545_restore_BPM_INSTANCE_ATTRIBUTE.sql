declare
  type BIA_TAB is table of BPM_INSTANCE_ATTRIBUTE%rowtype
  index by binary_integer;

  V_BIA_TAB BIA_TAB;
  V_BA_ID  BPM_INSTANCE_ATTRIBUTE.BA_ID%type;
  V_CNT    INTEGER := 0;
  V_BA_CNT INTEGER;

  cursor CRS_BA_RECORDS is
  select * from BPM_INSTANCE_ATTR_TEMP;

begin
    open CRS_BA_RECORDS;
    loop
      fetch CRS_BA_RECORDS
      bulk collect into V_BIA_TAB;
      exit when CRS_BA_RECORDS%notfound;
    end loop;
    close CRS_BA_RECORDS;
    --
    if V_BIA_TAB.count > 0
    then
      for I in V_BIA_TAB.first..V_BIA_TAB.Last
      loop
        V_BA_CNT := V_BA_CNT + 1;
        V_CNT := V_CNT + 1;
        insert into BPM_INSTANCE_ATTRIBUTE values V_BIA_TAB(I);
        --
        if V_CNT = 1000
        then V_CNT := 0;
             commit;
        end if;
      end loop;
      dbms_output.put_line('Inserted recs: '|| V_BA_CNT);
    end if;
  --
  commit;
end;
/
