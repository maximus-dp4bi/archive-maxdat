select
(case when si.PrecisionQueueID in (5110,5111,5112) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-05:00') as date) --MO CS
    when si.PrecisionQueueID in (5001,5004,5005,5006,5007,5013,5014,5015,5016,5017,5058,5059,5179,5180,5275,5276,5466) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --MD EB
    when si.PrecisionQueueID in (5091,5092,5093,5094,5095)  then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --VA EB
    when si.PrecisionQueueID in (5119,5121,5122,5123,5124,5125,5126,5128,5129,5131,5143,5144,5145,5146,5383,5384) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --GA IES
	  when si.PrecisionQueueID in (5151,5152,5153,5154,5155,5156,5157,5158,5159,5160,5161,5162,5163,5164,5165,5166,5359, 5360, 5361, 5362, 5363, 5364, 5365, 5366, 5367, 5368, 5369, 5370, 5371, 5372, 5373, 5374, 5375, 5376, 5377, 5378, 5380, 5381,5437,5438) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --CA HCO
    when si.PrecisionQueueID in (5400, 5401,5399, 5398, 5391, 5392, 5394, 5395, 5397,5396, 5393, 5402, 5403, 5404, 5405, 5406, 5410, 5407, 5411, 5412, 5409, 5408, 5497,5557,5558,5559,5560,5561,5562,5563,5564) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --CA FSS
	  when si.PrecisionQueueID in (5436, 5429, 5434, 5432, 5435, 5430, 5431, 5433, 5428, 5425, 5418, 5427, 5423, 5421, 5426, 5424, 5419, 5420, 5422,5500, 5501, 5502, 5503, 5504, 5505, 5506, 5507, 5508) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --CA SOA
	  when si.PrecisionQueueID in (5469, 5470, 5471,5473,5474,5475,5476,5478,5480,5481,5482,5483) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --CA CCHIP
	  when si.PrecisionQueueID in (5113,5114,5115)  then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --MI APCC
    when si.PrecisionQueueID in (5073,5074,5075,5076) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --MI CSCC
	  when si.PrecisionQueueID in (5033,5034,5035,5036,5037,5038,5440,5441,5493,5494,5495,5496,5498) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --MI EB
	  when si.PrecisionQueueID in (5346,5347,5343,5340,5344,5345,5348,5513) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --IN EB
	  when si.PrecisionQueueID in (5320,5321,5322,5472) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --MI PSSCC
	  when si.PrecisionQueueID in (5210,5211) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --VA CCCP
	  when si.PrecisionQueueID in (5087,5088,5089,5090,5194,5195,5202,5203,5204,5205,5206,5207,5208,5212,5246,5247,5248,5269,5270,5271,5272,5273,5274,5292,5293,5294,5296,5297,5298,5299,5300,5301,5302,5303,5304,5305,5307,5308,5309,5310,5311,5312,5313,5314,5315,5316,5317,5318,5319,5323,5324,5326,5327,5328,5329,5330,5331,5332,5333,5334,5342,5357,5446,5447,5448,5449,5450,5451,5511,5512,5518,5545,5546,5554,5574,5575,5588,5589,5601,5602,5603,5644,5645,5646,5647,5648) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --VA SOA
	  when si.PrecisionQueueID in (5219,5220,5221,5222,5223,5224, 5254, 5349, 5350) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --FL HK
	  when si.PrecisionQueueID in (5249,5250,5251,5252,5253) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --MBSHCC
	  when si.PrecisionQueueID in (5229,5289,5149,5181,5230,5290,5150,5182) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --WYCSC
	  when si.PrecisionQueueID in (5453, 5454, 5455, 5456, 5457, 5458, 5459, 5460, 5461, 5462, 5463, 5464, 5465) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --NCEB
    when si.PrecisionQueueID in (5515,5516,5517,5520,5521,5522,5568,5569,5570,5571,5572,5573,5594,5595,5598,5609,5610,5611,5614,5615,5616,5617,5618,5619,5632,5633,5634) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --CA CDPH
    when si.PrecisionQueueID in (5523,5530,5542,5547,5556,5566,5567) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date)--NC – UICC
    when si.PrecisionQueueID in (5548,5549,5550,5551,5552,5553,5622,5623,5624,5625,5626,5627,5628,5629,5630,5631) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date)--NJ SBE
    when si.PrecisionQueueID in (5283,5439,5539,5576,5577,5579,5580,5581) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --VT VHC
    else cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --Unknown
    end) as DDate,
