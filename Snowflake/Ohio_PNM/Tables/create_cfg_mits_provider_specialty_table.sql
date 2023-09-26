CREATE TABLE cfg_mits_provider_specialty 
(mits_specialty_code VARCHAR,
 mits_specialty_description VARCHAR,
 mits_provider_category VARCHAR);
 
 ALTER TABLE cfg_mits_provider_specialty ADD primary key(mits_specialty_code);
 
CREATE OR REPLACE VIEW public.d_cfg_mits_provider_specialty_sv
 AS
 SELECT mits_specialty_code
 ,mits_specialty_description
 ,mits_provider_category
 FROM ohpnm_dp4bi_dev.cfg_mits_provider_specialty;
 
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('001','General Hospital','General Hospitals');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('007','Distinct Part Psychiatric Unit','Psych Facilities');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('018','IMD','Psych Facilities');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('019','Non-IMD','Psych Facilities');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('030','Psychiatric Residential Treatment Facility','Psych Facilities');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('041','OHF Dental','Dental');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('045','OHF Vision','Vision');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('122','FQHC Dental','Dental');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('127','FQHC Vision','Vision');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('161','Other Accredited Home Health Agency JFS Waiver Service','Personal Care Agency/Waiver Nursing Agency');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('190','MCO Provider Only (Managed Care Organization Provider)','Managed Care Organization Provider');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('292','Opthalmology','Vision');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('300','General Dentistry','Dental');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('302','Endodontics','Dental');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('305','Pediatric Dentistry','Dental');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('306','Periodontics','Dental');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('307','Prosthodontics','Dental');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('309','Professional Dental Group','Dental');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('350','Optometry','Vision');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('370','Licensed Independent Social Worker','Behavioural Health');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('420','Psychology','Behavioural Health');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('421','Board Licensed School Psychologist','Behavioural Health');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('450','ODJFS Waiver','Waiver');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('451','ODJFS Waiver Supplemental Transport Services','Waiver Transportation');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('454','ODJFS Waiver Minor Home Modifications','Home Modifications');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('455','ODJFS Waiver Home Delivered Meals','Home Delivered Meals');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('456','ODJFS Waiver Out of Home Respite','Out of Home Respite');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('457','ODJFS Waiver Emergency Response System','Emergency Response');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('458','Community Integration','Community Integration');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('459','Community Transition','Community Transition');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('474','Licensed Professional Clinical Counselor','Behavioural Health');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('495','DODD Financial Management Service','Financial Management');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('505','Optometry School Clinic','Vision');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('506','Dental School Clinic','Dental');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('520','Licensed Independent Marriage and Family Therapist','Behavioural Health');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('540','Licensed Independent Chemical Dependency Counselor','Behavioural Health');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('555','Dual Licensed Dentist and Licensed MD/DO.','Dental');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('601','Medicare Certified Home Health Agency JFS Waiver','Personal Care Agency/Waiver Nursing Agency');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('704','DATA 2000 Waiver Practitioners','MAT Services');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('777','Nursing Facility','Nursing Facility');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('840','ODMH Community Health Agency','Community Mental Health Centers');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('847','Intensive Home Based Treatment','Behavioural Health');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('852','Peer Services','Peer Services');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('860','Dual Certified Skilled Nursing Facility','Nursing Facility');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('861','Dual Certified Pediatric Nursing Facility Outlier','Nursing Facility');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('862','Dual Certified Super Skilled Nursing Facility Out','Nursing Facility');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('863','Dual Certified Nursing Facility Acquired Brain In','Nursing Facility');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('870','Medicaid Only Nursing Facility','Nursing Facility');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('950','ODADAS Certified/Licensed Treatment Program','Substance Use Disorder Treatment');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('951','ODADAS Methadone Program','MAT Services');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('953','Opioid Treatment Program','MAT Services');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('954','SUD Residential Facility','MAT Services');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('45A','Home Maintenance/Chore','Home Maintenance/Chore');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('M08','Personal Care - Agency','Personal Care - Agency');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('M10','Homemaker','Homemaker');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('M11','Social Work Counseling','Social Work Counseling');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('M12','Home Medical Equipment','Home Medical Equipment');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('ORC','CANS Assessor','Behavioural Health');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('ORE','OhioRISE Care Management Entity','Behavioural Health');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('ORM','MRSS – Mobile Response and Stabilization Service','Behavioural Health');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('ORR','OhioRISE Waiver Out of Home Respite','OhioRISE Respite');
INSERT INTO cfg_mits_provider_specialty (mits_specialty_code,mits_specialty_description,mits_provider_category) VALUES('XXX','OhioRISE Transitional Services and Supports','Transitional Services and Supports');


 