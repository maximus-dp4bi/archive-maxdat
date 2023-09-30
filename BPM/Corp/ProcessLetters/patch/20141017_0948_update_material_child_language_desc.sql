UPDATE corp_etl_proc_let_material_chd
SET language_desc = CASE language_cd 
                         WHEN 'KO' THEN 'Korean'
                         WHEN 'HC' THEN 'Creole-Haitian'
                         WHEN 'EN' THEN 'English'
                         WHEN 'SC' THEN 'Simplified Chinese'
                         WHEN 'RU' THEN 'Russian'
                         WHEN 'ES' THEN 'Spanish'
                         WHEN 'FR' THEN 'French'
                         ELSE NULL END
;   

commit;