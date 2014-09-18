create or replace view D_SCI_CURRENT_SV as
select * from D_SCI_CURRENT
with read only;

