

create or replace view D_PROCESS_FLOW as
select
  bace.BACE_ID ACTIVITY_ID,
  bacl.ACTIVITY_NAME,
  bactl.ACTIVITY_TYPE_DESC ACTIVITY_TYPE,
  baca.FLOW_ORDER ACTIVITY_FLOW_ORDER,
  baca.BEM_ID,
  bem.NAME PROCESS_NAME
from BPM_ACTIVITY_EVENTS bace
inner join BPM_ACTIVITY_ATTRIBUTE baca on (bace.BACA_ID = baca.BACA_ID)
inner join BPM_EVENT_MASTER bem on (baca.BEM_ID = bem.BEM_ID)
inner join BPM_ACTIVITY_LKUP bacl on (baca.BACL_ID = bacl.BACL_ID)
inner join BPM_ACTIVITY_TYPE_LKUP bactl on (bacl.BACTL_ID = bactl.BACTL_ID);

create or replace view F_INSTANCE_ACTIVITIES as
select
  bace.BI_ID,
  bi.BEM_ID,
  bace.BACE_ID ACTIVITY_ID,
  case 
    when bactl.ACTIVITY_TYPE_CD != 'G' then null
    else bia.VALUE_DATE
    end ACTIVITY_START_DATE,
  case 
    when bactl.ACTIVITY_TYPE_CD != 'G' then null
    else bia.VALUE_DATE
    end ACTIVITY_END_DATE,
  bal.NAME ACTIVITY_ATTRIBUTE_NAME,
  case
    when bal.BDL_ID = 1 then to_char(bia.VALUE_NUMBER)
    when bal.BDL_ID = 3 then to_char('YYYY-MM-DD HH24:MI:SS',bia.VALUE_DATE)
    else bia.VALUE_CHAR
    end ACTIVITY_ATTRIBUTE_VALUE,
  '1' INSTANCE_ACTIVITY_COUNT
from BPM_ACTIVITY_EVENTS bace
inner join BPM_INSTANCE bi on (bace.BI_ID = bi.BI_ID)
inner join BPM_ACTIVITY_ATTRIBUTE baca on (bace.BACA_ID = baca.BACA_ID)
inner join BPM_ACTIVITY_LKUP bacl on (baca.BACL_ID = bacl.BACL_ID)
inner join BPM_ACTIVITY_TYPE_LKUP bactl on (bacl.BACTL_ID = bactl.BACTL_ID)
inner join BPM_INSTANCE_ATTRIBUTE bia on (bi.BI_ID = bia.BI_ID)
inner join BPM_ATTRIBUTE ba on (bia.BA_ID = ba.BA_ID)
inner join BPM_ATTRIBUTE_LKUP bal on (ba.BAL_ID = bal.BAL_ID);



