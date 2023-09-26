update dmas_application_v2_inventory v
set v.file_inventory_date = x.new_file_inventory_date
from(
select v.tracking_number, v.dmas_application_id,v.file_inventory_date, 
 CASE WHEN cast(v.file_inventory_date as date) = cast('05/27/2023' as date) then dateadd(day,3,v.file_inventory_date)
      WHEN cast(v.file_inventory_date as date) = cast('05/28/2023' as date) then dateadd(day,2,v.file_inventory_date)
      WHEN dayofweek(file_inventory_date) = 6 THEN dateadd(day,2,v.file_inventory_date)
      else dateadd(day,1,v.file_inventory_date)
    end new_file_inventory_date
from (select * from dmas_application_v2_inventory v
      QUALIFY ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY file_inventory_date DESC,dmas_application_id DESC) = 1) v
 join dmas_file_log f on v.file_id = f.file_id
where cast(file_inventory_date as date) = cast('05/13/2023' as date)
 or  cast(file_inventory_date as date) = cast('05/14/2023' as date)
 or  cast(file_inventory_date as date) = cast('05/20/2023' as date)
 or  cast(file_inventory_date as date) = cast('05/21/2023' as date)
 or  cast(file_inventory_date as date) = cast('05/27/2023' as date)
 or  cast(file_inventory_date as date) = cast('05/28/2023' as date)
 or  cast(file_inventory_date as date) = cast('04/29/2023' as date)
 or  cast(file_inventory_date as date) = cast('04/30/2023' as date)
 or  cast(file_inventory_date as date) = cast('05/06/2023' as date)
 or  cast(file_inventory_date as date) = cast('05/07/2023' as date)
) x
where v.dmas_application_id = x.dmas_application_id;

update dmas_application_v2_inventory v
set v.file_inventory_date = x.new_file_inventory_date
from(
select v.tracking_number, v.dmas_application_id,v.file_inventory_date, 
 CASE WHEN cast(v.file_inventory_date as date) = cast('05/27/2023' as date) then dateadd(day,3,v.file_inventory_date)
      WHEN cast(v.file_inventory_date as date) = cast('05/28/2023' as date) then dateadd(day,2,v.file_inventory_date)
      WHEN dayofweek(file_inventory_date) = 6 THEN dateadd(day,2,v.file_inventory_date)
      else dateadd(day,1,v.file_inventory_date)
    end new_file_inventory_date
from (select * from dmas_application_v2_inventory v
      QUALIFY ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY file_inventory_date ,dmas_application_id DESC) = 1) v
 join dmas_file_log f on v.file_id = f.file_id
where cast(file_inventory_date as date) = cast('05/13/2023' as date)
 or  cast(file_inventory_date as date) = cast('05/14/2023' as date)
 or  cast(file_inventory_date as date) = cast('05/20/2023' as date)
 or  cast(file_inventory_date as date) = cast('05/21/2023' as date)
 or  cast(file_inventory_date as date) = cast('05/27/2023' as date)
 or  cast(file_inventory_date as date) = cast('05/28/2023' as date)
 or  cast(file_inventory_date as date) = cast('04/29/2023' as date)
 or  cast(file_inventory_date as date) = cast('04/30/2023' as date)
 or  cast(file_inventory_date as date) = cast('05/06/2023' as date)
 or  cast(file_inventory_date as date) = cast('05/07/2023' as date)
) x
where v.dmas_application_id = x.dmas_application_id;