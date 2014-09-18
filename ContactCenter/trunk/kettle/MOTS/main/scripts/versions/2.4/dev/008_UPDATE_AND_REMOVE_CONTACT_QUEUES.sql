-- update cc_f_actuals_queue_interval queue IDs to NOT use the 'Unknown' queue type
update cc_f_actuals_queue_interval
set d_contact_queue_id = 267
where d_contact_queue_id in (130, 141);

update cc_f_actuals_queue_interval
set d_contact_queue_id = 268
where d_contact_queue_id in (134, 142);

update cc_f_actuals_queue_interval
set d_contact_queue_id = 253
where d_contact_queue_id in (138, 143);

update cc_f_actuals_queue_interval
set d_contact_queue_id = 267
where d_contact_queue_id in (130, 141);

update cc_f_actuals_queue_interval
set d_contact_queue_id = 254
where d_contact_queue_id in (144, 124);

update cc_f_actuals_queue_interval
set d_contact_queue_id = 255
where d_contact_queue_id in (127, 159);

update cc_f_actuals_queue_interval
set d_contact_queue_id = 256
where d_contact_queue_id in (160, 132);

update cc_f_actuals_queue_interval
set d_contact_queue_id = 269
where d_contact_queue_id in (136, 161);

update cc_f_actuals_queue_interval
set d_contact_queue_id = 270
where d_contact_queue_id in (157, 125);

update cc_f_actuals_queue_interval
set d_contact_queue_id = 271
where d_contact_queue_id in (126, 158);

update cc_f_actuals_queue_interval
set d_contact_queue_id = 272
where d_contact_queue_id in (131, 154);

update cc_f_actuals_queue_interval
set d_contact_queue_id = 273
where d_contact_queue_id in (135, 155);

update cc_f_actuals_queue_interval
set d_contact_queue_id = 274
where d_contact_queue_id in (139, 156);

update cc_f_actuals_queue_interval
set d_contact_queue_id = 275
where d_contact_queue_id in (152, 121);

update cc_f_actuals_queue_interval
set d_contact_queue_id = 276
where d_contact_queue_id in (153, 122);

update cc_f_actuals_queue_interval
set d_contact_queue_id = 277
where d_contact_queue_id in (128, 149);

update cc_f_actuals_queue_interval
set d_contact_queue_id = 278
where d_contact_queue_id in (150, 133);

update cc_f_actuals_queue_interval
set d_contact_queue_id = 257
where d_contact_queue_id in (137, 151);

update cc_f_actuals_queue_interval
set d_contact_queue_id = 258
where d_contact_queue_id in (140, 146);

update cc_f_actuals_queue_interval
set d_contact_queue_id = 259
where d_contact_queue_id in (123, 147);

update cc_f_actuals_queue_interval
set d_contact_queue_id = 260
where d_contact_queue_id in (129, 148);

-- remove queues with 'Unknown' queue type
delete cc_d_contact_queue
where d_contact_queue_id in (SELECT d_contact_queue_id
FROM CC_D_CONTACT_QUEUE
where queue_number >= 10039
  and queue_type = 'Unknown');
  
-- update effective dates of earliest version of queue type
update cc_d_contact_queue
set record_eff_dt = to_date('1900/01/01', 'yyyy/mm/dd')
  , record_end_dt = to_date('2014/05/13', 'yyyy/mm/dd')
  , version = 1
where d_contact_queue_id in (SELECT d_contact_queue_id
                            FROM CC_D_CONTACT_QUEUE
                            where queue_number >= 10039
                              and queue_type <> 'Unknown'
                              and record_eff_dt = to_date('2999/12/31 23:59:59', 'yyyy/mm/dd hh24:mi:ss'));

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME)
VALUES ('2.4','008','008_UPDATE_AND_REMOVE_CONTACT_QUEUES');

COMMIT;