'Cisco' as Site_Name,
 (case when si.PrecisionQueueID in (5110,5111,5112) then 'MO CS'
       when si.PrecisionQueueID in (5001,5004,5005,5006,5007,5013,5014,5015,5016,5017,5058,5059,5179,5180,5275,5276,5466) then 'MD EB'
       when si.PrecisionQueueID in (5091,5092,5093,5094,5095) then 'VA EB'
       when si.PrecisionQueueID in (5119,5121,5122,5123,5124,5125,5126,5128,5129,5131,5143,5144,5145,5146,5383,5384) then 'GA IES'
       when si.PrecisionQueueID in (5151,5152,5153,5154,5155,5156,5157,5158,5159,5160,5161,5162,5163,5164,5165,5166,5359, 5360, 5361, 5362, 5363, 5364, 5365, 5366, 5367, 5368, 5369, 5370, 5371, 5372, 5373, 5374, 5375, 5376, 5377, 5378, 5380, 5381,5437,5438) then 'CA HCO'
	     when si.PrecisionQueueID in (5400, 5401,5399, 5398, 5391, 5392, 5394, 5395, 5397,5396, 5393, 5402, 5403, 5404, 5405, 5406, 5410, 5407, 5411, 5412, 5409, 5408, 5497,5557,5558,5559,5560,5561,5562,5563,5564) then 'FSS'
	     when si.PrecisionQueueID in (5436, 5429, 5434, 5432, 5435, 5430, 5431, 5433, 5428, 5425, 5418, 5427, 5423, 5421, 5426, 5424, 5419, 5420, 5422,5500, 5501, 5502, 5503, 5504, 5505, 5506, 5507, 5508) then 'CA SOA'
	     when si.PrecisionQueueID in (5469, 5470, 5471,5473,5474,5475,5476,5478,5480,5481,5482,5483) then 'CA CCHIP'
	     when si.PrecisionQueueID in (5113,5114,5115)  then 'MI APCC'
	     when si.PrecisionQueueID in (5073,5074,5075,5076)  then 'MI CSCC'
	     when si.PrecisionQueueID in (5033,5034,5035,5036,5037,5038,5440,5441,5493,5494,5495,5496,5498)  then 'MI EB'
	     when si.PrecisionQueueID in (5346,5347,5343,5340,5344,5345,5348,5513)  then 'IN EB'
	     when si.PrecisionQueueID in (5320,5321,5322,5472)  then 'MI PSSCC'
       when si.PrecisionQueueID in (5210,5211)  then 'VA CCCP'
	     when si.PrecisionQueueID in (5087,5088,5089,5090,5194,5195,5202,5203,5204,5205,5206,5207,5208,5212,5246,5247,5248,5269,5270,5271,5272,5273,5274,5292,5293,5294,5296,5297,5298,5299,5300,5301,5302,5303,5304,5305,5307,5308,5309,5310,5311,5312,5313,5314,5315,5316,5317,5318,5319,5323,5324,5326,5327,5328,5329,5330,5331,5332,5333,5334,5342,5357,5446,5447,5448,5449,5450,5451,5511,5512,5518,5545,5546,5554,5574,5575,5588,5589,5601,5602,5603,5644,5645,5646,5647,5648)  then 'VA SOA'
	     when si.PrecisionQueueID in (5219,5220,5221,5222,5223,5224, 5254, 5349, 5350)  then 'FL HK'
	     when si.PrecisionQueueID in (5249,5250,5251,5252,5253)  then 'MBSHCC'
	     when si.PrecisionQueueID in (5229,5289,5149,5181,5230,5290,5150,5182)  then 'WY CSC'
       when si.PrecisionQueueID in (5453, 5454, 5455, 5456, 5457, 5458, 5459, 5460, 5461, 5462, 5463, 5464, 5465)  then 'NC EB'
       when si.PrecisionQueueID in (5515,5516,5517,5520,5521,5522,5568,5569,5570,5571,5572,5573,5594,5595,5598,5609,5610,5611,5614,5615,5616,5617,5618,5619,5632,5633,5634) then 'CA CDPH'
       when si.PrecisionQueueID in (5523,5530,5542,5547,5556,5566,5567) then 'NC - UICC'
       when si.PrecisionQueueID in (5548,5549,5550,5551,5552,5553,5622,5623,5624,5625,5626,5627,5628,5629,5630,5631) then 'NJ SBE'
       when si.PrecisionQueueID in (5283,5439,5539,5576,5577,5579,5580,5581) then 'VT VHC'
	   else 'Unknown' end) as Contact_Center,
  cast(pq.PrecisionQueueID as varchar) as Precision_Queue_ID,
  upper(cast(ltrim(rtrim(pq.EnterpriseName))as varchar)) as Queue_Name,
  sum(si.CallsAnswered + si.RouterCallsAbandQ + si.RouterCallsAbandToAgent + si.ShortCalls) Received,
  sum(si.AnsInterval1 + si.AnsInterval2) Handled_Before_Threshold,
  sum(si.CallsHandled - (si.AnsInterval1 + si.AnsInterval2)) Handled_After_Threshold,
  sum(si.CallsHandled) Handled,
  sum(si.ShortCalls + si.AbandInterval1 + si.AbandInterval2) Abandoned_Before_Threshold,
  sum(si.AbandInterval3 + si.AbandInterval4 + si.AbandInterval5 + si.AbandInterval6 + si.AbandInterval7 + si.AbandInterval8 + si.AbandInterval9 + si.AbandInterval10) Abandoned_After_Threshold,
  sum(si.ShortCalls + si.AbandInterval1 + si.AbandInterval2 + si. AbandInterval3 + si.AbandInterval4 + si.AbandInterval5 + si.AbandInterval6 + si.AbandInterval7 + si.AbandInterval8 + si.AbandInterval9 + si.AbandInterval10) Abandoned
