/*
Created by Shan on 11/02/2016 for MAXDAT-4283
*/
set serveroutput on size unlimited
DECLARE
    l_table_owner  VARCHAR2(30)   := 'MAXDAT';
    l_table_name   VARCHAR2(30)   := 'BPM_UPDATE_EVENT_QUEUE';
    l_tot_count    NUMBER(5)      := 0;     -- Total count in each partition
    l_sql          VARCHAR2(3000) := NULL;  -- Dynamic SQL
    l_part_dropped BOOLEAN        := FALSE; -- indicates if a partition was dropped; if yes, rebuild global indexes
BEGIN

-- Loop through all partitions except the initial and latest partitions
    FOR part_rec IN (
                     SELECT partition_name
                     FROM   dba_tab_partitions
                     WHERE  table_name  = l_table_name
                     AND    table_owner = l_table_owner
                     AND    interval    = 'YES' -- initial partition will have interval set to 'NO'
                     AND    partition_position < (SELECT MAX(partition_position) FROM dba_tab_partitions
                                                  WHERE  table_name  = l_table_name
                                                  AND    table_owner = l_table_owner)
                     ORDER BY partition_position
                    )
    LOOP

        -- Lock the partition first before checking for count. This may be redundant as data always goes into latest partition
        l_sql := 'LOCK TABLE ' || l_table_owner || '.' || l_table_name || ' PARTITION (' || part_rec.partition_name || ') IN EXCLUSIVE MODE';
        EXECUTE IMMEDIATE l_sql;

        -- Check the count from the partition
        l_sql := 'SELECT COUNT(*) FROM ' || l_table_owner || '.' || l_table_name || ' PARTITION (' || part_rec.partition_name || ')';
        EXECUTE IMMEDIATE l_sql INTO l_tot_count;

        -- If no rows exist in the partition, then drop it
        IF l_tot_count = 0
        THEN
--          dbms_output.put_line('Total count for partition ' || part_rec.partition_name || ' is 0. This partition can be dropped');
            l_sql := 'ALTER TABLE ' || l_table_owner || '.' || l_table_name || ' DROP PARTITION ' || part_rec.partition_name;
            EXECUTE IMMEDIATE l_sql;
            l_part_dropped := TRUE;
        END IF;

    END LOOP;

    -- Rebuild global indexes online if any partition was dropped
    -- If partition had no rows, then index will be usable even after dropping partition
    -- But we are rebuilding to eliminate 'holes' in the index
    IF l_part_dropped
    THEN
        FOR ind_rec IN (
                        SELECT owner
                              ,index_name 
                        FROM   dba_indexes
                        WHERE  table_name  =  l_table_name
                        AND    table_owner =  l_table_owner
                        AND    index_type != 'LOB' -- Ignore LOB indexes
                        AND    PARTITIONED = 'NO'  -- consider only global indexes
                       )
        LOOP
            l_sql := 'ALTER INDEX ' || ind_rec.owner || '.' || ind_rec.index_name || ' REBUILD ONLINE';
            EXECUTE IMMEDIATE l_sql;
        END LOOP;
    END IF;
END;
/
