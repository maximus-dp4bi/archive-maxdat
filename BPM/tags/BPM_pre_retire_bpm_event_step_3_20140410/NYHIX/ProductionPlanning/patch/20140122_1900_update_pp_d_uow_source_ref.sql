
insert into maxdat.pp_cfg_unit_of_work 
values (15, 'NYHIX_MANUAL_TASKS', 'N', 'Minutes', 2, 'CAL', 15, 'Manual Tasks');
insert into maxdat.pp_cfg_unit_of_work 
values (16, 'NYHIX_RETURNED_MAIL', 'N', 'Minutes', 2, 'CAL', 15, 'Returned Mail');
insert into maxdat.pp_cfg_unit_of_work 
values (17, 'NYHIX_HOLD', 'N', 'Minutes', 50, 'CAL', 50, 'Hold');

insert into maxdat.pp_d_unit_of_work 
values (15, 'NYHIX_MANUAL_TASKS', 'Minutes', 2, 'Manual Tasks');
insert into maxdat.pp_d_unit_of_work 
values (16, 'NYHIX_RETURNED_MAIL', 'Minutes', 2, 'Returned Mail');
insert into maxdat.pp_d_unit_of_work 
values (17, 'NYHIX_HOLD', 'Minutes', 50, 'Hold');


update pp_d_uow_source_ref set end_date = trunc(sysdate - 1)
where usr_id in (5,
40,
41,
39,
8,
10,
6,
9,
14,
20,
18,
17,
23,
22,
34,
35,
38,
24
);

