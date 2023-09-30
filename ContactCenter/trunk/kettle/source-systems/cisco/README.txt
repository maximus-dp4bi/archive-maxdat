There is a transform to help jumpstart importing table structures into sql server for views/tables that you do not have user rights to get the create scripts.

1) Login to the source system and run the following sql (including the views you want to include) to get the information out of the information_schema.  Save the data into a tab separated file including the headers.
e.g. 
select *
from [acn_awdb].[INFORMATION_SCHEMA].[COLUMNS]
where TABLE_NAME IN (
 'Bucket_Intervals'
 ,'Call_Type'
 ,'Call_Type_Interval'
 ,'Call_Type_SG_Interval'
 ,'Termination_Call_Detail'
 ,'Route_Call_Detail'
 ,'Person'
 ,'Agent'
 ,'Agent_Logout'
 ,'Agent_Team'
 ,'Agent_Interval'
 ,'Agent_Skill_Group_Interval'
 ,'Agent_Team_Member'
 ,'Agent_Team_Supervisor'
 ,'Skill_Group'
 ,'Skill_Group_Member'
 ,'Skill_Group_Interval'
)
ORDER BY TABLE_NAME, ORDINAL_POSITION

2) Open importTables.ktr and set the inputFile parameter to be the tsv you created in Step 1.

3) Run importTables

4) A file of all the create scripts will be created as  ./scripts/hds-tables-create-<DateTime>.sql.  This file does not have any pk or fk constraints defined.

5) Now that you have the create scripts stubbed, manually create any other statements needed to create pk, fk, or other constraints to be included in the db creation script.