/*Drop View*/
DROP VIEW MAXDAT_SUPPORT.PA_D_NURSES_ZIPCODES_SERVED_SV;

/*Create View */

CREATE OR REPLACE VIEW MAXDAT_SUPPORT.PA_D_NURSES_ZIPCODES_SERVED_SV
AS select nz.nurse_zipcode_id as nurse_zipcode_id
      ,nz.nurse_id as nurse_id
      ,s.staff_id as staff_id
      ,nz.zipcode as zipcode
      ,upper(z.attrib_city) as city
      ,upper(c.description) as county
      ,upper(d.description) as district
      ,upper(z.attrib_state) as state
      ,DECODE(z.covers_multiple_county_ind,1,'Y','N') AS COVERS_MULTIPLE_COUNTY
      ,CASE WHEN LENGTH(TRIM(sc.LAST_NAME)) < 1 THEN TRIM(sc.FIRST_NAME) 
             WHEN LENGTH(TRIM(sc.FIRST_NAME)) < 1 THEN TRIM(sc.LAST_NAME)
             ELSE TRIM(sc.LAST_NAME) || ', ' || TRIM(sc.FIRST_NAME) 
             END AS created_by
      ,trunc(nz.create_ts) as create_date 
      ,trunc(nz.update_ts) as update_date
from   ats.staff s
join   ats.groups gr on (s.default_group_id = gr.group_id and gr.group_name like 'Field EB Unit%' and gr.type_cd = 'TEAM')
left outer join   ats.nurse n on (s.staff_id = n.staff_id)
left outer join   ats.nurse_zipcode nz on (nz.nurse_id = n.nurse_id)
left outer join   ats.enum_zipcode z on (z.value = nz.zipcode)
left outer join   ats.enum_county c on (c.value = z.attrib_county)
left outer join   ats.enum_district d on (d.value = c.attrib_district_cd)
left outer join   ats.staff sc on (sc.staff_id = nz.created_by)
union
select 0 as nurse_zipcode_id
      ,0 as nurse_id
      ,0 as staff_id
      ,'0' as zipcode
      ,null as city
      ,null as county
      ,null as district
      ,null as state
      ,null AS COVERS_MULTIPLE_COUNTY
      ,null AS created_by
      ,to_date('01/01/1985', 'mm/dd/yyyy') as create_date 
      ,to_date('01/01/1985', 'mm/dd/yyyy') as update_date
from dual;

/*Grant Statements*/

GRANT SELECT ON MAXDAT_SUPPORT.PA_D_NURSES_ZIPCODES_SERVED_SV TO MAXDAT_SUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.PA_D_NURSES_ZIPCODES_SERVED_SV TO MAXDAT_REPORTS; 

commit;
