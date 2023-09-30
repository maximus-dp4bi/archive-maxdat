SELECT NULL source_record_id
       ,NULL zipcode_id
       ,value zip_code
       ,DECODE(covers_multiple_county_ind,1,'Y','N') covers_multiple_county
       ,attrib_county zip_county
       ,attrib_state zip_state
       ,attrib_city zip_city
FROM enum_zipcode