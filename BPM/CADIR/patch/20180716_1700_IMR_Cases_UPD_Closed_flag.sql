/*
This script is created to set the closed flag for cases whose decision need to be updated.
Updated records will be processed by nightly ETL job.
*/

Update maxdat_cadr.s_crs_imr  set imr_closed_dt_flg = 'Y'
where IMR_Closed_dt_flg = 'N' and
 case_number in 
('CM18-0119239','CM18-0119224','CM18-0119198','CM18-0119197','CM18-0119275','CM18-0119194','CM18-0119191','CM18-0119190','CM18-0119322','CM18-0119180',
'CM18-0119188','CM18-0114733','CM18-0119447','CM18-0114467','CM18-0112766','CM18-0119318','CM18-0114835','CM18-0120026','CM18-0114807','CM18-0120492',
'CM18-0119421','CM18-0113949','CM18-0119828','CM18-0112542','CM18-0114744','CM18-0119480','CM18-0119312','CM18-0120102','CM18-0114763','CM18-0119317',
'CM18-0119473','CM18-0119347','CM18-0119429','CM18-0119495','CM18-0119511','CM18-0119524','CM18-0119457','CM18-0119582','CM18-0114117','CM18-0116465',
'CM18-0117465','CM18-0119846','CM18-0114828','CM18-0117476','CM18-0119602','CM18-0119625','CM18-0116505','CM18-0114875','CM18-0119623','CM18-0112547',
'CM18-0119530','CM18-0119975','CM18-0119544','CM18-0114877','CM18-0119455','CM18-0119523','CM18-0112850','CM18-0119483','CM18-0114841','CM18-0122068',
'CM18-0121019','CM18-0114739','CM18-0119837','CM18-0109226','CM18-0114874','CM18-0113182','CM18-0121882','CM18-0097250','CM18-0114885','CM18-0119876',
'CM18-0119843','CM18-0114887','CM18-0100406','CM18-0120914','CM18-0119848','CM18-0121618','CM18-0119880','CM18-0121016','CM18-0114969','CM18-0120553',
'CM18-0120194','CM18-0122225','CM18-0120731','CM18-0114938','CM18-0122245','CM18-0120549','CM18-0121037','CM18-0120110','CM18-0122232','CM18-0122240',
'CM18-0119901','CM18-0119883','CM18-0122973','CM18-0120879','CM18-0112529','CM18-0120485','CM18-0122462','CM18-0113829','CM18-0119967','CM18-0092986',
'CM18-0113051','CM18-0113202','CM18-0120966','CM18-0112807','CM18-0119977','CM18-0120545','CM18-0120915','CM18-0120851','CM18-0121090','CM18-0120536',
'CM18-0112018','CM18-0120521','CM18-0117490','CM18-0119588','CM18-0119503','CM18-0119507','CM18-0124549','CM18-0122520','CM18-0124138','CM18-0123752',
'CM18-0123393','CM18-0119635','CM18-0124158','CM18-0123432','CM18-0123152','CM18-0119614','CM18-0123706','CM18-0119668','CM18-0122521','CM18-0124198',
'CM18-0124559','CM18-0112784','CM18-0119805','CM18-0123703','CM18-0119839','CM18-0117534','CM18-0119806','CM18-0119872','CM18-0119917','CM18-0118672',
'CM18-0112247','CM18-0119637','CM18-0119916','CM18-0120516','CM18-0120505','CM18-0120535','CM18-0119990','CM18-0120507','CM18-0118696','CM18-0120551',
'CM18-0119247','CM18-0120645','CM18-0118831','CM18-0112153','CM18-0119265','CM18-0121180','CM18-0120523','CM18-0119268','CM18-0119060','CM18-0120965',
'CM18-0120562','CM18-0119267','CM18-0112820','CM18-0119272','CM18-0119262','CM18-0119270','CM18-0119281','CM18-0119283','CM18-0115905','CM18-0119286',
'CM18-0104063','CM18-0117983','CM18-0102986','CM18-0119277','CM18-0120555','CM18-0124190','CM18-0102077','CM18-0115100','CM18-0118317','CM18-0117135',
'CM18-0115236','CM18-0117478','CM18-0119117','CM18-0119211','CM18-0117382','CM18-0122403','CM18-0123390','CM18-0123704','CM18-0123222','CM18-0124791',
'CM18-0124251','CM18-0123674','CM18-0124866','CM18-0124331','CM18-0124539','CM18-0124000','CM18-0121127','CM18-0117316','CM18-0123368','CM18-0115252',
'CM18-0117687','CM18-0124486','CM18-0118300','CM18-0118170','CM18-0112277','CM18-0116593','CM18-0119273','CM18-0112785','CM18-0117480','CM18-0111009',
'CM18-0116208','CM18-0116296','CM18-0116519','CM18-0116539','CM18-0117040','CM18-0117246','CM18-0117559','CM18-0117247','CM18-0117249','CM18-0117251',
'CM18-0117258','CM18-0117259','CM18-0117282','CM18-0118883','CM18-0119216','CM18-0118090','CM18-0112779','CM18-0118862','CM18-0117670','CM18-0119541',
'CM18-0122707','CM18-0118977','CM18-0118261','CM18-0117412','CM18-0117424','CM18-0118285','CM18-0117112','CM18-0118679','CM18-0119954','CM18-0111477',
'CM18-0118618','CM18-0100216','CM18-0115810','CM18-0118761','CM18-0119751','CM18-0119048','CM18-0119213','CM18-0118070','CM18-0118996','CM18-0118673',
'CM18-0116513','CM18-0118359','CM18-0116496','CM18-0118323','CM18-0111950','CM18-0116438','CM18-0118884','CM18-0117956','CM18-0112543','CM18-0117483',
'CM18-0118274','CM18-0118744','CM18-0121248','CM18-0116375','CM18-0118507','CM18-0109624','CM18-0113236','CM18-0120045','CM18-0113066','CM18-0123750',
'CM18-0113143','CM18-0118451','CM18-0116559','CM18-0123955','CM18-0113150','CM18-0120057','CM18-0118899','CM18-0118858','CM18-0116452','CM18-0112471',
'CM18-0111519','CM18-0119128','CM18-0116572','CM18-0118735','CM18-0101695','CM18-0117715','CM18-0119931','CM18-0119948','CM18-0119160','CM18-0118495',
'CM18-0119914','CM18-0119951','CM18-0118318','CM18-0014570','CM18-0119972','CM18-0119884','CM18-0114423','CM18-0119911','CM18-0111930','CM18-0119786',
'CM18-0118362','CM18-0114479','CM18-0118794','CM18-0112426','CM18-0099954','CM18-0118725','CM18-0114494','CM18-0118578','CM18-0100800','CM18-0109439',
'CM18-0119035','CM18-0118943','CM18-0117905','CM18-0117711','CM18-0111726','CM18-0120509','CM18-0118776','CM18-0119807','CM18-0112537','CM18-0103152',
'CM18-0119287','CM18-0118829','CM18-0119228','CM18-0116583','CM18-0119036','CM18-0118540','CM18-0118928','CM18-0118537','CM18-0118891','CM18-0119456',
'CM18-0117168','CM18-0116874','CM18-0119195','CM18-0119006','CM18-0119141','CM18-0118890','CM18-0118369','CM18-0118372','CM18-0119261','CM18-0095496',
'CM18-0117368','CM18-0119199','CM18-0121996','CM18-0119840','CM18-0116081','CM18-0119373','CM18-0117200','CM18-0119490','CM18-0119774','CM18-0119135',
'CM18-0121504','CM18-0118892','CM18-0118614','CM18-0119584','CM18-0119149','CM18-0116950','CM18-0119532','CM18-0121274','CM18-0119518','CM18-0112801',
'CM18-0119686','CM18-0108231','CM18-0124200','CM18-0118382','CM18-0120243','CM18-0120257','CM18-0119546','CM18-0118196','CM18-0119170','CM18-0121084',
'CM18-0120330','CM18-0119791','CM18-0119540','CM18-0120795','CM18-0119051','CM18-0119803','CM18-0118857','CM18-0119944','CM18-0117866','CM18-0119278',
'CM18-0118309','CM18-0118291','CM18-0119593','CM18-0123504','CM18-0119431','CM18-0121552','CM18-0123681','CM18-0116701','CM18-0119147','CM18-0121001',
'CM18-0119533','CM18-0118434','CM18-0119630','CM18-0117462','CM18-0114609','CM18-0119731','CM18-0115869','CM18-0115440','CM18-0094246','CM18-0118428',
'CM18-0116661','CM18-0117505','CM18-0117417','CM18-0118226','CM18-0116911','CM18-0117101','CM18-0114785','CM18-0110645','CM18-0109422','CM18-0116446',
'CM18-0116441','CM18-0116406','CM18-0116414','CM18-0120022','CM18-0117527','CM18-0116294','CM18-0116973','CM18-0116995','CM18-0117254','CM18-0117385',
'CM18-0117293','CM18-0116940','CM18-0113631','CM18-0117825','CM18-0115507','CM18-0114910','CM18-0115052','CM18-0106622','CM18-0115150','CM18-0114993',
'CM18-0114873','CM18-0116629','CM18-0114952','CM18-0114977','CM18-0116775','CM18-0116785','CM18-0116776','CM18-0116793','CM18-0116761','CM18-0114726',
'CM18-0116816','CM18-0116798','CM18-0113934','CM18-0116819','CM18-0113911','CM18-0116235','CM18-0114860','CM18-0114605','CM18-0115900','CM18-0115552',
'CM18-0115695','CM18-0114412','CM18-0115272','CM18-0114728','CM18-0116622','CM18-0118961','CM18-0117235','CM18-0117384','CM18-0116696','CM18-0114175',
'CM18-0116710','CM18-0115734','CM18-0114679','CM18-0115459','CM18-0114089','CM18-0115730','CM18-0112735','CM18-0117280','CM18-0121629','CM18-0117389',
'CM18-0116744','CM18-0116709','CM18-0115650','CM18-0114411','CM18-0114110','CM18-0114861','CM18-0113968','CM18-0118393','CM18-0117641','CM18-0114264',
'CM18-0117283','CM18-0115564','CM18-0112293','CM18-0116741','CM18-0115234','CM18-0116159','CM18-0119424','CM18-0114435');

commit;