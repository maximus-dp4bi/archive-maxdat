CREATE OR REPLACE VIEW MAXDAT_SUPPORT.D_CMI_ASSESSMENTDETREVIEW_SV
AS
SELECT adr.assessid
,ar.Rater
,ar.caseno
,ar.reviewdate
,ar.DATETIMESTAMP
--1. Introduction to Consumer Data
--1.B. CONSUMER DEMOGRAPHICS
,MAX(CASE 
  WHEN adr.scale = 'Consumer''s LIVING ARRANGEMENT (Include in the "Lives Alone" category, Consumers who live in AL, Dom Care, and PCH, pay rent, and have no roommate.)'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS CD_1_B_3
,MAX(CASE 
  WHEN adr.scale  = 'Is Consumer a VETERAN?'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS CD_1_B_6
--1.C. ADDRESS INFORMATION  
,MAX(CASE 
  WHEN adr.scale = 'RESIDENTIAL Municipality (Usually a Township or Boro where Consumer Votes, Pays Taxes.)'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS AI_1_C_6
,MAX(CASE 
  WHEN adr.scale = 'DIRECTIONS to Consumer''s Home'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS AI_1_C_13
--1.D. CARE MANAGEMENT INFORMATION  
,MAX(CASE 
  WHEN adr.scale = 'Where was Consumer interviewed?'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS CMI_1_D_1
,MAX(CASE 
  WHEN adr.scale = 'Does the Consumer have a Legal Guardian or Durable Power of Attorney ?'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS CMI_1_D_2
,MAX(CASE 
  WHEN adr.scale = 'Did the Consumer have a representative present and participating during the completion of the CMI?'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS CMI_1_D_3
--1.E. CONSUMER CONTACT
,MAX(CASE 
  WHEN adr.scale = 'Emergency Contact: Name of Friend /Relative'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS CC_1_E_1
,MAX(CASE 
  WHEN adr.scale = 'Relationship of Emergency Contact'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS CC_1_E_2
,MAX(CASE 
  WHEN adr.scale = 'Address of Emergency Contact'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS CC_1_E_3
,MAX(CASE 
  WHEN adr.scale = 'City or Town of Emergency Contact'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS CC_1_E_4
,MAX(CASE 
  WHEN adr.scale = 'State of Emergency Contact'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS CC_1_E_5
,MAX(CASE 
  WHEN adr.scale = 'Zip Code of Emergency Contact'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS CC_1_E_6
,MAX(CASE 
  WHEN adr.scale = 'Primary Telephone Number of Emergency Contact'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS CC_1_E_7
,MAX(CASE 
  WHEN adr.scale = 'Alternate Telephone Number of  Emergency Contact'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS CC_1_E_8
  
--2. Physical Health
--2.A. PHYSICIAN CONTACTS
,MAX(CASE 
  WHEN adr.scale = 'Primary Care Physician''s NAME'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_A_1
,MAX(CASE 
  WHEN adr.scale = 'Primary Care Physician''s Work Phone Number'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_A_2
,MAX(CASE 
  WHEN adr.scale = 'Primary Care Physician''s ADDRESS (Optional)'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_A_3
,MAX(CASE 
  WHEN adr.scale = 'DATE of Last  Physician Visit (approximate):  If unsure, document known information in Notes.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_A_4
,MAX(CASE 
  WHEN adr.scale = 'Physical Health Notes'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_A_5
--2.B. USE OF MEDICAL SERVICES
,MAX(CASE 
  WHEN adr.scale = 'Has the Consumer received treatment as a patient (emergency room or admitted)  in a hospital in the past 12 months?'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_B_1
,MAX(CASE 
  WHEN adr.scale = 'In past year, how many times has the Consumer stayed overnight in hospital?  Document in the Notes the Dates of each hospital admission.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_B_2
,MAX(CASE 
  WHEN adr.scale = 'In the past 12 months, how many days was the Consumer a resident in a nursing facility (does not include respite)?'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_B_3
,MAX(CASE 
  WHEN adr.scale = 'Why did the Consumer stay in a nursing facility in the past 12 months?  Use Notes if more space is needed (does not include respite).'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_B_4
,MAX(CASE 
  WHEN adr.scale = 'Medical Services Notes'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_B_5
--2.C. ILLNESS AND CONDITIONS: EYE,EAR, NOSE, THROAT AND MOUTH
,MAX(CASE 
  WHEN adr.scale = 'EYES: Glaucoma/Cataracts/Macular Degeneration or other eye problems.  List diagnosis/condition, symptoms, and medical need(s) created by Dx, complications, severity, effects on function, problems, treatments, and who provides, etc. in Notes.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_C_1
,MAX(CASE 
  WHEN adr.scale = 'VISION QUALITY:  (with glasses or contacts, if they are regularly used).  Document in Notes.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_C_2
,MAX(CASE 
  WHEN adr.scale = 'HEARING ABILITY: (with a hearing appliance, if used).  Document in Notes.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_C_3
,MAX(CASE 
  WHEN adr.scale = 'HEARING PROBLEMS:  not corrected with aids/devices?  Document in Notes.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_C_4
,MAX(CASE 
  WHEN adr.scale = 'SPEECH QUALITY:  List diagnosis/condition, symptoms, and medical need(s) created by Dx, complications, severity, effects on function, problems, treatments, and who provides, etc. in Notes.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_C_5
,MAX(CASE 
  WHEN adr.scale = 'Illness and Condition, Eye, Ear, Nose Throat and Mouth Notes'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_C_6
--2.D. ILLNESSES AND CONDITIONS, BREAST, CARDIOPULMONARY, AND OTHER INTERNAL ORGANS
,MAX(CASE 
  WHEN adr.scale = 'LUNG/BREATHING PROBLEMS:  TB, asthma, pneumonia, chronic obstructive pulmonary disease (bronchitis, emphysema), allergies, orthopnea, dyspnea?  Document in Notes.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_D_1
,MAX(CASE 
  WHEN adr.scale = 'HEART:  Angina, Irregular Heart Rate, Congestive Heart Failure, High Blood Pressure, Heart Attack .  Document in Notes section.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_D_2
,MAX(CASE 
  WHEN adr.scale = 'CIRCULATION PROBLEMS:  Leg ulcers, edema (swelling), varicosities, peripheral vascular disease, cerebral insufficiency, thrombus, embolus?  Document in Notes.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_D_3
,MAX(CASE 
  WHEN adr.scale = 'LYMPH NODES:  Enlargement?  Document in Notes.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_D_4
,MAX(CASE 
  WHEN adr.scale = 'EXTREMITIES:  Paralysis, Missing Limbs, Weakness?  Document in Notes.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_D_5
,MAX(CASE 
  WHEN adr.scale = 'GASTROINTESTINAL PROBLEMS:  Ulcer, bleeding, colitis, intestinal problems, diverticulosis, jaundice, gall bladder disease, gastro-esophageal reflux disorder (GERD)?  Document in Notes.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_D_6
,MAX(CASE 
  WHEN adr.scale = 'Illnesses and Conditions, Breast, CardioPulmonary, and other Internal Organs Notes'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_D_7
--2.E. ILLNESSES AND CONDITIONS, GENERAL
,MAX(CASE 
  WHEN adr.scale = 'MUSCULOSKELETAL:  Effect of fractures, osteoporosis, osteoarthritis, rheumatoid arthritis, contractures?  Document in Notes section.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_E_1
,MAX(CASE 
  WHEN adr.scale = 'SKIN CONDITIONS:  Dry, fragile, rashes, Psoriasis, open areas, excoriated areas, decubiti (pressure sores, bed sores), burns, bruises?  Document in Notes.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_E_2
,MAX(CASE 
  WHEN adr.scale = 'NERVOUS SYSTEM or OTHER RELATED CONDITIONS (ORC):  Effects of a stroke, Parkinson''s disease, cerebral palsy, muscular dystrophy, multiple sclerosis, polio history, seizures, epilepsy, or transient ischemic attacks?  Document in Notes.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_E_3
,MAX(CASE 
  WHEN adr.scale = 'BLOOD DISEASES:  Anemia, leukemia?  Document in Notes.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_E_4
,MAX(CASE 
  WHEN adr.scale = 'ENDOCRINE (GLANDULAR) DISORDERS:  Diabetes, thyroid, spleen, pancreas, liver, metabolic disorders?  Document in Notes.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_E_5
,MAX(CASE 
  WHEN adr.scale = 'KIDNEY/URINARY TRACT PROBLEMS:  Urinary retention, infection, kidney failure?  Document in Notes.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_E_6
,MAX(CASE 
  WHEN adr.scale = 'CANCER, TUMORS, LEUKEMIA, LYMPHOMA, HODGKIN''S:  Document in Notes.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_E_7
,MAX(CASE 
  WHEN adr.scale = 'Illnesses and Conditions, General Notes'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_E_8
--2.F. COMMUNICABLE DISEASES, DISABILITIES AND SURGERIES
,MAX(CASE 
  WHEN adr.scale = 'COMMUNICABLE DISEASES:  Document in Notes section.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_F_1
,MAX(CASE 
  WHEN adr.scale = 'OTHER DISABILITIES OR HEALTH PROBLEMS:  Specify and document in Notes section.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_F_2
,MAX(CASE 
  WHEN adr.scale = 'PHYSICAL HEALTH score:  Only required for Consumers being served in the community.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_F_3
,MAX(CASE 
  WHEN adr.scale = 'Communicable Diseases, Disabilities and Surgeries Notes'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_F_4
--2.G. COGNITIVE AND MENTAL HEALTH CONDITIONS
,MAX(CASE 
  WHEN adr.scale = 'PSYCHIATRIC DISORDERS:  Personality disorder, schizophrenia, anxiety, depression, mood swings, etc?  Document in Notes section.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_G_1
,MAX(CASE 
  WHEN adr.scale = 'DEMENTIA:  Alzheimer''s Disease, multi-infarct?  Document in Notes section.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_G_2
,MAX(CASE 
  WHEN adr.scale = 'TRAUMATIC BRAIN INJURY (TBI):  Does the Consumer have a traumatic brain injury sustained between birth to 22nd birthday?  Document in Notes section.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_G_3
,MAX(CASE 
  WHEN adr.scale = 'INTELLECTUAL DISABILITY:  Does the Consumer have a diagnosis of Intellectual Disability or is s/he known to the Intellectual Disability System?  Document in the Notes section.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_G_4
,MAX(CASE 
  WHEN adr.scale = 'AUTISM:  Does the Consumer have a diagnosis of Autism?  Document in Notes section.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_G_5
,MAX(CASE 
  WHEN adr.scale = 'NEED FOR SUPERVISION:  Taking into account physical health, mental impairment, and behavior, how long can the Consumer routinely be left alone at home safely?'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_G_6
,MAX(CASE 
  WHEN adr.scale = 'Cognitive and Mental Health Conditions Notes'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_G_7
--2.H. CURRENT MEDICATIONS
,MAX(CASE 
  WHEN adr.scale = 'MANAGING MEDICATIONS:  Requires assistance in managing medications?'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_H_1
,MAX(CASE 
  WHEN adr.scale = 'Type of help needed with medications:  Select all that apply.  If other assistance required, document in Notes.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_H_2
,MAX(CASE 
  WHEN adr.scale = 'Current Medications Notes'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PC_2_H_3
  
--3. Activities of Daily Living
--3.A. ADL's
,MAX(CASE 
  WHEN adr.scale = 'BATHING:  Rate the Consumer''s ability.  If response is 2-5, document in Notes additional help needed, comments or other relevant information.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS ADL_3_A_1
,MAX(CASE 
  WHEN adr.scale = 'DRESSING:  Rate the Consumer''s ability.   If response is 2-5, document in Notes any additional help needed, comments or other relevant information.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS ADL_3_A_2
,MAX(CASE 
  WHEN adr.scale = 'GROOMING:  Rate the Consumer''s ability.  If response is 2-5, document in Notes any additional help needed, comments or relevant information.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS ADL_3_A_3
,MAX(CASE 
  WHEN adr.scale = 'EATING:  Rate the Consumer''s ability.  If response is 2-5, document in Notes any additional help needed, comments or relevant information.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS ADL_3_A_4
,MAX(CASE 
  WHEN adr.scale = 'TRANSFER:   Rate the Consumer''s ability.  If response is 2-5, document in Notes any additional help needed, comments or relevant information.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS ADL_3_A_5
,MAX(CASE 
  WHEN adr.scale = 'TOILETING:  Rate the Consumer''s ability.  If response is 2-5, document in Notes any additional help needed, comments, or relevant information.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS ADL_3_A_6
,MAX(CASE 
  WHEN adr.scale = 'BLADDER MANAGEMENT:  Rate the Consumer''s ability.  If response is 2-5, document in Notes any additional help needed, comments, or relevant information.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS ADL_3_A_7
,MAX(CASE 
  WHEN adr.scale = 'BOWEL MANAGEMENT:  Rate the Consumer''s ability.  If response is 2-5, document in Notes any additional help needed, comments, or relevant information.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS ADL_3_A_8
,MAX(CASE 
  WHEN adr.scale = 'Comments/additional relevant information on ADL''s.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS ADL_3_A_9
,MAX(CASE 
  WHEN adr.scale = 'Number of ADL''s'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS ADL_3_A_10
,MAX(CASE 
  WHEN adr.scale = 'ADL score.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS ADL_3_A_11
  
--4. Mobility
--4.A. MOBILITY
,MAX(CASE 
  WHEN adr.scale = 'WALK INDOORS:  If coded 2-5, document in Notes how Consumer currently manages, any additional help needed, comments, or relevant information.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS M_4_A_1
,MAX(CASE 
  WHEN adr.scale = 'BEDBOUND:  Is Consumer bedbound and non-ambulatory?  Document in Notes any help needed, comments or relevant information.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS M_4_A_2
,MAX(CASE 
  WHEN adr.scale = 'WALK OUTDOORS:  If coded 2-5, document in Notes how the Consumer currently manages, any additional help needed, comments or additional relevant information.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS M_4_A_3
,MAX(CASE 
  WHEN adr.scale = 'CLIMB STAIRS:  If coded 2-5, document in the Notes how Consumer currently manages, any additional help needed, comments, or relevant information'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS M_4_A_4
,MAX(CASE 
  WHEN adr.scale = 'WHEEL IN CHAIR:  If coded 2-5 document in Notes how Consumer currently manages, any additional help needed, comments, or other relevant information.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS M_4_A_5
,MAX(CASE 
  WHEN adr.scale = 'AT RISK OF FALLING:  If yes, document in Notes the risk factor and any additional help needed, comments, or relevant information.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS M_4_A_6
,MAX(CASE 
  WHEN adr.scale = 'FALLEN RECENTLY:  If yes, document circumstances in Notes, document in Notes any additional comments or relevant information.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS M_4_A_7
,MAX(CASE 
  WHEN adr.scale = 'Enter any additional comments regarding mobility.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS M_4_A_8
,MAX(CASE 
  WHEN adr.scale = 'MOBILITY score.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS M_4_A_9
  
--5. Instrumental Activities of Daily Living
--5.A. IADL'S
,MAX(CASE 
  WHEN adr.scale = 'MEAL PREPARATION:  If rated 2-4 document in Notes how Consumer currently manages and any additional help needed.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS IADL_5_A_1
,MAX(CASE 
  WHEN adr.scale = 'DOING HOUSEWORK:  If rated 2-4 document in Notes how Consumer currently manages and any additional help needed.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS IADL_5_A_2
,MAX(CASE 
  WHEN adr.scale = 'DOING LAUNDRY.  If rated 2-4 document in Notes how Consumer currently manages and any additional help needed.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS IADL_5_A_3
,MAX(CASE 
  WHEN adr.scale = 'SHOPPING:  If rated 2-4 document in Notes how Consumer currently manages and any additional help needed.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS IADL_5_A_4
,MAX(CASE 
  WHEN adr.scale = 'USING TRANSPORTATION:  If rated 2-4 document in Notes how Consumer currently manages and any additional help needed.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS IADL_5_A_5
,MAX(CASE 
  WHEN adr.scale = 'MANAGING MONEY:  If rated 2-4 document in Notes how Consumer currently manages and any additional help needed.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS IADL_5_A_6
,MAX(CASE 
  WHEN adr.scale = 'USING TELEPHONE:  If rated 2-4 document in Notes how Consumer currently manages and any additional help needed.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS IADL_5_A_7
,MAX(CASE 
  WHEN adr.scale = 'HOME MAINTENANCE (chores and repairs):  If rated 2-4 document in Notes how Consumer currently manages and any additional help needed.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS IADL_5_A_8
,MAX(CASE 
  WHEN adr.scale = 'Enter any additional comments regarding IADLs.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS IADL_5_A_9
,MAX(CASE 
  WHEN adr.scale = 'Displays the number of IADLs with functionality issues.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS IADL_5_A_10
,MAX(CASE 
  WHEN adr.scale = 'IADL score.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS IADL_5_A_11

--6. Nutrition
--6.A. DIETARY HABITS
,MAX(CASE 
  WHEN adr.scale = 'Uses dietary supplements or aids?'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS DH_6_A_1
,MAX(CASE 
  WHEN adr.scale = 'Special diet for medical reasons?  Document diet in Notes.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS DH_6_A_2
,MAX(CASE 
  WHEN adr.scale = 'Comments/concerns regarding the Consumer''s nutritional status.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS DH_6_A_3
--6.B. NUTRITIONAL RISK ASSESSMENT
,MAX(CASE 
  WHEN adr.scale = 'Changes in lifelong eating habits because of health problems?'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS NRA_6_B_1

--7. Cognitive Functioning
--7.A. CONSUMER COGNITIVE
,MAX(CASE 
  WHEN adr.scale = 'Consumer presents as alert and without cognitive impairment?  Document in Notes.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS CC_7_A_1
,MAX(CASE 
  WHEN adr.scale = 'Consumer''s ability to judge safety?  Document in Notes.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS CC_7_A_2
,MAX(CASE 
  WHEN adr.scale = 'Consumer understands consequences of decisions?  Document in Notes.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS CC_7_A_3
,MAX(CASE 
  WHEN adr.scale = 'Information sources for Consumer''s cognitive status?'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS CC_7_A_4
,MAX(CASE 
  WHEN adr.scale = 'Consumer Cognitive Status Notes'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS CC_7_A_5
--7.B. SHORT PORTABLE MENTAL STATUS QUESTIONNAIRE - CONSUMER
,MAX(CASE 
  WHEN adr.scale = 'Consumer knows TODAY''S DATE?'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS SPMS_7_B_1
,MAX(CASE 
  WHEN adr.scale = 'Consumer knows DAY OF THE WEEK?'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS SPMS_7_B_2
,MAX(CASE 
  WHEN adr.scale = 'Consumer knows LOCATION?'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS SPMS_7_B_3
,MAX(CASE 
  WHEN adr.scale = 'Consumer knows TELEPHONE NUMBER (street address if no phone)?'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS SPMS_7_B_4
,MAX(CASE 
  WHEN adr.scale = 'Consumer knows AGE?'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS SPMS_7_B_5
,MAX(CASE 
  WHEN adr.scale = 'Consumer knows DATE OF BIRTH?'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS SPMS_7_B_6
,MAX(CASE 
  WHEN adr.scale = 'Consumer knows CURRENT PRESIDENT?'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS SPMS_7_B_7
,MAX(CASE 
  WHEN adr.scale = 'Consumer knows PREVIOUS PRESIDENT?'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS SPMS_7_B_8
,MAX(CASE 
  WHEN adr.scale = 'Consumer knows MOTHER''S MAIDEN NAME?'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS SPMS_7_B_9
,MAX(CASE 
  WHEN adr.scale = 'SUBTRACTION TEST:  Subtract 3 from 20 etc.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS SPMS_7_B_10
--7.C. SPMSQ RESULTS
,MAX(CASE 
  WHEN adr.scale = 'Consumer Subtraction Test result?'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS SPMSQ_7_C_1
,MAX(CASE 
  WHEN adr.scale = 'Highest grade Consumer completed in school?  If unknown, enter 0 and a note describing why it is unknown.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS SPMSQ_7_C_2
,MAX(CASE 
  WHEN adr.scale = 'COGNITIVE FUNCTIONING Score:  Only required for Consumers being served in the community.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS SPMSQ_7_C_3

--8. Informal Supports
--8.A. PRIMARY HELPER/CAREGIVER SECTION
,MAX(CASE 
  WHEN adr.scale = 'Does Consumer have an identified Primary (informal) HELPER/Caregiver who provides care on regular basis?'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PHCS_8_A_1
,MAX(CASE 
  WHEN adr.scale = 'Primary HELPER''S Last Name'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PHCS_8_A_2
,MAX(CASE 
  WHEN adr.scale = 'Primary HELPER''S First Name'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PHCS_8_A_3
,MAX(CASE 
  WHEN adr.scale = 'Primary HELPER''S Address'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PHCS_8_A_4
,MAX(CASE 
  WHEN adr.scale = 'Primary HELPER''S Telephone Number'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PHCS_8_A_5
,MAX(CASE 
  WHEN adr.scale = 'Relationship of Primary HELPER to Consumer'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PHCS_8_A_6
,MAX(CASE 
  WHEN adr.scale = 'What type of help does the Consumer''s Primary Unpaid HELPER/Caregiver provide?'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PHCS_8_A_7
--8.B. PRIMARY CAREGIVER/REPRESENTATIVE COGNITIVE
,MAX(CASE 
  WHEN adr.scale = 'Caregiver/Representative presents as alert and without cognitive impairment?'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS PCRC_8_B_1

--9. Formal Supports
--9.A. GENERAL
,MAX(CASE 
  WHEN adr.scale = 'Is Consumer receiving, has recently received or scheduled to receive formal services?'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS G_9_A_1
,MAX(CASE 
  WHEN adr.scale = 'Participating in following services or programs?  Note additional comments.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS G_9_A_2
,MAX(CASE 
  WHEN adr.scale = 'If in hospital or other facility discharge, are services scheduled to begin upon discharge?  If so, document in the Notes.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS G_9_A_3
,MAX(CASE 
  WHEN adr.scale = 'Formal Supports General Notes'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS G_9_A_4

--10. Physical Environment
--10.A. CURRENT DWELLING UNIT
,MAX(CASE 
  WHEN adr.scale = 'Does the Consumer own his/her current residence?'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS CDU_10_A_1
--10.B. CONDITION OF HOME
,MAX(CASE 
  WHEN adr.scale = 'Does the Consumer need any of the following new, repaired or additional devices or home modifications to help him/her to continue to stay in his/her home?'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS COH_10_B_1
,MAX(CASE 
  WHEN adr.scale = 'PHYSICAL ENVIRONMENT score.  Only required for Consumers being served in the community.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS COH_10_B_2

--11. Financial Resources
--11.A. CONSUMER INCOME – REQUIRED
,MAX(CASE 
  WHEN adr.scale = 'Medicaid Application Pending/PA-600L being completed?'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS CI_11_A_1
,MAX(CASE 
  WHEN adr.scale = 'Consumer''s Monthly Social Security Income (SS)'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS CI_11_A_2
,MAX(CASE 
  WHEN adr.scale = 'Total annual income of Consumer''s household?'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS CI_11_A_3
--11.B CONSUMER HEALTH INSURANCE - REQUIRED FOR FCSP
,MAX(CASE 
  WHEN adr.scale = 'Consumer''s Medicare A policy number.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS CHI_11_B_1
,MAX(CASE 
  WHEN adr.scale = 'Consumer''s Medicare B policy number.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS CHI_11_B_2
,MAX(CASE 
  WHEN adr.scale = 'Consumer''s Medigap policy number.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS CHI_11_B_3
,MAX(CASE 
  WHEN adr.scale = 'Consumer''s Medicare HMO policy number.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS CHI_11_B_4
,MAX(CASE 
  WHEN adr.scale = 'Consumer''s Medical Assistance number.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS CHI_11_B_5
,MAX(CASE 
  WHEN adr.scale = 'Consumer''s long term care insurance carrier and  policy number.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS CHI_11_B_6
,MAX(CASE 
  WHEN adr.scale = 'Consumer''s other health insurance carrier, if applicable.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS CHI_11_B_7
--11.C. FINANCIAL/LEGAL MANAGEMENT
,MAX(CASE 
  WHEN adr.scale = 'Select appropriate assistance with legal/financial matters?   Document needs in the Notes.'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS FLM_11_C_1
,MAX(CASE 
  WHEN adr.scale = 'If used, name of legal/financial assistant?'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS FLM_11_C_2
,MAX(CASE 
  WHEN adr.scale = 'Financial/Legal Management Notes'
  THEN dbms_lob.substr(adr.item, 4000, 1)
  ELSE NULL
  END) AS FLM_11_C_3

--12. Care Management Certification
,MAX(CASE 
  WHEN adr.scale = 'Summary'
  THEN REGEXP_REPLACE(ASCIISTR(dbms_lob.substr(adr.item, 3965, 1)), '\\[[:xdigit:]]{4}', '') ||REGEXP_REPLACE(ASCIISTR(dbms_lob.substr(adr.item, 34, 3966)), '\\[[:xdigit:]]{4}', '')
  ELSE NULL
  END) AS CMC_12_3
FROM harmony_conv.assessmentreview ar 
join harmony_conv.assessmentdetreview adr on (ar.AssessID = adr.AssessID)
GROUP BY adr.assessid
,ar.Rater
,ar.caseno
,ar.reviewdate
,ar.DATETIMESTAMP;
    
GRANT SELECT ON MAXDAT_SUPPORT.D_CMI_ASSESSMENTDETREVIEW_SV TO MAXDAT_REPORTS;  
