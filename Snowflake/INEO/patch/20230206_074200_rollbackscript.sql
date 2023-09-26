update file_load_lkup
set load_file = 'N'
where filename_prefix IN('REGIONALSTAFFROSTER',
'WMST_TASKCOMPLETIONTIMELINESSREPORTDAILY');
