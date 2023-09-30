--- Inserting MAXEB - PHAPP
--- Brian notified that Contract log totals are not matching since Phone App is entered manually
-- Soundra Rangarajulu 4/19/2023

--- Contract log entry for Phone App
insert into d_letter_contract
  (letter_program_group, letter_program_group_label, letter_program_group_order, contract_reference_level_1_code, contract_reference_level_1_desc, contract_reference_level_1_order, contract_reference_level_2_code, contract_reference_level_2_desc, contract_reference_level_2_order, contract_reference_level_3_code, contract_reference_level_3_desc, contract_reference_level_3_order , project_code, program_code, effective_from_date, effective_thru_date)
values
  ('BHACA', 'ACA', 3, '1.022D', '1.022D', 1, 'BH', 'Beneficiary Helpline Mailings', 1, 'BH', 'BH', 1, 'MIEB', 'MEDICAID', to_date('1/1/2017','mm/dd/yyyy'), to_date('7/7/7777','mm/dd/yyyy'));

-- Letter Definition entry for Phone App
insert into maxdat_mitran.d_letter_Definition (
 report_label, effective_from_date, effective_thru_date, contract_reference,  letter_source_code, letter_invoice_group_code, letter_program_group, source_table_name,
project_code,
program_code
, subprogram_code
, group_name
, letter_inv_name
) 
values
( 'PHAPP', to_date('1/1/2017','mm/dd/yyyy'), to_date('1/1/7777','mm/dd/yyyy'), 1,'MAXEB','MAXEB','BHACA', null, 'MIEB','MEDICAID','MED', null, null
);


