-- User Story 28488 CAHCO: IM-07 Report- Data issue fix
delete FROM MAXDAT.HCO_D_PURCHASEORDER_ITEM WHERE DP_PURCHASEORDER_item_id in (9815,9816);
commit;