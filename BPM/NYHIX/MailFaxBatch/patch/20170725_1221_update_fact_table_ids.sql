DECLARE 
h_FMFBBH_ID number; 
l_FMFBBH_ID number;

begin
h_FMFBBH_ID := 9894839;
l_FMFBBH_ID := 9894760;

update F_MFB_BY_HOUR
set FMFBBH_ID = 999999999
where FMFBBH_ID = h_FMFBBH_ID;

update F_MFB_BY_HOUR
set FMFBBH_ID = h_FMFBBH_ID
where FMFBBH_ID = l_FMFBBH_ID;

update F_MFB_BY_HOUR
set FMFBBH_ID = l_FMFBBH_ID
where FMFBBH_ID = 999999999;

h_FMFBBH_ID := 9894785;
l_FMFBBH_ID := 9894733;

update F_MFB_BY_HOUR
set FMFBBH_ID = 999999999
where FMFBBH_ID = h_FMFBBH_ID;

update F_MFB_BY_HOUR
set FMFBBH_ID = h_FMFBBH_ID
where FMFBBH_ID = l_FMFBBH_ID;

update F_MFB_BY_HOUR
set FMFBBH_ID = l_FMFBBH_ID
where FMFBBH_ID = 999999999;

end;
/

commit;

