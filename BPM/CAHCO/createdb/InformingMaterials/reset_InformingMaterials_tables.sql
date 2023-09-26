update corp_etl_control
set value = '2018/01/01 00:00:00'
where name like '%MAILING%'
or name like '%MATERIAL%'
or name like '%ITEM%'
or name like '%ORDER%';

commit;

truncate table hco_d_item_inventory;
truncate table hco_d_item;
truncate table hco_d_item_category;
truncate table hco_d_material_order;
truncate table hco_d_mailing;
truncate table hco_d_letter_mailing;
truncate table hco_d_packet_mailing;
truncate table hco_d_alternative_format;
truncate table hco_d_shipment_order;
truncate table hco_d_order;
truncate table hco_d_purchaseorder_item;
truncate table HCO_D_LETTER_DETAIL;