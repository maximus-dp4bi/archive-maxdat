
insert into emrs_d_provider_specialty_code
   ( PROVIDER_SPECIALTY_CODE
   , PROVIDER_SPECIALTY
   , PROVIDER_SPECIALTY_CODE_ID
   , MANAGED_CARE_PROGRAM
   , VALID_PCP
   , INVALID_PCP
   , SPECIAL_NEEDS  
 )
   VALUES
   ('0'
   , 'Unknown'
   , 0
   , 'Unknown'
   , 'N'
   , 'N'
   , 'N'     
);

insert into emrs_d_specialty_group_ref(specialty_group_id)
values(0);

insert into emrs_d_specialty_group(specialty_group_id
                                   ,minimum_row_id
                                   ,group_count
                                   ,provider_specialty_code_id)
values(0
       ,1
       ,1
       ,0);