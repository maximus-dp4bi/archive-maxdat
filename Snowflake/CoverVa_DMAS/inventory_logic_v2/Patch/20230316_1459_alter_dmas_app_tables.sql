alter table coverva_dmas.dmas_application_current ADD(renewal_closure_date TIMESTAMP_NTZ(9),auto_closure_date TIMESTAMP_NTZ(9),denial_reason VARCHAR);
alter table coverva_dmas.dmas_application ADD(renewal_closure_date TIMESTAMP_NTZ(9),auto_closure_date TIMESTAMP_NTZ(9),denial_reason VARCHAR);

alter table coverva_dmas.dmas_application_v2_current ADD(renewal_closure_date TIMESTAMP_NTZ(9),auto_closure_date TIMESTAMP_NTZ(9),denial_reason VARCHAR);
alter table coverva_dmas.dmas_application_v2_inventory ADD(renewal_closure_date TIMESTAMP_NTZ(9),auto_closure_date TIMESTAMP_NTZ(9),denial_reason VARCHAR);

alter table coverva_dmas.cp_application_inventory ADD(CLOSED_RENEWAL VARCHAR,RENEWAL_DUE_DATE DATE);
alter table coverva_dmas.cp_application_inventory_hist ADD(CLOSED_RENEWAL VARCHAR,RENEWAL_DUE_DATE DATE);