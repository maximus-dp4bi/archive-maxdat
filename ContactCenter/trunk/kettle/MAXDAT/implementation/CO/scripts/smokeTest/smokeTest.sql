/* smoke test for Illinois project */

-- test of EEV skillset program lookups
select 'Test 1:  EEV skillset program lookups = 6' as test_number,
  case
    when (select count(*)
      from cc_c_lookup
      where lookup_type = 'ACD_SKILLSET_PROGRAM'
        and lookup_value = 'EEV'
      group by lookup_type) = 6 THEN 'PASS'
    else 'FAIL'
  end result
from dual;


-- test of EB skillset program lookups
select 'Test 2: EB skillset program lookups = 20' as test_number,
  case
    when (select count(*)
      from cc_c_lookup
      where lookup_type = 'ACD_SKILLSET_PROGRAM'
        and lookup_value = 'EB'
      group by lookup_type) = 20 THEN 'PASS'
    else 'FAIL'
  end result
from dual;

-- test of EEV skillset project lookups
select 'Test 3:  EEV skillset project lookups = 6' as test_number,
  case
    when (select count(*)
      from cc_c_lookup
      where lookup_type = 'ACD_SKILLSET_PROJECT'
        and lookup_value = 'IL EEV'
      group by lookup_type) = 6 THEN 'PASS'
    else 'FAIL'
  end result
from dual;

-- test of EB skillset project lookups
select 'Test 4:  EB skillset project lookups = 20' as test_number,
  case
    when (select count(*)
      from cc_c_lookup
      where lookup_type = 'ACD_SKILLSET_PROJECT'
        and lookup_value = 'IL EB'
      group by lookup_type) = 20 THEN 'PASS'
    else 'FAIL'
  end result
from dual;

-- test of WFM group program lookups
select 'Test 5:  WFM group program lookups = 2' as test_number,
  case
    when (select count(*)
      from cc_c_lookup
      where lookup_type = 'WFM_GROUP_PROGRAM'
      group by lookup_type) = 2 THEN 'PASS'
    else 'FAIL'
  end result
from dual;

-- test of WFM group project lookups
select 'Test 6:  WFM group project lookups = 2' as test_number,
  case
    when (select count(*)
      from cc_c_lookup
      where lookup_type = 'WFM_GROUP_PROJECT'
      group by lookup_type) = 2 THEN 'PASS'
    else 'FAIL'
  end result
from dual;

-- test of queue filters
select 'Test 7:  queue filters = 26' as test_number,
  case
    when (select count(*)
      from cc_c_filter
      where filter_type = 'ACD_APPLICATION_ID_INC'
      group by filter_type) = 26 THEN 'PASS'
    else 'FAIL'
  end result
from dual;

-- test of skill group filters
select 'Test 8:  skill group filters = 26' as testNumber,
  case
    when (select count(*)
      from cc_c_filter
      where filter_type = 'ACD_SKILL_GROUP_INC'
      group by filter_type) = 26 THEN 'PASS'
    else 'FAIL'
  end result
from dual;

-- test of staff group filters
select 'Test 9:  staff group filters = 2' as testNumber,
  case
    when (select count(*)
      from cc_c_filter
      where filter_type = 'WFM_STAFF_GROUP_INC'
      group by filter_type) = 2 THEN 'PASS'
    else 'FAIL'
  end result
from dual;