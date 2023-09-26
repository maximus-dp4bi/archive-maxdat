CREATE TABLE ohpnm_dp4bi.cfg_county_region_program_xwalk (county_name VARCHAR,county_region VARCHAR,program VARCHAR);
INSERT INTO ohpnm_dp4bi.cfg_county_region_program_xwalk (county_name,county_region,program)
SELECT county_name
  ,CASE WHEN county_name IN('Delaware','Franklin','Madison','Pickaway','Union') THEN 'Central'
        WHEN county_name IN('Portage', 'Stark', 'Summit','Wayne') THEN 'East Central'
        WHEN county_name IN('Cuyahoga', 'Geauga', 'Lake', 'Lorain', 'Medina') THEN 'Northeast'
        WHEN county_name IN('Columbiana', 'Mahoning','Trumbull') THEN 'Northeast Central'
        WHEN county_name IN('Fulton', 'Lucas', 'Ottawa','Wood') THEN 'Northwest'
        WHEN county_name IN('Clark', 'Greene','Montgomery') THEN 'West Central'
        WHEN county_name IN('Butler', 'Clermont', 'Clinton', 'Hamilton','Warren') THEN 'Southwest'
   ELSE NULL END region
  ,'MyCare' program
FROM ohpnm_dp4bi.county_region;

INSERT INTO ohpnm_dp4bi_dev.cfg_county_region_program_xwalk (county_name,county_region,program)
SELECT county_name
 ,CASE WHEN county_name IN('Athens','Franklin','Knox','Meigs','Pike','Belmont','Gallia','Lawrence','Monroe','Ross',
                            'Coshocton','Guernsey','Licking','Morgan','Scioto','Crawford','Harrison','Logan','Muskingum','Union',
                            'Delaware','Hocking','Madison','Noble','Vinton','Fairfield','Jackson','Marion','Perry','Washington',
                            'Fayette','Jefferson','Morrow','Pickaway') THEN 'Central_SE'
       WHEN county_name IN('Ashland','Cuyahoga','Huron','Medina','Summit','Ashtabula','Erie','Lake','Mahoning','Trumbull','Carroll','Holmes','Lorain','Richland','Tuscarawas',
                             'Columbiana','Geauga','Portage','Stark','Wayne') THEN 'Northeast'
       WHEN county_name IN('Adams','Clermont','Hancock','Montgomery','Shelby','Allen','Clinton','Hardin','Ottawa','Van Wert','Auglaize','Darke','Henry','Paulding','Williams',
                           'Brown','Defiance','Highland','Preble','Wood','Butler','Fulton','Lucas','Putnam','Wyandot','Champaign','Greene','Mercer','Sandusky', 'Warren',
                           'Clark','Hamilton','Miami','Seneca') THEN 'West'
   ELSE NULL END region                          
 ,'MCO' program
FROM ohpnm_dp4bi.county_region; 

CREATE OR REPLACE VIEW public.cfg_county_region_program_xwalk_sv AS
SELECT county_name,county_region,program 
FROM ohpnm_dp4bi.cfg_county_region_program_xwalk;