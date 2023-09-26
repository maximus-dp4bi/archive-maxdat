update file_load_lkup
set load_file = 'N'
where filename_prefix IN('AGENTPERFORMANCE',
'RCCIEDSSTASKINVENTORY',
'INEOQUEUEDAILYSUMMARY',
'INEOQUEUESUMMARY');
