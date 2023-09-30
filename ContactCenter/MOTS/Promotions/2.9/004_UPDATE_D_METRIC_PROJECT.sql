
UPDATE d_metric_project
SET trend_indicator_calculation = 'CONTROL CHART'
WHERE d_metric_definition_id IN (SELECT d_metric_definition_id FROM d_metric_definition WHERE label in ('Calls Contained in IVR',
'Calls Handled',
'Web Chats Created',
'Web Chats Handled',
'Voice Mails Created',
'Voice Mails Handled',
'Outbound Calls Attempted',
'Max Number of Agents in Training',
'Max Number of Agents Needed to Handle Contacts',
'Max Number of Agents Scheduled to Handle Contacts',
'Max Number of Agents Available to Handle Contacts',
'Unplanned Absenteeism Percentage (e.g., sick)',
'Planned Absenteeism Percentage (e.g., Vacation)',
'Planned Unpaid Absenteeism Percentage (e.g., FMLA/LOA)',
'At Work - Not handling Contacts Percentage (e.g., training, meetings)',
'Max Handle Time',
'Max Speed to Answer',
'Average Time Clients Wait before Abandon',
'Occupancy',
'Total Utilization',
'Average Handle Time',
'Labor Cost per Transaction',
'Calls Created',
'Calls Offered',
'Average Speed to Answer',
'AB Rate',
'Calls Offered Per FTE'));

UPDATE d_metric_project
SET trend_indicator_calculation = 'DELTA'
WHERE d_metric_definition_id IN (SELECT d_metric_definition_id FROM d_metric_definition WHERE label IN('Peak Day Percentage',
'Peak Week Percentage',
'Number of Skilled Agents "on the floor" that Attritted',
'Max Number of Agents on Payroll'));

UPDATE d_metric_project
SET trend_indicator_calculation = 'NO TREND'
WHERE d_metric_definition_id IN (SELECT d_metric_definition_id FROM d_metric_definition WHERE label IN('Days of Operation'));

UPDATE d_metric_project
SET calculate_control_chart_ind = 'Y'    
WHERE trend_indicator_calculation = 'CONTROL CHART';  

INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME) 
	VALUES ('2.9','004','004_UPDATE_D_METRIC_PROJECT');

COMMIT;