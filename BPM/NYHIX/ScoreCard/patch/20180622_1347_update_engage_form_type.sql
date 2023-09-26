---- NYHIX-41686

set define off;
update ENGAGE_FORM_TYPE 
set EVALUATION_FORM = 'QC_NYSOH_EE_HSDEQC_V Docs_v2.1'
where FORM_TYPE_ID = 667;

update ENGAGE_FORM_TYPE 
set EVALUATION_FORM = 'Supe Review_QC_NYSOH_EE_HSDEQC_V Docs_v2.1'
where FORM_TYPE_ID = 668;


commit;

