
select * from hco_d_item
where item_id in(1970,1972);

delete from hco_d_item
where item_id in(1970,1972);

select * from HCO_D_ITEM_INVENTORY
where item_id  in(1970,1972);

delete from hco_d_item_inventory
where item_id  in(1970,1972);
commit;