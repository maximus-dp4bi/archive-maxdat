--Configuration Test
alter session set current_schema = maxdat_product_cc; 

set SERVEROUTPUT on
begin
 Dbms_Output.Put_Line(Systimestamp);
end;

--Note: Set the variables below to the record counts you are expecting from the excel
Declare 
  Query_Value int; 
  Test_No int := 1; 
  V1 int := 1;  --    1. "Projects" tab check
  V2 int := 56;  --   2. "Contact Queues" tab check
  V3 int := 16;  --   3. "Agent Routing Group" tab check
  V4 int := 18;  --   4. Units of Work tab check 
  V5 int := 6;  --   5. agent desk settings tab check 
  V6 int := 30;  --   6. Actvity types tab check
  V7 int := 1;  --    7. Geography tab check 
  V8 int := 2;  --    8. Application Lookup tab check
  V9 int := 51; --   9. Menu groups
  
Begin
--1. Project Name
select count(distinct Program_Name) into Query_Value
from cc_c_project_config 
where Project_Name = 'CA HCO'; 

if (Query_Value <> V1) then
  DBMS_OUTPUT.PUT_LINE('Test Number ' || Test_No || ': Failed - Check. ');
  else 
  DBMS_OUTPUT.PUT_LINE('Test Number ' || Test_No || ': Okay');
end if; 

Test_No := Test_No + 1 ;

--2. Contact Queues
select count(distinct Queue_Name)into Query_Value
from CC_C_CONTACT_QUEUE
where project_name = 'CA HCO'
and queue_number in (
	 6108
	,6109
	,6110
	,6111
	,6112
	,6113
	,6114
	,6115
	,6117
	,6118
	,6119
	,6120
	,6121
	,6122
	,6123
	,6124
	,6125
	,6127
	,6132
	,6133
	,6139
	,6140
	,6141
	,6142
	,6143
	,6144
	,6145
	,6146
	,6147
	,6148
	,6149
	,6150
	,6126
	,6152
	,6221
	,6222
	,6223
	,6224
	,6225
	,6106
	,6107
        ,6116
); 

if (Query_Value <> V2) then
  DBMS_OUTPUT.PUT_LINE('Test Number ' || Test_No || ': Failed - Check. ');
  else 
  DBMS_OUTPUT.PUT_LINE('Test Number ' || Test_No || ': Okay');
end if; 

Test_No := Test_No + 1 ;


--3. Agent Routing Groups
select count(distinct agent_routing_group_name)into Query_Value
from CC_C_AGENT_RTG_GRP
where agent_routing_group_number in (
	 5151
	,5152
	,5153
	,5154
	,5155
	,5156
	,5157
	,5158
	,5159
	,5160
	,5161
	,5162
	,5163
	,5164
	,5165
  ,5166
); 


if (Query_Value <> V3) then
  DBMS_OUTPUT.PUT_LINE('Test Number ' || Test_No || ': Failed - Check. ');
  else 
  DBMS_OUTPUT.PUT_LINE('Test Number ' || Test_No || ': Okay');
end if; 

Test_No := Test_No + 1 ;


--4. Units of Work
select count(*)into Query_Value
from CC_C_UNIT_OF_WORK
where Unit_of_work_name in (
 'After Hours'
, 'English - Main'
, 'Spanish - Main'
, 'Other Language - Main'
, 'Provider'
, 'ESR'
, 'Research'
, 'Other Language - Voicemail'
, 'Transfer'
, 'Transfer - Folsom'
, 'English After-Hours Voicemail'
, 'Spanish After-Hours Voicemail'
, 'Provider After-Hours Voicemail'
, 'ESR After-Hours Voicemail'
, 'Research After-Hours Voicemail'
, 'IVR'
, 'Global - Main'
, 'Unknown'
); 


if (Query_Value <> V4) then
  DBMS_OUTPUT.PUT_LINE('Test Number ' || Test_No || ': Failed - Check. ');
  else 
  DBMS_OUTPUT.PUT_LINE('Test Number ' || Test_No || ': Okay');
end if; 

Test_No := Test_No + 1 ;


--6. Agent Desk Settings
select count(*)into Query_Value
from CC_C_LOOKUP
where LOOKUP_KEY in (5052, 5053)
and lookup_type like '%DESKSETTING%';  


if (Query_Value <> V5) then
  DBMS_OUTPUT.PUT_LINE('Test Number ' || Test_No || ': Failed - Check. ');
  else 
  DBMS_OUTPUT.PUT_LINE('Test Number ' || Test_No || ': Okay');
end if; 

Test_No := Test_No + 1 ;


--7. Activity Types
select count(distinct Activity_Type_ID)into Query_Value
from CC_C_ACTIVITY_TYPE
where Activity_type_name in (
	 'ACW'
	, 'Bathroom'
	, 'Break'
	, 'Break 2'
	, 'Case Note'
	, 'Coaching'
	, 'CPS'
	, 'Dropped Call-Call Back'
	, 'Emergency'
	, 'End of Shift'
	, 'Follow Up'
	, 'Lunch'
	, 'Meeting'
	, 'Morning Prep'
	, 'Offline Work'
	, 'Outbound'
	, 'Personal'
	, 'Resource Center'
	, 'SME'
	, 'Special Projects'
	, 'Supervisor'
	, 'System Issues'
	, 'Training'
	, 'VM'
	, 'Unscheduled'
	, 'AM Break'
	, 'Outbound - CCC'
	, 'Outbound - M3'
	, 'PM Break'
	, 'Team Meeting'
);

if (Query_Value <> V6) then
  DBMS_OUTPUT.PUT_LINE('Test Number ' || Test_No || ': Failed - Check. ');
  else 
  DBMS_OUTPUT.PUT_LINE('Test Number ' || Test_No || ': Okay');
end if; 

Test_No := Test_No + 1 ;



--8. Geography
select count(*)into Query_Value
from CC_D_GEOGRAPHY_MASTER
where UPPER(Geography_Name) in ('CALIFORNIA');

if (Query_Value <> V7) then
  DBMS_OUTPUT.PUT_LINE('Test Number ' || Test_No || ': Failed - Check. ');
  else 
  DBMS_OUTPUT.PUT_LINE('Test Number ' || Test_No || ': Okay');
end if; 

Test_No := Test_No + 1 ;


--9. Application Lookup
select count(*)into Query_Value
from CC_A_LIST_LKUP
where name = 'CAHCO_CALLS_OFFERED_FORMULA'; 

if (Query_Value <> V8) then
  DBMS_OUTPUT.PUT_LINE('Test Number ' || Test_No || ': Failed - Check. ');
  else 
  DBMS_OUTPUT.PUT_LINE('Test Number ' || Test_No || ': Okay');
end if; 

Test_No := Test_No + 1 ;

--10. Menu Group 
select count(IVR_MENU_GROUP_ID)into Query_Value
from CC_C_IVR_MENU_GROUP
where project_name = 'CA HCO'; 

if (Query_Value <> V9) then
  DBMS_OUTPUT.PUT_LINE('Test Number ' || Test_No || ': Failed - Check. ');
  else 
  DBMS_OUTPUT.PUT_LINE('Test Number ' || Test_No || ': Okay');
end if; 

Test_No := Test_No + 1 ;

End;