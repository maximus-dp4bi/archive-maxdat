alter session set current_schema = MAXDAT;

update cc_c_activity_type
set activity_type_category = 'Other Not Ready'
, is_paid_flag = 1
where activity_type_name in 
(
   'QC - HSDE'
  ,'DSRIP Opt Out Survey'
  ,'QC - SWCC'
  ,'QC - Research'
  ,'QC - VDoc'
  ,'QC - Individual Marketplace'
  ,'QC - ARU Call'
  ,'QC - Link Doc Set'
  ,'QC - Link Doc Set QC'
  ,'QC - SBM'
  ,'QC - HSDE QC'
  ,'QC - Mailroom'
  ,'QC - ARU Task'
); 



update cc_d_activity_type
set activity_type_category = 'Other Not Ready'
, is_paid_flag = 1
where activity_type_name in 
(
  'QC - HSDE'
 ,'DSRIP Opt Out Survey'
 ,'QC - SWCC'
 ,'QC - Research'
 ,'QC - VDoc'
 ,'QC - Individual Marketplace'
 ,'QC - ARU Call'
 ,'QC - Link Doc Set'
 ,'QC - Link Doc Set QC'
 ,'QC - SBM'
 ,'QC - HSDE QC'
 ,'QC - Mailroom'
 ,'QC - ARU Task'
); 



 commit;