from maxco_awdb.dbo.Call_Type_SG_Interval si
inner join maxco_awdb.dbo.Call_Type_Interval cti on si.DateTime = cti.DateTime and si.CallTypeID = cti.CallTypeID
inner join maxco_awdb.dbo.Precision_Queue pq on si.PrecisionQueueID = pq.PrecisionQueueID
where
  si.PrecisionQueueID in
    (5001,5004,5005,5006,5007,5013,5014,5015,5016,5017,5033,5034,5035,5036,5037,5038,5058,5059,5073,5074,5075,5076,5087,5088,5089,5090,5091,5092,5093,5094,5095,5110,5111,5112,5113,5114,5115,5119,5121,5122,5123,5124,5125,5126,5128,5129,5131,5143,5144,5145,5146,5149,5150,5151,5152,5153,5154,5155,5156,5157,5158,5159,5160,5161,5162,5163,5164,5165,5166,5179,5180,5181,5182,5194,5195,5202,5203,5204,5205,5206,5207,5208,5210,5211,5212,5219,5220,5221,5222,5223,5224,5229,5230,5246,5247,5248,5249,5250,5251,5252,5253,5254,5269,5270,5271,5272,5273,5274,5275,5276,5283,5289,5290,5292,5293,5294,5296,5297,5298,5299,5300,5301,5302,5303,5304,5305,5307,5308,5309,5310,5311,5312,5313,5314,5315,5316,5317,5318,5319,5320,5321,5322,5323,5324,5326,5327,5328,5329,5330,5331,5332,5333,5334,5340,5342,5343,5344,5345,5346,5347,5348,5349,5350,5357,5359,5360,5361,5362,5363,5364,5365,5366,5367,5368,5369,5370,5371,5372,5373,5374,5375,5376,5377,5378,5380,5381,5383,5384,5391,5392,5393,5394,5395,5396,5397,5398,5399,5400,5401,5402,5403,5404,5405,5406,5407,5408,5409,5410,5411,5412,5418,5419,5420,5421,5422,5423,5424,5425,5426,5427,5428,5429,5430,5431,5432,5433,5434,5435,5436,5437,5438,5439,5440,5441,5446,5447,5448,5449,5450,5451,5453,5454,5455,5456,5457,5458,5459,5460,5461,5462,5463,5464,5465,5466,5469,5470,5471,5472,5473,5474,5475,5476,5478,5480,5481,5482,5483,5493,5494,5495,5496,5497,5498,5500,5501,5502,5503,5504,5505,5506,5507,5508,5511,5512,5513,5515,5516,5517,5518,5520,5521,5522,5523,5530,5539,5542,5545,5546,5547,5548,5549,5550,5551,5552,5553,5554,5556,5557,5558,5559,5560,5561,5562,5563,5564,5566,5567,5568,5569,5570,5571,5572,5573,5574,5575,5576,5577,5579,5580,5581,5588,5589,5594,5595,5598,5601,5602,5603,5609,5610,5611,5614,5615,5616,5617,5618,5619,5622,5623,5624,5625,5626,5627,5628,5629,5630,5631,5632,5633,5634,5644,5645,5646,5647,5648)
  and cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) between cast(dateadd(DAY,-365,getDate()) as date) and cast(dateadd(DAY,-1,getDate()) as date)
