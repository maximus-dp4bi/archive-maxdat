drop table ohpnm_dp4bi.cfg_county_capacities;
CREATE TABLE ohpnm_dp4bi.cfg_county_capacities
AS
SELECT crmc.county_id,crmc.mmis_county_code ,TRIM(REPLACE(crmc.county_name,'County','')) county_name,
 CASE WHEN county_region = 'Central_SE' THEN 'Central/Southeast' ELSE county_region END county_region_desc,
     /* CASE WHEN county_region = 'Central_SE' THEN 'C/SE'
           WHEN county_region = 'West' THEN 'W'
           WHEN county_region = 'Northeast' THEN 'NE'
        ELSE county_region END county_region,       */
   county_region, 
 CASE WHEN  TRIM(REPLACE(crmc.county_name,'County','')) IN('Adams','Auglaize','Brown','Carroll','Champaign','Crawford','Defiance','Fayette','Harrison','Highland','Holmes','Jefferson','Meigs','Monroe',
        'Morgan','Morrow','Noble','Paulding','Perry','Pike','Preble','Putnam','Seneca','Shelby','Union','Vinton','Washington','Wyandot') THEN 0
       WHEN  TRIM(REPLACE(crmc.county_name,'County','')) IN('Ashland','Darke','Gallia','Guernsey','Henry','Logan','Ottawa','Scioto','Van Wert') THEN 1
       WHEN  TRIM(REPLACE(crmc.county_name,'County','')) IN('Belmont','Clinton','Coshocton','Hancock','Hocking','Jackson','Lawrence','Madison','Pickaway') THEN 2
       WHEN  TRIM(REPLACE(crmc.county_name,'County','')) IN('Fairfield','Geauga','Hardin','Huron','Mercer','Williams') THEN 3
       WHEN  TRIM(REPLACE(crmc.county_name,'County','')) IN('Clermont','Delaware','Licking','Tuscarawas','Wayne') THEN 4
       WHEN  TRIM(REPLACE(crmc.county_name,'County','')) IN('Athens','Clark','Erie','Knox','Marion','Portage','Ross') THEN 5
       WHEN  TRIM(REPLACE(crmc.county_name,'County','')) IN('Fulton','Muskingum','Richland') THEN 6
       WHEN  TRIM(REPLACE(crmc.county_name,'County','')) IN('Columbiana','Miami','Warren') THEN 7
       WHEN  TRIM(REPLACE(crmc.county_name,'County','')) IN('Allen','Ashtabula') THEN 8
       WHEN  TRIM(REPLACE(crmc.county_name,'County','')) IN('Sandusky') THEN 9
       WHEN  TRIM(REPLACE(crmc.county_name,'County','')) IN('Lake','Wood') THEN 12
       WHEN  TRIM(REPLACE(crmc.county_name,'County','')) IN('Mahoning','Medina','Trumbull') THEN 13
       WHEN  TRIM(REPLACE(crmc.county_name,'County','')) IN('Greene') THEN 14
       WHEN  TRIM(REPLACE(crmc.county_name,'County','')) IN('Lorain','Stark') THEN 16
       WHEN  TRIM(REPLACE(crmc.county_name,'County','')) IN('Butler') THEN 17
       WHEN  TRIM(REPLACE(crmc.county_name,'County','')) IN('Montgomery') THEN 20
       WHEN  TRIM(REPLACE(crmc.county_name,'County','')) IN('Franklin') THEN 24
       WHEN  TRIM(REPLACE(crmc.county_name,'County','')) IN('Hamilton','Lucas') THEN 25
       WHEN  TRIM(REPLACE(crmc.county_name,'County','')) IN('Summit') THEN 29
       WHEN  TRIM(REPLACE(crmc.county_name,'County','')) IN('Cuyahoga') THEN 55
    ELSE 999 END bh_capacity ,
    CASE WHEN  TRIM(REPLACE(crmc.county_name,'County','')) IN('Adams','Ashland','Auglaize','Brown','Carroll','Champaign','Clinton','Coshocton','Darke','Fulton','Harrison','Henry','Holmes','Jackson','Jefferson',
                                                              'Mercer','Monroe','Morrow','Noble','Ottawa','Paulding','Preble','Putnam','Seneca','Shelby','Union','Van Wert','Washington','Wyandot') THEN 0
         WHEN  TRIM(REPLACE(crmc.county_name,'County','')) IN('Belmont','Crawford','Defiance','Delaware','Fayette','Geauga','Guernsey','Hancock','Hardin','Highland','Huron','Knox','Lawrence','Madison','Medina',
                                                             'Morgan','Pike','Sandusky','Tuscarawas','Vinton','Wayne','Williams') THEN 1
         WHEN  TRIM(REPLACE(crmc.county_name,'County','')) IN('Ashtabula','Clark','Erie','Gallia','Logan','Lorain','Meigs','Miami','Perry','Pickaway','Portage','Wood') THEN 2
         WHEN  TRIM(REPLACE(crmc.county_name,'County','')) IN('Athens','Columbiana','Fairfield','Hocking','Muskingum','Ross') THEN 3
         WHEN  TRIM(REPLACE(crmc.county_name,'County','')) IN('Clermont','Lake','Licking','Marion','Trumbull','Warren') THEN 4
         WHEN  TRIM(REPLACE(crmc.county_name,'County','')) IN('Greene') THEN 5
         WHEN  TRIM(REPLACE(crmc.county_name,'County','')) IN('Allen','Richland','Stark') THEN 6         
         WHEN  TRIM(REPLACE(crmc.county_name,'County','')) IN('Butler','Scioto') THEN 8
         WHEN  TRIM(REPLACE(crmc.county_name,'County','')) IN('Mahoning') THEN 12
         WHEN  TRIM(REPLACE(crmc.county_name,'County','')) IN('Lucas','Summit') THEN 14
         WHEN  TRIM(REPLACE(crmc.county_name,'County','')) IN('Montgomery') THEN 18
         WHEN  TRIM(REPLACE(crmc.county_name,'County','')) IN('Hamilton') THEN 30
         WHEN  TRIM(REPLACE(crmc.county_name,'County','')) IN('Cuyahoga') THEN 34
         WHEN  TRIM(REPLACE(crmc.county_name,'County','')) IN('Franklin') THEN 43
      ELSE 999 END mat_capacity,
    CASE WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Adams','Auglaize','Brown','Butler','Carroll','Champaign','Clermont','Delaware','Hardin','Harrison','Henry','Hocking','Jackson','Lawrence','Lucas','Meigs',
                                                             'Monroe','Morgan','Morrow','Noble','Ottawa','Paulding','Perry','Pike','Preble','Putnam','Seneca','Vinton','Warren','Wood') 
      THEN 0 ELSE 1 END general_hospital_capacity,
    CASE WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Cuyahoga','Lucas','Montgomery','Summit') THEN 1
         WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Franklin','Hamilton') THEN 2
      ELSE 0 END hospital_system_capacity,
    CASE WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Allen','Butler','Clermont','Darke','Defiance','Fulton','Gallia','Geauga','Hancock','Hocking','Lake','Licking','Mahoning','Marion','Miami','Montgomery',
                                                             'Muskingum','Ross','Shelby','Stark','Summit','Trumbull','Warren') THEN 1
         WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Cuyahoga') THEN 6
         WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Franklin','Hamilton') THEN 3
         WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Lucas') THEN 2
     ELSE 0 END inpatient_psych_capacity, 
      CASE WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Adams','Auglaize','Brown','Champaign','Clinton','Crawford','Darke','Fayette','Gallia','Geauga','Hardin','Henry','Hocking','Jackson',
                                                               'Logan','Madison','Mercer','Morrow','Noble','Ottawa','Perry','Pickaway','Pike','Putnam','Shelby','Union','Warren','Williams','Wyandot') THEN 1
           WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Erie','Hancock','Huron','Scioto','Seneca','Van Wert','Wood') THEN 2
           WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Ashland','Ashtabula','Athens','Columbiana','Coshocton','Delaware','Greene','Guernsey','Highland','Jefferson','Knox','Lawrence','Marion',
                                                                'Miami','Portage','Sandusky','Washington','Wayne') THEN 3                                                                
           WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Belmont','Fairfield','Licking','Medina','Muskingum','Ross','Tuscarawas') THEN 4
           WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Allen','Clermont') THEN 5
           WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Clark','Lake') THEN 6
           WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Richland') THEN 7
           WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Lorain','Trumbull') THEN 11
           WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Butler') THEN 13
           WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Mahoning') THEN 14
           WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Stark') THEN 17
           WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Summit') THEN 23
           WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Montgomery') THEN 25
           WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Cuyahoga') THEN 102
           WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Franklin') THEN 95
           WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Hamilton') THEN 50
           WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Lucas') THEN 29
        ELSE 0 END dental_capacity,
        CASE WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Auglaize','Clermont','Coshocton','Darke','Geauga','Hancock','Pickaway','Union') THEN 1
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Clinton','Crawford','Defiance','Erie','Gallia','Guernsey','Highland','Huron','Jackson','Knox','Licking','Logan','Marion','Richland','Ross','Scioto','Washington') THEN 2
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Allen','Ashtabula','Athens','Clark','Delaware','Fairfield','Greene','Jefferson','Lawrence') THEN 3
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Belmont','Butler','Medina','Muskingum','Trumbull') THEN 4
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Mahoning') THEN 5
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Lake') THEN 6
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Stark') THEN 7
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Lucas') THEN 9
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Lorain') THEN 11
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Cuyahoga') THEN 32
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Franklin') THEN 20
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Hamilton') THEN 14
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Summit') THEN 13
         ELSE 0 END vision_capacity,
        CASE WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Adams','Ashland','Athens','Auglaize','Brown','Champaign','Clinton','Coshocton','Crawford','Darke','Defiance','Delaware','Fayette','Fulton','Gallia','Geauga','Guernsey',
                    'Hancock','Harrison','Henry','Highland','Holmes','Huron','Jackson','Lawrence','Logan','Marion','Mercer','Miami','Morrow','Muskingum','Ottawa','Perry','Pickaway','Pike','Preble','Putnam','Ross','Seneca','Shelby',
                    'Union','Van Wert','Washington','Williams') THEN 1
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Allen','Belmont','Clermont','Erie','Fairfield','Greene','Jefferson','Knox','Lake','Licking','Medina','Portage','Richland','Sandusky','Scioto','Tuscarawas','Wayne','Wood') THEN 2
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Ashtabula','Clark','Columbiana','Warren') THEN 3
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Lorain','Trumbull') THEN 4
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Butler','Mahoning') THEN 5
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Lucas','Stark') THEN 7
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Montgomery') THEN 8
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Summit') THEN 9
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Franklin') THEN 11
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Hamilton') THEN 14
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Cuyahoga') THEN 19
             ELSE 0 END nursing_facility_capacity,
     CASE WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Delaware','Franklin','Madison','Pickaway','Union') THEN 'Central'
        WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Portage', 'Stark', 'Summit','Wayne') THEN 'East Central'
        WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Cuyahoga', 'Geauga', 'Lake', 'Lorain', 'Medina') THEN 'Northeast'
        WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Columbiana', 'Mahoning','Trumbull') THEN 'Northeast Central'
        WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Fulton', 'Lucas', 'Ottawa','Wood') THEN 'Northwest'
        WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Clark', 'Greene','Montgomery') THEN 'West Central'
        WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Butler', 'Clermont', 'Clinton', 'Hamilton','Warren') THEN 'Southwest'
     ELSE NULL END mycare_region,             
        CASE WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Delaware','Geauga','Madison','Medina','Wayne') THEN 1 
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Clark','Lorain','Pickaway','Portage','Wood') THEN 2
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Columbiana') THEN 3
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Clermont','Lake','Trumbull','Warren') THEN 4
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Greene') THEN 5
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Stark') THEN 6
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Butler') THEN 8
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Mahoning') THEN 12
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Lucas','Summit') THEN 14
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Montgomery') THEN 18
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Hamilton') THEN 30
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Cuyahoga') THEN 34
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Franklin') THEN 43
          ELSE 0 END mycare_mat_capacity,
        CASE WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Delaware','Greene') THEN 3
          WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Franklin') THEN 16
          WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Madison','Union','Clinton') THEN 1
          WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Pickaway','Portage','Geauga','Fulton','Ottawa') THEN 2
          WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Stark') THEN 11
          WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Summit') THEN 14
          WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Wayne','Columbiana') THEN 5
          WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Cuyahoga') THEN 31
          WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Lake','Lorain','Medina','Wood','Clermont','Clark') THEN 4
          WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Mahoning','Trumbull','Butler') THEN 7
          WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Lucas','Montgomery') THEN 12
          WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Hamilton') THEN 23
          WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Warren') THEN 6
        ELSE 0 END mycare_nursing_facility_capacity,
        CASE WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Medina','Clermont','Clinton','Pickaway','Union') THEN 1
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Lake','Wood','Warren') THEN 2
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Lorain','Delaware','Clark','Greene') THEN 3
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Trumbull','Butler') THEN 4
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Mahoning') THEN 5
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Stark') THEN 7
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Lucas') THEN 9
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Summit') THEN 11
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Montgomery') THEN 13
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Hamilton') THEN 14
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Franklin') THEN 20
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Cuyahoga') THEN 32
        ELSE 0 END mycare_vision_capacity,
        CASE WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Cuyahoga') THEN 85
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Geauga','Ottawa','Clinton','Madison','Pickaway','Union' ) THEN 1
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Lake') THEN 7
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Lorain','Mahoning') THEN 11
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Medina') THEN 4
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Columbiana','Wood') THEN 2
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Trumbull') THEN 8
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Lucas') THEN 26
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Butler') THEN 13
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Clermont') THEN 5
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Hamilton') THEN 34
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Warren','Portage','Wayne','Delaware','Greene') THEN 3
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Stark') THEN 17
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Summit') THEN 23
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Franklin') THEN 60
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Clark') THEN 6
             WHEN TRIM(REPLACE(crmc.county_name,'County','')) IN('Montgomery') THEN 23
          ELSE 0 END mycare_dental_capacity,
        0 mycare_general_hospital_capacity,
        0 mycare_hospital_system_capacity,
        0 mycare_inpatient_psych_capacity          
 from ohpnm_dp4bi.county crmc
  LEFT JOIN ohpnm_dp4bi.county_region crgmc ON UPPER(crgmc.county_name) = REPLACE(UPPER(TRIM(REPLACE(crmc.county_name,'County',''))) ,' ','')
  where crmc.state_abbreviation = 'OH'
  and county_region is not null
  order by crmc.county_name;

ALTER TABLE ohpnm_dp4bi.cfg_county_capacities ADD PRIMARY KEY(county_id);

CREATE OR REPLACE VIEW d_cfg_county_capacities_sv
AS
SELECT * FROM ohpnm_dp4bi.cfg_county_capacities;