select 
  (case when e.C_ID like '10%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) --MI EB
		when e.C_ID like '11%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) --MI APCC
		when e.C_ID like '12%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) --MI CSCC
		when e.C_ID like '13%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) --MBSHCC
		when e.C_ID like '14%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) --MI PSSCC
		when e.C_ID like '15%%%' and e.C_ID not in (15005,15006,15008,15017,15020,15021,15022) then cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) --MD HBE
		when e.C_ID like '17%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-06:00') as date) --WY CSC
        when e.C_ID like '18%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) --NJ SBE
		when e.C_ID like '20%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-07:00') as date) --CA FSS
		when e.C_ID like '25%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-07:00') as date) --CA HCO
		when e.C_ID like '21%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-07:00') as date) --CA SOA
		when e.C_ID like '22%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-07:00') as date) --CA CCHIP
                when e.C_ID like '23%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-07:00') as date) --CA CDPH
		when e.C_ID like '30%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-05:00') as date) --IL CES
		when e.C_ID like '35%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-05:00') as date) --IL EEV
		when e.C_ID like '36%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-05:00') as date) --MI MSS
		when e.C_ID like '40%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-05:00') as date) --MA MH
		when e.C_ID like '45%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) --VA EB
		when e.C_ID like '46%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) --VA CCCP
		when e.C_ID like '50%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) --GA GF
		when e.C_ID like '55%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) --PA EAP
		when e.C_ID like '60%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) --PA IEB
		when e.C_ID like '65%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) --GA IES
		when e.C_ID like '70%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-05:00') as date) --MO CS
		when e.C_ID like '75%%%'  then cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) --VT VHC
		when cast(e.C_ID as varchar) like '61%%%' OR cast(e.C_ID as varchar) like '80%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) --VA SOA
		when e.C_ID like '85%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) --FL HK
		when e.C_ID like '90%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) --IN EB
		when e.C_ID like '95%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) --NC EB
                             when e.C_ID like '96%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) --NC – UICC
		else cast(switchoffset(qs.C_TIMESTAMP,'-05:00') as date) end)
  as DDate,
 acd.C_Name Site_Name,
(case when e.C_ID like '10%%%' then 'MI EB' 
      when e.C_ID like '11%%%' then 'MI APCC'	
	  when e.C_ID like '12%%%' then 'MI CSCC'
	  when e.C_ID like '13%%%' then 'MBSHCC'
	  when e.C_ID like '14%%%' then 'MI PSSCC'
	  when e.C_ID like '15%%%' and e.C_ID not in (15005,15006,15008,15017,15020,15021,15022) then 'MD EB' 
	  when e.C_ID like '17%%%' then 'WY CSC'
      when e.C_ID like '18%%%' then 'NJ SBE'
	  when e.C_ID like '20%%%' then 'FSS'
	 -- WHEN q.C_QTAG not like 'P%' and e.C_ID >= 25000 and e.C_ID <= 25058 THEN 'CA HCO Avaya'
	  WHEN e.C_ID >= 25033 and e.C_ID <= 25085 THEN 'CA HCO Cisco'
	  when e.C_ID like '21%%%' then 'CA SOA'
	  when e.C_ID like '22%%%' then 'CA CCHIP'
      when e.C_ID like '23%%%' then 'CA CDPH'
	  when e.C_ID like '30%%%' then 'CES' 
	  when e.C_ID like '35%%%' then 'EEV' 
	  when e.C_ID like '36%%%' then 'MI MSS' 
	  when e.C_ID like '40%%%' then 'MA MH' 
	  when e.C_ID like '45%%%' then 'VA EB' 
	  when e.C_ID like '46%%%' then 'VA CCCP' 
	  when e.C_ID like '50%%%' then 'GA GF' 
	  when e.C_ID like '55%%%' then 'EAP'
	  when e.C_ID like '60%%%' then 'IEB' 
	  when e.C_ID like '65%%%' then 'GA IES'
      when e.C_ID like '70%%%' then 'MO CS'	 
      when e.C_ID like '75%%%' OR (cast(e.C_ID as varchar) like '80%%%' and e.C_ID in (80057, 80058, 80074))  then 'VT VHC'		  
	  when cast(e.C_ID as varchar) like '61%%%' OR (cast(e.C_ID as varchar) like '80%%%' and e.C_ID not in (80057, 80058, 80074))  then 'VA SOA'	
	  when e.C_ID like '85%%%' then 'FL HK'	
	  when e.C_ID like '90%%%' then 'IN EB'
	  when e.C_ID like '95%%%' then 'NC EB'
          when e.C_ID like '96%%%' then 'NC - UICC'
	  else 'Unknown'  end) Contact_Center,
