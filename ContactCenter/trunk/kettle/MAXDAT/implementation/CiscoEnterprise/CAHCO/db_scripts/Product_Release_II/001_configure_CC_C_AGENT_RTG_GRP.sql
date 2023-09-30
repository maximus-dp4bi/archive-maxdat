update cc_c_agent_rtg_grp
set project_name = 'CA HCO'
, program_name = 'Medi-Cal'
, region_name = 'West'
, state_name = 'California'
where agent_routing_group_number in
(
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
)

commit;