insert into maxdat.pp_d_uow_source_ref values (  42  ,  7  ,  1  ,  'APPEAL'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  43,  7  ,  1  ,  'Cancel Hearing'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  44  ,  7  ,  1  ,  'DPR - Appeals'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  45  ,  7  ,  1  ,  'DPR - Existing Appeal'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  46  ,  7  ,  1  ,  'Incident Open'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  47  ,  7  ,  1  ,  'Refer to ES-C Supervisor'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  48  ,  7  ,  1  ,  'Reschedule Hearing - Appellant Request'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  49  ,  7  ,  1  ,  'Reschedule Hearing - DOH Request'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  50  ,  6  ,  1  ,  'NYHBE Complaints'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  51  ,  6  ,  1  ,  'Nyhbe Incident VHT'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  52  ,  6  ,  1  ,  'Supervisor Complaint Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  53  ,  8  ,  1  ,  'Data Entry-SHOP Employee Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  54  ,  8  ,  1  ,  'Data Entry-Verification Document Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  55  ,  8  ,  1  ,  'NYHBE Verification Doc Research Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  56  ,  9  ,  1  ,  'HSDE-QC'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  57  ,  10  ,  1  ,  'DPR - Account Correction'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  58  ,  10  ,  1  ,  'DPR - Application in Process'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  59  ,  10  ,  1  ,  'DPR - Multiple Applications'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  60  ,  10  ,  1  ,  'DPR - Wrong Program'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  61  ,  12  ,  1  ,  'DPR - Financial Management'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  62  ,  11  ,  1  ,  'Document Problem Resolution'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  63  ,  11  ,  1  ,  'DPR - Doc/Form Type Mismatch Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  64  ,  11  ,  1  ,  'DPR - Other'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  65  ,  11  ,  2  ,  'Other'  ,  'BATCH TYPE'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  66  ,  13  ,  1  ,  'Alternate Document Processing'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  67  ,  13  ,  1  ,  'Alternate Document VHT'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  68  ,  13  ,  1  ,  'App Prob Res VHT'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  69  ,  13  ,  1  ,  'Application Document Relink'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  70  ,  13  ,  1  ,  'Application Problem Resolution'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  71  ,  13  ,  1  ,  'Backlog Application Data Entry'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  72  ,  13  ,  1  ,  'Classification Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  73  ,  13  ,  1  ,  'Complaint Data Entry Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  74  ,  13  ,  1  ,  'Consent Form Data Entry Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  75  ,  13  ,  1  ,  'Consumer Consent Form Data Entry Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  76  ,  13  ,  1  ,  'CSR General Reminder Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  77  ,  13  ,  1  ,  'Daily Eligible Error Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  78  ,  13  ,  1  ,  'Data Correction'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  79  ,  13  ,  1  ,  'Data Entry Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  80  ,  13  ,  1  ,  'DE General Reminder Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  81  ,  13  ,  1  ,  'Discrepancy on RFE Status'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  82  ,  13  ,  1  ,  'Disenrollment Denial Data Entry Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  83  ,  13  ,  1  ,  'Doc Prob Res VHT'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  84  ,  13  ,  1  ,  'EC/DE Disenroll Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  85  ,  13  ,  1  ,  'EE Adjudicator Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  86  ,  13  ,  1  ,  'EE Disposition Review Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  87  ,  13  ,  1  ,  'EE MI Received Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  88  ,  13  ,  1  ,  'EE Processing Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  89  ,  13  ,  1  ,  'EE with MI Call Customer Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  90  ,  13  ,  1  ,  'Enrollment Correction Task for EEU'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  91  ,  13  ,  1  ,  'Enrollment Correction Task for Special Projects'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  92  ,  13  ,  1  ,  'Enrollment Correction Task for State'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  93  ,  13  ,  1  ,  'Enrollment Data Entry Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  94  ,  13  ,  1  ,  'ERL Extract Daily Selections Error'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  95  ,  13  ,  1  ,  'ETL Load Selection Response Error'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  96  ,  13  ,  1  ,  'Exemption Exclusion Data Entry Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  97  ,  13  ,  1  ,  'Fair Hearing Notice email to prn scn Dt Entry Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  98  ,  13  ,  1  ,  'Fair Hearing Notice List Data Entry Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  99  ,  13  ,  1  ,  'FEC Presentation Survey Data Entry Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  100  ,  13  ,  1  ,  'General Correspondence Data Entry Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  101  ,  13  ,  1  ,  'General Correspondence Letter Data Entry Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  102  ,  13  ,  1  ,  'Health Assessment Form Data Entry Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  103  ,  13  ,  1  ,  'HRA MCSS Disposition Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  104  ,  13  ,  1  ,  'HRA Med. Dir. Disposition Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  105  ,  13  ,  1  ,  'HRA On-Site Clinicians Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  106  ,  13  ,  1  ,  'Incomplete'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  107  ,  13  ,  1  ,  'Letter Generation Error'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  108  ,  13  ,  1  ,  'Letter Request Creation Error'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  109  ,  13  ,  1  ,  'Letter Resend Request'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  110  ,  13  ,  1  ,  'Letter Voided Error'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  111  ,  13  ,  1  ,  'Liaison'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  112  ,  13  ,  1  ,  'Manual Linking'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  113  ,  13  ,  1  ,  'MAXIMUS EE Clinicians Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  114  ,  13  ,  1  ,  'Relink Request'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  115  ,  13  ,  1  ,  'Relink Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  116  ,  13  ,  1  ,  'Remand' ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  117 ,   13  ,  1  ,  'Rescan Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  118  ,  13  ,  1  ,  'Research Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  119  ,  13  ,  1  ,  'Returned Mail Data Entry Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  120  ,  13  ,  1  ,  'Special Projects Unit Fair Hearings'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  121  ,  13  ,  1  ,  'SPU Denied Selection Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  122  ,  13  ,  1  ,  'State Accep Task VHT'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  123  ,  13  ,  1  ,  'State Acceptance'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  124  ,  13  ,  1  ,  'State Complaints'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  125  ,  13  ,  1  ,  'State Data Entry'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  126  ,  13  ,  1  ,  'State Data Entry VHT'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  127  ,  13  ,  1  ,  'State EE Disposition Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  128  ,  13  ,  1  ,  'Supervisor Complaints VHT'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  129  ,  13  ,  1  ,  'Survey Data Entry Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  130  ,  14  ,  1  ,  'Link Doc Set QC Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  131  ,  14  ,  1  ,  'MAXIMUS-QC'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  132  ,  14  ,  1  ,  'MAXIMUS-QC VHT'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  133  ,  15  ,  1  ,  'Manual Human Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  134  ,  15  ,  1  ,  'Manual Task - General'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  135  ,  15  ,  1  ,  'MyManualTask'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  136  ,  15  ,  1  ,  'TPHI Manual Task'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  137  ,  16  ,  1  ,  'DPR - Financial Management'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  138  ,  16  ,  1  ,  'DPR - FM Returned Mail'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  139  ,  16  ,  1  ,  'DPR - Returned Mail Application'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  140  ,  17  ,  1  ,  'Appeal Validity Check'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  141 ,  17  ,  1  ,  'Awaiting Documentation'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  143  ,  17  ,  1  ,  'Awaiting Validity Amendment'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  144  ,  17  ,  1  ,  'Awaiting Validity Amendment - Individual'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  145  ,  17  ,  1  ,  'Awaiting Validity Amendment - SHOP'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;
insert into maxdat.pp_d_uow_source_ref values (  146  ,  17  ,  1  ,  'Awaiting Written Withdrawal'  ,  'TASK ID'  ,  TO_DATE('01/22/2014','mm/dd/yyyy')  ,  TO_DATE('07/07/2077','mm/dd/yyyy')  )  ;

commit;

/