cast(case when e.C_ID like '10%%%' OR e.C_ID like '11%%%' OR e.C_ID like '12%%%' OR e.C_ID like '13%%%' OR e.C_ID like '14%%%' or ( e.C_ID like '15%%%' and e.C_ID not in (15005,15006,15008,15017,15020,15021,15022) ) or(e.C_ID like '20%%%') or (e.C_ID like '21%%%') or (e.C_ID like '22%%%') or (e.C_ID like '23%%%') or ( e.C_ID like '25%%%' AND acd.C_Name = 'Cisco Enterprise' ) or e.C_ID like '45%%%' or e.C_ID like '46%%%' or e.C_ID like '65%%%'  or e.C_ID like '70%%%' or e.C_ID like '75%%%' or (cast(e.C_ID as varchar) like '80%%%' OR cast(e.C_ID as varchar) like '61%%%') or e.C_ID like '85%%%' or e.C_ID like '90%%%' or e.C_ID like '95%%%' or e.C_ID like '96%%%'  or e.C_ID like '17%%%' or e.C_ID like '18%%%' then 
substring(q.C_QTAG,2,10) else q.C_QTAG end as varchar) as Precision_Queue_ID,
convert(varchar(255),
	(case when e.C_ID like '10%%%' then upper(e.C_NAME) 
	      when e.C_ID like '11%%%' then upper(e.C_NAME) 
		  when e.C_ID like '12%%%' then upper(e.C_NAME) 
		  when e.C_ID like '13%%%' then upper(e.C_NAME) 
		  when e.C_ID like '14%%%' then upper(e.C_NAME) 
		  when e.C_ID like '15%%%' and e.C_ID not in (15005,15006,15008,15017,15020,15021,15022) then upper(e.C_NAME) 
		  when e.C_ID like '17%%%' then upper(e.C_NAME) 
          when e.C_ID like '18%%%' then upper(e.C_NAME)
		  when e.C_ID like '20%%%' then upper(e.C_NAME)
		  when e.C_ID like '21%%%' then upper(e.C_NAME) 
		  when e.C_ID like '22%%%' then upper(e.C_NAME)
          when e.C_ID like '23%%%' then upper(e.C_NAME)
		 -- WHEN q.C_QTAG not like 'P%' and e.C_ID >= 25000 and e.C_ID <= 25058 THEN q.C_QTAG
		  WHEN e.C_ID >= 25033 and e.C_ID <= 25085 THEN upper(e.C_NAME)
		  when e.C_ID like '30%%%' then q.C_QTAG 
		  when e.C_ID like '35%%%' then q.C_QTAG 
		  when e.C_ID like '36%%%' then q.C_QTAG 
		  when e.C_ID like '40%%%' then q.C_QTAG 
		  when e.C_ID like '45%%%' THEN CASE WHEN ascii(RIGHT(left(e.C_NAME, 20),1)) = 255 THEN upper(left(e.C_NAME, 19)) ELSE upper(left(e.C_NAME, 20)) END
		  when e.C_ID like '46%%%' THEN upper(e.C_NAME)
		  when e.C_ID like '50%%%' then q.C_QTAG 
		  when e.C_ID like '55%%%' then q.C_QTAG 
		  when e.C_ID like '60%%%' then q.C_QTAG 
		  when e.C_ID like '65%%%' THEN upper(e.C_NAME) 
		  when e.C_ID like '70%%%' then upper(e.C_NAME) 
		  when e.C_ID like '75%%%' then upper(e.C_NAME)
		  when cast(e.C_ID as varchar) like '61%%%' OR cast(e.C_ID as varchar) like '80%%%' THEN upper(e.C_NAME)
		  when e.C_ID like '85%%%' THEN upper(e.C_NAME)
		  when e.C_ID like '90%%%' THEN left(e.C_NAME,10)+right(left(e.C_NAME,len(e.C_NAME)-2),len(left(e.C_NAME,len(e.C_NAME)-2))-15)
		  when e.C_ID like '95%%%' THEN upper(e.C_NAME)
                  when e.C_ID like '96%%%' THEN upper(e.C_NAME)
		  else q.C_QTAG  end)
		  ) as Queue_Name,
  upper(e.C_NAME) NICE_Name,
  sum(qs.C_ORIGCONTRCVD) as Received,
  sum(qs.C_ORIGHNDLBEFSL) as Handled_Before_Threshold,
  sum(qs.C_ORIGHNDLAFTSL) as Handled_After_Threshold,
  sum(qs.C_ORIGHNDLBEFSL + qs.C_ORIGHNDLAFTSL) as Handled,
  sum(qs.C_ORIGABANDBEFSL) as Abandoned_Before_Threshold,
  sum(qs.C_ORIGABANDAFTSL) as Abandoned_After_Threshold,
  sum(qs.C_ORIGABANDBEFSL + qs.C_ORIGABANDAFTSL) as Abandoned
