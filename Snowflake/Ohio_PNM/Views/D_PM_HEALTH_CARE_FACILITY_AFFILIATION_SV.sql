create or replace view OHIO_PROVIDER_DP4BI_PROD_DB.PUBLIC.D_PM_HEALTH_CARE_FACILITY_AFFILIATION_SV(
	REG_ID,
	NPI,
	NAME,
	MEDICAID_ID,
	ISINPATIENTSETTING,
	PROVIDER_TYPE_NAME,
	PROVIDER_SPECIALTY
) as
select distinct rp.REG_ID, rp.npi,rp.name,rsl.MEDICAID_ID, reg.IsInpatientSetting, pt.PROVIDER_TYPE_NAME,
(SELECT  LISTAGG(st.SPECIALTY_TYPE_NAME, ', ') WITHIN GROUP (ORDER BY st.SPECIALTY_TYPE_NAME)
FROM  ohpnm_dp4bi.REG_SPECIALTY rs
INNER JOIN ohpnm_dp4bi.SPECIALTY_TYPE   st ON (rs.SPECIALTY_TYPE_ID = st.SPECIALTY_TYPE_ID)
WHERE  rs.REG_ID = rp.REG_ID
AND  TO_DATE(SYSDATE()) BETWEEN rs.START_DATE AND rs.END_DATE
) AS  PROVIDER_SPECIALTY
from ohpnm_dp4bi.REG_HEALTH_CARE_FACILITY_AFFILIATION reg
INNER join ohpnm_dp4bi.REG_SERVICE_LOCATION rsl on rsl.reg_id = reg.REG_ID
INNER join ohpnm_dp4bi.REG_PROVIDER rp on rp.REG_ID = rsl.REG_ID
LEFT join ohpnm_dp4bi.PROVIDER_TYPE pt on rp.PROVIDER_TYPE_ID = pt.PROVIDER_TYPE_ID;