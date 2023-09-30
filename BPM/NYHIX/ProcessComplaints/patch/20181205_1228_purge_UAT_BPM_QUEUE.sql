delete from corp_etl_complaints_incidents
where incident_id in (26107678,
26114390,
26114541,
26114618,
26114785,
26114934,
26115379,
26115720,
26115877,
26116027,
26116056,
26116092,
26116466,
26116567,
26116799,
26117120,
26118859,
26120016,
26120202,
26120219,
26120221,
26120224,
26120226,
26120229,
26120231,
26120232,
26120233,
26120244,
26120247,
26120249,
26120259,
26120260,
26120263,
26120264,
26120265,
26120268,
26120274,
26120275,
26120277,
26120279,
26120284,
26120286,
26120288,
26120291,
26120301,
26120306,
26120311,
26120348,
26120360,
26120374,
26120414,
26120446,
26120549,
26120633,
26120733,
26120747,
26120796,
26120981,
26121065,
26121094,
26121316,
26121334,
26121488,
26121729,
26121742,
26121800,
26122042,
26122343,
26122384,
26122792,
26123052,
26123082,
26123339,
26124851,
26125200,
26125456,
26126134,
26126136,
26126386,
26126456,
26126470,
26126717,
26126943,
26128777,
26128845,
26128872,
26128938,
26128959,
26129715,
26129844,
26130185,
26132667)
;

delete from corp_etl_compl_incidents_oltp
where incident_id in (26107678,
26114390,
26114541,
26114618,
26114785,
26114934,
26115379,
26115720,
26115877,
26116027,
26116056,
26116092,
26116466,
26116567,
26116799,
26117120,
26118859,
26120016,
26120202,
26120219,
26120221,
26120224,
26120226,
26120229,
26120231,
26120232,
26120233,
26120244,
26120247,
26120249,
26120259,
26120260,
26120263,
26120264,
26120265,
26120268,
26120274,
26120275,
26120277,
26120279,
26120284,
26120286,
26120288,
26120291,
26120301,
26120306,
26120311,
26120348,
26120360,
26120374,
26120414,
26120446,
26120549,
26120633,
26120733,
26120747,
26120796,
26120981,
26121065,
26121094,
26121316,
26121334,
26121488,
26121729,
26121742,
26121800,
26122042,
26122343,
26122384,
26122792,
26123052,
26123082,
26123339,
26124851,
26125200,
26125456,
26126134,
26126136,
26126386,
26126456,
26126470,
26126717,
26126943,
26128777,
26128845,
26128872,
26128938,
26128959,
26129715,
26129844,
26130185,
26132667)
;

delete from CORP_ETL_COMPL_INCIDN_WIP_BPM
where incident_id in (26107678,
26114390,
26114541,
26114618,
26114785,
26114934,
26115379,
26115720,
26115877,
26116027,
26116056,
26116092,
26116466,
26116567,
26116799,
26117120,
26118859,
26120016,
26120202,
26120219,
26120221,
26120224,
26120226,
26120229,
26120231,
26120232,
26120233,
26120244,
26120247,
26120249,
26120259,
26120260,
26120263,
26120264,
26120265,
26120268,
26120274,
26120275,
26120277,
26120279,
26120284,
26120286,
26120288,
26120291,
26120301,
26120306,
26120311,
26120348,
26120360,
26120374,
26120414,
26120446,
26120549,
26120633,
26120733,
26120747,
26120796,
26120981,
26121065,
26121094,
26121316,
26121334,
26121488,
26121729,
26121742,
26121800,
26122042,
26122343,
26122384,
26122792,
26123052,
26123082,
26123339,
26124851,
26125200,
26125456,
26126134,
26126136,
26126386,
26126456,
26126470,
26126717,
26126943,
26128777,
26128845,
26128872,
26128938,
26128959,
26129715,
26129844,
26130185,
26132667)
;

delete from F_COMPLAINT_BY_DATE
where cmpl_bi_id in (select cmpl_bi_id from D_COMPLAINT_CURRENT where incident_id in(26107678,
26114390,
26114541,
26114618,
26114785,
26114934,
26115379,
26115720,
26115877,
26116027,
26116056,
26116092,
26116466,
26116567,
26116799,
26117120,
26118859,
26120016,
26120202,
26120219,
26120221,
26120224,
26120226,
26120229,
26120231,
26120232,
26120233,
26120244,
26120247,
26120249,
26120259,
26120260,
26120263,
26120264,
26120265,
26120268,
26120274,
26120275,
26120277,
26120279,
26120284,
26120286,
26120288,
26120291,
26120301,
26120306,
26120311,
26120348,
26120360,
26120374,
26120414,
26120446,
26120549,
26120633,
26120733,
26120747,
26120796,
26120981,
26121065,
26121094,
26121316,
26121334,
26121488,
26121729,
26121742,
26121800,
26122042,
26122343,
26122384,
26122792,
26123052,
26123082,
26123339,
26124851,
26125200,
26125456,
26126134,
26126136,
26126386,
26126456,
26126470,
26126717,
26126943,
26128777,
26128845,
26128872,
26128938,
26128959,
26129715,
26129844,
26130185,
26132667))
;

delete from D_COMPLAINT_CURRENT
where incident_id in (26107678,
26114390,
26114541,
26114618,
26114785,
26114934,
26115379,
26115720,
26115877,
26116027,
26116056,
26116092,
26116466,
26116567,
26116799,
26117120,
26118859,
26120016,
26120202,
26120219,
26120221,
26120224,
26120226,
26120229,
26120231,
26120232,
26120233,
26120244,
26120247,
26120249,
26120259,
26120260,
26120263,
26120264,
26120265,
26120268,
26120274,
26120275,
26120277,
26120279,
26120284,
26120286,
26120288,
26120291,
26120301,
26120306,
26120311,
26120348,
26120360,
26120374,
26120414,
26120446,
26120549,
26120633,
26120733,
26120747,
26120796,
26120981,
26121065,
26121094,
26121316,
26121334,
26121488,
26121729,
26121742,
26121800,
26122042,
26122343,
26122384,
26122792,
26123052,
26123082,
26123339,
26124851,
26125200,
26125456,
26126134,
26126136,
26126386,
26126456,
26126470,
26126717,
26126943,
26128777,
26128845,
26128872,
26128938,
26128959,
26129715,
26129844,
26130185,
26132667)
;

DELETE FROM BPM_UPDATE_EVENT_QUEUE
where BSL_ID = 22 
and identifier in (26107678,
26114390,
26114541,
26114618,
26114785,
26114934,
26115379,
26115720,
26115877,
26116027,
26116056,
26116092,
26116466,
26116567,
26116799,
26117120,
26118859,
26120016,
26120202,
26120219,
26120221,
26120224,
26120226,
26120229,
26120231,
26120232,
26120233,
26120244,
26120247,
26120249,
26120259,
26120260,
26120263,
26120264,
26120265,
26120268,
26120274,
26120275,
26120277,
26120279,
26120284,
26120286,
26120288,
26120291,
26120301,
26120306,
26120311,
26120348,
26120360,
26120374,
26120414,
26120446,
26120549,
26120633,
26120733,
26120747,
26120796,
26120981,
26121065,
26121094,
26121316,
26121334,
26121488,
26121729,
26121742,
26121800,
26122042,
26122343,
26122384,
26122792,
26123052,
26123082,
26123339,
26124851,
26125200,
26125456,
26126134,
26126136,
26126386,
26126456,
26126470,
26126717,
26126943,
26128777,
26128845,
26128872,
26128938,
26128959,
26129715,
26129844,
26130185,
26132667)
;

commit;
