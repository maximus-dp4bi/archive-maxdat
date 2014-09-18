select "Timestamp", sum(CallsAnswered) 
from dApplicationStat das
where "Timestamp" >= {ts '2014-03-01 00:00:00'}
and "Timestamp" < {ts '2014-03-04 00:00:00'}
and Application in (
'VMCALLBACK_EN_CES_s'
,'VMCALLBACK_SPN_CES_s'
,'Gen_ENG_CES_s'
,'Gen_SP_CES_s'
,'HC_EN_CES_s'
,'HC_SPN_CES_s'
,'HC_OB_EN_CES_s'
,'HC_OB_SP_CES_s'
,'ICP_EN_CES_s'
,'ICP_SP_CES_s'
,'ICP_OB_EN_CES_s'
,'ICP_OB_SP_CES_s'
,'MAI_EN_s'
,'MAI_SP_s'
,'MAI_OB_EN_s'
,'MAI_OB_SP_s'
,'VMC_EN_CES_s'
,'VMC_SP_CES_s'
,'VMC_OB_EN_CES_s'
,'VMC_OB_SP_CES_s'
,'VMCALLBACK_ENG_s'
,'VMCALLBACK_SPN_s'
,'CSR_ENG_s'
,'CSR_SPN_s'
,'Sen_CSR_ENG_s'
,'Sen_CSR_SPN_s'
)
group by "Timestamp"
order by "Timestamp" desc;


select "Timestamp", sum(CallsAnswered) 
from dAgentbySkillsetStat das
where "Timestamp" >= {ts '2014-03-01 00:00:00'}
and "Timestamp" < {ts '2014-03-04 00:00:00'}
and Skillset in (
'VMCALLBACK_ENG_sk'
,'VMCALLBACK_SPN_sk'
,'CSR_ENG_sk'
,'CSR_SPN_sk'
,'Sen_CSR_ENG_sk'
,'Sen_CSR_SPN_sk'
,'VMCALLBACK_EN_sk'
,'VMCALLBACK_SP_sk'
,'GEN_ENG_sk'
,'GEN_SPN_SK'
,'HC_EN_sk'
,'HC_SP_sk'
,'HC_OB_EN_sk'
,'HC_OB_SP_sk'
,'ICP_EN_sk'
,'ICP_SP_sk'
,'ICP_OB_EN_sk'
,'ICP_OB_SP_sk'
,'MAI_EN_sk'
,'MAI_SP_sk'
,'MAI_OB_EN_sk'
,'MAI_OB_SP_sk'
,'VMC_EN_sk'
,'VMC_SP_sk'
,'VMC_OB_EN_sk'
,'VMC_OB_SP_sk'
)
group by "Timestamp"
order by "Timestamp" desc;



select "Timestamp", sum(LoggedInTime) 
from dAgentPerformanceStat das
where "Timestamp" >= {ts '2014-03-01 00:00:00'}
and "Timestamp" < {ts '2014-03-04 00:00:00'}
and UserID in (
	select distinct ssa.UserID 
	from dAgentBySkillsetStat ssa
	where Skillset in (
		'VMCALLBACK_ENG_sk'
		,'VMCALLBACK_SPN_sk'
		,'CSR_ENG_sk'
		,'CSR_SPN_sk'
		,'Sen_CSR_ENG_sk'
		,'Sen_CSR_SPN_sk'
		,'VMCALLBACK_EN_sk'
		,'VMCALLBACK_SP_sk'
		,'GEN_ENG_sk'
		,'GEN_SPN_SK'
		,'HC_EN_sk'
		,'HC_SP_sk'
		,'HC_OB_EN_sk'
		,'HC_OB_SP_sk'
		,'ICP_EN_sk'
		,'ICP_SP_sk'
		,'ICP_OB_EN_sk'
		,'ICP_OB_SP_sk'
		,'MAI_EN_sk'
		,'MAI_SP_sk'
		,'MAI_OB_EN_sk'
		,'MAI_OB_SP_sk'
		,'VMC_EN_sk'
		,'VMC_SP_sk'
		,'VMC_OB_EN_sk'
		,'VMC_OB_SP_sk'
	)
)
group by "Timestamp"
order by "Timestamp" desc;


select distinct UserID 
from dAgentBySkillsetStat
where Skillset in (
		'VMCALLBACK_ENG_sk'
		,'VMCALLBACK_SPN_sk'
		,'CSR_ENG_sk'
		,'CSR_SPN_sk'
		,'Sen_CSR_ENG_sk'
		,'Sen_CSR_SPN_sk'
		,'VMCALLBACK_EN_sk'
		,'VMCALLBACK_SP_sk'
		,'GEN_ENG_sk'
		,'GEN_SPN_SK'
		,'HC_EN_sk'
		,'HC_SP_sk'
		,'HC_OB_EN_sk'
		,'HC_OB_SP_sk'
		,'ICP_EN_sk'
		,'ICP_SP_sk'
		,'ICP_OB_EN_sk'
		,'ICP_OB_SP_sk'
		,'MAI_EN_sk'
		,'MAI_SP_sk'
		,'MAI_OB_EN_sk'
		,'MAI_OB_SP_sk'
		,'VMC_EN_sk'
		,'VMC_SP_sk'
		,'VMC_OB_EN_sk'
		,'VMC_OB_SP_sk'
)
and "Timestamp" >= {ts '2014-03-01 00:00:00'}
and "Timestamp" < {ts '2014-03-04 00:00:00'}
;