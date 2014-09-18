alter table d_pi_current
add (
"ENROLLEE_RIN"   Varchar2(30),         
"REPORTER_NAME"  Varchar2(80)
);

/* Added on 06-Feb-2014 by Raj A: Though the TXEB project does not need enrollee_rin and reporter_name attributes these exist in the semantic view to keep it consistent
with corporate code.
*/
create or replace view D_PI_CURRENT_SV as
select * from D_PI_CURRENT
with read only;