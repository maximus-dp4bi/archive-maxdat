delete from CORP_ETL_CONTROL Where name in (
'HCO_MATERIALORDER_CREATE_DATE',
'HCO_ORDER_UPDATE_DATE',
'HCO_ORDER_CREATE_DATE',
'HCO_LETTERMAILING_UPDATE_DATE',
'HCO_PACKETMAILING_UPDATE_DATE',
'HCO_MAILING_CREATE_DATE',
'HCO_ITEMINVENTORY_CREATE_DATE',
'HCO_ITEMINVENTORY_UPDATE_DATE',
'PO_LOOKBACK_DAYS',
'PO_ORDER_DATE',
'HCO_SHIPMENTORDER_ENTER_DATE',
'HCO_SHIPMENTORDER_UPDATE_DATE',
'HCO_LETTERDETAIL_CREATE_DATE',
'HCO_LETTERDETAIL_UPDATE_DATE',
'HCO_LTR_BADADDR_CREATE_DATE',
'HCO_LETTERMAILING_LOOKBACK_DAYS',
'HCO_PACKETMAILING_LOOKBACK_DAYS');

commit;

insert into CORP_ETL_CONTROL
values ('HCO_MATERIALORDER_CREATE_DATE','D','2017/01/01 00:00:00','Max material order creation date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('HCO_ORDER_UPDATE_DATE','D','2017/01/01 00:00:00','Max material order update date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('HCO_ORDER_CREATE_DATE','D','2017/01/01 00:00:00','Max order creation date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('HCO_LETTERMAILING_UPDATE_DATE','D','2017/01/01 00:00:00','Max letter mailing creation date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('HCO_LETTERMAILING_LOOKBACK_DAYS','N','180','This is the number of lookback days used to get the updates for letter mailings', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('HCO_PACKETMAILING_UPDATE_DATE','D','2017/01/01 00:00:00','Max letter mailing creation date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('HCO_PACKETMAILING_LOOKBACK_DAYS','N','180','This is the number of lookback days used to get the updates for packet mailings', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('HCO_MAILING_CREATE_DATE','D','2017/01/01 00:00:00','Date parameter to use to extract custom mailing indicator', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('HCO_ITEMINVENTORY_CREATE_DATE','D','2017/01/01 00:00:00','Max item inventory creation date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('HCO_ITEMINVENTORY_UPDATE_DATE','D','2017/01/01 00:00:00','Max item inventory update date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('PO_LOOKBACK_DAYS','N','45','This is the number of lookback days used to get the Purchase Order info in each run', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('PO_ORDER_DATE','D','2017/01/01 00:00:00','Order Date perameter', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('HCO_SHIPMENTORDER_ENTER_DATE','D','2017/01/01 00:00:00','Max enter date for order shipment from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('HCO_SHIPMENTORDER_UPDATE_DATE','D','2017/01/01 00:00:00','Max update date for order shipment from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('HCO_LETTERDETAIL_CREATE_DATE','D','2017/01/01 00:00:00','Max letter mailing creation date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('HCO_LETTERDETAIL_UPDATE_DATE','D','2017/01/01 00:00:00','Max letter mailing update date from source', sysdate, sysdate);

insert into CORP_ETL_CONTROL
values ('HCO_LTR_BADADDR_CREATE_DATE','D','2017/01/01 00:00:00','Max bad address create date from source', sysdate, sysdate);



commit;
