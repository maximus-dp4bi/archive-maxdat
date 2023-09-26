SELECT 
    DB_NAME(mf.database_id) AS 'DB Name', 
    name AS 'File Logical Name',
    'File Type' = CASE WHEN type_desc = 'LOG' THEN 'Log File' WHEN type_desc = 'ROWS' THEN 'Data File' ELSE type_desc END,
    mf.physical_name AS 'File Physical Name', 
    size_on_disk_bytes/ 1024 AS 'Size(KB)', 
    size_on_disk_bytes/ 1024 / 1024 AS 'Size(MB)',
    size_on_disk_bytes/ 1024 / 1024 / 1024 AS 'Size(GB)'
FROM 
    sys.dm_io_virtual_file_stats(NULL, NULL) AS divfs 
    JOIN sys.master_files AS mf 
        ON mf.database_id = divfs.database_id 
            AND mf.file_id = divfs.file_id
ORDER BY 
    DB_NAME(mf.database_id)