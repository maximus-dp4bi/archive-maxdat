UPDATE cviu_daily_release_full_load c
SET filename = x.new_filename
FROM(
SELECT r.filename,concat(SUBSTR(filename_prefix,1,5),Initcap(substr(filename_prefix,6)),'_',to_number(to_char(cast(file_date as date)-1,'yyyymmdd'))) new_filename,count(*) tbl_count,f.row_count
FROM cviu_daily_release_full_load r
 JOIN dmas_file_log f ON UPPER(r.filename) = UPPER(f.filename)
WHERE filename_prefix = 'CVIU_DAILY_RELEASE'
AND file_date >= cast('05/04/2023' as date)
GROUP BY r.filename,f.row_count,f.filename_prefix,f.file_date) x WHERE c.filename = r.filename;
 

UPDATE dmas_file_log
SET file_date = cast(file_date as date) - 1,
  filename = concat(filename_prefix,'_',to_number(to_char(cast(file_date as date)-1,'yyyymmdd')))
WHERE filename_prefix = 'CVIU_DAILY_RELEASE'
AND file_date >= cast('05/04/2023' as date);