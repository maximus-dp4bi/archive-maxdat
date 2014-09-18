-- Change from point to null to point to 0.
update F_NYEC_PA_BY_DATE
set DNPARI_ID = 286
where DNPARI_ID = 265;

commit;

update D_NYEC_PA_CURRENT
set "Cur Reactivation Indicator" = 0
where "Cur Reactivation Indicator" is null;

commit;