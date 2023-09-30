/*
Created on 11/13/2015 by Raj A.
Description:
Created for MAXDAT-2721, to make the PL Semantic package a Corp process.
*/
INSERT INTO corp_etl_list_lkup
(NAME,LIST_TYPE,VALUE,out_var,comments)
VALUES
(
'N'
,'PL_CORP_SEMANTIC_PKG'
,'N'
,'Other'
,'Global controls used in the Process Letters Semantic package. These controls help make the pkg a Corp process.'
);

INSERT INTO corp_etl_list_lkup (NAME,LIST_TYPE,VALUE,out_var,comments)
VALUES (
'N' --newborn_flag
,'PL_CORP_SEMANTIC_PKG' --list_type
,'IA - Mandatory Welcome Letter (PCCM/VMC)' -- value letter_type
,'New Enrollment' --out_var sla_category
,'Global controls used in the Process Letters Semantic package. These controls help make the pkg a Corp process.'
);
INSERT INTO corp_etl_list_lkup (NAME,LIST_TYPE,VALUE,out_var,comments)
VALUES (
'N' --newborn_flag
,'PL_CORP_SEMANTIC_PKG' --list_type
,'IA - Mandatory Welcome Letter for ACA ELigibles (PCCM)' -- value letter_type
,'New Enrollment' --out_var sla_category
,'Global controls used in the Process Letters Semantic package. These controls help make the pkg a Corp process.'
);
INSERT INTO corp_etl_list_lkup (NAME,LIST_TYPE,VALUE,out_var,comments)
VALUES (
'N' --newborn_flag
,'PL_CORP_SEMANTIC_PKG' --list_type
,'IA - Mandatory Welcome Letter (PCCM)' -- value letter_type
,'New Enrollment' --out_var sla_category
,'Global controls used in the Process Letters Semantic package. These controls help make the pkg a Corp process.'
);
INSERT INTO corp_etl_list_lkup (NAME,LIST_TYPE,VALUE,out_var,comments)
VALUES (
'N' --newborn_flag
,'PL_CORP_SEMANTIC_PKG' --list_type
,'IA - Mandatory Welcome Letter (ACA)' -- value letter_type
,'New Enrollment' --out_var sla_category
,'Global controls used in the Process Letters Semantic package. These controls help make the pkg a Corp process.'
);
INSERT INTO corp_etl_list_lkup (NAME,LIST_TYPE,VALUE,out_var,comments)
VALUES (
'N' --newborn_flag
,'PL_CORP_SEMANTIC_PKG' --list_type
,'IA - Mandatory Welcome Letter (ICP)' -- value letter_type
,'New Enrollment' --out_var sla_category
,'Global controls used in the Process Letters Semantic package. These controls help make the pkg a Corp process.'
);
INSERT INTO corp_etl_list_lkup (NAME,LIST_TYPE,VALUE,out_var,comments)
VALUES (
'N' --newborn_flag
,'PL_CORP_SEMANTIC_PKG' --list_type
,'IA - Mandatory Welcome Letter (MMC)' -- value letter_type
,'New Enrollment' --out_var sla_category
,'Global controls used in the Process Letters Semantic package. These controls help make the pkg a Corp process.'
);
INSERT INTO corp_etl_list_lkup (NAME,LIST_TYPE,VALUE,out_var,comments)
VALUES (
'N' --newborn_flag
,'PL_CORP_SEMANTIC_PKG' --list_type
,'IA - Mandatory Welcome Letter (CSN)' --value letter_type
,'New Enrollment' --out_var sla_category
,'Global controls used in the Process Letters Semantic package. These controls help make the pkg a Corp process.'
);

INSERT INTO corp_etl_list_lkup (NAME,LIST_TYPE,VALUE,out_var,comments)
VALUES (
'Y' --newborn_flag
,'PL_CORP_SEMANTIC_PKG' --list_type
,'IA - Mandatory Welcome Letter (PCCM/VMC)' -- value letter_type
,'Newly Eligible Newborn' --out_var sla_category
,'Global controls used in the Process Letters Semantic package. These controls help make the pkg a Corp process.'
);
INSERT INTO corp_etl_list_lkup (NAME,LIST_TYPE,VALUE,out_var,comments)
VALUES (
'Y' --newborn_flag
,'PL_CORP_SEMANTIC_PKG' --list_type
,'IA - Mandatory Welcome Letter for ACA ELigibles (PCCM)' -- value letter_type
,'Newly Eligible Newborn' --out_var sla_category
,'Global controls used in the Process Letters Semantic package. These controls help make the pkg a Corp process.'
);
INSERT INTO corp_etl_list_lkup (NAME,LIST_TYPE,VALUE,out_var,comments)
VALUES (
'Y' --newborn_flag
,'PL_CORP_SEMANTIC_PKG' --list_type
,'IA - Mandatory Welcome Letter (PCCM)' -- value letter_type
,'Newly Eligible Newborn'  --out_var sla_category
,'Global controls used in the Process Letters Semantic package. These controls help make the pkg a Corp process.'
);
INSERT INTO corp_etl_list_lkup (NAME,LIST_TYPE,VALUE,out_var,comments)
VALUES (
'Y' --newborn_flag
,'PL_CORP_SEMANTIC_PKG' --list_type
,'IA - Mandatory Welcome Letter (ACA)' -- value letter_type
,'Newly Eligible Newborn'  --out_var sla_category
,'Global controls used in the Process Letters Semantic package. These controls help make the pkg a Corp process.'
);
INSERT INTO corp_etl_list_lkup (NAME,LIST_TYPE,VALUE,out_var,comments)
VALUES (
'Y' --newborn_flag
,'PL_CORP_SEMANTIC_PKG' --list_type
,'IA - Mandatory Welcome Letter (ICP)' -- value letter_type
,'Newly Eligible Newborn'  --out_var sla_category
,'Global controls used in the Process Letters Semantic package. These controls help make the pkg a Corp process.'
);
INSERT INTO corp_etl_list_lkup (NAME,LIST_TYPE,VALUE,out_var,comments)
VALUES (
'Y' --newborn_flag
,'PL_CORP_SEMANTIC_PKG' --list_type
,'IA - Mandatory Welcome Letter (MMC)' -- value letter_type
,'Newly Eligible Newborn'  --out_var sla_category
,'Global controls used in the Process Letters Semantic package. These controls help make the pkg a Corp process.'
);
INSERT INTO corp_etl_list_lkup (NAME,LIST_TYPE,VALUE,out_var,comments)
VALUES (
'Y' --newborn_flag
,'PL_CORP_SEMANTIC_PKG' --list_type
,'IA - Mandatory Welcome Letter (CSN)' --value letter_type
,'Newly Eligible Newborn'  --out_var sla_category
,'Global controls used in the Process Letters Semantic package. These controls help make the pkg a Corp process.'
);

UPDATE corp_etl_list_lkup
   SET out_var = NULL
 WHERE 1=1
   AND ref_type = 'LETTER_TYPE'
   AND list_type = 'TASK_TYPE'
   AND NAME = 'ProcLetters_SLA_Days'
   AND VALUE = 'Other';
COMMIT;