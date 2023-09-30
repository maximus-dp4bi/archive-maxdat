/*
Created on 11/23/2015 by Raj A.
Description:
Created for MAXDAT-2721, to make the PL Semantic package a Corp process.
Per NYHIX PL workbook, SLA_Category is the Letter_type. So, these global controls are merely fetching letter_type.
But these are needed to make the process letters semantic package a corp process.
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
,'XA-Application Material Request' -- value letter_type
,'XA-Application Material Request' --out_var sla_category
,'Global controls used in the Process Letters Semantic package. These controls help make the pkg a Corp process.'
);
INSERT INTO corp_etl_list_lkup (NAME,LIST_TYPE,VALUE,out_var,comments)
VALUES (
'N' --newborn_flag
,'PL_CORP_SEMANTIC_PKG' --list_type
,'XX-Material Request' -- value letter_type
,'XX-Material Request' --out_var sla_category
,'Global controls used in the Process Letters Semantic package. These controls help make the pkg a Corp process.'
);
INSERT INTO corp_etl_list_lkup (NAME,LIST_TYPE,VALUE,out_var,comments)
VALUES (
'N' --newborn_flag
,'PL_CORP_SEMANTIC_PKG' --list_type
,'RE-Return Email Material Request' -- value letter_type
,'RE-Return Email Material Request' --out_var sla_category
,'Global controls used in the Process Letters Semantic package. These controls help make the pkg a Corp process.'
);
INSERT INTO corp_etl_list_lkup (NAME,LIST_TYPE,VALUE,out_var,comments)
VALUES (
'N' --newborn_flag
,'PL_CORP_SEMANTIC_PKG' --list_type
,'MN-Manual Notices Material Request' -- value letter_type
,'MN-Manual Notices Material Request' --out_var sla_category
,'Global controls used in the Process Letters Semantic package. These controls help make the pkg a Corp process.'
);
COMMIT;