/* Attach to the NICE DB and the nice_wfm.customer1 DB to execute
These commands are used to identify and remove stray records that prevent supervior profles from being deleted in Agent Data Groups
Refer to JIRA - 2275 for an example of when this process was needed
*/


/* identify supervisor by name */
select * from [nice_wfm_customer1].dbo.r_agtdataval where c_alphaval like '%zzGonzalez, Jose%';

/* delete supervisor by name */
--delete from [nice_wfm_customer1].dbo.r_agtdataval where c_alphaval = 'zzSantos, Odair';

/* identify agents by C_OID */
select * from [nice_wfm_customer1].dbo.r_agtdata where C_AGTDATAVAL='8a16cc946749470e016774f230560d3b';

--delete from [nice_wfm_customer1].dbo.r_agtdata where C_AGTDATAVAL='8a16cc945519a3e401568f1ca6181c62';

/* Identify C_AGTDATAVAL instances from R_MUSETFUTACTIVITY table */
select * from [nice_wfm_customer1].dbo.R_MUSETFUTACTIVITY where C_AGTDATAVAL = '8a16cc946749470e016774f230560d3b';

/* delete stray C_AGTDATAVAL instances from the R_MUSETFUTACTIVITY table */
--delete from [nice_wfm_customer1].dbo.R_MUSETFUTACTIVITY where C_AGTDATAVAL = '8a16cc945519a40201554f7da1151848';