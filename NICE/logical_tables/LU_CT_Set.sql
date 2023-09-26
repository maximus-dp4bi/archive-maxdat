select distinct es.c_name as CT_Set, e.c_name as CT
from
nice_wfm_customer1.dbo.r_ct ct
inner join nice_wfm_customer1.dbo.r_entity e on ct.c_oid = e.c_oid and c_type = 'T'
inner join nice_wfm_customer1.dbo.r_entitysetmbr em on e.c_oid = em.c_entity
inner join nice_wfm_customer1.dbo.r_entityset es on em.c_entityset = es.c_oid