group by
  (case when si.PrecisionQueueID in (5110,5111,5112) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-05:00') as date) --MO CS
    when si.PrecisionQueueID in (5001,5004,5005,5006,5007,5013,5014,5015,5016,5017,5058,5059,5179,5180,5275,5276,5466) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --MD EB
    when si.PrecisionQueueID in (5091,5092,5093,5094,5095) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --VA EB
    when si.PrecisionQueueID in (5119,5121,5122,5123,5124,5125,5126,5128,5129,5131,5143,5144,5145,5146,5383,5384) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --GA IES
	  when si.PrecisionQueueID in (5151,5152,5153,5154,5155,5156,5157,5158,5159,5160,5161,5162,5163,5164,5165,5166,5359, 5360, 5361, 5362, 5363, 5364, 5365, 5366, 5367, 5368, 5369, 5370, 5371, 5372, 5373, 5374, 5375, 5376, 5377, 5378, 5380, 5381,5437,5438) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --CA HCO
	  when si.PrecisionQueueID in (5400, 5401,5399, 5398, 5391, 5392, 5394, 5395, 5397,5396, 5393, 5402, 5403, 5404, 5405, 5406, 5410, 5407, 5411, 5412, 5409, 5408, 5497,5557,5558,5559,5560,5561,5562,5563,5564) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --CA FSS
	  when si.PrecisionQueueID in (5436, 5429, 5434, 5432, 5435, 5430, 5431, 5433, 5428, 5425, 5418, 5427, 5423, 5421, 5426, 5424, 5419, 5420, 5422,5500, 5501, 5502, 5503, 5504, 5505, 5506, 5507, 5508) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --CA SOA
	  when si.PrecisionQueueID in (5469, 5470, 5471,5473,5474,5475,5476,5478,5480,5481,5482,5483) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --CA CCHIP
	  when si.PrecisionQueueID in (5113,5114,5115)  then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --MI APCC
    when si.PrecisionQueueID in (5073,5074,5075,5076) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --MI CSCC
	  when si.PrecisionQueueID in (5033,5034,5035,5036,5037,5038,5440,5441,5493,5494,5495,5496,5498) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --MI EB
	  when si.PrecisionQueueID in (5346,5347,5343,5340,5344,5345,5348,5513) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --IN EB
	  when si.PrecisionQueueID in (5320,5321,5322,5472) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --MI PSSCC
	  when si.PrecisionQueueID in (5210,5211) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --VA CCCP
	  when si.PrecisionQueueID in (5087,5088,5089,5090,5194,5195,5202,5203,5204,5205,5206,5207,5208,5212,5246,5247,5248,5269,5270,5271,5272,5273,5274,5292,5293,5294,5296,5297,5298,5299,5300,5301,5302,5303,5304,5305,5307,5308,5309,5310,5311,5312,5313,5314,5315,5316,5317,5318,5319,5323,5324,5326,5327,5328,5329,5330,5331,5332,5333,5334,5342,5357,5446,5447,5448,5449,5450,5451,5511,5512,5518,5545,5546,5554,5574,5575,5588,5589,5601,5602,5603,5644,5645,5646,5647,5648) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --VA SOA
	  when si.PrecisionQueueID in (5219,5220,5221,5222,5223,5224, 5254, 5349, 5350) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --FL HK
    when si.PrecisionQueueID in (5249,5250,5251,5252,5253) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --MBSHCC
    when si.PrecisionQueueID in (5229,5289,5149,5181,5230,5290,5150,5182) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --WYCSC
	  when si.PrecisionQueueID in (5453, 5454, 5455, 5456, 5457, 5458, 5459, 5460, 5461, 5462, 5463, 5464, 5465) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --NCEB
    when si.PrecisionQueueID in (5515,5516,5517,5520,5521,5522,5568,5569,5570,5571,5572,5573,5594,5595,5598,5609,5610,5611,5614,5615,5616,5617,5618,5619,5632,5633,5634) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --CA CDPH
    when si.PrecisionQueueID in (5523,5530,5542,5547,5556, 5566,5567) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date)--NC-UICC
    when si.PrecisionQueueID in (5548,5549,5550,5551,5552,5553,5622,5623,5624,5625,5626,5627,5628,5629,5630,5631) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date)--NJ SBE
    when si.PrecisionQueueID in (5283,5439,5539,5576,5577,5579,5580,5581) then cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date)--VT VHC
	 else cast(switchoffset(todatetimeoffset(si.DateTime,-360),'-04:00') as date) --Unknown
    end),
 (case when si.PrecisionQueueID in (5110,5111,5112) then 'MO CS'
     when si.PrecisionQueueID in (5001,5004,5005,5006,5007,5013,5014,5015,5016,5017,5058,5059,5179,5180,5275,5276,5466) then 'MD EB'
     when si.PrecisionQueueID in (5091,5092,5093,5094,5095)  then 'VA EB'
     when si.PrecisionQueueID in (5119,5121,5122,5123,5124,5125,5126,5128,5129,5131,5143,5144,5145,5146,5383,5384)  then 'GA IES'
     when si.PrecisionQueueID in (5151,5152,5153,5154,5155,5156,5157,5158,5159,5160,5161,5162,5163,5164,5165,5166,5359, 5360, 5361, 5362, 5363, 5364, 5365, 5366, 5367, 5368, 5369, 5370, 5371, 5372, 5373, 5374, 5375, 5376, 5377, 5378, 5380, 5381,5437,5438) then 'CA HCO'
	   when si.PrecisionQueueID in (5400, 5401,5399, 5398, 5391, 5392, 5394, 5395, 5397,5396, 5393, 5402, 5403, 5404, 5405, 5406, 5410, 5407, 5411, 5412, 5409, 5408, 5497,5557,5558,5559,5560,5561,5562,5563,5564) then 'FSS'
	   when si.PrecisionQueueID in (5436, 5429, 5434, 5432, 5435, 5430, 5431, 5433, 5428, 5425, 5418, 5427, 5423, 5421, 5426, 5424, 5419, 5420, 5422,5500, 5501, 5502, 5503, 5504, 5505, 5506, 5507, 5508) then 'CA SOA'
	   when si.PrecisionQueueID in (5469, 5470, 5471,5473,5474,5475,5476,5478,5480,5481,5482,5483) then 'CA CCHIP'
	   when si.PrecisionQueueID in (5113,5114,5115)  then 'MI APCC'
	   when si.PrecisionQueueID in (5073,5074,5075,5076) then 'MI CSCC'
	   when si.PrecisionQueueID in (5033,5034,5035,5036,5037,5038,5440,5441,5493,5494,5495,5496,5498)   then 'MI EB'
	   when si.PrecisionQueueID in (5346,5347,5343,5340,5344,5345,5348,5513)   then 'IN EB'
	   when si.PrecisionQueueID in (5320,5321,5322,5472)   then 'MI PSSCC'
	   when si.PrecisionQueueID in (5210,5211) then 'VA CCCP'
	   when si.PrecisionQueueID in (5087,5088,5089,5090,5194,5195,5202,5203,5204,5205,5206,5207,5208,5212,5246,5247,5248,5269,5270,5271,5272,5273,5274,5292,5293,5294,5296,5297,5298,5299,5300,5301,5302,5303,5304,5305,5307,5308,5309,5310,5311,5312,5313,5314,5315,5316,5317,5318,5319,5323,5324,5326,5327,5328,5329,5330,5331,5332,5333,5334,5342,5357,5446,5447,5448,5449,5450,5451,5511,5512,5518,5545,5546,5554,5574,5575,5588,5589,5601,5602,5603,5644,5645,5646,5647,5648) then 'VA SOA'
	   when si.PrecisionQueueID in (5219,5220,5221,5222,5223,5224, 5254, 5349, 5350)   then 'FL HK'
     when si.PrecisionQueueID in (5249,5250,5251,5252,5253)   then 'MBSHCC'
     when si.PrecisionQueueID in (5229,5289,5149,5181,5230,5290,5150,5182)   then 'WY CSC'
	   when si.PrecisionQueueID in (5453, 5454, 5455, 5456, 5457, 5458, 5459, 5460, 5461, 5462, 5463, 5464, 5465	)   then 'NC EB'
     when si.PrecisionQueueID in (5515,5516,5517,5520,5521,5522,5568,5569,5570,5571,5572,5573,5594,5595,5598,5609,5610,5611,5614,5615,5616,5617,5618,5619,5632,5633,5634) then 'CA CDPH'
     when si.PrecisionQueueID in (5523,5530,5542,5547,5556, 5566,5567) then 'NC - UICC'
     when si.PrecisionQueueID in (5548,5549,5550,5551,5552,5553,5622,5623,5624,5625,5626,5627,5628,5629,5630,5631) then 'NJ SBE'
     when si.PrecisionQueueID in (5283,5439,5539,5576,5577,5579,5580,5581) then 'VT VHC'
	   else 'Unknown' end),
cast(pq.PrecisionQueueID as varchar),
upper(cast(ltrim(rtrim(pq.EnterpriseName))as varchar))
