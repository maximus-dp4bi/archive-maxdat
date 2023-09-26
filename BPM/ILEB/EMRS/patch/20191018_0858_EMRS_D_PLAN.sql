ALTER TABLE EMRS_D_PLAN ADD (PLAN_ID_EXT VARCHAR(32));

CREATE OR REPLACE VIEW MAXDAT.EMRS_D_PLAN_SV
AS
SELECT plan_id
       ,managed_care_program
       ,csda
       ,plan_code
       ,plan_name
       ,plan_abbreviation
       ,plan_effective_date
       ,address1
       ,address2
       ,city
       ,state
       ,zip
       ,active
       ,contact_first_name
       ,contact_initial
       ,contact_last_name
       ,contact_full_name
       ,contact_phone
       ,contact_extension
       ,member_contact_phone
       ,enrollok
       ,plan_assign
       ,record_date
       ,record_time
       ,record_name
       ,source_record_id
       ,plan_type_id
       ,plan_service_type
       ,plan_id_ext
FROM emrs_d_plan 
;
/

GRANT SELECT ON MAXDAT.EMRS_D_PLAN_SV TO MAXDAT_READ_ONLY;

update emrs_d_plan set plan_id_ext = '23' where source_record_id = 1000319;                
update emrs_d_plan set plan_id_ext = '52' where source_record_id = 1000340;                
update emrs_d_plan set plan_id_ext = '15' where source_record_id = 1000341;                
update emrs_d_plan set plan_id_ext = '19' where source_record_id = 1000342;                
update emrs_d_plan set plan_id_ext = '24' where source_record_id = 1000339;                
update emrs_d_plan set plan_id_ext = '1' where source_record_id = 1000301;                 
update emrs_d_plan set plan_id_ext = '19' where source_record_id = 1000709;                
update emrs_d_plan set plan_id_ext = '9B' where source_record_id = 1000686;                
update emrs_d_plan set plan_id_ext = '25' where source_record_id = 1000710;                
update emrs_d_plan set plan_id_ext = '252' where source_record_id = 1000718;               
update emrs_d_plan set plan_id_ext = '28' where source_record_id = 1000721;                
update emrs_d_plan set plan_id_ext = '27' where source_record_id = 1000727;                
update emrs_d_plan set plan_id_ext = '9C' where source_record_id = 1000722;                
update emrs_d_plan set plan_id_ext = '9D' where source_record_id = 1000723;                
update emrs_d_plan set plan_id_ext = '9E' where source_record_id = 1000724;                
update emrs_d_plan set plan_id_ext = '19' where source_record_id = 1000832;                
update emrs_d_plan set plan_id_ext = '8A' where source_record_id = 1000854;                
update emrs_d_plan set plan_id_ext = '8B' where source_record_id = 1000911;                
update emrs_d_plan set plan_id_ext = '24' where source_record_id = 1000912;                
update emrs_d_plan set plan_id_ext = '8H' where source_record_id = 1001037;                
update emrs_d_plan set plan_id_ext = '23' where source_record_id = 1000953;                
update emrs_d_plan set plan_id_ext = '28' where source_record_id = 1000992;                
update emrs_d_plan set plan_id_ext = '7A' where source_record_id = 1001031;                
update emrs_d_plan set plan_id_ext = '52' where source_record_id = 1001053;                
update emrs_d_plan set plan_id_ext = '8A' where source_record_id = 1001056;                
update emrs_d_plan set plan_id_ext = '8D' where source_record_id = 1001071;                
update emrs_d_plan set plan_id_ext = '8G' where source_record_id = 1001075;                
update emrs_d_plan set plan_id_ext = '8B' where source_record_id = 1001111;                
update emrs_d_plan set plan_id_ext = '8D' where source_record_id = 1001112;                
update emrs_d_plan set plan_id_ext = '8I' where source_record_id = 1001113;                
update emrs_d_plan set plan_id_ext = '8H' where source_record_id = 1001135;                
update emrs_d_plan set plan_id_ext = '8J' where source_record_id = 1001151;                
update emrs_d_plan set plan_id_ext = '59' where source_record_id = 1001232;                
update emrs_d_plan set plan_id_ext = '25' where source_record_id = 1001256;                
update emrs_d_plan set plan_id_ext = '26' where source_record_id = 1000663;                
update emrs_d_plan set plan_id_ext = '19' where source_record_id = 1000682;                
update emrs_d_plan set plan_id_ext = '25' where source_record_id = 1000662;                
update emrs_d_plan set plan_id_ext = '9A' where source_record_id = 1000685;                
update emrs_d_plan set plan_id_ext = '28' where source_record_id = 1000703;                
update emrs_d_plan set plan_id_ext = '27' where source_record_id = 1000705;                
update emrs_d_plan set plan_id_ext = '19' where source_record_id = 1000717;                
update emrs_d_plan set plan_id_ext = '15' where source_record_id = 1000831;                
update emrs_d_plan set plan_id_ext = '25' where source_record_id = 1000833;                
update emrs_d_plan set plan_id_ext = '8C' where source_record_id = 1000952;                
update emrs_d_plan set plan_id_ext = '52' where source_record_id = 1000954;                
update emrs_d_plan set plan_id_ext = '28' where source_record_id = 1000955;                
update emrs_d_plan set plan_id_ext = '23' where source_record_id = 1000991;                
update emrs_d_plan set plan_id_ext = '15' where source_record_id = 1000993;                
update emrs_d_plan set plan_id_ext = '24' where source_record_id = 1000995;                
update emrs_d_plan set plan_id_ext = '8C' where source_record_id = 1000996;                
update emrs_d_plan set plan_id_ext = '8E' where source_record_id = 1001034;                
update emrs_d_plan set plan_id_ext = '24' where source_record_id = 1001055;                
update emrs_d_plan set plan_id_ext = '19' where source_record_id = 1001057;                
update emrs_d_plan set plan_id_ext = '8H' where source_record_id = 1001076;                
update emrs_d_plan set plan_id_ext = '56' where source_record_id = 1001211;                
update emrs_d_plan set plan_id_ext = '28' where source_record_id = 1001251;                
update emrs_d_plan set plan_id_ext = '15' where source_record_id = 1001253;                
update emrs_d_plan set plan_id_ext = '24' where source_record_id = 1001254;                
update emrs_d_plan set plan_id_ext = '23' where source_record_id = 1000702;                
update emrs_d_plan set plan_id_ext = '26' where source_record_id = 1000704;                
update emrs_d_plan set plan_id_ext = '10' where source_record_id = 1000706;                
update emrs_d_plan set plan_id_ext = '24' where source_record_id = 1000716;                
update emrs_d_plan set plan_id_ext = '56' where source_record_id = 1000851;                
update emrs_d_plan set plan_id_ext = '9F' where source_record_id = 1000852;                
update emrs_d_plan set plan_id_ext = '26' where source_record_id = 1000853;                
update emrs_d_plan set plan_id_ext = '7B' where source_record_id = 1000956;                
update emrs_d_plan set plan_id_ext = '26' where source_record_id = 1000971;                
update emrs_d_plan set plan_id_ext = '25' where source_record_id = 1000973;                
update emrs_d_plan set plan_id_ext = '8A' where source_record_id = 1000974;                
update emrs_d_plan set plan_id_ext = '52' where source_record_id = 1000994;                
update emrs_d_plan set plan_id_ext = '8D' where source_record_id = 1001032;                
update emrs_d_plan set plan_id_ext = '56' where source_record_id = 1001033;                
update emrs_d_plan set plan_id_ext = '8G' where source_record_id = 1001036;                
update emrs_d_plan set plan_id_ext = '8G' where source_record_id = 1001133;                
update emrs_d_plan set plan_id_ext = '19' where source_record_id = 1001255;                
update emrs_d_plan set plan_id_ext = '57' where source_record_id = 1000642;                
update emrs_d_plan set plan_id_ext = '24' where source_record_id = 1000707;                
update emrs_d_plan set plan_id_ext = '88' where source_record_id = 1000708;                
update emrs_d_plan set plan_id_ext = '23' where source_record_id = 1000711;                
update emrs_d_plan set plan_id_ext = '28' where source_record_id = 1000712;                
update emrs_d_plan set plan_id_ext = '272' where source_record_id = 1000713;               
update emrs_d_plan set plan_id_ext = '262' where source_record_id = 1000714;               
update emrs_d_plan set plan_id_ext = '102' where source_record_id = 1000715;               
update emrs_d_plan set plan_id_ext = '10' where source_record_id = 1000726;                
update emrs_d_plan set plan_id_ext = '19' where source_record_id = 1000972;                
update emrs_d_plan set plan_id_ext = '8F' where source_record_id = 1001035;                
update emrs_d_plan set plan_id_ext = '23' where source_record_id = 1001051;                
update emrs_d_plan set plan_id_ext = '28' where source_record_id = 1001052;                
update emrs_d_plan set plan_id_ext = '15' where source_record_id = 1001054;                
update emrs_d_plan set plan_id_ext = '8C' where source_record_id = 1001058;                
update emrs_d_plan set plan_id_ext = '56' where source_record_id = 1001072;                
update emrs_d_plan set plan_id_ext = '8E' where source_record_id = 1001073;                
update emrs_d_plan set plan_id_ext = '8F' where source_record_id = 1001074;                
update emrs_d_plan set plan_id_ext = '56' where source_record_id = 1001131;                
update emrs_d_plan set plan_id_ext = '8F' where source_record_id = 1001132;                
update emrs_d_plan set plan_id_ext = '8E' where source_record_id = 1001134;                
update emrs_d_plan set plan_id_ext = '8I' where source_record_id = 1001191;                
update emrs_d_plan set plan_id_ext = '59' where source_record_id = 1001231;                
update emrs_d_plan set plan_id_ext = '59' where source_record_id = 1001233;                
update emrs_d_plan set plan_id_ext = '56' where source_record_id = 1001252;                
update emrs_d_plan set plan_id_ext = '59' where source_record_id = 1001257;                
update emrs_d_plan set plan_id_ext = '24' where source_record_id = 1001258;                
commit;
