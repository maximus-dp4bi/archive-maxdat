Update bpm_cin_snapshot set first_pe_checkpoint_date=to_date('09/09/1999','mm/dd/yyyy')
 where trunc(snapshot_date) =
       (select distinct first_value(trunc(snapshot_date)) over(partition by null order by snapshot_date desc)
          from bpm_cin_snapshot
         where snapshot_date <
               (select max(snapshot_date) from bpm_cin_snapshot))
   and first_pe_checkpoint_date is null
   and clnt_cin in
       (select distinct clnt_cin
          from bpm_cin_snapshot
         where trunc(snapshot_date) =
               (select distinct first_value(trunc(snapshot_date)) over(partition by null order by snapshot_date desc)
                  from bpm_cin_snapshot)
           and first_pe_checkpoint_date <
               (select distinct first_value(snapshot_date) over(partition by null order by snapshot_date desc)
                  from bpm_cin_snapshot
                 where snapshot_date <
                       (select max(snapshot_date) from bpm_cin_snapshot)));

/					   