from nice_wfm_customer1.dbo.R_QUEUESTATS qs
inner join nice_wfm_customer1.dbo.R_QUEUE q on qs.C_QUEUE = q.C_OID
inner join nice_wfm_customer1.dbo.R_ACD acd on q.C_ACD = acd.C_OID
inner join nice_wfm_customer1.dbo.R_ENTITY e on q.C_OID = e.C_OID and e.C_TYPE = 'Q'
where cast(switchoffset(qs.C_TIMESTAMP,'-07:00') as date) between cast(dateadd(DAY,-5,getDate()) as date) and cast(dateadd(DAY,-1,getDate()) as date)
  and e.C_DTIME is NULL and e.C_ID not in (40048,40057,40058,40018,40049,40059)
group by   (case when e.C_ID like '10%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) --MI EB
        when e.C_ID like '11%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) --MI APCC
		when e.C_ID like '12%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) --MI CSCC
		when e.C_ID like '13%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) --MBSHCC
		when e.C_ID like '14%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) --MI PSSCC
		when e.C_ID like '15%%%' and e.C_ID not in (15005,15006,15008,15017,15020,15021,15022) then cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) --MD HBE
		when e.C_ID like '17%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-06:00') as date) --WY CSC
        when e.C_ID like '18%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) --NJ SBE
		when e.C_ID like '20%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-07:00') as date) --CA FSS
		when e.C_ID like '25%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-07:00') as date) --CA HCO
		when e.C_ID like '21%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-07:00') as date) --CA SOA
		when e.C_ID like '22%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-07:00') as date) --CA CCHIP
        when e.C_ID like '23%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-07:00') as date) --CA CDPH
		when e.C_ID like '30%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-05:00') as date) --IL CES
		when e.C_ID like '35%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-05:00') as date) --IL EEV
		when e.C_ID like '36%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-05:00') as date) --MI MSS
		when e.C_ID like '40%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-05:00') as date) --MA MH
		when e.C_ID like '45%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) --VA EB
		when e.C_ID like '46%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) --VA CCCP
		when e.C_ID like '50%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) --GA GF
		when e.C_ID like '55%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) --PA EAP
		when e.C_ID like '60%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) --PA IEB
		when e.C_ID like '65%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) --GA IES
		when e.C_ID like '70%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-05:00') as date) --MO CS
		when e.C_ID like '75%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) --VT VHC
		when cast(e.C_ID as varchar) like '61%%%' OR cast(e.C_ID as varchar) like '80%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) --VA SOA
		when e.C_ID like '85%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) --FL HK
		when e.C_ID like '90%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) --IN EB
		when e.C_ID like '95%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) --NC EB
        when e.C_ID like '96%%%' then cast(switchoffset(qs.C_TIMESTAMP,'-04:00') as date) --NC - UICC
		else cast(switchoffset(qs.C_TIMESTAMP,'-05:00') as date) end),
 acd.C_Name,
(case when e.C_ID like '10%%%' then 'MI EB' 
      when e.C_ID like '11%%%' then 'MI APCC' 
	  when e.C_ID like '12%%%' then 'MI CSCC' 
	  when e.C_ID like '13%%%' then 'MBSHCC' 
	  when e.C_ID like '14%%%' then 'MI PSSCC' 
      when e.C_ID like '15%%%' and e.C_ID not in (15005,15006,15008,15017,15020,15021,15022) then 'MD EB' 
	  when e.C_ID like '17%%%' then 'WY CSC' 
      when e.C_ID like '18%%%' then 'NJ SBE'
	  when e.C_ID like '20%%%' then 'FSS' 
	 -- WHEN q.C_QTAG not like 'P%' and e.C_ID >= 25000 and e.C_ID <= 25058 THEN 'CA HCO Avaya'
	  WHEN e.C_ID >= 25033 and e.C_ID <= 25085 THEN 'CA HCO Cisco'
	  WHEN e.C_ID like '21%%%'then 'CA SOA'
	  WHEN e.C_ID like '22%%%' THEN 'CA CCHIP'
          WHEN e.C_ID like '23%%%' THEN 'CA CDPH'
	  when e.C_ID like '30%%%' then 'CES' 
	  when e.C_ID like '35%%%' then 'EEV' 
	  when e.C_ID like '36%%%' then 'MI MSS' 
	  when e.C_ID like '40%%%' then 'MA MH' 
	  when e.C_ID like '45%%%' then 'VA EB' 
	  when e.C_ID like '46%%%' then 'VA CCCP' 
	  when e.C_ID like '50%%%' then 'GA GF' 
	  when e.C_ID like '55%%%' then 'EAP'
	  when e.C_ID like '60%%%' then 'IEB' 
	  when e.C_ID like '65%%%' then 'GA IES'
	  when e.C_ID like '70%%%' then 'MO CS'	
      when e.C_ID like '75%%%' OR (cast(e.C_ID as varchar) like '80%%%' and e.C_ID in (80057, 80058, 80074))  then 'VT VHC'			  
	  when cast(e.C_ID as varchar) like '61%%%' OR (cast(e.C_ID as varchar) like '80%%%' and e.C_ID not in (80057, 80058, 80074))  then 'VA SOA'  
	  when e.C_ID like '85%%%' then 'FL HK'
	  when e.C_ID like '90%%%' then 'IN EB'
	  when e.C_ID like '95%%%' then 'NC EB'	
          when e.C_ID like '96%%%' then 'NC - UICC'		  
	  else 'Unknown'  end),
