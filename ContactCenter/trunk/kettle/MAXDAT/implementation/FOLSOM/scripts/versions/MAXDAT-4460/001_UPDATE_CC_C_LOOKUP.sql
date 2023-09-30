update cc_c_lookup
set lookup_value = 'CALLS_ABANDONED_PERIOD_1'
where lookup_type = 'ACD_ABDDELAY_PERIOD'
and lookup_key in
(
'ABDDELAY12'
,'ABDDELAY14'
,'ABDDELAY16'
,'ABDDELAY18'
,'ABDDELAY20'
)
and lookup_value = 'CALLS_ABANDONED_PERIOD_2';

commit;