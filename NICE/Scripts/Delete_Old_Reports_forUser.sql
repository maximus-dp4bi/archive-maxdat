----Script for deleting old reports for a user

-- Step1: Run the below query for the UserID. Get the C_OID column value

select * from r_user where c_username = '31076';

-- Step2: Copy&Paste the C_OID value from step1 query. Evaluate the results.

select count(*) from R_GENREPORTPARMS where C_GENREPORT in (
	select c_oid from r_genreport where c_owner = '8a16cc945d2fb2f9015d3e21286a2e3c');

-- Step3: Delete all the older reports. Enter the same C_OID value.

delete from R_GENREPORTPARMS where C_GENREPORT in (
	select c_oid from r_genreport where c_owner = '8a16cc945d2fb2f9015d3e21286a2e3c');