cast(case when e.C_ID like '10%%%' OR e.C_ID like '11%%%' OR e.C_ID like '12%%%' OR e.C_ID like '13%%%' OR e.C_ID like '14%%%' OR ( e.C_ID like '15%%%' and e.C_ID not in (15005,15006,15008,15017,15020,15021,15022) ) or (e.C_ID like '20%%%') or (e.C_ID like '21%%%') or (e.C_ID like '22%%%') or (e.C_ID like '23%%%')  OR ( e.C_ID like '25%%%' AND acd.C_Name = 'Cisco Enterprise' ) or e.C_ID like '45%%%' or e.C_ID like '46%%%' or e.C_ID like '65%%%'  or e.C_ID like '70%%%' or e.C_ID like '75%%%' or (cast(e.C_ID as varchar) like '80%%%' OR cast(e.C_ID as varchar) like '61%%%') or e.C_ID like '85%%%' or e.C_ID like '90%%%'or e.C_ID like '95%%%' or e.C_ID like '96%%%' or e.C_ID like '17%%%' or e.C_ID like '18%%%' then 
substring(q.C_QTAG,2,10) else q.C_QTAG end as varchar),
convert(varchar(255), 
	(case when e.C_ID like '10%%%' then upper(e.C_NAME) 
	        when e.C_ID like '11%%%' then upper(e.C_NAME) 
		when e.C_ID like '12%%%' then upper(e.C_NAME) 
		when e.C_ID like '13%%%' then upper(e.C_NAME) 
		when e.C_ID like '14%%%' then upper(e.C_NAME) 
		when e.C_ID like '15%%%' and e.C_ID not in (15005,15006,15008,15017,15020,15021,15022) then upper(e.C_NAME) 
		when e.C_ID like '17%%%' then upper(e.C_NAME) 
        when e.C_ID like '18%%%' then upper(e.C_NAME)
		when e.C_ID like '20%%%' then upper(e.C_NAME)
		when e.C_ID like '21%%%'then upper(e.C_NAME) 
		when e.C_ID like '22%%%' then upper(e.C_NAME)
                when e.C_ID like '23%%%' then upper(e.C_NAME)
 		--WHEN q.C_QTAG not like 'P%' and e.C_ID >= 25000 and e.C_ID <= 25058 THEN q.C_QTAG
		WHEN e.C_ID >= 25033 and e.C_ID <= 25085 THEN upper(e.C_NAME)
		when e.C_ID like '30%%%' then q.C_QTAG
		when e.C_ID like '35%%%' then q.C_QTAG 
		when e.C_ID like '36%%%' then q.C_QTAG 
		when e.C_ID like '40%%%' then q.C_QTAG 
		when e.C_ID like '45%%%' THEN CASE WHEN ascii(RIGHT(left(e.C_NAME, 20),1)) = 255 THEN upper(left(e.C_NAME, 19)) ELSE upper(left(e.C_NAME, 20)) END
		when e.C_ID like '46%%%' THEN upper(e.C_NAME) 
		when e.C_ID like '50%%%' then q.C_QTAG 
		when e.C_ID like '55%%%' then q.C_QTAG 
		when e.C_ID like '60%%%' then q.C_QTAG 
		when e.C_ID like '65%%%' THEN upper(e.C_NAME) 
		when e.C_ID like '70%%%' then upper(e.C_NAME) 
		when e.C_ID like '75%%%' then upper(e.C_NAME) 
		when cast(e.C_ID as varchar) like '61%%%' OR cast(e.C_ID as varchar) like '80%%%' THEN upper(e.C_NAME) 
		when e.C_ID like '85%%%' THEN upper(e.C_NAME) 
		when e.C_ID like '90%%%' THEN left(e.C_NAME,10)+right(left(e.C_NAME,len(e.C_NAME)-2),len(left(e.C_NAME,len(e.C_NAME)-2))-15) 
		when e.C_ID like '95%%%' THEN upper(e.C_NAME)
                when e.C_ID like '96%%%' THEN upper(e.C_NAME)
		else q.C_QTAG  end)
	),
	  upper(e.C_NAME)
	
